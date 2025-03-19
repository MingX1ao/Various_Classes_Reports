module top(
	input	SYSCLK_125MHZ,
	input 	BTN0,
	input	SW0,
	output 	LED0,
	output 	LED1,
	output 	LED2,
	output 	LED3,
	output 	LED4,
	output 	LED5,
	output 	LED6,
	output 	LED7
);

freq_div freq_div(
      .clk(SYSCLK_125MHZ),
      .rst_n(SW0),
      .clk_1hz(clk_1hz)
);

reg LED0 = 0;
reg LED1 = 0;
reg LED2 = 0;
reg LED3 = 0;
reg LED4 = 0;
reg LED5 = 0;
reg LED6 = 0;
reg LED7 = 0;

always @(posedge clk_1hz)
begin
	LED0 = BTN0;
	LED1 = LED0;
	LED2 = LED1;
	LED3 = LED2;
	LED4 = LED3;
	LED5 = LED4;
	LED6 = LED5;
	LED7 = LED6;
end
endmodule