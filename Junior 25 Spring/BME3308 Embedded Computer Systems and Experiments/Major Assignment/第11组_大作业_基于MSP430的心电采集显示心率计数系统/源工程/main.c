#include <msp430.h>
#include <stdint.h>
#include <stdio.h>
#include "dr_tft.h"
#include "ecg_words.h"


// 串口存储区
unsigned char send_data[]={'0','\0'};
unsigned char recv_data[]={'0','\0'};

// 画波形使用的存储区
volatile unsigned int value = 0;									// 读取的ADC的输入
volatile unsigned int is_first_time = 0;							// 是否是第一次采集信号，因为画波形需要两个时刻的波幅
volatile unsigned int prev_wave = 0;								// 前一时刻的波幅
volatile unsigned int curr_wave = 0;								// 当前时刻的波幅
volatile unsigned int t = 0;										// 时间变量
volatile unsigned int median = 0;									// 两个时刻的波幅中间值，用于平滑曲线
char dispaly_rate[5]=":000";										// 存储心率的每一位

// 计算心率的存储区
volatile int prev2 = 0;
volatile int prev1 = 0;
volatile int peak_times[5] = {0, 0, 0, 0, 0};
volatile int pointer = 0;
volatile unsigned int curr_time = 0;  								// 当前采样点时间
volatile unsigned int prev_time = 0;								// 前一个峰值的时间
volatile int threshold = 50;   										// 检测峰值的阈值


// 使用到的函数头
void UART_RS232_Init(void);											// 串口初始化
void initAll();														// 所有的初始化
void show_words(uint16_t sx, uint16_t sy, uint16_t size);			// 显示汉字
void initClock();													// 时钟初始化
void display_heart_rate();											// 显示心率到TFT
void draw_wave();													// 在TFT上画波形
int calc_heart_rate();												// 计算心率


void main(void)
{
    WDTCTL = WDTPW + WDTHOLD; 										// 关闭看门狗，防止自动复位
    _DINT(); 														// 禁用总中断，防止初始化被打断
    initAll();												        // 所有的初始化操作
    _EINT(); 														// 初始化完成，使能总中断
    __bis_SR_register(LPM0_bits + GIE); 							// 进入低功耗模式LPM0并开启中断
    // 等待中断唤醒
}


// 所有的初始函数
void initAll()
{
    UART_RS232_Init();        										// 初始化串口

	// 初始化TimerA
    TA0CTL |= MC_1 + TASSEL_2 + TACLR;								//时钟为SMCLK,比较模式，开始时清零计数器
	TA0CCTL0 = CCIE;												//比较器中断使能
	TA0CCR0  = 50000;												//比较值设为50000，相当于50ms的时间间隔

	// 初始化ADC
	ADC12CTL0 |= ADC12MSC;											// 自动循环采样转换
	ADC12CTL0 |= ADC12ON;											// 启动ADC12模块
	ADC12CTL1 |= ADC12CONSEQ1;										// 选择单通道循环采样转换
	ADC12CTL1 |= ADC12SHP;											// 采样保持模式
	ADC12MCTL0 |= ADC12INCH_12; 									// 选择通道15，连接拨码电位器
	ADC12CTL0 |= ADC12ENC;											// 开始转换

    initClock();    												// 初始化系统时钟（使用 XT1 和 XT2 作为参考）
    initTFT();      												// 初始化 TFT 显示屏

    etft_AreaSet(0, 0, 319, 239, 0); 								// 清屏（设置整个显示区域颜色）
    show_words(127, 223, 16);										// 显示“心率”两个字

}

