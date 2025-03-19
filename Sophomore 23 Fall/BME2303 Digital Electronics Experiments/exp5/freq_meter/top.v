`timescale 1ns / 1ps

module top(clk,rst_n,clk_in,sel,data,led    //增加led
);
input clk;
input rst_n;
input clk_in;
output [3:0] sel;
output [7:0] data;
output [3:0] led;          //输出led
wire   [19:0] freq;
wire   [4:0]  TenThousand,Thousand,Hundred,Ten,One;    //增加万位

freq_count freq_count(
	.clk(clk),
	.rst_n(rst_n),
	.clk_in(clk_in),
	.freq(freq)
);

bit_calc bit_calc(
	.clk(clk),
	.rst(rst_n),
	.hex(freq),
	.TenThousand(TenThousand),   //增加万位
	.Thousand(Thousand),
	.Hundred(Hundred),
	.Ten(Ten),
	.One(One)
);

display display(
	.clk(clk),
	.TenThousand(TenThousand),    //增加万位
	.Thousand(Thousand),
	.Hundred(Hundred),
	.Ten(Ten),
	.One(One),
	.sel(sel),
	.led(led),                //增加led
	.data(data)
);

endmodule

