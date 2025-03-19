assume cs:code

code segment

	mov ax, 4240H
	mov dx, 000FH
	mov cx, 0AH
	call divdw
	
	mov ax, 4c00H
	int 21H

divdw:	
	push bx
	push si
	push di

	mov si, ax			;存数据给临时变量
	mov di, dx
	mov bx, cx
	
	mov ax, di			;计算高位的商
	mov dx, 0
	div bx
	mov di, ax			;高位的商在di，高位的余数在dx
	
	mov ax, si			;计算低位的商和余数
	div bx			;低位的商在ax，低位的余数在dx

	mov cx, dx
	mov dx, di

	pop di
	pop si
	pop bx
	ret

code ends

end