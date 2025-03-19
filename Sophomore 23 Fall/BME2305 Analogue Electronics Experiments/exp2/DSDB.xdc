#system clock - 125 MHz
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { SYSCLK_125MHZ }];

#Audio
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { AC_BCLK }];
set_property -dict { PACKAGE_PIN L22   IOSTANDARD LVCMOS33 } [get_ports { AC_MCLK }];
set_property -dict { PACKAGE_PIN J21   IOSTANDARD LVCMOS33 } [get_ports { AC_MUTEN }];
set_property -dict { PACKAGE_PIN L21   IOSTANDARD LVCMOS33 } [get_ports { AC_PBDAT }];
set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { AC_PBLRC }];
set_property -dict { PACKAGE_PIN J22   IOSTANDARD LVCMOS33 } [get_ports { AC_RECDAT }];
set_property -dict { PACKAGE_PIN C19   IOSTANDARD LVCMOS33 } [get_ports { AC_RECLRC }]; 
set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports { AC_SCL }];
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { AC_SDA }];

#ADC
set_property -dict { PACKAGE_PIN Y4    IOSTANDARD LVCMOS33 } [get_ports { ADC_CS }];
set_property -dict { PACKAGE_PIN U6    IOSTANDARD LVCMOS33 } [get_ports { ADC_SCLK }];
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { ADC_SDI }];
set_property -dict { PACKAGE_PIN Y5    IOSTANDARD LVCMOS33 } [get_ports { ADC_SDO }];

#Breadboard
set_property -dict { PACKAGE_PIN AA13  IOSTANDARD LVCMOS33 } [get_ports { BB_S_DIO0 }];
set_property -dict { PACKAGE_PIN AB14  IOSTANDARD LVCMOS33 } [get_ports { BB_S_DIO1 }];
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { BB_S_DIO2 }];
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { BB_S_DIO3 }];
set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports { BB_S_DIO4 }];
set_property -dict { PACKAGE_PIN Y15   IOSTANDARD LVCMOS33 } [get_ports { BB_S_DIO5 }];
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { BB_S_DIO6 }];
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { BB_S_DIO7 }];

#BTN
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { BTN0 }];
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { BTN1 }];
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { BTN2 }];
set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { BTN3 }];

#power reset
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { POWER_RESET }];

#crypto sda
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { CRYPTO_SDA }];

#DAC pins for MXP AO0 and AO1
set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { DAC_DIN_B }];
set_property -dict { PACKAGE_PIN AB1   IOSTANDARD LVCMOS33 } [get_ports { DAC_LDAC_B }];
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { DAC_SCLK_B }];
set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports { DAC_SYNC_B }];

#eth
set_property -dict { PACKAGE_PIN D15   IOSTANDARD LVCMOS33 PULLUP true} [get_ports { ETH_INT_B }];
set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { ETH_RST_B }];

#hdmi
set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { HDMI_CEC }];
set_property -dict { PACKAGE_PIN B20   IOSTANDARD TMDS_33  } [get_ports { HDMI_CLK_N }];
set_property -dict { PACKAGE_PIN B19   IOSTANDARD TMDS_33  } [get_ports { HDMI_CLK_P }];
set_property -dict { PACKAGE_PIN C18   IOSTANDARD TMDS_33  } [get_ports { HDMI_D_N0 }];
set_property -dict { PACKAGE_PIN C17   IOSTANDARD TMDS_33  } [get_ports { HDMI_D_P0 }];
set_property -dict { PACKAGE_PIN D17   IOSTANDARD TMDS_33  } [get_ports { HDMI_D_N1 }];
set_property -dict { PACKAGE_PIN D16   IOSTANDARD TMDS_33  } [get_ports { HDMI_D_P1 }];
set_property -dict { PACKAGE_PIN G16   IOSTANDARD TMDS_33  } [get_ports { HDMI_D_N2 }];
set_property -dict { PACKAGE_PIN G15   IOSTANDARD TMDS_33  } [get_ports { HDMI_D_P2 }];
set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { HDMI_HPD }];
set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { HDMI_OUT_EN }];
set_property -dict { PACKAGE_PIN G20   IOSTANDARD LVCMOS33 } [get_ports { HDMI_SCL }];
set_property -dict { PACKAGE_PIN G21   IOSTANDARD LVCMOS33 } [get_ports { HDMI_SDA }];

