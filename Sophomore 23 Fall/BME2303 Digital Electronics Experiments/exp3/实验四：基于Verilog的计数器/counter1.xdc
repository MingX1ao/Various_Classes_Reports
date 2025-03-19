#system clock - 125 MHz
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { clk }];

#Switch
set_property -dict { PACKAGE_PIN T6    IOSTANDARD LVCMOS33 } [get_ports { rst }];

#leds
set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { out }];

set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { out1 }];

set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { out2 }];

set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { out3 }];