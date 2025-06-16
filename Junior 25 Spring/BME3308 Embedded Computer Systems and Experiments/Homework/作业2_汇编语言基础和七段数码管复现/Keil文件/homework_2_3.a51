ORG 0000H
		 LJMP START
         ORG 040H
START:	 MOV SP, #5FH 
         MOV A, #69H 
         MOV B, #12H
         PUSH   ACC
         PUSH   B
		 MOV A, #0H
         MOV B, #0H
         POP B
         POP ACC;
 LOOP:	 NOP
         LJMP LOOP
         END