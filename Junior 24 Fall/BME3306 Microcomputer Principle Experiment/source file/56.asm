assume cs:code

a segment
	dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 0aH, 0bH, 0cH, 0dH, 0eH, 0fH, 0ffH
a ends

b segment
	dw 0, 0, 0, 0, 0, 0, 0, 0
b ends


code segment
start:	mov ax, a
	mov ds, ax
	mov bx, 0H
	add ax, 3			;将b段之后的一个段定义为ss
	mov ss, ax
	mov cx, 8

s1:	push [bx]
	add bx, 2
	loop s1

	mov bx, 20H
	mov cx, 8

s2:	pop [bx]
	add bx, 2
	loop s2

	mov ax, 4c00H
	int 21H

code ends

end start