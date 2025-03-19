module clk_7segff_sub(
					input [3:0] NUM,
					output reg [6:0] a_to_g
					);
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

//clock count
//number printed on the segment LEDs
//deal the clock and clear events
//if clear button pressed,clear the clock count
//if clock flip, count clock
//决定两个数码管交替显示
module clk_7segff_top(
					input clk,
					input clr,
					output [3:0] an,
					output [6:0] a_to_g
					);
	
	reg [32:0] clk_cnt;
	reg [3:0] NUM;
	wire s;
	
	always @(posedge clk or posedge clr)
	begin
		if (clr)
			clk_cnt = 0;
		else
		begin
			clk_cnt = clk_cnt +1;
		end
	end
	
	assign s = clk_cnt[15];
	assign an[0] = ~s;             //改动
	assign an[1] = s;              //改动
	assign an[3:2] = 2'b11;
	
	always @(*)
		case (s) //take the higher four bits as number for printing
			1:NUM = clk_cnt[32:29];
			0:NUM = clk_cnt[28:25];
		endcase
	
	clk_7segff_sub A1(.NUM(NUM),.a_to_g(a_to_g)); //call the sub display module
endmodule