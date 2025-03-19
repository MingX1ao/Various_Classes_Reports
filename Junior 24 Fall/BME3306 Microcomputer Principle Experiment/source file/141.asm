assume cs:code


code segment
	s: db 9, 8, 7, 4, 2, 0
	time: dw '00', ' /', '00', ' /', '00', '  ', '00', ' :', '00', ' :', '00'	;存放读到的时间
start:
	mov ax, cs
	mov ds, ax
	mov si, offset s			;定位到数据段
	mov di, offset time		;存储用
	mov cx, 6				;循环6次

read:	
	mov al, ds:[si]			;写入要读的端口
	out 70h, al				
	in al, 71h				;写到al，还需要变换
	
	mov ah, al
	push cx
	mov cl, 4
	shr ah, cl
	pop cx
	and al, 00001111b
	add ah, 30h
	add al, 30h

	mov byte ptr ds:[di], ah	;写入内存
	mov byte ptr ds:[di+1], al
	
	inc si
	add di, 4
	
	loop read

print:						;显示时间
	mov ax, 0B800h
	mov es, ax
	mov bx, 12*160+(39-11)*2
	
	mov si, offset time
	mov cx, 22
printloop:
	mov dl, ds:[si]
	mov es:[bx], dl
	add bx, 2
	inc si
	loop printloop

	mov ax, 4c00h
	int 21h

code ends

end start





