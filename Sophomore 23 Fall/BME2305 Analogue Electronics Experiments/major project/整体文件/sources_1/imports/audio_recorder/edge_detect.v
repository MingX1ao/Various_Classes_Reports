module edge_detect (
    input wire clk,
    input wire rst,
    input wire signal_in,
    output reg pos_edge,
    output reg neg_edge
);

reg [1:0] buff = 2'b00;

// edge_detect_proc
always @(posedge clk or posedge rst) begin
    if (rst) begin
        buff <= 2'b00;
    end else if (clk) begin
        buff[0] <= signal_in;
        buff[1] <= buff[0];
    end
end

always @ (*) begin
    pos_edge <= buff[0] & ~buff[1];
    neg_edge <= ~buff[0] & buff[1];
end

endmodule
