`timescale 1ns / 1ps
module mode1(
    input btn2,
    input Clk,
    output reg [1:0]mode1
    );
    wire pulse;
    always @(posedge pulse)
    begin
        if (btn2) begin
            mode1 <= mode1+1;//0Ϊ24��1Ϊ12
        end
    end
    Debounce1 myDebounce(.Clk(Clk),
                        .pulse(pulse)); 
endmodule

module Debounce1(
    input Clk,
    output pulse
    );
    reg [24:0] d;//ȡʱ��
    always @(posedge Clk)
    begin
        d <= d + 1;
    end
    assign pulse = d[24];
endmodule

