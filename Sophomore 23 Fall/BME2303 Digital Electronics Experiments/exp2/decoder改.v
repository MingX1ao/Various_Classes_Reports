`timescale 1ns / 1ps

module decode (
	input wire[2:0] in,
	output reg[7:0] led
	);

	always @(*) begin
        case(in)
            0: led=8'b00000001;
            1: led=8'b00000010;
            2: led=8'b00000100;
            3: led=8'b00001000;
            4: led=8'b00010000;
            5: led=8'b00100000;
            6: led=8'b01000000;
            7: led=8'b10000000;
            default: led=8'b00000000;
        endcase
	end
endmodule