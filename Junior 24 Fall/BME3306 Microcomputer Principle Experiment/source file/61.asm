assume cs:codesg, ss:stacksg, ds:datasg

stacksg segment
	dw 0, 0, 0, 0, 0, 0, 0, 0
stacksg ends

datasg segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '
datasg ends

codesg segment
start:	mov ax, datasg
	mov ds, ax
	mov bx, 0H
	mov ax, stacksg
	mov ss, ax
	mov sp, 0H
	mov cx, 4
s1:	push cx
	mov cx, 4
	mov si, 0
s2:	mov al,  [bx+3+si]
	and al, 11011111B
	mov [bx+3+si], al
	inc si
	loop s2
	pop cx
	add bx, 10H
	loop s1

	mov ax, 4c00H
	int 21H
codesg ends

end start
	
	
	