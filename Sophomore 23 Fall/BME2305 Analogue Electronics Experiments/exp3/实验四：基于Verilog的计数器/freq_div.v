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
		count1 <= 0;  //初始化count1为0
		clk_1hz <= 0;  //初始化clk_1hz为0
	end
else
	begin
		if (count1 < 62500000)      //clk是125MHz，产生占空比50%，频率为1hz的时钟clk_1hz
			begin
				count1 <= count1 + 1;   //频率计数加一
				clk_1hz <= 1;   //clk_1hz迎来上升沿，clk_1hz=1持续0.5秒，总共62500000个1
			end
		else if (count1 < 125000000-1)
			begin
				count1 <= count1 + 1;   //频率计数加一
				clk_1hz <= 0;   //clk_1hz迎来下降沿，clk_1hz=0持续约0.5秒，总共62499999个0
			end
		else
			begin
				count1 <= 0;    //clk_1hz历经一个完整周期1秒钟，计数器清零
				clk_1hz <= 0;    //这是clk_1hz第62500000个0，clk_1hz=0持续满0.5秒
			end
	end
end

endmodule