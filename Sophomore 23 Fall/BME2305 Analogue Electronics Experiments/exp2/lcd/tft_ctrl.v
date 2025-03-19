`timescale  1ns/1ns
module  tft_ctrl
(
    input   wire            tft_clk_33m,    //����ʱ��,Ƶ��33.3MHz
    input   wire            sys_rst_n,  //ϵͳ��λ,�͵�ƽ��Ч
    input   wire    [23:0]  pix_data,   //����ʾ����
    output  wire    [10:0]  pix_x,      //���TFT��Ч��ʾ�������ص�X������
    output  wire    [10:0]  pix_y,      //���TFT��Ч��ʾ�������ص�Y������
    output  wire    [23:0]  tft_rgb,    //TFT��ʾ����
    output  wire            tft_hs,     //TFT��ͬ���ź�
    output  wire            tft_vs,     //TFT��ͬ���ź�
    output  wire            tft_clk,    //TFT����ʱ��
    output  wire            tft_de,     //TFT����ʹ��
    output  wire            tft_bl      //TFT�����ź�
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//

//parameter define
parameter H_SYNC   =   11'd1,       //��ͬ��
          H_BACK    =   11'd46,     //��ʱ�����
          H_VALID   =   11'd800,    //����Ч����
          H_FRONT   =   11'd210,    //��ʱ��ǰ��
          H_TOTAL   =   11'd1057;   //��ɨ������

parameter V_SYNC   =   11'd1,       //��ͬ��
          V_BACK    =   11'd23,     //��ʱ�����
          V_VALID   =   11'd480,    //����Ч����
          V_FRONT   =   11'd22,     //��ʱ��ǰ��
          V_TOTAL   =   11'd526;    //��ɨ������

//wire  define
wire            rgb_valid;          //VGA��Ч��ʾ����
wire            pix_data_req;       //���ص�ɫ����Ϣ�����ź�

//reg   define
reg     [10:0]   cnt_h;     //��ɨ�������
reg     [10:0]   cnt_v;     //��ɨ�������

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//tft_clk,tft_de,tft_bl��TFT����ʱ�ӡ�����ʹ�ܡ������ź�
assign  tft_clk = tft_clk_33m;
assign  tft_de  = rgb_valid;
assign  tft_bl  = sys_rst_n;

//cnt_h:��ͬ���źż�����
always@(posedge tft_clk_33m or  negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_h   <=  11'd0   ;
    else    if(cnt_h == H_TOTAL - 1'd1)
        cnt_h   <=  11'd0   ;
    else
        cnt_h   <=  cnt_h + 1'd1   ;

//tft_hs:��ͬ���ź�
assign  tft_hs = (cnt_h  <=  H_SYNC - 1'd1) ? 1'b1 : 1'b0  ;

//cnt_v:��ͬ���źż�����
always@(posedge tft_clk_33m or  negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_v   <=  11'd0 ;
    else    if((cnt_v == V_TOTAL - 1'd1) &&  (cnt_h == H_TOTAL-1'd1))
        cnt_v   <=  11'd0 ;
    else    if(cnt_h == H_TOTAL - 1'd1)
        cnt_v   <=  cnt_v + 1'd1 ;
    else
        cnt_v   <=  cnt_v ;

//tft_vs:��ͬ���ź�
assign  tft_vs = (cnt_v  <=  V_SYNC - 1'd1) ? 1'b1 : 1'b0  ;

//rgb_valid:VGA��Ч��ʾ����
assign  rgb_valid = (((cnt_h >= H_SYNC + H_BACK)
                    && (cnt_h < H_SYNC + H_BACK + H_VALID))
                    &&((cnt_v >= V_SYNC + V_BACK)
                    && (cnt_v < V_SYNC + V_BACK + V_VALID)))
                    ? 1'b1 : 1'b0;

//pix_data_req:���ص�ɫ����Ϣ�����ź�,��ǰrgb_valid�ź�һ��ʱ������
assign  pix_data_req = (((cnt_h >= H_SYNC + H_BACK - 1'b1)
                    && (cnt_h < H_SYNC + H_BACK + H_VALID - 1'b1))
                    &&((cnt_v >= V_SYNC + V_BACK)
                    && (cnt_v < V_SYNC + V_BACK + V_VALID)))
                    ? 1'b1 : 1'b0;

//pix_x,pix_y:VGA��Ч��ʾ�������ص�����
assign  pix_x = (pix_data_req == 1'b1)
                ? (cnt_h - (H_SYNC + H_BACK - 1'b1)) : 11'h3ff;
assign  pix_y = (pix_data_req == 1'b1)
                ? (cnt_v - (V_SYNC + V_BACK )) : 11'h3ff;

//tft_rgb:������ص�ɫ����Ϣ
assign  tft_rgb = (rgb_valid == 1'b1) ? pix_data : 24'b0 ;

endmodule