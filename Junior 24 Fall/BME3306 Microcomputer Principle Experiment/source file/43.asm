assume cs:code
code segment
	
	mov ax, code			;补全了code
	mov ds, ax
	mov ax, 0020H
	mov es, ax
	mov bx, 0H
	mov cx, 18H				;补全了18H
	
s:	mov al, [bx]
	mov es:[bx], al
	inc bx
	loop s
	
	mov ax, 4c00H
	int 21H
	
code ends
end