// 显示汉字的函数
void show_words(uint16_t sx, uint16_t sy, uint16_t size)
{
    uint16_t cx, cy;
    uint16_t words_len = 2;

    int i;
    for (i = 0; i < words_len; i++)
    {
        cx = 0;
        cy = 0;
        // 屏幕是横的，XY要对调
        tft_SendCmd(TFTREG_WIN_MINX, sx);            				// x start point
        tft_SendCmd(TFTREG_WIN_MINY, sy);            				// y start point
        tft_SendCmd(TFTREG_WIN_MAXX, sx + size - 1); 				// x end point
        tft_SendCmd(TFTREG_WIN_MAXY, sy + size - 1); 				// y end point
        tft_SendCmd(TFTREG_RAM_XADDR, sx);           				// x start point
        tft_SendCmd(TFTREG_RAM_YADDR, sy);           				// y start point
        tft_SendIndex(TFTREG_RAM_ACCESS);

        uint16_t color;
        while (1)
        {
            if (cx >= size) {
                cx = 0;
                cy++;
                if (cy >= size) 									// 一个字符发送完毕
                {
                    sx += size;
                    if (sx >= TFT_YSIZE) 							// 越过行末
                    {
                        sx = 0;
                        sy += size;
                    }
                    break;
                }
            }

            uint16_t pos = i * size * size * 3 + cy * size * 3 + cx * 3;
            color = etft_Color(words[pos], words[pos + 1], words[pos + 2]);

            tft_SendData(color);
            cx++;
        }
    }
}




// 计算心率的函数
int calc_heart_rate()
{
    // 简单三点峰值检测：中点高于两边并大于阈值
    if (prev1 < prev2 && prev1 < curr_wave && prev1 < threshold)
    {
        if (curr_time > 5 && curr_time < 1000)  // 合理区间
        {
        	peak_times[pointer%5] = 6000 / curr_time;  // 每点50ms -> 60,000 / (interval * 50) = 1200 / interval
            pointer++;
            curr_time = 0;
        }
    }

    // 更新历史值
    prev2 = prev1;
    prev1 = curr_wave;
    curr_time++;

    int avg = (peak_times[0] + peak_times[1] + peak_times[2] + peak_times[3] + peak_times[4]) / 5;

    return avg;  // 返回心率值（如果未检测到则为 -1）
}



// 定义 Timer_A中断服务函数，每次计满都会画曲线
#pragma vector = TIMER0_A0_VECTOR
__interrupt void Timer_A (void)
{
	// 第一次进入，需要额外计算一个点
	if (is_first_time == 1) 									// 如果是第一次进入
	{
		ADC12CTL0 |= ADC12SC; 									// 读取下一次数据
		value = ADC12MEM0; 										// 赋值
		is_first_time = 0; 										// 清除，后续不再需要
		prev_wave = 207 - value / 20; 							// 207是设定的最下方，4096/207=20，可以将ADC读到的数据放缩到屏幕的范围内
																// 207我们设定的显示的最下方，为了美观而设计
		UCA1TXBUF = (uint8_t)(value/20);										// 赋值给发送缓冲，准备发送
	}

	// 处理当前时刻的波幅
	ADC12CTL0 |= ADC12SC; 										// 启动 ADC转换
	value = ADC12MEM0; 											// 将 ADC转换结果赋值给变量 value，注意这里value最大是4096
	curr_wave = 207 - value / 20; 								// 和上面同理
	UCA1TXBUF = (uint8_t)(value/20);											// 串口发送


	// 画波形，显示心率
	draw_wave();												// 画波形
	display_heart_rate();										// 显示心率

	// 准备下一次处理
	t++; 														// x坐标加 1，准备处理下一个坐标
	prev_wave = curr_wave; 										// 时刻更新，波幅也要更新
}




