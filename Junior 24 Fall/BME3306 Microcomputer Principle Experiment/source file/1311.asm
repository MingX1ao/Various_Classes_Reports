assume cs:code

code segment
start:
	mov ax, code						;复制指令
	mov ds, ax
	mov si, offset do7C
	mov di, 200
	mov ax, 0
	mov es, ax
	mov cx, offset do7Cend - offset do7C
	cld
	rep movsb

	mov word ptr es:[7Ch*4], 200			;更改中断向量表
	mov word ptr es:[7Ch*4+2], 0

	mov ax, 4C00h
	int 21h

do7C:
	push bx
	push ax
	push es
	push cx
	push si
	push di

	mov bl, 160D		;找显示位置
	mov ax, 0B800H
	mov es, ax
	mov al, dh
	mul bl

	mov bl, dl
	add bl, bl			;存列号
	mov di, ax			;存行号

	mov si, 0			;源
	mov ah, cl			;字符属性
	mov ch, 0
s:	mov al, ds:[si]		;转移到显存
	mov cl, al
	jcxz over
	mov es:[di+bx], ax
	add bl, 2
	inc si
	jmp short s

over:
	pop di
	pop si
	pop cx
	pop es
	pop ax
	pop bx
	iret
do7Cend:
	nop
	
code ends

end start