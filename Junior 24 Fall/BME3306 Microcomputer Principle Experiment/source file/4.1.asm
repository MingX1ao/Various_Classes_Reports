assume cs:codesg

codesg segment

	mov cx, 64
	mov bx, 0
	mov ds, bx
	s:	mov [200H+bx], bx
		inc bx
	loop s

	mov ax, 4c00H
	int 21H

codesg ends

end