;PRESS Esc TO EXIT         			; 清屏或上卷宏定义
SCROLL    MACRO     N,ULR,ULC,LRR,LRC,ATT	;宏定义
          MOV       AH,6				;清屏或上卷
          MOV       AL,N		;N=上卷行数；N=0时，整个窗口空白
          MOV       CH,ULR		;左上角行号
          MOV       CL,ULC		;左上角列号
          MOV       DH,LRR		;右下角行号
          MOV       DL,LRC		;右下角列号
          MOV       BH,ATT		;卷入行属性
          INT       10H
          ENDM  
CURSE     MACRO     CURY,CURX    
          MOV       AH,2		     	;置光标位置
          MOV       DH,CURY			;行号
          MOV       DL,CURX			;列号
          MOV       BH,0			;当前页
          INT       10H
          ENDM

;输出字符串
print macro str; 
    push dx
    push ax
    lea dx,str
    mov ah,09h
    int 21h
    pop ax
    pop dx
    endm


date segment 
    line1           db "++====+=====+=====+=====+=====+=====+===++$"
    author          db "||         Author:2022102151-hzq        ||$"
    welcome_prompt  db "||      Welcome to the typing game!     ||$"
    exit_prompt     db "|| Press the esc button to esc the game ||$"
    choice_prompt   db "||  Press number to choose your choice  ||$ "
    choice1         db "||          1.start the game            ||$"
    choice2         db "||          2.check my score            ||$"
    choice3         db "||          3.close the game            ||$"
    line2           db "++====+=====+=====+=====+=====+=====+===++$"
    your_choice     db "            Your choice:  $"
    correct_count dw 0
    total_count dw 0
    start_r equ 23
    start_c equ 2
    string db "hello,world!$"
    
    
date ends

stack segment
   db 32 dup(0)

stack ends


code segment
start:
    mov ax,date
    mov ds,ax
    mov ax,stack
    mov ss,ax
 
    call start_view
    

     
    ;print string
    ;lea si,string
    ;curse 23,2
    ;call process_input
    

      
     ;开始界面
start_view proc
       
    scroll 0,0,0,25,80,50h;开外窗口，品红底
    scroll 0,1,2,23,78,3fh;开内窗口，浅绿底，白字
    curse 9,19             ;置光标位于9行19列
    print line1
    curse 10,19
    print author
    curse 11,19
    print welcome_prompt
    curse 12,19
    print choice_prompt
    curse 13,19
    print choice1
    curse 14,19
    print choice2
    curse 15,19
    print choice3
    curse 16,19
    print line2
    curse 17,19
    print your_choice
    mov ah,1
    int 21h
    cmp al,'1'
    je start_game
    cmp al,'2'
    je check_score
    cmp al,'3'
    je close_game
    jmp error
start_game:
    ;开始游戏
check_score:
    ;查看分数
close_game:
    ;关闭游戏
    mov ax,4c00h
    int 21h
error:
    call start_view
    ret
start_view endp
    
    
         
     
   ;处理用户输入,1个字符
   ;[si]为当前要输出的字符
process_input proc
    push ax
    push bx
    push cx
    mov ah,00h
    int 16h
    cmp al,[si]
    je correct_input
    jmp incorrect_input 
correct_input:
    ;更新正确计数
    inc correct_count
    inc total_count
    mov ah,09h
    mov al,[si]
    mov bh,0
    mov bl,2;绿色
    mov cx,1
    int 10h
    jmp e1
incorrect_input: 
    cmp al,1bh;是不是esc键
    je quit
    ;更新总计数
    inc total_count
    mov ah,09h
    mov al,[si]
    mov bh,0
    mov bl,4;红色
    mov cx,1
    int 10h

e1:  
    pop cx
    pop bx
    pop ax
    ret

quit:
    call start_view
     


    

    
    
    

code ends
end start
    
    
 