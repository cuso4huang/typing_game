;PRESS Esc TO EXIT         			; �������Ͼ�궨��
SCROLL    MACRO     N,ULR,ULC,LRR,LRC,ATT	;�궨��
          MOV       AH,6				;�������Ͼ�
          MOV       AL,N		;N=�Ͼ�������N=0ʱ���������ڿհ�
          MOV       CH,ULR		;���Ͻ��к�
          MOV       CL,ULC		;���Ͻ��к�
          MOV       DH,LRR		;���½��к�
          MOV       DL,LRC		;���½��к�
          MOV       BH,ATT		;����������
          INT       10H
          ENDM  
CURSE     MACRO     CURY,CURX    
          MOV       AH,2		     	;�ù��λ��
          MOV       DH,CURY			;�к�
          MOV       DL,CURX			;�к�
          MOV       BH,0			;��ǰҳ
          INT       10H
          ENDM

;����ַ���
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
    

      
     ;��ʼ����
start_view proc
       
    scroll 0,0,0,25,80,50h;���ⴰ�ڣ�Ʒ���
    scroll 0,1,2,23,78,3fh;���ڴ��ڣ�ǳ�̵ף�����
    curse 9,19             ;�ù��λ��9��19��
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
    ;��ʼ��Ϸ
check_score:
    ;�鿴����
close_game:
    ;�ر���Ϸ
    mov ax,4c00h
    int 21h
error:
    call start_view
    ret
start_view endp
    
    
         
     
   ;�����û�����,1���ַ�
   ;[si]Ϊ��ǰҪ������ַ�
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
    ;������ȷ����
    inc correct_count
    inc total_count
    mov ah,09h
    mov al,[si]
    mov bh,0
    mov bl,2;��ɫ
    mov cx,1
    int 10h
    jmp e1
incorrect_input: 
    cmp al,1bh;�ǲ���esc��
    je quit
    ;�����ܼ���
    inc total_count
    mov ah,09h
    mov al,[si]
    mov bh,0
    mov bl,4;��ɫ
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
    
    
 