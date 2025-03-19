module ssm2603_config(
    //system clock
    input        clk     ,                 // ʱ���ź�
    input        reset   ,                 // ��λ�ź�

    //ssm2603 interface
    output       AC_SCL ,                 // SSM2603��SCLʱ��
    inout        AC_SDA                   // SSM2603��SDA�ź�

    //user interface
);

//parameter define
parameter        SLAVE_ADDR =  7'b0011010   ;  // SSM2603 I2C������ַ
parameter        WL         =  6'd16        ;  // word length��Ƶ�ֳ���������
parameter        BIT_CTRL   =  1'b0         ;  // �ֵ�ַλ���Ʋ���(16b/8b)
parameter        CLK_FREQ   = 26'd24_576_000;  // i2c_driģ�������ʱ��Ƶ��(CLK_FREQ)
parameter        I2C_FREQ   = 18'd122_880   ;  // I2C��SCLʱ��Ƶ��

//wire define
wire             clk_i2c   ;               // i2c�Ĳ���ʱ��
wire             i2c_exec  ;               // i2c��������
wire             i2c_done  ;               // i2c����������־
wire             cfg_done  ;               // SSM2603������ɱ�־
wire   [15:0]    reg_data  ;               // SSM2603��Ҫ���õļĴ�������ַ�����ݣ�

//*****************************************************
//**                    main code
//*****************************************************

//����i2c_dri,����IICЭ��
i2c_dri #(
    .SLAVE_ADDR  (SLAVE_ADDR),             // slave address�ӻ���ַ���Ŵ˴������������
    .CLK_FREQ    (CLK_FREQ  ),             // i2c_driģ�������ʱ��Ƶ��(CLK_FREQ)
    .I2C_FREQ    (I2C_FREQ  )              // I2C��SCLʱ��Ƶ��
) u_i2c_dri(
    //global clock
    .clk         (clk       ),             // i2c_driģ�������ʱ��(CLK_FREQ)
    .reset       (reset     ),             // ��λ�ź�
    //i2c interface
    .i2c_exec    (i2c_exec  ),             // I2C����ִ���ź�
    .bit_ctrl    (BIT_CTRL  ),             // ������ַλ����(16b/8b)
    .i2c_rh_wl   (1'b0      ),             // I2C��д�����ź�
    .i2c_addr    (reg_data[15:8]),         // I2C�����ֵ�ַ
    .i2c_data_w  (reg_data[ 7:0]),         // I2CҪд������
    .i2c_data_r  (),                       // I2C����������
    .i2c_done    (i2c_done  ),             // I2Cһ�β������
    .scl         (AC_SCL   ),             // I2C��SCLʱ���ź�
    .sda         (AC_SDA   ),             // I2C��SDA�ź�
    //user interface
    .dri_clk     (clk_i2c   )              // I2C����ʱ��
);

//����i2c_reg_cfgģ�飬����SSM2603�ļĴ���
i2c_reg_cfg #(.WL(WL)                      // word length��Ƶ�ֳ���������
) u_i2c_reg_cfg(
    //clock & reset
    .clk         (clk_i2c  ),              // i2c_reg_cfg����ʱ��(һ��ȡ1MHz)
    .reset       (reset    ),              // ��λ�ź�
    //i2c interface
    .i2c_done    (i2c_done ),              // I2Cһ�β�����ɵķ����ź�            
    .i2c_exec    (i2c_exec ),              // I2C����ִ���ź�
    .cfg_done    (cfg_done ),              // SSM2603�������
    .i2c_data    (reg_data )               // �Ĵ������ݣ�7λ��ַ+9λ���ݣ�
);

endmodule