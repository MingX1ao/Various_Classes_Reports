assume cs:code, ds:data

data segment							;在code段内定义会有bug，不知道怎么回事就单独定义一个data段
	dw offset sub1 - offset do7C + 200h
	dw offset sub2 - offset do7C + 200h
	dw offset sub3 - offset do7C + 200h
	dw offset sub4 - offset do7C + 200h
data ends

code segment

start:									;安装程序
	mov ax, 0
	mov es, ax
	mov ax, code
	mov ds, ax
	mov di, 200h
	mov si, offset do7C
	mov cx, offset do7CEnd - offset do7C
	cld
	rep movsb

	mov word ptr es:[7Ch*4],  200h			;重定向
	mov word ptr es:[7Ch*4+2], 0

	mov di, 200h + offset do7CEnd - offset do7C		;记录data段的数据，紧跟这do7C的指令
	mov si, 0
	mov ax, data
	mov ds, ax
	mov cx, 4
	cld
	rep movsw

	mov ax, 4C00h
	int 21h

do7C:
	jmp near ptr set

set:
	push es
	push bx
	push ds
	push ax
	
	cmp ah, 3
	ja sret
	mov bl, ah
	mov bh, 0
	add bx, bx
	mov ax, 0
	mov es, ax
	mov si, 200h + offset do7CEnd - offset do7C 	;指向几个数据
	mov bx, es:[bx+si]
	pop ax						;ax必须在这里pop，不然就是0
	call bx
sret:
	pop ax
	pop bx
	pop es

	iret

sub1:
	push bx
	push es
	push cx
	push dx
	mov bx, 0B800h
	mov es, bx
	mov cx, 2000
	mov bx, 0
	mov dl, ' '
sub1s:
	mov es:[bx], dl
	inc bx
	inc bx
	loop sub1s
	pop dx
	pop cx
	pop es
	pop bx
	ret


sub2:
	push bx
	push es
	push cx
	mov bx, 0B800h
	mov es, bx
	mov cx, 2000
	mov bx, 1
sub2s:
	and byte ptr es:[bx], 11111000b
	or es:[bx], al
	inc bx
	inc bx
	loop sub2s
	pop cx
	pop es
	pop bx
	ret


sub3:
	push bx
	push es
	push cx
	mov bx, 0B800h
	mov es, bx
	mov cl, 4
	shl al, cl
	mov cx, 2000
	mov bx, 1
sub3s:
	and byte ptr es:[bx], 10001111b
	or es:[bx], al
	inc bx
	inc bx
	loop sub3s
	pop cx
	pop es
	pop bx
	ret


sub4:
	push bx
	push es
	push si
	push di
	push cx
	mov bx, 0B800h
	mov es, bx
	mov di, 0
	mov si, 160
	mov ds, bx
	cld
 	mov cx, 24
sub4s:
	push cx
	mov cx, 160
	rep movsb
	pop cx
	loop sub4s

	mov cx, 80
	mov di, 0
sub4s1:
	mov byte ptr es:[di+160*24], ' '
	inc si
	inc si
	loop sub4s1
	pop cx
	pop di
	pop si
	pop es
	pop bx
	ret

do7CEnd:
	nop

code ends

end start




	