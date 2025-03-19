`timescale  1ns/1ns
module  tft_char
(
    input   wire            sys_clk,    //���빤��ʱ��,Ƶ��125MHz
    input   wire            sys_rst_n,  //���븴λ�ź�,�͵�ƽ��Ч
    output  wire    [23:0]  tft_rgb,    //���������Ϣ
    output  wire            tft_clk,    //���TFTʱ���ź�
    output  wire            tft_de,     //���TFTʹ���ź�
    output  wire            tft_disp,   //�����ʾ�ź�
    output  wire            tft_hs,     //�����ͬ���ź�
    output  wire            tft_vs,     //�����ͬ���ź�
    output  wire            tft_bl      //��������ź�
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//

//wire  define
wire            tft_clk_33m;    //TFT����ʱ��,Ƶ��33.3MHz
wire            locked;         //PLL locked�ź�
wire            rst_n;          //TFTģ�鸴λ�ź�
wire    [10:0]  pix_x;          //TFT��Ч��ʾ����X������
wire    [10:0]  pix_y;          //TFT��Ч��ʾ����Y������
wire    [23:0]  pix_data;       //TFT���ص�ɫ����Ϣ

assign tft_disp = 1'b1;

//rst_n:VGAģ�鸴λ�ź�
assign  rst_n = (sys_rst_n & locked);

//********************************************************************//
//*************************** Instantiation **************************//
//********************************************************************//

//------------- clk_wiz_0_inst -------------
clk_wiz_0 uclk_wiz (
    .clk_in1(sys_clk),      //����125MHz����ʱ��,1bit
	.reset(~sys_rst_n),     //���븴λ�ź�,�ߵ�ƽ��Ч,1bit
    .clk_out1(tft_clk_33m), //���TFT����ʱ��,Ƶ��33Mhz,1bit
	.locked(locked)         //���pll locked�ź�,1bit
);

//------------- tft_ctrl_inst -------------
tft_ctrl    tft_ctrl_inst
(
    .tft_clk_33m    (tft_clk_33m),  //����ʱ��,Ƶ��33.3MHz,1bit
    .sys_rst_n      (rst_n),        //ϵͳ��λ,�͵�ƽ��Ч,1bit
    .pix_data       (pix_data),     //����ʾ����,24bit
    .pix_x          (pix_x),        //���TFT��Ч��ʾ�������ص�X������,11bit
    .pix_y          (pix_y),        //���TFT��Ч��ʾ�������ص�Y������,11bit
    .tft_rgb        (tft_rgb),      //���TFT��ʾ����,24bit
    .tft_hs         (tft_hs),       //���TFT��ͬ���ź�,1bit
    .tft_vs         (tft_vs),       //���TFT��ͬ���ź�,1bit
    .tft_clk        (tft_clk),      //���TFT����ʱ��,1bit
    .tft_de         (tft_de),       //���TFT����ʹ��,1bit
    .tft_bl         (tft_bl)        //���TFT�����ź�,1bit
);

//------------- tft_pic_inst -------------

tft_disp tft_disp_inst
(
    .tft_clk    (tft_clk),  //���빤��ʱ��,Ƶ��33MHz,1bit
    .sys_rst_n  (rst_n),    //���븴λ�ź�,�͵�ƽ��Ч,1bit
    .pix_x      (pix_x),    //����TFT��Ч��ʾ�������ص�X������,11bit
    .pix_y      (pix_y),    //����TFT��Ч��ʾ�������ص�Y������,11bit
    .pix_data   (pix_data)  //������ص�ɫ����Ϣ,24bit
);

endmodule