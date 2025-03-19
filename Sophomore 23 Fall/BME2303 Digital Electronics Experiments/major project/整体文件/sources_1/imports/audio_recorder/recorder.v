module recorder(clk,
	AC_BCLK, AC_MCLK, AC_MUTEN, AC_PBDAT, AC_PBLRC, AC_RECDAT, AC_RECLRC, AC_SCL, AC_SDA, 
    LEDREC, LEDTONE, LEDPLAY, LEDFEEDBACK, 
    reset, voldown, volup, rec_aud, 
    play_tone, play_aud, feedback, 
    t_node);

// Input & Output Ports
input   clk;
inout  	AC_BCLK;
output 	AC_MCLK;
output 	AC_MUTEN;
output 	AC_PBDAT;
inout 	AC_PBLRC;
input 	AC_RECDAT;
inout 	AC_RECLRC;
output 	AC_SCL;
inout  	AC_SDA;
output reg LEDREC, LEDTONE, LEDPLAY, LEDFEEDBACK;
input reset, voldown, volup, rec_aud;
input play_tone, play_aud, feedback;
output reg [3:0] t_node;

reg [7:0] state;

reg [1:0]   volume_control;
wire [15:0] audio_output;
wire [1:0] sample_end; // write to internal register
wire [1:0] sample_req; // take the audio input
wire       clk_48kHz;  // clock 48kHz

reg [15:0] mem_in;
reg [15:0] mem_out;
wire [18:0]max_ram_address = 19'd262144;
reg [18:0] blk_addr;
reg [15:0] blk_din;
wire [15:0] blk_dout;
reg blk_wr;
reg iblk_wr;
reg iblk_rd;

wire clk_50MHz, clk_11MHz;
clk_wiz_0 uclk_wiz (
    .clk_out1(clk_50MHz),   //50 MHz
    .clk_out2(clk_11MHz),   //11.2896 MHz
    .clk_out3(clk_12MHz),   //12.288 MHz
    .clk_in1(clk)
);

initial begin
	volume_control <= 1;
	state <= 8'h00;
end

wire volupstate, vu_up, vu_dn;
wire voldnstate, vd_up, vd_dn;

always @(posedge clk)
begin
	if(vu_dn && (volume_control < 3))
		volume_control <= volume_control + 1;
	else if(vd_dn && (volume_control > 0))
		volume_control <= volume_control - 1;
end

debounce volumeup(
	.clk(clk),
    .i_btn(volup),
    .o_state(volupstate),
    .o_ondn(vu_dn),
    .o_onup(vu_up)
);

debounce volumedn(
	.clk(clk),
    .i_btn(voldown),
    .o_state(voldnstate),
    .o_ondn(vd_dn),
    .o_onup(vd_up)
);

// Audio Codec Interface Instantiation
i2c_top i2c_top_inst(
    .clk(clk),
    .main_clk(clk_50MHz),
    .audio_clk(clk_11MHz),
    .clk_12MHz(clk_12MHz),
    .play_tone(play_tone),
	.playback(play_aud),
	.volume_control(volume_control),
    .AC_RECLRC(AC_RECLRC), 
    .AC_RECDAT(AC_RECDAT), 
    .AC_PBLRC(AC_PBLRC), 
    .AC_PBDAT(AC_PBDAT), 
    .AC_MCLK(AC_MCLK), 
    .AC_BCLK(AC_BCLK), 
    .AC_SCL(AC_SCL), 
    .AC_SDA(AC_SDA),
    .AC_MUTEN(AC_MUTEN), 
    .KEY(1), 
    .FEEDBACK(feedback),
	.audio_in(mem_out), 	//audio_input
	.audio_out(audio_output),
    .sample_end (sample_end),
    .sample_req (sample_req),
    .clk_48kHz(clk_48kHz)
);

reg [2:0] bck_buf;
reg [8:0] lrck_buf;

localparam [2:0]
    idle = 3'b000,
    l_st = 3'b001,
    l_cap = 3'b010,
    r_st = 3'b011,
    r_cap = 3'b100;

reg [2:0] i2s_state;    // = idle;

wire lr_pos, lr_neg, bck_pos, bck_neg;

// Process for ssm_clk_gen_proc
always @(posedge clk_11MHz or posedge reset) begin
    if (reset) begin
        bck_buf <= 3'b000;
        lrck_buf <= 9'b000000000;
    end else if (clk_11MHz) begin
        bck_buf <= bck_buf + 1'b1;
        lrck_buf <= lrck_buf + 1'b1;
    end
end

edge_detect ulr_edge_detect (
	.clk(clk_11MHz),
	.rst(reset),
	.signal_in(lrck_buf[8]),
	.pos_edge(lr_pos),
	.neg_edge(lr_neg)
);

edge_detect ubck_edge_detect (
	.clk(clk_11MHz),
	.rst(reset),
	.signal_in(bck_buf[2]),
	.pos_edge(bck_pos),
	.neg_edge(bck_neg)
);

blk_mem_gen_0 ublk_mem_gen (
    .clka(AC_RECLRC),
    .ena(1'b1),
    .wea(blk_wr),
    .addra(blk_addr),
    .dina(blk_din),
    .douta(blk_dout)
);

// Process for cap_dat_proc
always @(posedge AC_RECLRC or posedge reset) begin
    if (reset) begin
        i2s_state <= idle;
        blk_wr <= 1'b0;
    end else if (AC_RECLRC) begin
        blk_wr <= 1'b0;
        if (iblk_wr) begin
            blk_din <= audio_output;
            blk_wr <= 1'b1;
        end else if (iblk_rd) begin
            mem_out <= blk_dout;
        end
    end
end

// Process for blk_mem_proc
always @(posedge AC_RECLRC or posedge reset) begin
    if (reset) begin
        iblk_wr <= 1'b0;
        iblk_rd <= 1'b0;
        blk_addr <= 19'b0;
    end else if (AC_RECLRC) begin
        if (iblk_wr) begin
            if (blk_addr < max_ram_address) begin
                blk_addr <= blk_addr + 1'b1;
            end else begin
                blk_addr <= 19'b0;
                iblk_wr <= 1'b0;
            end
        end else if (iblk_rd) begin
            if (blk_addr < max_ram_address) begin
                blk_addr <= blk_addr + 1'b1;
            end else begin
                blk_addr <= 19'b0;
                iblk_rd <= 1'b0;
            end
        end else if (rec_aud) begin
            iblk_wr <= 1'b1;
            blk_addr <= 19'b0;
        end else if (play_aud) begin
            iblk_rd <= 1'b1;
            blk_addr <= 19'b0;
        end
    end
end

always @(*)	begin
    t_node[0] = clk_48kHz;   //JA1
    t_node[1] = sample_end;        //JB1
    t_node[2] = AC_MCLK;     //JA2
    t_node[3] = AC_BCLK;           //JB2
    t_node[4] = AC_PBLRC;    //JA3
    t_node[5] = AC_RECLRC;         //JB3
    LEDREC <= iblk_wr;
    LEDTONE <= play_tone;
    LEDPLAY <= iblk_rd;
    LEDFEEDBACK <= feedback;
//    t_node[0] = AC_PBDAT;    //JA1
//    t_node[1] = AC_RECDAT;       //JB1    
end

endmodule