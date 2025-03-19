`timescale 1ns / 1ps

module top(clk,clr,an,Led,a_to_g,change,renew,SW,clock
);
input clk;
input clr;
input change;
input renew;
input clock;
input [5:0] SW;
output [3:0] an;
output [7:0] Led;
output [6:0] a_to_g;

count count(
	.clk(clk),
	.clr(clr),
	.renew(renew),
	.clock(clock),
	.SW(SW),
	.change(change),
	.Led(Led),
	.an(an),
	.a_to_g(a_to_g)
);

endmodule