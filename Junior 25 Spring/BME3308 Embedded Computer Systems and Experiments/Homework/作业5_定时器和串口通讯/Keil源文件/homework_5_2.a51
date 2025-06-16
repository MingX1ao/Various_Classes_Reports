ORG   0000H
	LJMP  MAIN             

ORG   000BH              	
	LJMP  DVT0                

ORG   0100H
MAIN:
	MOV   TMOD,#01H 
	MOV   TH0,#0D8H         
	MOV   TL0,#0F0H          
	SETB  ET0              
	SETB  EA                
	SETB  TR0              
	SJMP  $                      
DVT0:
	CPL  P1.0             
	MOV  TH0,#0D8H        
	MOV  TL0,#0F0H           
	RETI                       
END
