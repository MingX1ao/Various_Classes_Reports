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
		din = 1'b1;//��һ���ƽ�����
		#10 rst = 1'b0;
		#10 rst = 1'b1;
		#15 din = 1'b0;//�ڶ����ƽ�����
		#20 din = 1'b1;//������
		#20 din = 1'b0;//���ĸ�
		#20 din = 1'b1;//�����
		#20 din = 1'b0;//������  
	end
endmodule



