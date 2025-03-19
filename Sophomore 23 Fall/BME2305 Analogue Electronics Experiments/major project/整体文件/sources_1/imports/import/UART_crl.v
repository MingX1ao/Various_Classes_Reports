`timescale 1ns / 1ps
//��ģ������Ŀ�ĵ��߸����⣬UART�����趨�õ�����
module UART_crl(
    input            sys_clk  ,   //�ⲿ125MHzʱ��
    input            reset,   //ϵ�ⲿ��λ�źţ�����Ч
    
    //UART�˿�    
    input            uart_rxd ,   //UART���ն˿�
    output           uart_txd,     //UART���Ͷ˿�
    output       reg en             //ʹ���ź������ͨ������źſ��ƺ�����������ú�ͣ��
    );

//parameter define
parameter CLK_FREQ = 125000000;    //����ϵͳʱ��Ƶ��
parameter UART_BPS = 115200  ;    //���崮�ڲ�����

//wire define
wire         uart_rx_done;    //UART��������ź�
wire  [7:0]  uart_rx_data;    //UART�������ݣ�Ϊ��������Ŀ��ƣ�ͨ����������ݵ��ж�Ϊʹ�������ֵ

//*****************************************************
//**                    main code
//*****************************************************


always @(posedge sys_clk)begin          //���ݼ��̵������ʹ�������ֵ
    if(uart_rx_data==49)begin            //�������1����ʹ���źű�Ϊ1
        en=1;
    end
    else if(uart_rx_data==50)begin       //�������2����ʹ���źű�Ϊ0
        en=0;
    end

end


//���ڽ���ģ��
uart_rx #(
    .CLK_FREQ  (CLK_FREQ),
    .UART_BPS  (UART_BPS)
    )    
    u_uart_rx(
    .clk           (sys_clk     ),
    .reset         (reset   ),
    .uart_rxd      (uart_rxd    ),
    .uart_rx_done  (uart_rx_done),
    .uart_rx_data  (uart_rx_data)
    );

//���ڷ���ģ��
uart_tx #(
    .CLK_FREQ  (CLK_FREQ),
    .UART_BPS  (UART_BPS)
    )    
    u_uart_tx(
    .clk          (sys_clk     ),
    .reset        (reset   ),
    .uart_tx_en   (uart_rx_done),
    .uart_tx_data (uart_rx_data),
    .uart_txd     (uart_txd    ),
    .uart_tx_busy (            )
    );
    
endmodule
