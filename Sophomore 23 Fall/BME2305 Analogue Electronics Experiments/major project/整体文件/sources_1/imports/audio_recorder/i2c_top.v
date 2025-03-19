module i2c_top (
	input clk,
	input main_clk,    //50 MHz
	input audio_clk,   //11.2896 MHz
	input clk_12MHz,   //12.288 MHz
	input play_tone,
	input playback,
	input [1:0] volume_control,
    inout AC_RECLRC,
    input AC_RECDAT,

    inout  AC_PBLRC,
    output AC_PBDAT,

    output AC_MCLK,
    inout  AC_BCLK,

    output AC_SCL,
    inout  AC_SDA,

    output AC_MUTEN,
	 
    input  [3:0] KEY,
    input  FEEDBACK,
	 
	 output [15:0] audio_out,
	 input  [15:0] audio_in,
	 
	 output [1:0]sample_end,
	 output [1:0]sample_req,
	 output clk_48kHz
);

reg [15:0] audio_selection;
wire [15:0] audio_output;
wire [15:0] audio_input;

assign audio_out = audio_output;

wire clk_48kHz;
freq_div freq_div_inst (
	.clk_12MHz(clk_12MHz),
	.reset(reset),
    .clk_48kHz(clk_48kHz)
);

//test : playback sine wave tone, or loopback using incoming data
wire [19:0] tone;
sine_wave sine_wave_inst (
    .clock   (clk_12MHz),
    .ready   (clk_48kHz),
    .pcm_data(tone)
);

always @(posedge audio_clk) begin
	if(playback) begin
        if(play_tone)
            audio_selection <= tone[19:4] * volume_control;
        else
            audio_selection <= audio_in * volume_control;
	end
	else begin
        audio_selection <= audio_output * volume_control;
	end
end

wire reset = !KEY[0];

wire [1:0] sample_end; // write to internal register
wire [1:0] sample_req; // take the audio input

// I2C Protocol - FPGA is Master, Codec is Slave
i2c_config i2c_config_inst (
    .clk (main_clk),
    .reset (reset),
    .i2c_sclk (AC_SCL),
    .i2c_sdat (AC_SDA),
    .status (LED)
);

assign AC_MCLK = audio_clk;
assign AC_MUTEN = 1'b1;  // active low, so set to 1 and disable mute

audio_codec audio_codec_inst (
    .clk (audio_clk),
    .reset (reset),
	.volume_control(volume_control),
    .sample_end (sample_end),
    .sample_req (sample_req),
    .audio_output (audio_selection),
    .audio_input (audio_input),
    .channel_sel (2'b10),
    .AC_RECLRC (AC_RECLRC),
    .AC_RECDAT (AC_RECDAT),
    .AC_PBLRC (AC_PBLRC),
    .AC_PBDAT (AC_PBDAT),
    .AC_BCLK (AC_BCLK)
);

audio_effects audio_effects_inst (
	.clk (audio_clk),
    .sample_end (sample_end[1]),
    .sample_req (sample_req[1]),
	.volume_control(volume_control),
    .audio_output (audio_output),
    .audio_input  (audio_input),
    .feedback (FEEDBACK)
);

endmodule
