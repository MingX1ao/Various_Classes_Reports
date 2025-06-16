/*
 * main.c
 */
#include <msp430.h>
#include <stdint.h>
#include <stdio.h>
#include "dr_tft.h"
#include "ow_logo.h"
#define TFT_WIDTH 320
#define TFT_HEIGHT 240

#define WIDTH  40
#define HEIGHT 40
#define PIXEL_BYTES 3
#define IMAGE_SIZE (WIDTH * HEIGHT * PIXEL_BYTES)

// 大 字的 16x16 点阵
const char da_dot[] = {
    0x01, 0x00,
    0x01, 0x00,
    0x01, 0x00,
    0x01, 0x00,
    0x01, 0x00,
    0xFF, 0xFE,
    0x01, 0x00,
    0x01, 0x00,
    0x02, 0x80,
    0x02, 0x80,
    0x04, 0x40,
    0x04, 0x40,
    0x08, 0x20,
    0x10, 0x10,
    0x20, 0x08,
    0xC0, 0x06,
};

// 司 字的 16x16 点阵
const char si_dot[] = {
    0x00, 0x00,
    0x3F, 0xF8,
    0x00, 0x08,
    0x00, 0x08,
    0x7F, 0xE8,
    0x00, 0x08,
    0x00, 0x08,
    0x1F, 0x88,
    0x10, 0x88,
    0x10, 0x88,
    0x10, 0x88,
    0x10, 0x88,
    0x1F, 0x88,
    0x10, 0x88,
    0x00, 0x28,
    0x00, 0x10,
};

// 马 字的 16x16 点阵
const char ma_dot[] = {
    0x00, 0x00,
    0x7F, 0xE0,
    0x00, 0x20,
    0x00, 0x20,
    0x10, 0x20,
    0x10, 0x20,
    0x10, 0x20,
    0x1F, 0xFC,
    0x00, 0x04,
    0x00, 0x04,
    0x00, 0x04,
    0xFF, 0xE4,
    0x00, 0x04,
    0x00, 0x04,
    0x00, 0x28,
    0x00, 0x10,
};
void display_hanzi(const char* str, int width, int height, uint16_t sx, uint16_t sy, uint16_t fRGB, uint16_t bRGB)
{
	uint16_t cx, cy;

	cx = 0;
	cy = 0;
	//屏幕是横的，XY要对调
	tft_SendCmd(TFTREG_WIN_MINX, sx);//x start point
	tft_SendCmd(TFTREG_WIN_MINY, sy);//y start point
	tft_SendCmd(TFTREG_WIN_MAXX, sx+15);//x end point
	tft_SendCmd(TFTREG_WIN_MAXY, sy+15);//y end point
	tft_SendCmd(TFTREG_RAM_XADDR, sx);//x start point
	tft_SendCmd(TFTREG_RAM_YADDR, sy);//y start point
	tft_SendIndex(TFTREG_RAM_ACCESS);

	uint16_t color;
	while(cy < 32)
	{
		if(cx >= 8)
		{
			cx = 0;
			cy++;
		}

		if((str[cy] << cx) & 0x80)
			color = fRGB;
		else
			color = bRGB;

		tft_SendData(color);
		cx++; //X自增
	}

}
void display_logo();
void initClock()
{
  while(BAKCTL & LOCKIO) // Unlock XT1 pins for operation
    BAKCTL &= ~(LOCKIO);
  UCSCTL6 &= ~XT1OFF; //启动XT1
  P7SEL |= BIT2 + BIT3; //XT2引脚功能选择
  UCSCTL6 &= ~XT2OFF; //启动XT2
  while (SFRIFG1 & OFIFG) { //等待XT1、XT2与DCO稳定
    UCSCTL7 &= ~(DCOFFG+XT1LFOFFG+XT2OFFG);
    SFRIFG1 &= ~OFIFG;
}

  UCSCTL4 = SELA__XT1CLK + SELS__XT2CLK + SELM__XT2CLK; //避免DCO调整中跑飞
  UCSCTL1 = DCORSEL_5; //6000kHz~23.7MHz
  UCSCTL2 = 20000000 / (4000000 / 16); //XT2频率较高，分频后作为基准可获得更高的精度
  UCSCTL3 = SELREF__XT2CLK + FLLREFDIV__16; //XT2进行16分频后作为基准
  while (SFRIFG1 & OFIFG) { //等待XT1、XT2与DCO稳定
    UCSCTL7 &= ~(DCOFFG+XT1LFOFFG+XT2OFFG);
    SFRIFG1 &= ~OFIFG;
  }
  UCSCTL5 = DIVA__1 + DIVS__1 + DIVM__1; //设定几个CLK的分频
  UCSCTL4 = SELA__XT1CLK + SELS__DCOCLK + SELM__DCOCLK; //设定几个CLK的时钟源
}

int main( void )
{
  // Stop watchdog timer to prevent time out reset
  WDTCTL = WDTPW + WDTHOLD;
  _DINT();
  initClock();
  initTFT();
  _EINT();
  etft_AreaSet(0,0,319,239,0);
  while(1)
  {
	  display_logo();
	  __delay_cycles(MCLK_FREQ*3);
	  etft_AreaSet(0,0,319,239,0);
	  __delay_cycles(MCLK_FREQ);



	  // 显示“大”
	  display_hanzi(da_dot, 16, 16, 152, 112, 65535, 0);



	  // 显示“司”
	  display_hanzi(si_dot, 16, 16, 168, 112, 65535, 0);


	  // 显示“马”
	  display_hanzi(ma_dot, 16, 16, 184, 112, 65535, 0);

	  __delay_cycles(MCLK_FREQ*3);
	  etft_AreaSet(0,0,319,239,0);



	 }

}
void display_logo()
{
  uint16_t offsetX = (TFT_WIDTH - LOGO_WIDTH) / 2;
  uint16_t offsetY = (TFT_HEIGHT - LOGO_HEIGHT) / 2;
  uint16_t x,y;
  for (y = 0; y < LOGO_HEIGHT; y++) {
    for (x = 0; x < LOGO_WIDTH; x++) {
      uint16_t color;
      switch (ow_logo[y][x]) {
        case 0: color = 0; break;
        case 1: color = 65535; break;
      }
      etft_AreaSet(x, y + offsetY, x+offsetX, y + offsetY, color);
    }
  }
}

