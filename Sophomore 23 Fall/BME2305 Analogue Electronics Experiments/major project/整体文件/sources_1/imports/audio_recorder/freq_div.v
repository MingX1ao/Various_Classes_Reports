`timescale 1ns / 1ps

module freq_div(
	clk_12MHz,
	reset,
    clk_48kHz
);

input clk_12MHz, reset;
output reg clk_48kHz;
reg [30:0] count1;

initial
begin
    count1 <= 0;
    clk_48kHz <= 0;
end

always @(posedge clk_12MHz or posedge reset)
begin
if(reset)
	begin
		count1 <= 0;  //��ʼ��count1Ϊ0
		clk_48kHz <= 0;  //��ʼ��clk_48kHzΪ0
	end
else
	begin
		if (count1 < 128)      //clk_12MHz��12.288MHz������ռ�ձ�50%��Ƶ��Ϊ48kHz��ʱ��clk_48kHz
			begin
				count1 <= count1 + 1;   //Ƶ�ʼ�����һ
				clk_48kHz <= 1;   //clk_48kHzӭ�������أ�clk_48kHz=1����0.5���ڣ��ܹ�128��1
			end
		else if (count1 < 256-1)
			begin
				count1 <= count1 + 1;   //Ƶ�ʼ�����һ
				clk_48kHz <= 0;   //clk_48kHzӭ���½��أ�clk_48kHz=0����Լ0.5���ڣ��ܹ�127��0
			end
		else
			begin
				count1 <= 0;    //clk_48kHz����һ���������ڣ�����������
				clk_48kHz <= 0;    //����clk_48kHz��128��0��clk_48kHz=0������0.5����
			end
	end
end

endmodule