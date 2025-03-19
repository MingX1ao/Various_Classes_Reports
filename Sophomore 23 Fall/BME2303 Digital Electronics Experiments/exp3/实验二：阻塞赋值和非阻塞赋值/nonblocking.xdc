#system clock - 125 MHz
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { SYSCLK_125MHZ }];

#leds
set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { LED0 }];
set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { LED1 }];
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { LED2 }];
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { LED3 }];
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { LED4 }];
set_property -dict { PACKAGE_PIN W12   IOSTANDARD LVCMOS33 } [get_ports { LED5 }];
set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS33 } [get_ports { LED6 }];
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { LED7 }];

#Switch
set_property -dict { PACKAGE_PIN T6    IOSTANDARD LVCMOS33 } [get_ports { SW0 }];

#BTN
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { BTN0 }];