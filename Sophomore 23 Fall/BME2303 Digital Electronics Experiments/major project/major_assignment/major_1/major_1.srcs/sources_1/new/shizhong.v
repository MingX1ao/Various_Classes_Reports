module ClockDivider (
   clk,     // ����ʱ���ź�
   rst_n,   // ���븴λ�ź�
   clk_1hz,  // �����Ƶ���1 Hzʱ���ź�
   count1  //���ԭʼʱ���ź�
);

input clk, rst_n;
output reg clk_1hz;
output reg [31:0] count1;



  always @(posedge clk or negedge rst_n) begin
    if (rst_n) begin
      count1 <= 0;      // ��λʱ��������������
      clk_1hz <= 0;     // ��λʱ��������ź�����
    end else begin
      if (count1 < 62500000) begin
        count1 <= count1 + 1;   // ��ǰ�������ڣ�����������
        clk_1hz <= 1;           // ����ź�Ϊ1
      end else if (count1 < 125000000-1) begin
        count1 <= count1 + 1;   // �ں�������ڣ�����������
        clk_1hz <= 0;           // ����ź�Ϊ0
      end else begin
        count1 <= 0;            // һ���������ں󣬼���������
        clk_1hz <= 0;           // ����ź�Ϊ0
      end
    end
  end
endmodule

module DigitalClock (
   clk_1hz,           // �����Ƶ���1 Hzʱ���ź�
   btn_reset,         // ���븴λ��ť�ź�
   count1,            // ����ԭʼʼ���źţ����ڿ���an
   led_hours,   // ���Сʱ��LED��ʾ
   sseg,        // ����߶��������ʾ
   an           //����
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
  // ��Сʱת��Ϊ�����Ʊ�ʾ������LED����ʾ

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
        case(data_dis)                //�߶�����
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
