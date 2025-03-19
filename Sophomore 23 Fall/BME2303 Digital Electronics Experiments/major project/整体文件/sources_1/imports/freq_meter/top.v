`timescale 1ns / 1ps

module top(change,clk,clr,btn2,sw,btn3,an,Led,a_to_g,uart_rxd,uart_txd,AC_BCLK,
               AC_MCLK,AC_MUTEN,AC_PBDAT,AC_PBLRC,AC_RECDAT,AC_RECLRC,AC_SCL,AC_SDA
);
input change;
input clk;
input clr;
input btn2;
input [5:0]sw;
input btn3;
output [3:0] an;
output [7:0] Led;
output [6:0] a_to_g;
input uart_rxd;
output uart_txd;
inout  	AC_BCLK;
output 	AC_MCLK;
output 	AC_MUTEN;
output 	AC_PBDAT;
inout 	AC_PBLRC;
input 	AC_RECDAT;
inout 	AC_RECLRC;
output 	AC_SCL;
inout  	AC_SDA;
wire mode;
wire [1:0] mode1;
wire [1:0] bell_cnt;
wire [1:0] ring_bell_cnt;
wire bell;
wire sound;

assign sound = (bell || ring_bell);

Mode mymode(
    .Flag(change),
    .Clk(clk),
    .mode(mode)
);
wire en;

count Count(
     .en(en),
     .btn2(btn2),
     .sw(sw),
     .mode(mode),
	 .clk(clk),
	 .clr(clr),
	 .btn3(btn3),
	 .Led(Led),
	 .an(an),
	 .a_to_g(a_to_g),
	 .bell(bell),
	 .ring_bell(ring_bell)
   );   
   
UART_crl UART_crl(
      .sys_clk(clk),
      .reset(clr),
      .uart_rxd(uart_rxd),
      .uart_txd(uart_txd),
      .en(en) 
       ); 
         
recorder recoder(
               .clk(clk),
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
               .reset(clr),
               .voldown(),
               .volup(),
               .rec_aud(), 
               .play_tone(sound),
               .play_aud(1),
               .feedback(), 
               .t_node()
               );       
endmodule