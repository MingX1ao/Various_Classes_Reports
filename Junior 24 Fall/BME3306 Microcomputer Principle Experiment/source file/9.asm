assume cs:code, ds:data

data segment
	db 'welcom to masm!'
data ends

code segment
	
start:
	mov bx, 0000H
	mov ax, data
	mov ds, ax
	mov bp, 0000H
	mov ax, 0B800H
	mov es, ax
	
	mov ah, 00000010B
	mov cx, 15D
	mov bp, 11*80*2+(39-7)*2
s1:	mov al, ds:[bx]
	mov es:[bp], ax
	inc bp
	inc bp
	inc bx
	loop s1

	mov bx, 0
	mov ah, 00100100B
	mov cx, 15D
	mov bp, 12*80*2+(39-7)*2
s2:	mov al, ds:[bx]
	mov es:[bp], ax
	inc bp
	inc bp
	inc bx
	loop s2

	mov bx, 0
	mov ah, 01110001B
	mov cx, 15D
	mov bp, 13*80*2+(39-7)*2
s3:	mov al, ds:[bx]
	mov es:[bp], ax
	inc bp
	inc bp
	inc bx
	loop s3

	mov ax, 4c00H
	int 21H

code ends
end start
	