#include <msp430f6638.h>

void main(void)
{
  WDTCTL = WDTPW + WDTHOLD;                 //关闭看门狗
  P4DIR |= BIT7;                            //设置P4.7口方向为输出
  P4DIR &= ~BIT0;
  P4REN |= BIT0;                            //使能P4.0上拉电阻
  P4OUT |= BIT0;                            //P4.0口置高电平
  P4IES |= BIT0;                            //中断沿设置（下降沿触发）
  P4IFG &= ~BIT0;                           //清P4.0中断标志
  P4IE |= BIT0;                             //使能P4.0口中断
  P4OUT |= BIT7;
  __bis_SR_register(LPM3_bits + GIE);       //进入低功耗模式3 开中断
  while(1)
  __no_operation();                         //空操作
}

// P4中断函数
#pragma vector=PORT4_VECTOR
__interrupt void Port_4(void)
{
  P4OUT ^= BIT7;                            //改变LED3灯状态，点亮LED3
  __delay_cycles(327600);					// 延时约1000ms
  P4OUT ^= BIT7;							// 关闭LED3
  P4IFG &= ~BIT0;                          //清P4.0中断标志位
}
