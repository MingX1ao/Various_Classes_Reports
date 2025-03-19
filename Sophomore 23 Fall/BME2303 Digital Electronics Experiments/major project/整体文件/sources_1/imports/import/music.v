`timescale 1ns / 1ps
/*
module ring_bell(
    input wire sys_clk,
    input wire en,
    // SSM2603
    inout  wire AC_BCLK,
    output wire AC_MCLK,
    output wire AC_MUTEN,
    output wire AC_PBDAT,
    output wire AC_PBLRC,
    input  wire AC_RECDAT,
    output wire AC_RECLRC,
    output wire AC_SCL,
    inout  wire AC_SDA,
    input wire reset

    );

    recorder recoder(
        .en(en),
        .clk(sys_clk),
        .reset(reset),
        .AC_BCLK(AC_BCLK),
        .AC_MCLK(AC_MCLK),
        .AC_MUTEN(AC_MUTEN),
        .AC_PBDAT(AC_PBDAT),
        .AC_PBLRC(AC_PBLRC),
        .AC_RECDAT(AC_RECDAT),
        .AC_RECLRC(AC_RECLRC),
        .AC_SCL(AC_SCL),
        .AC_SDA(AC_SDA), 
        .LEDREC(),
        .LEDTONE(), 
        .LEDPLAY(), 
        .LEDFEEDBACK(), 
        .t_node()
        );
    
   
    
endmodule
*/