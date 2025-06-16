ORG 0000H
LJMP START
ORG 040H
START:   MOV  DPTR,#7FF8H;DPTR??0808??0
		 MOVX @DPTR,A;??0808?IN0????
		 LCALL DELAY;??
		 MOVX A,@DPTR;??A/D??
		 MOV  30H,A;???????RAM??30H
		 JMP  NEXT
		
DELAY:   MOV  R5,#050
DELAYY:  DJNZ R5,DELAYY
         RET

NEXT:    MOV  A,30H;
		 MOV  B,#10;
		 DIV  AB; A÷B???A,???B
		 PUSH B;?????,??
		 MOV  B,#10;
		 DIV  AB;
		 PUSH B;?????,??
		 MOV  B,#10;
		 DIV  AB;
		 MOV  A,B;????A?
; ????????
N30:     CJNE A,#0,N31; ?????,?N31
			 MOV  R2,#11000000B;???0,???0?LED????R2,DP?????????
			 JMP  N20
N31:     CJNE A,#1,N32;
			 MOV  R2,#11001111B;1
			 JMP  N20
N32:     CJNE A,#2,N33;
             MOV  R2,#10100100B;
             JMP  N20
N33:     CJNE A,#3,N34;
             MOV  R2,#10110000B;3
             JMP  N20
N34:     CJNE A,#4,N35;
             MOV  R2,#10011001B;4
             JMP  N20
N35:     CJNE A,#5,N36;
             MOV  R2,#10010010B;5
             JMP  N20
N36:     CJNE A,#6,N37;
             MOV  R2,#10000010B;6
             JMP  N20
N37:     CJNE A,#7,N38;
             MOV  R2,#11111000B;7
             JMP  N20
N38:     CJNE A,#8,N39;
             MOV  R2,#10000000B;8
             JMP  N20
N39:     MOV  R2,#10010000B;9
; ????????
N20:     POP  B;??????
             MOV  A,B
             CJNE A,#0,N21;
             MOV  R3,#01000000B;?0?R3
             JMP  N10
N21:     CJNE A,#1,N22;
             MOV  R3,#01001111B;1
             JMP  N10
N22:     CJNE A,#2,N23;
             MOV  R3,#00100100B;2???LED???,cf????,???3,6??;?????1,??DP?????
             JMP  N10
N23:     CJNE A,#3,N24;
             MOV  R3,#00110000B;3
             JMP  N10
N24:     CJNE A,#4,N25;
             MOV  R3,#00011001B;4
             JMP  N10
N25:     CJNE A,#5,N26;
             MOV  R3,#00010010B;5
             JMP  N10
N26:     CJNE A,#6,N27;
             MOV  R3,#00000010B;6
             JMP  N10
N27:     CJNE A,#7,N28;
             MOV  R3,#01111000B;7
             JMP  N10
N28:     CJNE A,#8,N29;
             MOV  R3,#00000000B;8
             JMP  N10
N29:     MOV  R3,#00010000B;9
;????????
N10:     POP  B;???????
             MOV  A,B
             CJNE A,#0,N11;
             MOV  R4,#11000000B;??0?R4
             JMP  LOOOP
N11:     CJNE A,#1,N12;
             MOV  R4,#11001111B;1
             JMP  LOOOP
N12:     CJNE A,#2,N13;
             MOV  R4,#10100100B;2
             JMP  LOOOP
N13:     CJNE A,#3,N14;
             MOV  R4,#10110000B;3
             JMP  LOOOP
N14:     CJNE A,#4,N15;
             MOV  R4,#10011001B;4
             JMP  LOOOP
N15:     CJNE A,#5,N16;
             MOV  R4,#10010010B;5
             JMP  LOOOP
N16:     CJNE A,#6,N17;
             MOV  R4,#10000010B;6
             JMP  LOOOP
N17:     CJNE A,#7,N18;
             MOV  R4,#11111000B;7
             JMP  LOOOP
N18:     CJNE A,#8,N19;
             MOV  R4,#10000000B;8
             JMP  LOOOP
N19:     MOV  R4,#10010000B;9
;?????R2(?),R3(?),R4(?)???????????????

LOOOP:  MOV  P2,#00000010B;????2?,????
		MOV  P1,#11111111B;??
		MOV  P1,R2;???2??  ,???????????,???????
		MOV  P2,#00000100B;????3?,????
		MOV  P1,R3;???3??,R3?????
		MOV  P1,#11111111B;??
		MOV  P2,#00001000B;????4?,????
		MOV  P1,R4;???4??,R4?????
		MOV  P1,#11111111B;??
		LJMP START
		END ;



