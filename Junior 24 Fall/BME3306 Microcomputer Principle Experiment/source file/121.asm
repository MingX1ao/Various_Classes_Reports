assume cs:code

code segment
start:
	mov ax, 0
	mov es, ax
	mov di, 204	;在0000:0204处安装程序
	
	mov ax, cs
	mov ds, ax
	mov si, offset do0
	mov ax, offset do0end
	sub ax, si
	mov cx, ax		;将程序的长度给cx
	
	cld			;复制程序
	rep movsb
	
	mov word ptr es:[0], 204	;重定向中断例程
	mov word ptr es:[2], 0
	
	mov ax, 4c00H
	int 21H

do0:
	jmp short do0start
	db 'divide error!', 0

do0start:
	push ax
	push bx
	push es
	push cx
	push bp
	push ds
	
	mov ax, 0
	mov ds, ax
	mov ax, 0B800H			;设置显示位置
	mov es, ax
	mov bp, 12*80*2+(39-6)*2
	mov bx, 206				;设置显示源
	mov ah, 00100100B			;设置字符属性

	mov ch, 0
s:	mov al, [bx]
	mov cl, al
	jcxz over
	mov es:[bp], ax
	inc bp
	inc bp
	inc bx
	jmp short s

over:
	pop ds
	pop bp
	pop cx
	pop es
	pop bx
	pop ax
	
	mov ax, 4c00H
	int 21H
do0end:
	nop

code ends

end start