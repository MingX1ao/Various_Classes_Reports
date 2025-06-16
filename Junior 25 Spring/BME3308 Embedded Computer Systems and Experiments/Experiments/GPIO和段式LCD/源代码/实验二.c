/*
 * main.c
 */
#include <msp430.h>
#include <msp430f6638.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "dr_lcdseg.h" //调用段式液晶驱动头文件

#define XT2_FREQ 4000000

#define MCLK_FREQ 16000000
#define SMCLK_FREQ 4000000

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

// 显示SJTU的函数
void LCDSEG_SetSJTU()
{
    // 映射表：0-6对应a-g，这是4复用模式对应的段在显存内的位置
    const static uint8_t map[7] = {BIT7, BIT6, BIT5, BIT0, BIT1, BIT3, BIT2};

    // 显示SJTU的段码
    const uint8_t CONTROL_BIN[4] = {
        0x6d, // S
        0x0e, // J
        0x07, // T
        0x3e, // U
    };
    uint8_t mem;   // 当前显示的段码

    int j;
    for (j = 0; j < 4; j++) 
    {
        mem = LCDMEM[j];    // 读取当前显示的段码
        mem &= 0x10; // 清空控制数字段的位

        int i;
        // 对每个字母，验证每一个段是否需要点亮
        for (i = 0; i < 7; ++i) 
        {
            // 通过移位操作，判断当前段是否需要点亮
            // 如果需要，那么用或操作和map映射表点亮
            if (CONTROL_BIN[j] & (1 << i))
            {
                mem |= map[i];
            }
        }
        LCDMEM[j] = mem;    // 更新显示的段码
    }
}

void LCDSEG_SetDate(int year, int month, int day)
{
    // 定义数字段码映射表：0-9、A-F、-对应的段码
    const uint8_t SEG_CTRL_BIN[17] = {
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
        0x77, // display A
        0x7C, // display b
        0x39, // display C
        0x5E, // display d
        0x79, // display E
        0x71, // display F
        0x40, // display -
    };

    // 映射表：0-6对应a-g，最后一位是小数点
    const static uint8_t map[8] = {BIT7, BIT6, BIT5, BIT0,
                                   BIT1, BIT3, BIT2, BIT4};
    int i;
    // 定义临时变量
    uint8_t mem;
    // 用于储存显示的值
    uint8_t values[6] = {0};

    // 检查输入的日期是否合法
    if (month < 1 || month > 12 || day < 1 || day > 31) {
        return;
    }

    // 根据年月日计算显示内容
    // 当月份小于10时，显示0X
    if (month < 10) {
        values[0] = SEG_CTRL_BIN[0];
        values[1] = SEG_CTRL_BIN[month];
    } else {
        values[0] = SEG_CTRL_BIN[month / 10];   // 显示十位数
        values[1] = SEG_CTRL_BIN[month % 10];   // 显示个位数
    }
    // 显示日期
    if (day < 10) {
        values[2] = SEG_CTRL_BIN[0];
        values[3] = SEG_CTRL_BIN[day];
    } else {
        values[2] = SEG_CTRL_BIN[day / 10];
        values[3] = SEG_CTRL_BIN[day % 10];
    }
    // 显示年份
    if (year < 10) {
        values[4] = SEG_CTRL_BIN[0];
        values[5] = SEG_CTRL_BIN[year];
    } else {
        values[4] = SEG_CTRL_BIN[year / 10];
        values[5] = SEG_CTRL_BIN[year % 10];
    }
    values[4] |= BIT7; // 设置小数点

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

int main(void)
{
    unsigned char i;
    initClock();  // 配置系统时钟
    initLcdSeg(); // 初始化段式液晶

    WDTCTL = WDTPW | WDTHOLD; // Stop watchdog timer

    int flag = 0;
    while (1) {

        if (flag) {
            LCDSEG_SetSJTU();          // 显示SJTU
            __delay_cycles(MCLK_FREQ); // 延时1s
            flag ^= 1;                 // 取反flag，为了显示日期
            for (i = 0; i < 6; i++) {
                LCDSEG_SetDigit(i, -1); // 清屏
            }
        } else {
            LCDSEG_SetDate(25, 5, 6);  // 显示日期，这里是2025年5月6日
            __delay_cycles(MCLK_FREQ); // 延时1s
            flag ^= 1;
            for (i = 0; i < 6; i++) {
                LCDSEG_SetDigit(i, -1); // 清屏
            }
            LCDMEM[4] &= ~BIT4; // 清除小数点，这里是用的显存中的位置
        }
    }
    return 0;
}
