`timescale 1ns / 1ps

module display(
	clk,
	Thousand,
	Hundred,
	Ten,
	One,
	sel,
	data
);
	input clk;
	input [3:0]Thousand,Hundred,Ten,One;
	output reg [7:0] data;
	output reg [3:0] sel;

	reg [3:0] cnt,data_dis;
	reg [20:0] m;
		 
	always@(posedge clk) 
	begin
		m<=m+1;
	end
  
	always@(m[15]) 
	begin
		case(m[17:15])
		0:  begin
				data_dis<=4'b1111;
				sel<=4'b0000;
			end
		1:  begin
				data_dis<=Thousand;
				sel<=4'b0111;
			end
		2:  begin
				data_dis<=Hundred;
				sel<=4'b1011;		
			end
		3:  begin
				data_dis<=Ten;
				sel<=4'b1101;
			end
		4:  begin
				data_dis<=One;	
				sel<=4'b1110;		
			end
		default:  begin
				data_dis<=4'b1111;
				sel<=4'b0000;
			end	
		endcase
	end

	always@(data_dis)
	begin
		case(data_dis)				//七段译码
			4'h0:data = 8'b11000000;		//显示0
			4'h1:data = 8'b11111001;		//显示1
			4'h2:data = 8'b10100100;		//显示2
			4'h3:data = 8'b10110000;		//显示3
			4'h4:data = 8'b10011001;		//显示4
			4'h5:data = 8'b10010010;		//显示5
			4'h6:data = 8'b10000010;		//显示6
			4'h7:data = 8'b11111000;		//显示7
			4'h8:data = 8'b10000000;		//显示8
			4'h9:data = 8'b10010000;		//显示9
			4'hF:data = 8'b11111111;		//不显示
			default data = 8'hxx;
		endcase
	end
endmodule
