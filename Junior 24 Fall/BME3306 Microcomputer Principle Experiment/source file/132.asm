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
	pop ax							;ax存原来的下一个ip，即offst se
	pop dx							;dx存原来的cs						

	add ax, bx							;此时ax为offset s
	sub cx, 1
	jcxz notDo						;进入中断前有一次循环，故判断==0在-1之后
	
	push dx							;cs不变
	push ax							;ip重新指向s
	iret

notDo:
	sub ax, bx
	push dx
	push ax
	iret

do7Cend:
	nop
	
code ends

end start