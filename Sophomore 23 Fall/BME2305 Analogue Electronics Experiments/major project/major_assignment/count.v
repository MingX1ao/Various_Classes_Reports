`timescale 1ns / 1ps

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
            default a_to_g = 7'b1000000;
        endcase
endmodule

module count(
    input clk,
    input clr,
    input renew,
    input clock,
    input change,
    input [5:0]SW,
    output [7:0] Led,
    output [3:0]an,
    output [6:0] a_to_g
);
reg [3:0] second_l; //秒数低位
reg [3:0] second_h; //秒数高位
reg [3:0] minute_l; //分钟低位
reg [3:0] minute_h; //分钟高位
reg [4:0] hour;     //小时.
reg [4:0] hour12;   //12小时制
reg [32:0] cnt; // 时钟计数
reg [3:0] NUM;
reg jin_flag;
reg zheng_flag;
reg h_state; //12/24小时制 0:12/1:24
reg change_flag;
reg [32:0] zheng_cnt;
reg [32:0] ring_cnt;
reg ring_flag;
reg [1:0] set_mode;
reg renew_flag;
reg clock_flag;
reg [4:0] n_hour;
reg [3:0] n_second_l;
reg [3:0] n_second_h;
reg [3:0] n_minute_l;
reg [3:0] n_minute_h;
reg [4:0] chour;
reg [3:0] csecond_l;
reg [3:0] csecond_h;
reg [3:0] cminute_l;
reg [3:0] cminute_h;
reg c_state;
reg s_state;
reg clock_mode;
assign an[0] = cnt[14:13]!=0||(((set_mode == 3? 0:1)&&(set_mode == 0? 0:1))||(set_mode == 1? 1:0));
assign an[1] = cnt[14:13]!=1||(((set_mode == 3? 0:1)&&(set_mode == 0? 0:1))||(set_mode == 1? 1:0));
assign an[2] = cnt[14:13]!=2||(((set_mode == 2? 0:1)&&(set_mode == 0? 0:1))||(set_mode == 1? 1:0));
assign an[3] = cnt[14:13]!=3||(((set_mode == 2? 0:1)&&(set_mode == 0? 0:1))||(set_mode == 1? 1:0));

always @(posedge clk)
   if(clk)
       begin
           cnt <= cnt + 1;
           if(cnt >= 125000000) 
               begin
                   jin_flag = 1;
                   cnt <= 0;
               end
           else 
               jin_flag = 0;
       end
       
always @(posedge clk) 
begin
if(change_flag&&(!change))
    begin
        if(h_state == 0) h_state = 1;
        else h_state = 0;
    end
    change_flag = change;
if(renew_flag&&(!renew))
    begin
        if(c_state == 0)
        begin
            if(s_state == 0)
            begin
                s_state = 1;
            end
            set_mode = set_mode + 1;
	    if(set_mode == 0) s_state = 0;
         end
    end
    renew_flag = renew;
if(clock_flag&&(!clock))
    begin
        if(s_state == 0)
        begin
            if(c_state == 0)
            begin
                c_state = 1;
            end
            set_mode = set_mode + 1;
	    if(set_mode == 0) c_state = 0;
         end
    end
    clock_flag = clock;
case(set_mode)
    0: begin
            n_hour = hour;
            n_second_l = second_l;
            n_second_h = second_h;
            n_minute_l = minute_l;
            n_minute_h = minute_h;
       end
    1: begin
            n_hour = SW[4:0];
       end
    2: begin
            n_minute_l = SW[5:0]%10;
            n_minute_h = SW[5:0]/10;
       end
    3:begin
            n_second_l = SW[5:0]%10;
            n_second_h = SW[5:0]/10;
      end
endcase
if(s_state == 1)
begin
hour = n_hour;
hour12 = n_hour%12;
second_l = n_second_l;
second_h = n_second_h;
minute_l = n_minute_l;
minute_h = n_minute_h;
end
if(c_state == 1)
begin
chour = n_hour;
csecond_l = n_second_l;
csecond_h = n_second_h;
cminute_l = n_minute_l;
cminute_h = n_minute_h;
end
if(clr)
   begin
   second_l <= 0;
   second_h <= 0;
   minute_l <= 0;
   minute_h <= 0;
   hour <=0;
   end
else
   begin
   if(jin_flag) 
       begin
           second_l = second_l + 1;
           if(zheng_flag)
           begin
                zheng_cnt <= zheng_cnt + 1;
                if(zheng_cnt >= 3) 
                begin
                    zheng_cnt <= 0;
                    zheng_flag = 0;
                end
           end 
           if(ring_flag)
           begin
               ring_cnt <= ring_cnt + 1;
               if(ring_cnt >= 3) 
               begin
                   ring_cnt <= 0;
                   ring_flag = 0;
               end
          end 
       end
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
           hour12 = hour12 + 1;
           zheng_flag  = 1;
       end
    if(hour >=24)
        begin
            hour = hour - 24;
        end
    if(hour12 >= 12)
        begin 
            hour12 = hour12 - 12;
        end
    if(hour == chour && minute_h == cminute_h && minute_l == cminute_l && csecond_l == second_l && csecond_h == second_h)
    begin   
       ring_flag = 1; 
    end
   case(cnt[14:13])
       0: NUM = set_mode == 3? n_second_l:second_l;
       1: NUM = set_mode == 3? n_second_h:second_h;
       2: NUM = set_mode == 2? n_minute_l:minute_l;
       3: NUM = set_mode == 2? n_minute_h:minute_h;
   endcase
   end
end
number_output A1(.NUM(NUM),.a_to_g(a_to_g));
assign Led[4:0] = set_mode == 1? n_hour:(h_state == 1? hour:hour12);
assign Led[5] = set_mode == 0? (h_state == 1? 0: hour/12):0;
assign Led[6] = set_mode == 0? zheng_flag:0;
assign Led[7] = set_mode == 0? ring_flag:0;
endmodule
