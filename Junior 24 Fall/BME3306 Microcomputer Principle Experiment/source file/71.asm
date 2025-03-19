assume cs:codesg

data segment

	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'

	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800

data ends

table segment
	
	db 21 dup ('year summ ne ?? ')

table ends



stacksg segment
	
	dw 21 dup(0)

stacksg ends


codesg segment

start:	mov ax, data
	mov ds, ax
	mov ax, table
	mov es, ax
	mov ax, stacksg
	mov ss, ax
	mov sp, 0H
	mov bx, 0H
	mov bp, 0H
	mov si, 84
	mov di, 168
	mov cx, 21

s1:	push cx
	mov cx, 2

	mov ax, ds:[bx]			;转移年份
	mov es:[bp], ax
	mov ax, ds:[bx+2]
	mov es:[bp+2], ax
	
	pop cx
	mov ax, ds:[si]			;转移收入
	mov dx, ds:[si+2]
	mov es:[bp+5], ax
	mov es:[bp+7], dx

	push bx					;计算人均收入并转移
	mov bx, ds:[di]
	div bx
	pop bx
	mov es:[bp+13], ax

	mov ax, ds:[di]			;转移雇员数
	mov es:[bp+10], ax
	
	add bx, 4H
	add si, 4H
	add di, 2H
	add bp, 10H
	loop s1

	mov ax, 4c00H
	int 21H

codesg ends

end start





	