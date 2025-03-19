assume cs:code
code segment
start:
	mov ax, 0b800h
	mov es, ax
	mov di, 160*12
	mov bx, offset s - offset se
	mov cx, 80
s:	mov byte ptr es:[di], '!'
	add di, 2
	int 7Ch
se:	nop
	mov ax, 4c00H
	int 21H
code ends
end start