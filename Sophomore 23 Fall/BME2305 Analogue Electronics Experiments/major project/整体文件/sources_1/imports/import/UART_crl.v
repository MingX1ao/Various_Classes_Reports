`timescale 1ns / 1ps
//本模块解决项目的第七个问题，UART控制设定好的闹铃
module UART_crl(
    input            sys_clk  ,   //外部125MHz时钟
    input            reset,   //系外部复位信号，高有效
    
    //UART端口    
    input            uart_rxd ,   //UART接收端口
    output           uart_txd,     //UART发送端口
    output       reg en             //使能信号输出，通过这个信号控制后续闹铃的启用和停用
    );

//parameter define
parameter CLK_FREQ = 125000000;    //定义系统时钟频率
parameter UART_BPS = 115200  ;    //定义串口波特率

//wire define
wire         uart_rx_done;    //UART接收完成信号
wire  [7:0]  uart_rx_data;    //UART接收数据，为键盘输入的控制，通过对这个数据的判断为使能输出赋值

//*****************************************************
//**                    main code
//*****************************************************


always @(posedge sys_clk)begin          //根据键盘的输入对使能输出赋值
    if(uart_rx_data==49)begin            //如果按下1，则使能信号变为1
        en=1;
    end
    else if(uart_rx_data==50)begin       //如果按下2，则使能信号变为0
        en=0;
    end

end


//串口接收模块
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

//串口发送模块
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
