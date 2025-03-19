module ClockDivider (
   clk,     // 输入时钟信号
   rst_n,   // 输入复位信号
   clk_1hz,  // 输出分频后的1 Hz时钟信号
   count1  //输出原始时钟信号
);

input clk, rst_n;
output reg clk_1hz;
output reg [31:0] count1;



  always @(posedge clk or negedge rst_n) begin
    if (rst_n) begin
      count1 <= 0;      // 复位时，将计数器清零
      clk_1hz <= 0;     // 复位时，将输出信号清零
    end else begin
      if (count1 < 62500000) begin
        count1 <= count1 + 1;   // 在前半周期内，计数器递增
        clk_1hz <= 1;           // 输出信号为1
      end else if (count1 < 125000000-1) begin
        count1 <= count1 + 1;   // 在后半周期内，计数器递增
        clk_1hz <= 0;           // 输出信号为0
      end else begin
        count1 <= 0;            // 一个完整周期后，计数器清零
        clk_1hz <= 0;           // 输出信号为0
      end
    end
  end
endmodule

module DigitalClock (
   clk_1hz,           // 输入分频后的1 Hz时钟信号
   btn_reset,         // 输入复位按钮信号
   count1,            // 输入原始始终信号，用于控制an
   led_hours,   // 输出小时的LED显示
   sseg,        // 输出七段数码管显示
   an           //是能
);
input clk_1hz;
input btn_reset;
input [31:0] count1;


output reg [4:0] led_hours;
output reg [6:0] sseg;
output reg [3:0] an;



 
  reg [3:0] second1;
  reg [2:0] second2;
  reg [3:0] min1;
  reg [2:0] min2;
  reg [3:0] hour1;
  reg [1:0] hour2;
  
  always @(posedge clk_1hz) begin
     
    if (btn_reset) begin
      second1 <= 3'b000;
      second2 <= 2'b00;
      min1 <= 3'b000;
      min2 <= 2'b00;
      hour1 <= 3'b000;
      hour2 <= 2'b00;
    end else begin
      if (second1<9) begin
        second1 <= second1+1;
      end else begin
        second1 <= 0;
        if (second2<5) begin
          second2 <= second2 + 1;
        end else begin
          second2 <=0;
          if (min1<9) begin
            min1 <= min1 + 1;
          end else begin
            min1 <= 0;
            if (min2<5) begin
              min2 <= min2 + 1;
            end else begin 
              min2 <=0;
              if (hour1 <9 && hour2<2) begin
                hour1 <= hour1 + 1;
              end else if (hour1==9 && hour2<2) begin
                hour2 <= hour2 + 1;
              end else if (hour1<3 && hour2==2)begin
                hour1 <= hour1+1;
              end else if (hour1==3 && hour2==2)begin
                hour1 <= 0;
                hour2 <= 0;
              end
           end
          end
         end
        end
       end
      
 /*  
   if (second<60 && second>=50) begin
        second1=second-50;
        second2=5;
   end else if (second<50 && second>=40)begin
        second1=second-40;
        second2=4;
   end else if (second<40 && second>=30)begin
        second1=second-30;
        second2=3;
   end else if (second<30 && second>=20)begin
        second1=second-20;
        second2=2;
   end else if (second<20 && second>=10)begin
        second1=second-10;
        second2=1;
   end else if (second<10 && second>=00)begin
        second1=second;
        second2=0;
   end
  */ 
  // 将小时转换为二进制表示，并用LED灯显示

end
reg [3:0] data_dis;
  always@(count1[20]) 
	begin
		case(count1[21:20])
		        0:  begin
                        data_dis<=min2;
                        an<=4'b1000;
                    end
                1:  begin
                        data_dis<=min1;
                        an<=4'b0100;
                    end
                2:  begin
                        data_dis<=second2;
                        an<=4'b0010;        
                    end
                3:  begin
                        data_dis<=second1;
                        an<=4'b0001;
                    end
                /*
                default:  begin
                        data_dis<=4'b1111;
                        an<=4'b0000;
                    end    
		       */    
		endcase
	end
  	always@(data_dis)
    begin
        case(data_dis)                //七段译码
                         0: sseg=7'b1000000;
                         1: sseg=7'b1111001;
                         2: sseg=7'b0100100;
                         3: sseg=7'b0110000;
                         4: sseg=7'b0011001;
                         5: sseg=7'b0010010;
                         6: sseg=7'b0000010;
                         7: sseg=7'b1111000;
                         8: sseg=7'b0000000;
                         9: sseg=7'b0010000;
                         //default: sseg=7'b0000000;
        endcase
    end


endmodule
