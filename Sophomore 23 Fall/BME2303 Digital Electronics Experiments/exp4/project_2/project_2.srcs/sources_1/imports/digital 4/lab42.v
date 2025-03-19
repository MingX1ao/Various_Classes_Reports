module clk_sw_7seg_sub (
						input [3:0] NUM,
						input[3:0] sw,
						output reg [3:0] an,
						output reg [6:0] a_to_g
						);
	always @(*)
		an = ~sw;
	
	always @(*)
		case(NUM)
			0: a_to_g=7'b1000000;
			1: a_to_g=7'b1111001;
			2: a_to_g=7'b0100100;
			3: a_to_g=7'b0110000;
			4: a_to_g=7'b0011001;
			5: a_to_g=7'b0010010;
			6: a_to_g=7'b0000010;
			7: a_to_g=7'b1111000;
			8: a_to_g=7'b0000000;
			9: a_to_g=7'b0010000;
			'hA: a_to_g=7'b0001000;
			'hB: a_to_g=7'b0000011;
			'hC: a_to_g=7'b1000110;
			'hD: a_to_g=7'b0100001;
			'hE: a_to_g=7'b0000110;
			'hF: a_to_g=7'b0001110;
			default: a_to_g=7'b1000000;
		endcase
endmodule

module clk_sw_7seg_top	(
						input clk,
						input clr,
						input[3:0]sw,
						output[3:0]an,
						output[6:0]a_to_g
						);
	reg[28:0] clk_cnt; //clock count
	reg [3:0] NUM; //number printed on the segment LEDs
	
	always @(posedge clk or posedge clr) //deal the clock and clear events
	begin
		if (clr)
			clk_cnt = 0; //if clear button pressed,clear the clock count
		else
		begin
			clk_cnt = clk_cnt + 1; //if clock flip, count clock
		end
	end
	
	always @(*)
		NUM = clk_cnt[28:25]; //take the higher four bits as number for printing
	
	clk_sw_7seg_sub A1(.NUM(NUM),.sw(sw),.an(an),.a_to_g(a_to_g)); //call the sub display module
endmodule