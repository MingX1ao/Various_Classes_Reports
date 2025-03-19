module clk_7seg99_sub(
					input [3:0] NUM,
					output reg[6:0] a_to_g
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

module B7_to_D2(
	input [6:0] B_7,
	output [7:0] D_2);
	reg [3:0] c;
	reg [7:0] q;
	assign D_2 = {c,q[3:0]};
	
	always @(*)
	begin
		c = B_7[6:0]/10;
		q = (B_7[6:0]%10);
	end
endmodule

module clk_7seg99_top(
					input clk,
					input clr,
					input pause,
					output [3:0] an,
					output [6:0] a_to_g
					);
	reg [30:0] clk_cnt;
	reg [3:0] NUM;
	reg [16:0] s;
	reg p_flag;
	wire [7:0] temp;
	wire [7:0] temp_1;
	
	always @(posedge clk or posedge clr)
	begin
		if (clr)
			clk_cnt = 0;
		else if (!p_flag)
		begin
		    if (clk_cnt[30:24] < 99)
			    clk_cnt = clk_cnt + 1;
			else
			    clk_cnt = 0;
		end
	end
	
	always @(posedge pause)
		p_flag = ~p_flag;
	
	always @(posedge clk)
	begin
		if (clk)
		begin
			s = s + 1;
			if (s[16])
				s = 0;
		end
	end
	
	assign temp_1 = clk_cnt[30:24];
	assign an[0] = s[15];
	assign an[1] = ~s[15];
	assign an[3:2] = 2'b11;

	always @(*)
		case (s[15])
            1:NUM = temp[7:4];
            0:NUM = temp[3:0];
		endcase
	
	B7_to_D2 C1(temp_1, temp);
	clk_7seg99_sub A1(.NUM(NUM),.a_to_g(a_to_g));
endmodule