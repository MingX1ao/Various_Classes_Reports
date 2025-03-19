module shifter4(din,clk,rst,dout);
	input din;
	input clk;
	input rst;
	output dout;
	wire dout;
	reg [3:0] t;
	assign dout = t[0];
	always @(posedge clk or negedge rst)
	begin
		if(!rst) begin
			t <= 4'b0000;//����ֵ
		end
		else begin
			t = {din,t[3],t[2],t[1]};//����ƴ�ӷ�������λ����
		end
	end
endmodule