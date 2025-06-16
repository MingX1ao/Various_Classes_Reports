ORG 0000H
LJMP START
		
ORG 0013H
LJMP ITR1								; 重定向为中断例程ITR1

ORG 0040H
START:	
	; 写了两个宏来简化程序的显示效果
	; 这是计算每一位并给寄存器赋值的宏
	GET_NUM MACRO x, m, n
			MOV	 A,		x			; 求每一位数字
			MOV  B,		#10
			DIV  AB
			MOV  R1,	A
			MOV  A,		B
			MOVC A,		@A+DPTR	; 使用直接查表法进行数字判断，比循环判断的可读性高
			SUBB A,		#m			; 由于第三位有小数点，这里要视情况减法
			MOV  n,		A			; 保存到寄存器中
	ENDM

	; 这是给数码管送数字的宏
	LIGHT_SEG MACRO	x, m					
			MOV	 P2,	#x				; 给数码管的串口传送，显示数字
			MOV	 P1, 	m				; 这是表示需要亮的数字位
			MOV P1,	#0FFH			; 关闭数码管
	ENDM
	
	
; 初始化
INIT:	MOV  SCON,	#50H				; 初始化串口，工作在方式1
		MOV  TMOD,	#20H    			; 初始化定时器，T1工作在方式2，产生波特率
		MOV  TH1,	#0FDH    			; 在11.0592MHz下，波特率为9600
		MOV  TL1,	#0FDH     			
		SETB TR1						; T1开始工作
		
		MOV  31H,	#00H			; 清空内存单元，存放ADC输入
		
		MOV  SP,	#60H 				; 开栈，很重要 
		
		MOV  DPTR,	#7FF8H			; DPTR指向ADC地址，通过MEM计算
		MOVX @DPTR,	A				; 触发ADC向INT1发数据
		
		SETB EA						; 开中断
		SETB EX1						; 开INT1中断
		CLR  PX1						; 关优先级
		SETB IT1						; 设置为下跳沿触发INT1
      
		SJMP  $						; 初始化完成，这里可以干别的事去了

; 串口通讯函数
COMMUNITY:
		PUSH ACC					; 保护现场
		SUBB A,		31H				; 验证ADC的采样是否有变化
		JNZ	COM						; 有变化，就发送给串口
		POP  ACC						; 没变化，就直接返回，出栈
		RET							; 返回
COM:	POP	 ACC						; 有变化，要传新的数字，故要先弹栈
		MOV	 31H,	A					; 传新的数字到内存单元
		MOV  SBUF,	A			 	; 发送到发送的BUFFER
		JNB  TI,	$					; BUFFER发完之前先别动
		CLR  TI						; 发完了手动清空中断服务寄存器
		RET							; 返回
			

ITR1:	CLR	 EA							; 进入中断后先关中断，防止嵌套
		MOV  P1, 	#0FFH				; 关闭数码管
		MOVX A,		@DPTR			; 读取ADC输入
		LCALL 		COMMUNITY		; 由于串口用16进制表示，这里先把数据传到串口
		MOV	 30H,	A					; 送到存储的内存单元进行下一步处理
		
		
		MOV	 DPTR,	#SEVEN_SEG_OUT	; 直接定址表，指向数据表
		GET_NUM 30H, 80H, R4			; 获取个位，这里用80H因为小数点都是亮的
		GET_NUM R1,  0,  R3				; 获取十位
		GET_NUM R1,  0,  R2				; 获取百位
		
		
		MOV  R5, 	#150					; 一个小循环，否则数码管看不见的
LIGHTEN:
		LIGHT_SEG 01H, R2				; 数码管显示百位
		LIGHT_SEG 02H, R3				; 十位
		LIGHT_SEG 04H, R4				; 个位
		LIGHT_SEG 08H, #0C0H			; 小数，这里小数恒为0
		
		DJNZ R5,	LIGHTEN				; 重复显示
		
		MOV  DPTR,	#7FF8H			; 重新指向ADC
		MOVX @DPTR,	A				; 激活ADC发送中断
		SETB EA						; 开中断
		RETI							; 中断返回
		
; 这是存放数字相应的数码管输入的字段
SEVEN_SEG_OUT:		
		DB	 0C0H, 0CFH, 0A4H, 0B0H, 99H
		DB	 92H,  82H,  0F8H, 80H,  90H



END 
	
