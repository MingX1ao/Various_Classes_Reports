assume ds:data, cs:code, es:extra

data segment
	dw 123, 12666, 1, 8, 3, 38
data ends


extra segment		;保存字符串
	db 10 dup (0)
extra ends


code segment
	
start:
	mov ax, data
	mov ds, ax
	mov si, 2

	mov ax, extra
	mov es, ax
	mov di, 0

	mov cx, 1
	mov bx, 5		;从第5开始打印，打印6行，这里只打印一个12666

s:	mov ax, ds:[si]
	call dtoc
	
	push dx
	push cx
	
	mov dh, bl
	mov dl, 3
	mov cl, 2
	call show_str

	pop cx
	pop dx
	
	inc bl
	add si, 2
	add di, 4

	loop s

	mov ax, 4c00H
	int 21H

dtoc:
	push bp
	push bx
	push dx
	push cx
	push ax

	mov bp, 0
	mov bx, 10
dtoc1:
	mov dx, 0
	div bx
	add dx, 30H			;余数变ASCII
	mov cx, ax				;看除完了没				
	mov byte ptr es:[di+bp], dl		;写结果
	jcxz inverse1
	inc bp
	jmp short dtoc1

inverse1:					;因为是倒着存的，还要倒回去
	mov byte ptr es:[di+bp+1], 0		;最后写0
	mov bp, 0
	push bp						;作为弹栈完成标志
inverse15:	
	mov ch, 0
	mov cl, es:[di+bp]
	jcxz inverse2
	push cx
	inc bp
	jmp short inverse15

inverse2:
	mov bp, 0
inverse25:
	pop cx
	mov es:[di+bp], cl
	inc bp
	jcxz overdtoc
	jmp short inverse25

overdtoc:
	pop ax
	pop cx
	pop dx
	pop bx
	pop bp
	ret


show_str:
	push ax
	push bx
	push ds
	push di
	push cx
	push si

	mov bl, 160D
	mov ax, 0B800H
	mov ds, ax
	mov al, dh
	mul bl

	mov bl, dl
	add bl, bl
	mov si, ax
	
	
	mov ah, cl
str:	mov ch, 0
	mov cl, es:[di]
	jcxz overstr
	mov al, es:[di]
	mov ds:[bx+si], ax
	inc di
	inc bx
	inc bx
	jmp short str
overstr:	
	pop si
	pop cx
	pop di
	pop es
	pop bx
	pop ax
	
	ret

code ends

end start



code ends

end start



