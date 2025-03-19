module ssm2603_config(
    //system clock
    input        clk     ,                 // 时钟信号
    input        reset   ,                 // 复位信号

    //ssm2603 interface
    output       AC_SCL ,                 // SSM2603的SCL时钟
    inout        AC_SDA                   // SSM2603的SDA信号

    //user interface
);

//parameter define
parameter        SLAVE_ADDR =  7'b0011010   ;  // SSM2603 I2C器件地址
parameter        WL         =  6'd16        ;  // word length音频字长参数设置
parameter        BIT_CTRL   =  1'b0         ;  // 字地址位控制参数(16b/8b)
parameter        CLK_FREQ   = 26'd24_576_000;  // i2c_dri模块的驱动时钟频率(CLK_FREQ)
parameter        I2C_FREQ   = 18'd122_880   ;  // I2C的SCL时钟频率

//wire define
wire             clk_i2c   ;               // i2c的操作时钟
wire             i2c_exec  ;               // i2c触发控制
wire             i2c_done  ;               // i2c操作结束标志
wire             cfg_done  ;               // SSM2603配置完成标志
wire   [15:0]    reg_data  ;               // SSM2603需要配置的寄存器（地址及数据）

//*****************************************************
//**                    main code
//*****************************************************

//例化i2c_dri,调用IIC协议
i2c_dri #(
    .SLAVE_ADDR  (SLAVE_ADDR),             // slave address从机地址，放此处方便参数传递
    .CLK_FREQ    (CLK_FREQ  ),             // i2c_dri模块的驱动时钟频率(CLK_FREQ)
    .I2C_FREQ    (I2C_FREQ  )              // I2C的SCL时钟频率
) u_i2c_dri(
    //global clock
    .clk         (clk       ),             // i2c_dri模块的驱动时钟(CLK_FREQ)
    .reset       (reset     ),             // 复位信号
    //i2c interface
    .i2c_exec    (i2c_exec  ),             // I2C触发执行信号
    .bit_ctrl    (BIT_CTRL  ),             // 器件地址位控制(16b/8b)
    .i2c_rh_wl   (1'b0      ),             // I2C读写控制信号
    .i2c_addr    (reg_data[15:8]),         // I2C器件字地址
    .i2c_data_w  (reg_data[ 7:0]),         // I2C要写的数据
    .i2c_data_r  (),                       // I2C读出的数据
    .i2c_done    (i2c_done  ),             // I2C一次操作完成
    .scl         (AC_SCL   ),             // I2C的SCL时钟信号
    .sda         (AC_SDA   ),             // I2C的SDA信号
    //user interface
    .dri_clk     (clk_i2c   )              // I2C操作时钟
);

//例化i2c_reg_cfg模块，配置SSM2603的寄存器
i2c_reg_cfg #(.WL(WL)                      // word length音频字长参数设置
) u_i2c_reg_cfg(
    //clock & reset
    .clk         (clk_i2c  ),              // i2c_reg_cfg驱动时钟(一般取1MHz)
    .reset       (reset    ),              // 复位信号
    //i2c interface
    .i2c_done    (i2c_done ),              // I2C一次操作完成的反馈信号            
    .i2c_exec    (i2c_exec ),              // I2C触发执行信号
    .cfg_done    (cfg_done ),              // SSM2603配置完成
    .i2c_data    (reg_data )               // 寄存器数据（7位地址+9位数据）
);

endmodule