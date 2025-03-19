`timescale 1ns / 1ps




module Mode(
    input Flag,
    input Clk,
    output reg mode
    );
    wire pulse;
    always @(posedge pulse)
    begin
        if (Flag) begin
         if(mode)
            mode <= 0;//0为24，1为12
         else mode <= 1;
        end
    end
    Debounce myDebounce(.Clk(Clk),
                        .pulse(pulse)); 
endmodule

module Debounce(
    input Clk,
    output pulse
    );
    reg [24:0] d;//取时长
    always @(posedge Clk)
    begin
        d <= d + 1;
    end
    assign pulse = d[24];
endmodule
