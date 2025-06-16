/*
 * main.c
 */
#include<msp430f6638.h>

void main(void) {
    WDTCTL = WDTPW + WDTCNTCL+WDTIS2; 	// 启用看门狗并立即喂狗
    P4DIR |= BIT5;             	// 配置LED5
    P8DIR |= BIT0;				// 配置LED1，作为重启的信号量
    P8OUT |= BIT0;				// 初始化为输出
    P4OUT |= BIT5;
    while (1) {
    	WDTCTL = WDTPW + WDTCNTCL; // 定期喂狗
        __delay_cycles(32760); // 模拟耗时操作
        P8OUT &= ~BIT0;			// 关闭LED1
        P4OUT ^= BIT5;          // LED5闪烁表示程序运行中
    }
}
