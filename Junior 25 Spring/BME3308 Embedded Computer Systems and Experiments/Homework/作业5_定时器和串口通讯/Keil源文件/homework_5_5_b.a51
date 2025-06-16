ORG 0000H
		LJMP 	INIT
		
ORG	0023H
		LJMP	BLOOP1

ORG 0400H
INIT:
		MOV		00H,	#01H
		MOV		SP,		#60H
		MOV		P0,		#00H
		
BSTART:	SETB  	EA
		SETB	ES
		MOV  	TMOD,	#20H
		MOV  	TH1,	#0F4H
		MOV  	TL1,	#0F4H
		MOV  	PCON,	#00H
		SETB  	TR1
		MOV  	SCON,	#50H

DETECT:	SJMP	$
		SJMP	DETECT

BLOOP1:	CLR		EA
		CLR  	RI               
		MOV  	A,		SBUF          
		XRL 	A,		#0E1H        
		JNZ		BLOOP1           
		MOV  	SBUF,	#0E2H     
		JNB 	TI,		$       
		CLR  	TI  
		MOV  	R0,		#40H       
		MOV 	R6,		#00H       
BLOOP2:	JNB  	RI,		$
		CLR  	RI  
		MOV 	A,		SBUF
		MOV  	@R0,	A         
		INC  	R0  
		ADD 	A,		R6       
		MOV 	R6,		A  
		JNB 	RI,		$        
		CLR  	RI
		MOV  	A,		SBUF
		XRL  	A,		R6           
		JZ   	END1             
		MOV  	SBUF,	#0FFH   
		JNB  	TI,		$            
		CLR  	TI
END1:	MOV  	SBUF,	#00H
		MOV		DPTR,	#SET_NUM
		MOV		A,		40H
		MOVC	A,		@A+DPTR
		MOV		P0,		A
		SETB	EA
		RETI
		
SET_NUM:
		DB		3FH, 06H, 5BH, 4FH, 66H
		DB		6DH, 7DH, 07H, 7FH,	6FH

END