// 画波形的函数
void draw_wave()
{
	if (t >= 319) 												// 如果已经画到了最右边
	{
		t = 0; 													// 将t设为0，从左端开始重新画
		etft_AreaSet(0, 0, 319, 223, 0); 							// 更新当前的图像窗口
	}

	median = (prev_wave + curr_wave) / 2;		 				// 将median设为prev_wave和curr_wave的平均值

	if (prev_wave < curr_wave) 									// 如果prev_wave小于 curr_wave
	{
		etft_AreaSet(t, prev_wave, t, median, 63488); 			// 画前一时刻的波形，设置为红色
		etft_AreaSet(t+1, median, t+1, curr_wave, 63488); 		// 画当前时刻的波形，设置为红色
	}

	else														// 如果大小相反需要反过来
	{
		etft_AreaSet(t, median, t, prev_wave, 63488);
		etft_AreaSet(t+1, curr_wave, t+1, median, 63488);
	}
}



void display_heart_rate()
{
	int heart_rate = calc_heart_rate(curr_wave); 						// 计算curr_wave和prev_wave的脉冲计数
	if (heart_rate < 0)											// 仅当有心率时才计算
		heart_rate = 0;

	dispaly_rate[1] = heart_rate / 100 + '0'; 					// 取心率的百位，加上'0'的变为数字字符而不是整型
	dispaly_rate[2] = (heart_rate % 100) / 10+ '0'; 			// 取十位
	dispaly_rate[3] = heart_rate % 10+ '0'; 					// 取个位

	etft_DisplayString(dispaly_rate, 161, 223, 65535, 0); 		// 显示心率
}




//RS232 接口初始化函数
void UART_RS232_Init(void)
{
	/*通过对 P3.4。P3.5，P4.4，P4.5 的配置实现通道选择
	使 USCI 切换到 UART 模式*/
	P3DIR|=(1<<4)|(1<<5);
	P4DIR|=(1<<4)|(1<<5);
	P4OUT|=(1<<4);
	P4OUT&=~(1<<5);
	P3OUT|=(1<<5);
	P3OUT&=~(1<<4);
	P8SEL|=0x0c; 												//模块功能接口设置，即 P8.2 与 P8.3 作为 USCI 的接收口与发射口
	UCA1CTL1|=UCSWRST; 											//复位 USCI
	UCA1CTL1|=UCSSEL_1;											//设置辅助时钟，用于发生特定波特率
	UCA1BR0=0x03; 												//设置波特率
	UCA1BR1=0x00;
	UCA1MCTL=UCBRS_3+UCBRF_0;
	UCA1CTL1&=~UCSWRST;											//结束复位
	UCA1IE|=UCRXIE; 											//使能接收中断
}



void initClock()
{
	while(BAKCTL & LOCKIO) 										// Unlock XT1 pins for operation

	BAKCTL &= ~(LOCKIO);
	UCSCTL6 &= ~XT1OFF; 										//启动XT1
	P7SEL |= BIT2 + BIT3; 										//XT2引脚功能选择
	UCSCTL6 &= ~XT2OFF; 										//启动XT2

	while (SFRIFG1 & OFIFG) 									//等待XT1、XT2与DCO稳定
	{
		UCSCTL7 &= ~(DCOFFG+XT1LFOFFG+XT2OFFG);
		SFRIFG1 &= ~OFIFG;
	}

	UCSCTL4 = SELA__XT1CLK + SELS__XT2CLK + SELM__XT2CLK; 		//避免DCO调整中跑飞

	UCSCTL1 = DCORSEL_5; 										//6000kHz~23.7MHz
	UCSCTL2 = 20000000 / (4000000 / 16); 						//XT2频率较高，分频后作为基准可获得更高的精度
	UCSCTL3 = SELREF__XT2CLK + FLLREFDIV__16; 					//XT2进行16分频后作为基准

	while (SFRIFG1 & OFIFG) 									//等待XT1、XT2与DCO稳定
	{
		UCSCTL7 &= ~(DCOFFG+XT1LFOFFG+XT2OFFG);
		SFRIFG1 &= ~OFIFG;
	}

	UCSCTL5 = DIVA__1 + DIVS__1 + DIVM__1; 						//设定几个CLK的分频
	UCSCTL4 = SELA__XT1CLK + SELS__DCOCLK + SELM__DCOCLK; 		//设定几个CLK的时钟源
}
