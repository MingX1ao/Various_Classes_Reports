module ssm2603_ctrl(
    //system clock
    input                clk        ,        // ʱ���ź�
    input                reset      ,        // ��λ�ź�

    //ssm2603 interface
    //audio interface(master mode)
    input                AC_BCLK   ,        // SSM2603λʱ��
    input                AC_LRC    ,        // �����ź�
    input                AC_RECDAT ,        // ��Ƶ����
    output               AC_PBDAT ,        // ��Ƶ���
    //control interface       
    output               AC_SCL    ,        // SSM2603��SCL�ź�
    inout                AC_SDA    ,        // SSM2603��SDA�ź�

    //user interface
    input      [15:0]    dac_data   ,        // �������Ƶ����
    output               tx_done             // һ�η������
);

//parameter define
parameter    WL = 6'd16;                     // word length��Ƶ�ֳ�����

//*****************************************************
//**                    main code
//*****************************************************

//����ssm2603_config,����SSM2603�ļĴ���
ssm2603_config #(.WL(WL)) u_ssm2603_config(
    //system clock
    .clk       (clk      ),         // ʱ���ź�
    .reset     (reset    ),         // ��λ�ź�
    //ssm2603 interface
    .AC_SCL   (AC_SCL  ),         // SSM2603��SCLʱ��
    .AC_SDA   (AC_SDA  )          // SSM2603��SDA�ź�
    //user interface
);


//����audio_send��FPGA��SSM2603������Ƶ����
audio_send #(.WL(WL)) u_audio_send(
    //system reset
    .reset     (reset     ),        // ��λ�ź�
    //ssm2603 interface
    .AC_BCLK  (AC_BCLK  ),        // SSM2603λʱ��
    .AC_LRC   (AC_LRC   ),        // �����ź�
    .AC_PBDAT(AC_PBDAT),        // ��Ƶ�������
    //user interface
    .dac_data  (dac_data  ),        // Ԥ�������Ƶ����
    .tx_done   (tx_done   )         // ��������ź�
);

endmodule