module UART_crl(
    input            sys_clk  ,   //外部125MHz时钟
    input            reset,   //系外部复位信号，高有效
    
    //UART端口    
    input            uart_rxd ,   //UART接收端口
    output           uart_txd,     //UART发送端口
    output   [7:0]   led
    );

//parameter define
parameter CLK_FREQ = 125000000;    //定义系统时钟频率
parameter UART_BPS = 115200  ;    //定义串口波特率

//wire define
wire         uart_rx_done;    //UART接收完成信号
wire  [7:0]  uart_rx_data;    //UART接收数据

//*****************************************************
//**                    main code
//*****************************************************

assign led = uart_rx_data;

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
