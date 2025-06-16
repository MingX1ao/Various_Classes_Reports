/*
 * main.c
 */

#include<msp430f6638.h>
#include<math.h>
#include<stdint.h>
#include<stdio.h>
#include<string.h>

#include"dr_lcdseg.h" //调用段式液晶驱动头文件

#define XT2_FREQ 4000000

#define MCLK_FREQ 16000000
#define SMCLK_FREQ 4000000


void initClock();
void LCDSEG_Display(int num);

void main(void)
{
	WDTCTL = WDTPW + WDTHOLD;//关闭看门狗
    initClock();  // 配置系统时钟
    initLcdSeg(); // 初始化段式液晶
	P4DIR |= BIT5 + BIT6 + BIT7;//配置GPIO引脚
	P5DIR |= BIT7;
	P8DIR |= BIT0;
	ADC12CTL0 |= ADC12MSC;//自动循环采样转换
	ADC12CTL0 |= ADC12ON;//启动ADC12模块
	ADC12CTL1 |= ADC12CONSEQ1 ;//选择单通道循环采样转换
	ADC12CTL1 |= ADC12SHP;//采样保持模式
	ADC12MCTL0 |= ADC12INCH_15; //选择通道15，连接拨码电位器
	ADC12CTL0 |= ADC12ENC;

	volatile unsigned int value = 0;//设置判断变量
	float voltage = 0;				// 储存真实电压

	while(1)
	{
		ADC12CTL0 |= ADC12SC;//开始采样转换
		value = ADC12MEM0;//把结果赋给变量
		voltage = 3.3 * value / 4096;	// 转换为真实电压
		voltage = (int)roundf(voltage * 1000); 	// 保留三位小数

		LCDSEG_Display(voltage);
	}
}




void initClock()
{
    while (BAKCTL & LOCKIO) {
        // 解锁XT1引脚操作
        BAKCTL &= ~(LOCKIO);
    }
    UCSCTL6 &= ~XT1OFF;     // 启动XT1，选择内部时钟源
    P7SEL |= BIT2 + BIT3;   // XT2引脚功能选择
    UCSCTL6 &= ~XT2OFF;     // 启动XT2
    while (SFRIFG1 & OFIFG) // 等待XT1、XT2与DCO稳定
    {
        UCSCTL7 &= ~(DCOFFG + XT1LFOFFG + XT2OFFG);
        SFRIFG1 &= ~OFIFG;
    }
    UCSCTL4 = SELA__XT1CLK + SELS__XT2CLK + SELM__XT2CLK; // 避免DCO调整中跑飞
    UCSCTL1 = DCORSEL_5;                                  // 6000kHz~23.7MHz
    UCSCTL2 = MCLK_FREQ /
              (XT2_FREQ / 16); // XT2频率较高，分频后作为基准可获得更高的精度
    UCSCTL3 = SELREF__XT2CLK + FLLREFDIV__16; // XT2进行16分频后作为基准
    while (SFRIFG1 & OFIFG)                   // 等待XT1、XT2与DCO稳定
    {
        UCSCTL7 &= ~(DCOFFG + XT1LFOFFG + XT2OFFG);
        SFRIFG1 &= ~OFIFG;
    }
    UCSCTL5 = DIVA__1 + DIVS__1 + DIVM__1;                // 设定几个CLK的分频
    UCSCTL4 = SELA__XT1CLK + SELS__XT2CLK + SELM__DCOCLK; // 设定几个CLK的时钟源
}





void LCDSEG_Display(int num)
{
    // 定义数字段码映射表：0-9、A-F、-对应的段码
    const uint8_t SEG_CTRL_BIN[10] = {
        0x3F, // display 0
        0x06, // display 1
        0x5B, // display 2
        0x4F, // display 3
        0x66, // display 4
        0x6D, // display 5
        0x7D, // display 6
        0x07, // display 7
        0x7F, // display 8
        0x6F, // display 9
    };

    // 映射表：0-6对应a-g，最后一位是小数点
    const static uint8_t map[8] = {BIT7, BIT6, BIT5, BIT0,
                                   BIT1, BIT3, BIT2, BIT4};
    int i;
    // 定义临时变量
    uint8_t mem;
    // 用于储存显示的值
    uint8_t values[6] = {0};

    // 取num的每一位
    int j = 5;		// 取余是倒着来的
    while(num)
    {
    	values[j] = SEG_CTRL_BIN[num % 10];
    	num /= 10;
    	j--;
    }

    values[3] |= BIT7; // 设置小数点

    // 逐个设置显示的段码
    for (i = 0; i < 6; i++) {
        mem = LCDMEM[i];
        mem &= 0x10; // 清空控制数字段的位
        int j;
        for (j = 0; j < 8; ++j) {
            if (values[i] & (1 << j)) {
                mem |= map[j];
            }
        }
        LCDMEM[i] = mem;
    }
}


