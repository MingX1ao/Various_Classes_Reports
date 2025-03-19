module i2c_config (
    input clk,
    input reset,

    output i2c_sclk,
    inout  i2c_sdat,

    output [3:0] status
);

reg [23:0] i2c_data;
reg [15:0] lut_data;
reg [3:0]  lut_index = 4'd0;

parameter LAST_INDEX = 4'ha;

reg  i2c_start = 1'b0;
wire i2c_done;
wire i2c_ack;

i2c_controller i2c_controller_inst (
    .clk (clk),
    .i2c_sclk (i2c_sclk),
    .i2c_sdat (i2c_sdat),
    .i2c_data (i2c_data),
    .start (i2c_start),
    .done (i2c_done),
    .ack (i2c_ack)
);

always @(*) begin
    case (lut_index)
        4'h0: lut_data <= 16'b0000_1100_0001_0000; // power on everything except out. R6
        4'h1: lut_data <= 16'b0000_0000_0001_0111; // left input. R0
        4'h2: lut_data <= 16'b0000_0010_0001_0111; // right input. R1
        4'h3: lut_data <= 16'b0000_0100_0111_1001; // left output. R2
        4'h4: lut_data <= 16'b0000_0110_0111_1001; // right output. R3
//        4'h5: lut_data <= 16'b0000_1000_1101_0100; // analog path. R4. Microphone
        4'h5: lut_data <= 16'b0000_1000_1101_0000; // analog path. R4. Line In
        4'h6: lut_data <= 16'b0000_1010_0000_0100; // digital path. R5
        4'h7: lut_data <= 16'b0000_1110_0000_0001; // digital IF. R7. 16 bits, left justified.
//        4'h7: lut_data <= 16'b0000_1110_0000_0010; // digital IF. R7. 16 bits, I2S mode.
        4'h8: lut_data <= 16'b0001_0000_0010_0000; // sampling rate. R8. MCLK=11.2896MHz-->RECLRC=44.1KHz,PBLRC=44.1KHz
//        4'h8: lut_data <= 16'b0001_0000_0000_1100; // sampling rate. R8. MCLK=12.288MHz-->RECLRC=8KHz,PBLRC=8KHz
        4'h9: lut_data <= 16'b0000_1100_0000_0000; // power on everything. R6.
        4'ha: lut_data <= 16'b0001_0010_0000_0001; // activate. R9
        default: lut_data <= 16'b0000_0000_0000_0000;   
    endcase
end

reg [1:0] control_state = 2'b00;

assign status = lut_index;

always @(posedge clk) begin
    if (reset) begin
        lut_index <= 4'd0;
        i2c_start <= 1'b0;
        control_state <= 2'b00;
    end else begin
        case (control_state)
            2'b00: begin
                i2c_start <= 1'b1;
                i2c_data <= {8'h34, lut_data};
                control_state <= 2'b01;
            end
            2'b01: begin
                i2c_start <= 1'b0;
                control_state <= 2'b10;
            end
            2'b10: if (i2c_done) begin
                if (i2c_ack) begin
                    if (lut_index == LAST_INDEX)
                        control_state <= 2'b11;
                    else begin
                        lut_index <= lut_index + 1'b1;
                        control_state <= 2'b00;
                    end
                end else
                    control_state <= 2'b00;
            end
        endcase
    end
end

endmodule
