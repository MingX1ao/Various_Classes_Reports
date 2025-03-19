assume cs:code

a segment
	db 1, 2, 3, 4, 5, 6, 7, 8
a ends

b segment
	db 1, 2, 3, 4, 5, 6, 7, 8
b ends

c segment
	db 0, 0, 0, 0, 0, 0, 0, 0
c ends

code segment
start:	
	mov ax, a
	mov ds, ax

	mov cx, 8H
	mov bx, 0H

s:	mov al, 0
	add al, ds:[bx]
	add al, ds:[bx+10H]
	mov ds:[bx+20H], al
	inc bx
	loop s
	
	mov ax, 4c00H
	int 21H

code ends
end start