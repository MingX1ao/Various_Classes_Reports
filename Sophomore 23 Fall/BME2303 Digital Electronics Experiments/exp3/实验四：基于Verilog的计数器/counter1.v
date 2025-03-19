module top (input clk,
            input rst,
            output out,
            output out1,
            output out2,
            output out3
			);
    integer num = 0;
    reg clkdiv = 0;
    always @(posedge clk) begin
        if (num < 62500000) begin
            num = num + 1;
        end
        else begin
            num = 0;
            clkdiv = ~clkdiv;
        end
    end
	counter counter_inst(.clk(clkdiv),.rst(rst),.out(out),.out1(out1),.out2(out2),.out3(out3));
endmodule

module counter (input clk,
                input rst,
                output out,
                output out1,
                output out2,
                output out3
				);
	wire q;
	wire qn;

	dff dff(.d(qn),
			 .clk(clk),
			 .rst(rst),
			 .q(q),
			 .qn(qn)
			 );
			 
	dff dff1(.d(qn1),
            .clk(qn),
            .rst(rst),
            .q(q1),
            .qn(qn1)
             );	
	dff dff2(.d(qn2),
             .clk(qn1),
             .rst(rst),
             .q(q2),
             .qn(qn2)
             );                
     dff dff3(.d(qn3),
               .clk(qn2),
               .rst(rst),
               .q(q3),
               .qn(qn3)
              );            
	assign out = q;
	assign out1 = q1;
	assign out2 = q2;
	assign out3 = q3;
	
endmodule

module dff (input d,
            input clk,
            input rst,
            output reg q,
            output qn
			);
	always @ (posedge clk or negedge rst)
	if (!rst)
		q = 0;
	else
		q = d;
	assign qn = ~q;
endmodule

