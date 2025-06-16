/*
 * main.c
 */

#include <intrinsics.h>
#include <msp430f6638.h>
#include <stdint.h>

int debounce(uint8_t BITx);

typedef struct // 以指针形式定义P8口的各个寄存器
{
    const volatile uint8_t *PxIN; // 定义一个不会被编译的无符号字符型变量
    volatile uint8_t *PxOUT;
    volatile uint8_t *PxDIR;
    volatile uint8_t *PxREN;
    volatile uint8_t *PxSEL;
} GPIO_TypeDef;

const GPIO_TypeDef GPIO4 = {&P4IN, &P4OUT, &P4DIR, &P4REN, &P4SEL};

const GPIO_TypeDef GPIO5 = {&P5IN, &P5OUT, &P5DIR, &P5REN, &P5SEL};

const GPIO_TypeDef GPIO8 = {&P8IN, &P8OUT, &P8DIR, &P8REN, &P8SEL};

const GPIO_TypeDef *LED_GPIO[5] = {&GPIO8, &GPIO5, &GPIO4, &GPIO4, &GPIO4};	// LED的IO控制口，里面都是寄存器
const uint8_t LED_PORT[5] = {BIT0, BIT7, BIT7, BIT6, BIT5};							// 控制LED灯亮，内部引脚对应的比特位

int main()
{

    WDTCTL = WDTPW | WDTHOLD; // 关闭看门狗
    // 下面出现的BIT3对应与S4（P4.3），BIT4对应S3（P4.4）
    // 设置S4按键
    P4REN |= BIT3; // 使能上下拉电阻
    P4OUT |= BIT3; // 上拉电阻
    // 设置S3按键
    P4REN |= BIT4; // 使能上下拉电阻
    P4OUT |= BIT4; // 上拉电阻

    int i;
    for (i = 0; i < 5; ++i)
        *LED_GPIO[i]->PxDIR |= LED_PORT[i]; // 设置各LED灯所在端口为输出方向

    // 设置LED初始时不亮
    for (i = 0; i < 5; ++i) {
        *LED_GPIO[i]->PxOUT &= ~LED_PORT[i];
    }

    int count = -1; // 计数器初始化

    while (1) {
        // 如果S3按键被按下
        if (debounce(BIT4) && count < 4) {
            count++; // 计数器加1
        }

        // 如果S4按键被按下
        if (debounce(BIT3)) {
            count = -1; // 计数器重置，灯全灭
        }

        // 点亮对应的LED灯
        if (count != -1) {
            for (i = 0; i <= count; ++i) {
                *LED_GPIO[i]->PxOUT |= LED_PORT[i];		// 按顺序依次点亮
            }
        } else {
            // 关闭所有LED灯
            for (i = 0; i < 5; ++i) {
                *LED_GPIO[i]->PxOUT &= ~LED_PORT[i];		// 全部熄灭
            }
        }
    }

    return 0;
}


// 防抖模块，原理是判断按钮的上升沿（松开的瞬间）
int debounce(uint8_t BITx)
{
    // 检测按键是否被按下
    if (!(P4IN & BITx)) {
        // 延时约100ms
        __delay_cycles(3276);

        // 再次检测按键状态
        if (P4IN & BITx) {
            return 1; // 按键有效
        }
    }
    return 0; // 按键无效
}
