`timescale 1ns / 1ps

module freq_count(
	clk,
	rst_n,
	clk_in,
	freq
);//ʱ ӡ   λ źš           źš      Ƶ  ֵ
input clk,rst_n,clk_in;
output [19:0] freq;

reg [19:0] freq;
reg [30:0] count1, count2;
reg clk_1hz, en;

wire load, clr;
//  Ƶ
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
	begin
		count1 <= 0;  //  ʼ  count1Ϊ0
		clk_1hz <= 0;  //  ʼ  clk_1hzΪ0
	end
else
	begin
		if (count1 < 62500000)      //clk  125MHz      ռ ձ 50%  Ƶ  Ϊ1hz  ʱ  clk_1hz
			begin
				count1 <= count1 + 1;   //Ƶ ʼ     һ
				clk_1hz <= 1;   //clk_1hzӭ       أ clk_1hz=1    0.5 룬 ܹ 62500000  1
			end
		else if (count1 < 125000000-1)
			begin
				count1 <= count1 + 1;   //Ƶ ʼ     һ
				clk_1hz <= 0;   //clk_1hzӭ   ½  أ clk_1hz=0    Լ0.5 룬 ܹ 62499999  0
			end
		else
			begin
				count1 <= 0;    //clk_1hz    һ          1   ӣ           
				clk_1hz <= 0;    //    clk_1hz  62500000  0  clk_1hz=0      0.5  
			end
	end
end
	   
always @(posedge clk_1hz or negedge rst_n)  //  ⵽clk_1hz     أ   rst_n ½   
begin
    if (!rst_n)
        en <= 0;
    else
        begin
            en <= ~en;    //ȡ    enΪ ߵ ƽ  ʱ  Ϊ1s
        end
end

assign load = ~en;                   //load   ź   Զ  ʹ   ź en Ƿ   
assign clr = load && (~clk_1hz);     //  loadΪ1  clk_1hzΪ0ʱ     ź clr  Ч
 
always @(posedge clk_in or posedge clr)  //    clk_in     أ   clr      
begin
	if (clr)
		count2 <= 0;         //     ź ʱ        count2Ϊ0
	else
    begin
        if (en)        //ʹ   ź ʱ    ʼ    
            count2 <= count2 + 1;  //    ⵽     źŵ       ʱ             ֵ  Ϊ źŵ Ƶ  ֵ
        else
            count2 <= count2;   //  ʹ   ź enΪ0   ̶ Ƶ ʼ   ֵ  load  en   򣬴Ӷ        ³      Ƶ  ?
    end
end

always @(posedge load or negedge rst_n)     //loadΪ         Ƶ ʣ rst_nΪ ½   Ƶ    0
begin
	if(!rst_n)
		freq <= 0;
	else 
    begin
        if(count2 < 100000)     //将10000改为100000，得到count2从0到99999的变化
            freq <= count2;
    end
end

endmodule
