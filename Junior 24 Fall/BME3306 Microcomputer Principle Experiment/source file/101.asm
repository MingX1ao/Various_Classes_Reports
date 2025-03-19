assume cs:code

data segment
	db 'Welcome to masm!', 0
data ends

code segment

start:
	mov dh, 8
	mov dl, 3
	mov cl, 2
	mov ax, data
	mov ds, ax
	mov si, 0
	call show_str
	
	mov ax, 4c00H
	int 21H

show_str:
	push ax
	push bx
	push es
	push di
	push cx
	push si

	mov bl, 160D
	mov ax, 0B800H
	mov es, ax
	mov al, dh
	mul bl

	mov bl, dl
	add bl, bl
	mov di, ax
	
	mov ah, cl
s:	mov ch, 0
	mov cl, ds:[si]
	jcxz over
	mov al, ds:[si]
	mov es:[bx+di], ax
	inc si
	inc bx
	inc bx
	jmp short s
over:	
	pop si
	pop cx
	pop di
	pop es
	pop bx
	pop ax
	
	ret

code ends
end start