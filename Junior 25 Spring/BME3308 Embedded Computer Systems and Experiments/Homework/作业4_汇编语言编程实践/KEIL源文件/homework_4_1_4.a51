ORG 0000H
		LJMP START4
				
ORG 0040H
START4:
		MOV R0,#DATA1
		MOV DPTR,#BUFFER
LOOP1:	MOV A,@R0
		CJNE A,#24H,LOOP2    ;?????$??
		SJMP  LOOP3          ;?,???
LOOP2:	MOVX @DPTR,A         ;??,????
		INC R0
		INC DPTR
		SJMP LOOP1           ;??????
LOOP3:	NOP

ORG 1980H
DATA1:	DB 'Hello_Word$'
ORG 2000H
BUFFER:	DB '           '


END
