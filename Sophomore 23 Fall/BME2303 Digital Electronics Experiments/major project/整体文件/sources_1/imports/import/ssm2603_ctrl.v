module ssm2603_ctrl(
    //system clock
    input                clk        ,        // 时钟信号
    input                reset      ,        // 复位信号

    //ssm2603 interface
    //audio interface(master mode)
    input                AC_BCLK   ,        // SSM2603位时钟
    input                AC_LRC    ,        // 对齐信号
    input                AC_RECDAT ,        // 音频输入
    output               AC_PBDAT ,        // 音频输出
    //control interface       
    output               AC_SCL    ,        // SSM2603的SCL信号
    inout                AC_SDA    ,        // SSM2603的SDA信号

    //user interface
    input      [15:0]    dac_data   ,        // 输出的音频数据
    output               tx_done             // 一次发送完成
);

//parameter define
parameter    WL = 6'd16;                     // word length音频字长定义

//*****************************************************
//**                    main code
//*****************************************************

//例化ssm2603_config,配置SSM2603的寄存器
ssm2603_config #(.WL(WL)) u_ssm2603_config(
    //system clock
    .clk       (clk      ),         // 时钟信号
    .reset     (reset    ),         // 复位信号
    //ssm2603 interface
    .AC_SCL   (AC_SCL  ),         // SSM2603的SCL时钟
    .AC_SDA   (AC_SDA  )          // SSM2603的SDA信号
    //user interface
);


//例化audio_send，FPGA向SSM2603传送音频数据
audio_send #(.WL(WL)) u_audio_send(
    //system reset
    .reset     (reset     ),        // 复位信号
    //ssm2603 interface
    .AC_BCLK  (AC_BCLK  ),        // SSM2603位时钟
    .AC_LRC   (AC_LRC   ),        // 对齐信号
    .AC_PBDAT(AC_PBDAT),        // 音频数据输出
    //user interface
    .dac_data  (dac_data  ),        // 预输出的音频数据
    .tx_done   (tx_done   )         // 发送完成信号
);

endmodule