module i2c_reg_cfg #(parameter WL = 6'd16        // word length��Ƶ�ֳ���������
)(
    input                clk      ,              // i2c_reg_cfg����ʱ��
    input                reset    ,              // ��λ�ź�
    input                i2c_done ,              // I2Cһ�β�����ɷ����ź�
    output  reg          i2c_exec ,              // I2C����ִ���ź�
    output  reg          cfg_done ,              // SSM2603�������
    output  reg  [15:0]  i2c_data                // �Ĵ������ݣ�7λ��ַ+9λ���ݣ�
);

//parameter define
localparam   REG_NUM       = 5'd11;              // �ܹ���Ҫ���õļĴ�������
localparam   PHONE_VOLUME  = 6'd30;              // �������������С������0~63��
localparam   SPEAK_VOLUME  = 6'd63;              // �������������С������0~63��

//reg define
reg    [1:0]  wl            ;                    // word length��Ƶ�ֳ���������
reg    [7:0]  start_init_cnt;                    // ��ʼ��ʱ�����
reg    [4:0]  init_reg_cnt  ;                    // �Ĵ������ø���������

//*****************************************************
//**                    main code
//*****************************************************

//��Ƶ�ֳ���λ������������
always @(posedge clk or posedge reset) begin
    if(reset) begin
        wl <= 2'b00;
    end
    else begin
        case(WL)
            6'd16:begin wl <= 2'b00; end
            6'd20:begin wl <= 2'b01; end
            6'd24:begin wl <= 2'b10; end
            6'd32:begin wl <= 2'b11; end
        default: wl <= 2'd00;
        endcase
    end
end

//I2Cд������ƣ���1���͵�2���Ĵ�������ʱ��ʱһ��ʱ�䣩
always @(posedge clk or posedge reset) begin
    if(reset) begin
        start_init_cnt <= 8'b0;
    end
    else if(init_reg_cnt == 5'd1 && i2c_done) begin
        start_init_cnt <= 8'b0;
    end
    else if(start_init_cnt < 8'hff && init_reg_cnt <= 5'd1) begin
        start_init_cnt <= start_init_cnt + 1'b1;
    end
end

//����I2C��������
always @(posedge clk or posedge reset) begin
    if(reset) begin
        i2c_exec <= 1'b0;
    end
    else if(init_reg_cnt == 5'd0 & start_init_cnt == 8'hfc)
        i2c_exec <= 1'b1;
    else if(i2c_done & init_reg_cnt == 5'd1 & start_init_cnt == 8'hfc)
        i2c_exec <= 1'b1;
    else if(i2c_done && init_reg_cnt < REG_NUM)
        i2c_exec <= 1'b1;
    else
        i2c_exec <= 1'b0;
end

//���üĴ�����������
always @(posedge clk or posedge reset) begin
    if(reset) begin
        init_reg_cnt <= 5'd0;
    end
    else if(i2c_exec)
        init_reg_cnt <= init_reg_cnt + 1'b1;
end

//�Ĵ�����������ź�
always @(posedge clk or posedge reset) begin
    if(reset)
        cfg_done <= 1'b0;
    else if(i2c_done & init_reg_cnt == REG_NUM )
        cfg_done <= 1'b1;
end

//����I2C�����ڼĴ�����ַ��������
always @(posedge clk or posedge reset) begin
    if(reset) begin
        i2c_data <= 16'b0;
    end
    else begin
        case(init_reg_cnt)
            4'h0: i2c_data <= 16'b0000_1100_0001_0000; // power on everything except out. R6
            4'h1: i2c_data <= 16'b0000_0000_0001_0111; // left input. R0
            4'h2: i2c_data <= 16'b0000_0010_0001_0111; // right input. R1
            4'h3: i2c_data <= 16'b0000_0100_0111_1001; // left output. R2
            4'h4: i2c_data <= 16'b0000_0110_0111_1001; // right output. R3
    //        4'h5: i2c_data <= 16'b0000_1000_1101_0100; // analog path. R4. Microphone
            4'h5: i2c_data <= 16'b0000_1000_1101_0000; // analog path. R4. Line In
            4'h6: i2c_data <= 16'b0000_1010_0000_0100; // digital path. R5
            4'h7: i2c_data <= 16'b0000_1110_0000_0010; // digital IF. R7. Original: 16 bits, I2S mode.
//            4'h7: i2c_data <= 16'b0000_1110_0000_0001; // digital IF. R7. Original: 16 bits, left justified.
//            4'h7: i2c_data <= 16'b0000_1110_0000_1010; // digital IF. R7. shehuajun: 24 bits, I2S mode.
            4'h8: i2c_data <= 16'b0001_0000_0100_0000; // sampling rate. R8. shehuajun:MCLK=24.576MHz-->RECLRC=48KHz,PBLRC=48KHz
//            4'h8: i2c_data <= 16'b0001_0000_0000_0000; // sampling rate. R8. shehuajun:MCLK=12.288MHz-->RECLRC=48KHz,PBLRC=48KHz
//            4'h8: i2c_data <= 16'b0001_0000_0010_0000; // sampling rate. R8. Original:MCLK=11.2896MHz-->RECLRC=44.1KHz,PBLRC=44.1KHz
    //        4'h8: i2c_data <= 16'b0001_0000_0000_1100; // sampling rate. R8. shehuajun:MCLK=12.288MHz-->RECLRC=8KHz,PBLRC=8KHz
            4'h9: i2c_data <= 16'b0000_1100_0000_0000; // power on everything. R6.
            4'ha: i2c_data <= 16'b0001_0010_0000_0001; // activate. R9
            default: ;
        endcase
    end
end

endmodule