#leds
set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { LED0 }];
set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { LED1 }];
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { LED2 }];
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { LED3 }];
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { LED4 }];
set_property -dict { PACKAGE_PIN W12   IOSTANDARD LVCMOS33 } [get_ports { LED5 }];
set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS33 } [get_ports { LED6 }];
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { LED7 }];

#oled
set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { OLED_DC }];
set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { OLED_RES }];
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { OLED_SCLK }];
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { OLED_SDIN }];
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports { OLED_VBAT }];
set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { OLED_VDD }];

#ELVIS PCI
set_property -dict { PACKAGE_PIN Y20   IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO0 }];
set_property -dict { PACKAGE_PIN AA16  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO1 }];
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO2 }];
set_property -dict { PACKAGE_PIN AB16  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO3 }];
set_property -dict { PACKAGE_PIN AA18  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO4 }];
set_property -dict { PACKAGE_PIN AB15  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO5 }];
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO6 }];
set_property -dict { PACKAGE_PIN AA14  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO7 }];
set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO8 }];
set_property -dict { PACKAGE_PIN AA19  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO9 }];
set_property -dict { PACKAGE_PIN U20   IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO10 }];
set_property -dict { PACKAGE_PIN AB19  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO11 }];
set_property -dict { PACKAGE_PIN U10   IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO12 }];
set_property -dict { PACKAGE_PIN AA17  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO13 }];
set_property -dict { PACKAGE_PIN W20   IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO14 }];
set_property -dict { PACKAGE_PIN AB17  IOSTANDARD LVCMOS33 } [get_ports { PBC_DIO15 }];
set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports { PBC_PFI_8 }];
set_property -dict { PACKAGE_PIN AB20  IOSTANDARD LVCMOS33 } [get_ports { PBC_PFI_9 }];
set_property -dict { PACKAGE_PIN R21   IOSTANDARD LVCMOS33 } [get_ports { PBC_PFI_12 }];

#PS2 signals
set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 PULLUP true } [get_ports { PS2_CLK0 }];
set_property -dict { PACKAGE_PIN R7    IOSTANDARD LVCMOS33 PULLUP true } [get_ports { PS2_DATA0 }];
set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 PULLUP true } [get_ports { PS2_CLK1 }];
set_property -dict { PACKAGE_PIN Y21   IOSTANDARD LVCMOS33 PULLUP true } [get_ports { PS2_DATA1 }];

#MXP pins
set_property -dict { PACKAGE_PIN M21   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO0 }];
set_property -dict { PACKAGE_PIN N22   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO1 }];
set_property -dict { PACKAGE_PIN P21   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO2 }];
set_property -dict { PACKAGE_PIN T22   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO3 }];
set_property -dict { PACKAGE_PIN U22   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO4 }];
set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO5 }];
set_property -dict { PACKAGE_PIN V22   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO6 }];
set_property -dict { PACKAGE_PIN U21   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO7 }];
set_property -dict { PACKAGE_PIN AA22  IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO8 }];
set_property -dict { PACKAGE_PIN AA21  IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO9 }];
set_property -dict { PACKAGE_PIN AB22  IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO10 }];
set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO11 }];
set_property -dict { PACKAGE_PIN W22   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO12 }];
set_property -dict { PACKAGE_PIN W21   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO13 }];
set_property -dict { PACKAGE_PIN AB21  IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO14 }];
set_property -dict { PACKAGE_PIN N20   IOSTANDARD LVCMOS33 } [get_ports { MXP_DIO15 }];
set_property -dict { PACKAGE_PIN M22   IOSTANDARD LVCMOS33 } [get_ports { S_UART_RX }];
set_property -dict { PACKAGE_PIN P22   IOSTANDARD LVCMOS33 } [get_ports { S_UART_TX }];

