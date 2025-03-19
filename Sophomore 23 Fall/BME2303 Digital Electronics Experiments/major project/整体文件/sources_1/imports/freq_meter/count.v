`timescale 1ns / 1ps

module count(
    input en,
    input btn2,
    input [5:0] sw,
    input mode,
    input clk,
    input clr,
    input btn3,
    output reg [7:0] Led,
    output [3:0] an,
    output [6:0] a_to_g,
    output reg [1:0] bell_cnt,
    output reg [1:0] ring_bell_cnt,
    output reg bell,
    output reg ring_bell
);
reg [3:0] second_l; //秒数低位
reg [3:0] second_h; //秒数高位
reg [3:0] minute_l; //分钟低位
reg [3:0] minute_h; //分钟高位
reg [4:0] hour;     //小时

reg [3:0] bell_second_l; //秒数低位闹钟
reg [3:0] bell_second_h; //秒数高位闹钟
reg [3:0] bell_minute_l; //分钟低位闹钟
reg [3:0] bell_minute_h; //分钟高位闹钟
reg [4:0] bell_hour;     //小时闹钟

reg [32:0] cnt; // 时钟计数
reg [3:0] NUM;
reg clk_1Hz;      //1hz时钟
//reg bell;         //报时信号
//reg ring_bell;   //闹钟报时信号
reg ring_flag;   //亮灯信号
//reg [2:0] bell_cnt;  //整点报时3s
//reg [2:0] ring_bell_cnt; //闹钟报时

reg [4:0] tmpHour;   //输出am
reg noon; //判断am，pm
reg [1:0] mode1;  //设置时间的
reg [1:0] mode2;  //设置闹钟的

reg [5:0] tmpSW;
assign an[0] = cnt[14:13]!=0;
assign an[1] = cnt[14:13]!=1;
assign an[2] = cnt[14:13]!=2;
assign an[3] = cnt[14:13]!=3;

always @(posedge clk)begin
   if(clk)
       begin
           cnt <= cnt + 1;
           if(cnt >= 125000000) 
               begin
                   clk_1Hz = 1;
                   cnt <= 0;
               end
           else begin
               clk_1Hz = 0;
          end
      end  
   end
always @(posedge clk_1Hz)begin
 if (btn2) begin
    mode1 = mode1 + 1;
 end
end
always @(posedge clk_1Hz)begin
  if (btn3) begin
     mode2 = mode2 + 1;
  end
end   
always @(posedge clk or negedge clr) 
begin
if(clr)
   begin
   second_l <= 4'b0101;
   second_h <= 4'b0101;
   minute_l <= 4'b1001;
   minute_h <= 4'b0101;
   hour <= 5'b10000;
   end
else
   begin
   if(clk_1Hz) 
       begin
           second_l = second_l + 1;
           ring_bell = ((second_l==bell_second_l)&&(second_h==bell_second_h)
                        &&(minute_l==bell_minute_l)&&(minute_h==bell_minute_h)
                        &&(bell_hour==hour)&&(en==0)); 
           if(bell)
           begin
                bell_cnt <= bell_cnt + 1;
                if(bell_cnt >= 3) 
                begin
                    bell_cnt <= 0;
                    bell = 0;
                end
           end
            else if(ring_bell || ring_flag)
                     begin
                          ring_flag = 1;
                          ring_bell_cnt <= ring_bell_cnt + 1;
                          if(ring_bell_cnt >= 3) 
                          begin
                              ring_bell_cnt <= 0;
                              ring_flag = 0;
                          end
                     end 
       end
       
  if (mode1==0 && mode2==0)begin 
   if(second_l>= 10)
       begin
           second_l = second_l - 10;
           second_h = second_h + 1;
       end
   if(second_h>=6)
       begin
           second_h = second_h - 6;
           minute_l = minute_l + 1;
       end
    if(minute_l>=10)
       begin
           minute_l = minute_l - 10;
           minute_h = minute_h + 1;
       end
    if(minute_h>=6)
       begin
           minute_h = minute_h -6;
           hour = hour + 1;
           bell  = 1;
       end
    
    tmpHour = hour;
    
    if(mode)begin 
        if(tmpHour >= 12) begin
           if (hour>12)begin
           noon = 1;
           end else begin
           noon = 0;
           end
           tmpHour = tmpHour - 12;
        end   
      end
    else begin 
        noon = 0;
        if(hour >=24) begin
          hour = hour - 24;
        end
     end
     Led[4:0] = tmpHour;
     Led[5] = noon;
     Led[6] = bell;
     Led[7] = ring_flag;  
   case(cnt[14:13])
       0: NUM = second_l;
       1: NUM = second_h;
       2: NUM = minute_l;
       3: NUM = minute_h;
   endcase
 end //moded1=0
 
else if (mode1==1 && mode2==0) begin
  Led[5:0]=sw[5:0];
  Led[7:6]=2'b00;
  hour=sw;
  NUM=4'b1111;
end//mode1==1 

else if (mode1==2 && mode2==0)begin
    Led=8'b00000000;
    tmpSW = sw;
    minute_h<=tmpSW/10;
    minute_l<=tmpSW%10;
    case(cnt[14:13])
           0: NUM = 4'b1111;
           1: NUM = 4'b1111;
           2: NUM = minute_l;
           3: NUM = minute_h;
    
    endcase
end//mode1=2

else if (mode1==3 && mode2==0)begin
    Led=8'b00000000;
    tmpSW = sw;
    second_h<=tmpSW/10;
    second_l<=tmpSW%10;
    case(cnt[14:13])
               0: NUM = second_l;
               1: NUM = second_h;
               2: NUM = 4'b1111;
               3: NUM = 4'b1111;
    endcase
end//mode1==3

else if (mode2==1) begin
  Led[5:0]=sw[5:0];
  Led[7:6]=2'b00;
  bell_hour=sw;
  NUM=4'b1111;
end//mode2==1  
  
else if (mode2==2) begin
   Led=8'b00000000;
   tmpSW = sw;
   bell_minute_h<=tmpSW/10;
   bell_minute_l<=tmpSW%10;
   case(cnt[14:13])
          0: NUM = 4'b1111;
          1: NUM = 4'b1111;
          2: NUM = bell_minute_l;
          3: NUM = bell_minute_h; 
   endcase
end//mode2==2

else if (mode2==3) begin
   Led=8'b00000000;
   tmpSW = sw;
   bell_second_h<=tmpSW/10;
   bell_second_l<=tmpSW%10;
   case(cnt[14:13])
          0: NUM = bell_second_l;
          1: NUM = bell_second_h;
          2: NUM = 4'b1111;
          3: NUM = 4'b1111; 
   endcase
end//mode2==3 
  
  end
end
number_output A1(.NUM(NUM),.a_to_g(a_to_g));
endmodule


module number_output( //七段数码管显示数字
    input [3:0] NUM,
    output reg[6:0] a_to_g
    );
    always @(*)
        case(NUM)
            0: a_to_g = 7'b1000000;
            1: a_to_g = 7'b1111001;
            2: a_to_g = 7'b0100100;
            3: a_to_g = 7'b0110000;
            4: a_to_g = 7'b0011001;
            5: a_to_g = 7'b0010010;
            6: a_to_g = 7'b0000010;
            7: a_to_g = 7'b1111000;
            8: a_to_g = 7'b0000000;
            9: a_to_g = 7'b0010000;
            default a_to_g = 7'b1111111;
        endcase
endmodule