assume cs:code, ds:data

data segment
	db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends

code segment

pushreg macro
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push bp
	endm

popreg macro
	pop bp
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	endm

begin:
	mov ax, data
	mov ds, ax
	mov si, 0
	
	pushreg
	call letterc
	popreg

	mov ax, 4c00H
	int 21H

letterc:
	mov al, ds:[si]
	
	cmp al, 0
	je lettercEnd
	
	cmp al, 'a'		;在不在范围内的判断
	jb nextLetter
	cmp al, 'z'
	ja nextLetter
	
	and al, 11011111B
	mov ds:[si], al

nextLetter:
	inc si
	jmp short letterc	

lettercEnd:
	ret

code ends

end begin