#JA
set_property -dict { PACKAGE_PIN AA11  IOSTANDARD LVCMOS33 } [get_ports { S_JA0 }];
set_property -dict { PACKAGE_PIN AA12  IOSTANDARD LVCMOS33 } [get_ports { S_JA1 }];
set_property -dict { PACKAGE_PIN AB10  IOSTANDARD LVCMOS33 } [get_ports { S_JA2 }];
set_property -dict { PACKAGE_PIN AA9   IOSTANDARD LVCMOS33 } [get_ports { S_JA3 }];
set_property -dict { PACKAGE_PIN AB11  IOSTANDARD LVCMOS33 } [get_ports { S_JA4 }];
set_property -dict { PACKAGE_PIN AB12  IOSTANDARD LVCMOS33 } [get_ports { S_JA5 }];
set_property -dict { PACKAGE_PIN AB9   IOSTANDARD LVCMOS33 } [get_ports { S_JA6 }];
set_property -dict { PACKAGE_PIN AA8   IOSTANDARD LVCMOS33 } [get_ports { S_JA7 }];

#JB
set_property -dict { PACKAGE_PIN AB6   IOSTANDARD LVCMOS33 } [get_ports { S_JB0 }];
set_property -dict { PACKAGE_PIN AB7   IOSTANDARD LVCMOS33 } [get_ports { S_JB1 }];
set_property -dict { PACKAGE_PIN AB4   IOSTANDARD LVCMOS33 } [get_ports { S_JB2 }];
set_property -dict { PACKAGE_PIN AB2   IOSTANDARD LVCMOS33 } [get_ports { S_JB3 }];
set_property -dict { PACKAGE_PIN AA6   IOSTANDARD LVCMOS33 } [get_ports { S_JB4 }];
set_property -dict { PACKAGE_PIN AA7   IOSTANDARD LVCMOS33 } [get_ports { S_JB5 }];
set_property -dict { PACKAGE_PIN AB5   IOSTANDARD LVCMOS33 } [get_ports { S_JB6 }];
set_property -dict { PACKAGE_PIN AA4   IOSTANDARD LVCMOS33 } [get_ports { S_JB7 }];

#Seven segment display
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { SSEG_AN0 }];
set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS33 } [get_ports { SSEG_AN1 }];
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { SSEG_AN2 }];
set_property -dict { PACKAGE_PIN J20   IOSTANDARD LVCMOS33 } [get_ports { SSEG_AN3 }];
set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports { SSEG_CA }];
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { SSEG_CB }];
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { SSEG_CC }];
set_property -dict { PACKAGE_PIN K21   IOSTANDARD LVCMOS33 } [get_ports { SSEG_CD }];
set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS33 } [get_ports { SSEG_CE }];
set_property -dict { PACKAGE_PIN H18   IOSTANDARD LVCMOS33 } [get_ports { SSEG_CF }];
set_property -dict { PACKAGE_PIN L19   IOSTANDARD LVCMOS33 } [get_ports { SSEG_CG }];
set_property -dict { PACKAGE_PIN K20   IOSTANDARD LVCMOS33 } [get_ports { SSEG_DP }];

#Switch
set_property -dict { PACKAGE_PIN T6    IOSTANDARD LVCMOS33 } [get_ports { SW0 }];
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { SW1 }];
set_property -dict { PACKAGE_PIN T4    IOSTANDARD LVCMOS33 } [get_ports { SW2 }];
set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { SW3 }];
set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { SW4 }];
set_property -dict { PACKAGE_PIN U9    IOSTANDARD LVCMOS33 } [get_ports { SW5 }];
set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { SW6 }];
set_property -dict { PACKAGE_PIN V9    IOSTANDARD LVCMOS33 } [get_ports { SW7 }];

