`timescale 1ns/1ps
module shifter4_tb();
	reg din;
	reg clk;
	reg rst;
	wire dout;
	always #10 clk = ~clk;
	shifter4 shifter4_inst(.din(din),.clk(clk),.rst(rst),.dout(dout));
	initial begin
		clk = 1'b0;
		rst = 1'b1;
		din = 1'b1;//第一个移进的数
		#10 rst = 1'b0;
		#10 rst = 1'b1;
		#15 din = 1'b0;//第二个移进的数
		#20 din = 1'b1;//第三个
		#20 din = 1'b0;//第四个
		#20 din = 1'b1;//第五个
		#20 din = 1'b0;//第六个  
	end
endmodule



