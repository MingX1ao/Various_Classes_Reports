assume cs:code

code segment
start: 
        ;保存原始int9的地址
        mov ax, 0
        mov es, ax
        mov ax, es:[9*4]
        mov es:[200h], ax
        mov ax, es:[9*4+2]
        mov es:[202h], ax
        
        ;复制指令
        mov ax, code                                     
        mov ds, ax
        mov si, offset do9
        mov di, 204h
        mov cx, offset do9end - offset do9
        cld
        rep movsb

        ;更改中断向量表
        cli                                 ;关中断
        mov word ptr es:[9h*4], 204h       
        mov word ptr es:[9h*4+2], 0
        sti                                 ;开中断

        mov ax,4c00h
        int 21h

do9:
        push ax
        push bx
        push cx
        push es
        push ds

        in al, 60h                          ;读取扫描码
        
        pushf                               ;保存标志寄存器
        call dword ptr cs:[200h]            ;调用原中断处理程序
        
        cmp al, 1Eh                         ;比较是否为A键的通码
        jne do9ret                          ;不是A键就直接返回
        
        ;是A键，等待松开
wait_release:
        in al, 60h
        cmp al, 9Eh                         ;比较是否为A键的断码
        jne wait_release                    ;不是断码就继续等待
        
        ;显示满屏A
        mov ax, 0B800h
        mov es, ax
        mov bx, 0
        mov cx, 2000
        mov al, 'A'
s:      
        mov es:[bx], al
        add bx, 2
        loop s

do9ret:
        pop ds
        pop es
        pop cx
        pop bx
        pop ax
        iret
        
do9end:
        nop

code ends
end start