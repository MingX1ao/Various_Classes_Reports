assume cs:code
code segment
start:
; 调用中断，等待输入
mov ah,0
int 16h
; 识别按键
mov ah,1
cmp al,'r'
je red
cmp al,'g'
je green
cmp al,'b'
je blue
jmp short sret
; 设置屏幕颜色
red: shl ah, 1 ;移动2位
green: shl ah,1 ;移动1位
blue: mov bx,0b800h
mov es,bx
mov bx,1
mov cx,2000
s: and byte ptr es:[bx],11111000b ;清除前景颜色
or es:[bx], ah  ;设定为特定颜色
add bx,2
loop s
sret: mov ax,4c00h
int 21h
code ends
end start