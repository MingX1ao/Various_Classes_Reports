ORG 0000H
LJMP START

ORG 1234H
START: MOV SP, #34H

; Test Case 1: Addition (No Carry)
MOV A, #12H
ADD A, #34H

; Test Case 2: Addition (With Carry)
MOV A, #0F0H
ADD A, #10H

; Test Case 1: Subtraction (No Borrow)
MOV A, #50H
SUBB A, #30H

; Test Case 2: Subtraction (With Borrow)
MOV A, #10H
SUBB A, #30H

; Test Case 1: Multiplication (Result fits in 8 bits)
MOV A, #08H
MOV B, #02H
MUL AB

; Test Case 2: Multiplication (Result exceeds 8 bits)
MOV A, #0FFH
MOV B, #02H
MUL AB

; Test Case 1: Division (Exact Division)
MOV A, #10H
MOV B, #02H
DIV AB

; Test Case 2: Division 0
MOV A, #11H
MOV B, #00H
DIV AB

LOOP: NOP
LJMP LOOP

END