#TFT display
set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports { TFT_R0 }];
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { TFT_R1 }];
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { TFT_R2 }];
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { TFT_R3 }];
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { TFT_R4 }];
set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { TFT_R5 }];
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { TFT_R6 }];
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { TFT_R7 }];
set_property -dict { PACKAGE_PIN P20   IOSTANDARD LVCMOS33 } [get_ports { TFT_G0 }];
set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { TFT_G1 }];
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { TFT_G2 }];
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { TFT_G3 }];
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { TFT_G4 }];
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { TFT_G5 }];
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { TFT_G6 }];
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { TFT_G7 }];
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { TFT_B0 }];
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { TFT_B1 }];
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { TFT_B2 }];
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { TFT_B3 }];
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { TFT_B4 }];
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { TFT_B5 }];
set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { TFT_B6 }];
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { TFT_B7 }];
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { TFT_DCLK }];
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS33 } [get_ports { TFT_DE }];
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { TFT_DISP }];
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { TFT_HS }];
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { TFT_VS }];
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { BCK_DIM }];

#Touch Panel
set_property -dict { PACKAGE_PIN R20   IOSTANDARD LVCMOS33 } [get_ports { TP_IRQ }];
set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { TP_RES }];
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { TP_SCK }];
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { TP_SDA }];

#UART
set_property -dict { PACKAGE_PIN Y10   IOSTANDARD LVCMOS33 } [get_ports { UART_RXD_OUT }];
set_property -dict { PACKAGE_PIN R6    IOSTANDARD LVCMOS33 } [get_ports { UART_TXD_IN }];

#VGA
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports { VGA_R3 }];
set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports { VGA_R4 }];
set_property -dict { PACKAGE_PIN A19   IOSTANDARD LVCMOS33 } [get_ports { VGA_R5 }];
set_property -dict { PACKAGE_PIN A22   IOSTANDARD LVCMOS33 } [get_ports { VGA_R6 }];
set_property -dict { PACKAGE_PIN D22   IOSTANDARD LVCMOS33 } [get_ports { VGA_R7 }];
set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { VGA_G2 }];
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports { VGA_G3 }];
set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33 } [get_ports { VGA_G4 }];
set_property -dict { PACKAGE_PIN A21   IOSTANDARD LVCMOS33 } [get_ports { VGA_G5 }];
set_property -dict { PACKAGE_PIN B22   IOSTANDARD LVCMOS33 } [get_ports { VGA_G6 }];
set_property -dict { PACKAGE_PIN F21   IOSTANDARD LVCMOS33 } [get_ports { VGA_G7 }];
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { VGA_B3 }];
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { VGA_B4 }];
set_property -dict { PACKAGE_PIN B21   IOSTANDARD LVCMOS33 } [get_ports { VGA_B5 }];
set_property -dict { PACKAGE_PIN C22   IOSTANDARD LVCMOS33 } [get_ports { VGA_B6 }];
set_property -dict { PACKAGE_PIN F22   IOSTANDARD LVCMOS33 } [get_ports { VGA_B7 }];
set_property -dict { PACKAGE_PIN G22   IOSTANDARD LVCMOS33 } [get_ports { VGA_HS }];
set_property -dict { PACKAGE_PIN H22   IOSTANDARD LVCMOS33 } [get_ports { VGA_VS }];

set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { XADC_3V3_USER_CURRENT- }];
set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { XADC_3V3_USER_CURRENT+ }];
set_property -dict { PACKAGE_PIN E20   IOSTANDARD LVCMOS33 } [get_ports { XADC_3V3_USER_VOLTAGE- }];
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports { XADC_3V3_USER_VOLTAGE+ }];
set_property -dict { PACKAGE_PIN D21   IOSTANDARD LVCMOS33 } [get_ports { XADC_5V0_USER_CURRENT- }];
set_property -dict { PACKAGE_PIN E21   IOSTANDARD LVCMOS33 } [get_ports { XADC_5V0_USER_CURRENT+ }];
set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports { XADC_5V0_USER_VOLTAGE- }];
set_property -dict { PACKAGE_PIN D20   IOSTANDARD LVCMOS33 } [get_ports { XADC_5V0_USER_VOLTAGE+ }];
