assume cs:codeseg, ds:dataseg, ss:stackseg
dataseg segment

mus_freq dw 524,524,524,494,440,659,494
dw 524,524,524,524,440,494,392
dw 524,494,440,524,494,440,659,494
dw 524,494,440,440,440
dw 0,440,494,524,494,440,524,524,524,494,440,659,494
dw 524,524,524,440,440,494,392,-1

mus_time dw 2 dup(24,12,12,12,12,36,36)
dw 12,12,12,12,12,12,36,24,12,12,12,12,36
dw 12,12,12,12,12,12,24,12,12,12,12,36,36
dw 24,12,12,12,12,36,36
dataseg ends
stackseg segment
db 100h dup (0)
stackseg ends
codeseg segment
start:
mov ax, stackseg
mov ss, ax
mov sp, 100h
mov ax, dataseg
mov ds, ax
;依序播放乐谱
lea si, mus_freq ;lea：加载有效地址，类似于C语言中的&
lea di, mus_time
play:
mov dx, [si]
cmp dx, -1
je end_play
call sound
add si, 2
add di, 2
jmp play
end_play:
mov ax, 4c00h
int 21h
;子程序：演奏一个音符
sound:
push ax
push dx
push cx
;8253芯片的设置
mov al,0b6h
out 43h,al
mov dx,12h
mov ax,34dch
div word ptr [si]
out 42h, al
mov al, ah
out 42h, al
;设置8255芯片, 控制扬声器的开/关
in al,61h
mov ah,al
or al,3
out 61h,al
;延长一定时长
mov dx, [di]
wait1:
mov cx, 28000
delay:
nop
loop delay
dec dx
jnz wait1
;恢复扬声器端口原值
mov al, ah
out 61h, al
pop cx
pop dx
pop ax
ret

codeseg ends
end start
