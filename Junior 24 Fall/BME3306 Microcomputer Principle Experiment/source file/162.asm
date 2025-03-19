assume cs:code

code segment

	mov ah, 2
	mov al, 3

	int 7Ch
	
	mov ax, 4C00h
	int 21h
code ends

end