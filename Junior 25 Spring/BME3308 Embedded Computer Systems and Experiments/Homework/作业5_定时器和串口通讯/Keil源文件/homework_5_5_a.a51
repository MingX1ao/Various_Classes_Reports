ORG 0000H
		LJMP 	INIT
		
ORG	0013H
		LCALL	GET_NUM
		
ORG 0400H
INIT:
		MOV		00H,	#01H
		MOV		SP,		#60H
		
		
ASTART:	SETB  	EA
		MOV  	TMOD,	#20H     
		MOV  	TH1,	#0F4H       
		MOV  	TL1,	#0F4H
		MOV  	PCON,	#00H       
		SETB  	TR1                  
		MOV  	SCON,	#50H  

DETECT:	SETB	EX1
		SJMP	$
		SJMP	DETECT
		
GET_NUM:  
		CLR		EX1
		MOV 	P1, 	#0FFH
		CLR 	P1.3
		JNB 	P1.2, 	NUM1
		JNB 	P1.1, 	NUM2
		JNB 	P1.0, 	NUM3
		SETB 	P1.3
		CLR 	P1.4
		JNB 	P1.2, 	NUM4
		JNB 	P1.1, 	NUM5
		JNB 	P1.0, 	NUM6
		SETB 	P1.4
		CLR 	P1.5
		JNB 	P1.2, 	NUM7
		JNB 	P1.1, 	NUM8
		JNB 	P1.0, 	NUM9
		SETB 	P1.5
		CLR 	P1.6
		JNB 	P1.1, 	NUM0
		SETB 	P1.6
		JB		P3.3,	OUT
		LJMP	GET_NUM

OUT:	RETI

NUM0:	MOV 	40H,	#00H
		LJMP	ALOOP1

NUM1:   MOV 	40H,	#01H
		LJMP 	ALOOP1        

NUM2:   MOV 	40H,	#02H
		LJMP 	ALOOP1

NUM3:   MOV 	40H,	#03H
		LJMP	ALOOP1

NUM4:   MOV 	40H,	#04H
		LJMP 	ALOOP1

NUM5:   MOV 	40H,	#05H
		LJMP 	ALOOP1

NUM6:   MOV 	40H,	#06H
		LJMP 	ALOOP1

NUM7:   MOV 	40H,	#07H
		LJMP 	ALOOP1

NUM8:   MOV 	40H,	#08H
		LJMP 	ALOOP1

NUM9:   MOV 	40H,	#09H
		LJMP 	ALOOP1


  
ALOOP1:	MOV  	SBUF,	#0E1H    
		JNB  	TI,		$                  
		CLR  	TI                       
		JNB  	RI,		$                             
		CLR  	RI                      
		MOV  	A,		SBUF          
		XRL  	A,		#0E2H           
		JNZ  	ALOOP1
ALOOP2:	MOV  	R0,		#40H                
		MOV  	R6,		#00H         
ALOOP3:	MOV  	SBUF,	@R0      
		MOV  	A,		R6           
		ADD  	A,		@R0          
		MOV  	R6,		A            
		INC 	R0
		JNB  	TI,		$   
		CLR  	TI
		MOV  	SBUF,	R6       
		JNB  	TI,		$
		CLR  	TI
		JNB  	RI,		$            
		CLR  	RI
		MOV  	A,		SBUF        
		JNZ   	ALOOP2         
		LJMP	GET_NUM
		
END
	