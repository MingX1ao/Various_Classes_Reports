//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/15 18:39:48
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module top(clk,
           rst_n,
           led_hours,
           an,
           sseg
);

input clk;
input rst_n;
output [4:0] led_hours;  
output [6:0] sseg;
output [3:0] an; 
wire [31:0]count1;
wire clk_1hz;
ClockDivider ClockDivider(
           .clk(clk),
           .rst_n(rst_n),
           .clk_1hz(clk_1hz),
           .count1(count1)
);
DigitalClock DigitalClock(
  .clk_1hz(clk_1hz),           
  .btn_reset(rst_n),
  .count1(count1),
  .led_hours(led_hours), 
  .sseg(sseg),
  .an(an)  
);

endmodule
