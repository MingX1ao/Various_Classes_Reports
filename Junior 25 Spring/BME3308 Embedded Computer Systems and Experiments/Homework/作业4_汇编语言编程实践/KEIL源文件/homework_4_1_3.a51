ORG 0000H
		LJMP START3
	
ORG 0100H
START3:	MOV P1, #0FFH
		LCALL DEL 
		MOV P1, #00H
        LCALL DEL
        LJMP START3

DEL: 	MOV R7,#200      ;1MC
DEL1:	MOV R6,#123      ;1MC
        NOP              ;1MC
        DJNZ R6,$        ;2MC,???
        DJNZ R7,DEL1     ;2MC
        RET              ;2MC
END