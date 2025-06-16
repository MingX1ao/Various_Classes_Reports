/*
 * main.c
 */
#include <msp430f6638.h>
#include <intrinsics.h>
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

int count = -1; // 计数器初始化
int timer_count = 0; // 由于16bit计数器计不到1s，用一个累加器进行扩展

void main(void)
{
	WDTCTL = WDTPW + WDTHOLD;//关闭看门狗
	P1DIR |= BIT5;//控制蜂鸣器输出
	P4DIR |= BIT5;//控制LED输出
	TA0CTL |= MC_1 + TASSEL_2 + TACLR;
	//时钟为SMCLK,比较模式，开始时清零计数器
	TA0CCTL0 = CCIE;//比较器中断使能
	TA0CCR0  = 50000;//比较值设为50000，相当于50ms的时间间隔


    // 下面出现的BIT3对应与S4（P4.3），BIT4对应S3（P4.4）
    // 设置S4按键
    P4REN |= BIT3; // 使能上下拉电阻
    P4OUT |= BIT3; // 上拉电阻
    // 设置S3按键
    P4REN |= BIT4; // 使能上下拉电阻
    P4OUT |= BIT4; // 上拉电阻

    // 配置中断寄存器
    P4IES |= (BIT3+BIT4);                            //中断沿设置（下降沿触发）
	P4IFG &= ~(BIT3+BIT4);                           //清P4.3/4.4中断标志
	P4IE |= (BIT3+BIT4);                             //使能P4.3/4.4口中断

    int i;
    for (i = 0; i < 5; ++i)
        *LED_GPIO[i]->PxDIR |= LED_PORT[i]; // 设置各LED灯所在端口为输出方向

    // 设置LED初始时不亮
    for (i = 0; i < 5; ++i) {
        *LED_GPIO[i]->PxOUT &= ~LED_PORT[i];
    }


	__bis_SR_register(LPM0_bits + GIE);//进入低功耗并开启总中断
}



#pragma vector = TIMER0_A0_VECTOR
__interrupt void Timer_A (void)
{
	int i = 0;
	timer_count += 1;
	if (timer_count == 20)		// 进入20次，即20*50ms=1000ms
	{
		// 点亮对应的LED灯
		if (count != -1)
		{
			for (i = 0; i <= count; ++i)
			{
				*LED_GPIO[i]->PxOUT ^= LED_PORT[i];		// 按顺序依次点亮
			}
		}

		// 关闭所有LED灯
		else
		{
			for (i = 0; i < 5; ++i)
			{
				*LED_GPIO[i]->PxOUT &= ~LED_PORT[i];		// 全部熄灭
			}
		}
		timer_count = 0;
	}
}


// P4中断函数，检测按键并对count进行处理
#pragma vector=PORT4_VECTOR
__interrupt void Port_4(void)
{
	if (P4IFG & BIT4)			// 如果按下的是P3
	{
		if (count < 4)
		{
			count += 1;
		}
		else
		{
			count = 4;			// 防止溢出
		}

		P4IFG &= ~BIT4;			// 清中断标志
	}

	if (P4IFG & BIT3)			// 如果按下的是P4
	{
		count = -1;
		P4IFG &= ~BIT3;			// 清中断标志
	}

}

