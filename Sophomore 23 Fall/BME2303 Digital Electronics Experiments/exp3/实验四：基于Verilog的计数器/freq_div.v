`timescale 1ns / 1ps

module freq_div(
	clk,
	rst_n,
    clk_1hz
);

input clk, rst_n;
output reg clk_1hz;
reg [30:0] count1;

initial
begin
    count1 <= 0;
    clk_1hz <= 0;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
	begin
		count1 <= 0;  //��ʼ��count1Ϊ0
		clk_1hz <= 0;  //��ʼ��clk_1hzΪ0
	end
else
	begin
		if (count1 < 62500000)      //clk��125MHz������ռ�ձ�50%��Ƶ��Ϊ1hz��ʱ��clk_1hz
			begin
				count1 <= count1 + 1;   //Ƶ�ʼ�����һ
				clk_1hz <= 1;   //clk_1hzӭ�������أ�clk_1hz=1����0.5�룬�ܹ�62500000��1
			end
		else if (count1 < 125000000-1)
			begin
				count1 <= count1 + 1;   //Ƶ�ʼ�����һ
				clk_1hz <= 0;   //clk_1hzӭ���½��أ�clk_1hz=0����Լ0.5�룬�ܹ�62499999��0
			end
		else
			begin
				count1 <= 0;    //clk_1hz����һ����������1���ӣ�����������
				clk_1hz <= 0;    //����clk_1hz��62500000��0��clk_1hz=0������0.5��
			end
	end
end

endmodule