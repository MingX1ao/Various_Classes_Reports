assume cs:code

code segment

start:
	mov si, 4
	call SQRT
	
	mov ax, 4c00H
	int 21H

SQRT PROC NEAR
	push ax
	push bx
	push cx
	
	mov ax, si		;取n2
	sub cx, cx		;cx=0,同时让FLAGS置零
again:
	mov bx, cx		;bx=i
	add bx, bx
	inc bx			;bx=2i+1
	sub ax, bx		
	jc over			;存在借位，说明ax<bx，就结束
	inc cx
	jmp again		;ax>bx就继续
over:			
	mov si, cx
	pop cx
	pop bx
	pop ax
	ret
SQRT ENDP

code ends

end start