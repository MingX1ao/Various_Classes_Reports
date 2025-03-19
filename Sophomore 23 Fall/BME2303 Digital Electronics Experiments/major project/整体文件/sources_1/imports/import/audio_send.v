module audio_send #(parameter WL = 6'd16) (    // WL(word length音频字长定义)
    input                  reset     ,         // 复位信号

    //ssm2603 interface
    input                  AC_BCLK  ,         // SSM2603位时钟
    input                  AC_LRC   ,         // 对齐信号
    output   reg           AC_PBDAT,         // 音频数据输出
    //user interface
    input         [15:0]   dac_data  ,         // 预输出的音频数据
    output   reg           tx_done             // 发送一次音频位数完成
);

//reg define
reg              aud_lrc_d0;                   // 延迟一个时钟周期
reg    [ 5:0]    tx_cnt;                       // 发送数据计数
reg    [15:0]    dac_data_t;                   // 预输出的音频数据的暂存值

//wire define
wire             lrc_edge;                     // 边沿信号

//*****************************************************
//**                    main code
//*****************************************************
//为了在aud_lrc变化的第二个AUD_BCLK上升沿采集aud_adcdat,延迟打拍采集
always @(posedge AC_BCLK or posedge reset) begin
    if(reset) begin
        aud_lrc_d0 <= 1'b0;
    end
    else
        aud_lrc_d0 <= AC_LRC;
end

// LRC信号的边沿检测
assign   lrc_edge = AC_LRC ^ aud_lrc_d0; //这个出来的audio_valid频率变成96kHz，发送两个声道，一左一右
//assign   lrc_edge = AC_LRC & (~aud_lrc_d0);//这个出来的audio_valid频率是48kHz，发送一个通道

//16位音频发送数据计数
always @(posedge AC_BCLK or posedge reset) begin
    if(reset) begin
        tx_cnt     <=  6'd0;
        dac_data_t <= 16'd0;
    end
    else if(lrc_edge == 1'b1) begin
        tx_cnt     <= 6'd0;
        dac_data_t <= dac_data;
    end
    else if(tx_cnt < 6'd19)
        tx_cnt <= tx_cnt + 1'b1;
end

//把要发送的音频数据串行发送出去
always @(negedge AC_BCLK or posedge reset) begin
    if(reset) begin
        AC_PBDAT <= 1'b0;
    end
    else if(tx_cnt < WL)
        AC_PBDAT <= dac_data_t[WL - 1'd1 - tx_cnt];
    else
        AC_PBDAT <= 1'b0;
end

//16位数据计数完毕，设置完成信号
always @(posedge AC_BCLK or posedge reset) begin
    if(reset) begin
        tx_done <= 1'b0;
    end
    else if(tx_cnt == 6'd16)
        tx_done <= 1'b1;
    else
        tx_done <= 1'b0;
end

endmodule