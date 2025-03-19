module audio_send #(parameter WL = 6'd16) (    // WL(word length��Ƶ�ֳ�����)
    input                  reset     ,         // ��λ�ź�

    //ssm2603 interface
    input                  AC_BCLK  ,         // SSM2603λʱ��
    input                  AC_LRC   ,         // �����ź�
    output   reg           AC_PBDAT,         // ��Ƶ�������
    //user interface
    input         [15:0]   dac_data  ,         // Ԥ�������Ƶ����
    output   reg           tx_done             // ����һ����Ƶλ�����
);

//reg define
reg              aud_lrc_d0;                   // �ӳ�һ��ʱ������
reg    [ 5:0]    tx_cnt;                       // �������ݼ���
reg    [15:0]    dac_data_t;                   // Ԥ�������Ƶ���ݵ��ݴ�ֵ

//wire define
wire             lrc_edge;                     // �����ź�

//*****************************************************
//**                    main code
//*****************************************************
//Ϊ����aud_lrc�仯�ĵڶ���AUD_BCLK�����زɼ�aud_adcdat,�ӳٴ��Ĳɼ�
always @(posedge AC_BCLK or posedge reset) begin
    if(reset) begin
        aud_lrc_d0 <= 1'b0;
    end
    else
        aud_lrc_d0 <= AC_LRC;
end

// LRC�źŵı��ؼ��
assign   lrc_edge = AC_LRC ^ aud_lrc_d0; //���������audio_validƵ�ʱ��96kHz����������������һ��һ��
//assign   lrc_edge = AC_LRC & (~aud_lrc_d0);//���������audio_validƵ����48kHz������һ��ͨ��

//16λ��Ƶ�������ݼ���
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

//��Ҫ���͵���Ƶ���ݴ��з��ͳ�ȥ
always @(negedge AC_BCLK or posedge reset) begin
    if(reset) begin
        AC_PBDAT <= 1'b0;
    end
    else if(tx_cnt < WL)
        AC_PBDAT <= dac_data_t[WL - 1'd1 - tx_cnt];
    else
        AC_PBDAT <= 1'b0;
end

//16λ���ݼ�����ϣ���������ź�
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