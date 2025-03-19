module audio_effects (
    input  clk,
    input  sample_end,
    input  sample_req,
	input  [1:0]  volume_control,
    output [15:0] audio_output,
    input  [15:0] audio_input,
    input  feedback
);

reg [15:0] last_sample;
reg [15:0] dat;

assign audio_output = dat;

always @(posedge clk) begin
    if (sample_end) begin
        last_sample <= audio_input;
    end

    if (sample_req) begin
        if (feedback)
            dat <= last_sample * volume_control;
        else
            dat <= 16'd0;
    end
end

endmodule
