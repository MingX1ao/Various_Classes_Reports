ORG 0000H 
		LJMP  MAIN
		ORG   0003H       
		LJMP  ITR0
MAIN:	SETB  EA          
		SETB  EX0          
		CLR   PX1            
		MOV   A, #01111111B    
LOOP:	SJMP  LOOP
ITR0:	RL    A               
		MOV   P1,A        
		ACALL DEL
		RETI                     

DEL:	MOV   R7, #20
DEL1: 	MOV   R6, #200      
DEL2:	MOV   R5, #123      
        NOP              
        DJNZ  R5, $        
        DJNZ  R6, DEL2     
		DJNZ  R7, DEL1
        RET              	
		
END