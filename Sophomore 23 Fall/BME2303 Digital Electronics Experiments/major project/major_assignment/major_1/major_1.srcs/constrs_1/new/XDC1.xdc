# Clock Signal
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_34 Sch=sysclk_125mhz

# LEDs
set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { led_hours[0] }]; #IO_L12P_T1_MRCC_13 Sch=led[0]
set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { led_hours[1] }]; #IO_L12N_T1_MRCC_13 Sch=led[1]
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { led_hours[2] }]; #IO_L23P_T3_13 Sch=led[2]
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { led_hours[3] }]; #IO_L23N_T3_13 Sch=led[3]
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { led_hours[4] }]; #IO_L1P_T0_13 Sch=led[4]
set_property -dict { PACKAGE_PIN W12   IOSTANDARD LVCMOS33 } [get_ports { li[2] }]; #IO_L4N_T0_13 Sch=led[5]
set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS33 } [get_ports { li[1] }]; #IO_L3P_T0_DQS_13 Sch=led[6]
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { li[0] }]; #IO_L2P_T0_13 Sch=led[7]

# Buttons
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { rst_n }]; #IO_L5P_T0_13 Sch=btn[0]
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { clr }]; #IO_L4P_T0_13 Sch=btn[1]
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { record }]; #IO_25_13 Sch=btn[2]
set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { judge }]; #IO_L13P_T2_MRCC_13 Sch=btn[3]

# Switches
set_property -dict { PACKAGE_PIN T6    IOSTANDARD LVCMOS33 } [get_ports { sw[7] }]; #IO_L19N_T3_VREF_13 Sch=sw[0]
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { sw[6] }]; #IO_L22N_T3_13 Sch=sw[1]
set_property -dict { PACKAGE_PIN T4    IOSTANDARD LVCMOS33 } [get_ports { sw[5] }]; #IO_L20P_T3_13 Sch=sw[2]
set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { sw[4] }]; #IO_L21N_T3_DQS_13 Sch=sw[3]
set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { sw[3] }]; #IO_L2N_T0_13 Sch=sw[4]
set_property -dict { PACKAGE_PIN U9    IOSTANDARD LVCMOS33 } [get_ports { sw[2] }]; #IO_L6N_T0_VREF_13 Sch=sw[5]
set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]; #IO_L3N_T0_DQS_13 Sch=sw[6]
set_property -dict { PACKAGE_PIN V9    IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]; #IO_L1N_T0_13 Sch=sw[7]

# Seven Segment Display
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { an[0] }]; #IO_L11P_T1_SRCC_34 Sch=sseg_an[0]
set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS33 } [get_ports { an[1] }]; #IO_L19N_T3_VREF_35 Sch=sseg_an[1]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { an[2] }]; #IO_L7P_T1_34 Sch=sseg_an[2]
set_property -dict { PACKAGE_PIN J20   IOSTANDARD LVCMOS33 } [get_ports { an[3] }]; #IO_L9P_T1_DQS_34 Sch=sseg_an[3]
set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports {  sseg[0]   }]; #IO_L19P_T3_35 Sch=sseg_ca
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports {  sseg[1]   }]; #IO_0_35 Sch=sseg_cb
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports {  sseg[2]   }]; #IO_L7N_T1_34 Sch=sseg_cc
set_property -dict { PACKAGE_PIN K21   IOSTANDARD LVCMOS33 } [get_ports {  sseg[3]   }]; #IO_L9N_T1_DQS_34 Sch=sseg_cd
set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS33 } [get_ports {  sseg[4]   }]; #IO_L13N_T2_MRCC_34 Sch=sseg_ce
set_property -dict { PACKAGE_PIN H18   IOSTANDARD LVCMOS33 } [get_ports {  sseg[5]   }]; #IO_25_35 Sch=sseg_cf
set_property -dict { PACKAGE_PIN L19   IOSTANDARD LVCMOS33 } [get_ports {  sseg[6]   }]; #IO_L12N_T1_MRCC_34 Sch=sseg_cg