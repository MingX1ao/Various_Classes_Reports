/*
 * main.c
 */

#include<msp430f6638.h>
#include<math.h>


int bias = 0x7FF;			// 指定偏置，因为DAC不能输出负数
double pi = 3.1415926535;	// pi
int t = 0;					// 时间变化
int sine = 0;				// 存放波形变化

void main(void)
{
	WDTCTL = WDTPW + WDTHOLD; //关闭看门狗
	P7DIR |= BIT6;//设置P7.6口为输出口
	P7SEL |= BIT6;//使能P7.6口第二功能位
	DAC12_0CTL0 |= DAC12IR; //设置参考电压满刻度值，使Vout = Vref×(DAC12_xDAT/4096)
	DAC12_0CTL0 |= DAC12SREF_1; //设置参考电压为AVCC
	DAC12_0CTL0 |= DAC12AMP_5;	//设置运算放大器输入输出缓冲器为中速中电流
	DAC12_0CTL0 |= DAC12CALON; //启动校验功能
	DAC12_0CTL0 |= DAC12OPS;//选择第二通道P7.6
	DAC12_0CTL0 |= DAC12ENC; //转化使能

	// TimerA初始化
	TA0CTL |= MC_1 + TASSEL_2 + TACLR;
	//时钟为SMCLK,比较模式，开始时清零计数器
	TA0CCTL0 = CCIE;//比较器中断使能
	TA0CCR0  = 10000;					// 相当于10ms的时间间隔，修改这里可以更改采样时间，当前为10ms

	__bis_SR_register(LPM0_bits + GIE);	// 进入低功耗并开启总中断
	__no_operation();
}


#pragma vector = TIMER0_A0_VECTOR
__interrupt void Timer_A (void)
{	
	t=t+1;
	if (t < 100)			// 修改这里可以更改周期，当前周期为100
	{
		sine = (int)roundf(bias - bias * sin(2*pi*t/100));		//	每个周期用100个点描述
	}
	else
	{
		t = 0;
		sine = bias;
	}
	DAC12_0DAT = sine;		// 更改DAC输出
}

