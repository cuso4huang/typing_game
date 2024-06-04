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

song segment
db
"Enchanted (Taylor's Version)$"
"Taylor Swift$"
"There I was again tonight$"
"Forcing laughter, faking smiles$"
"Same old tired, lonely place$"
"Walls of insincerity$"
"Shifting eyes and vacancy$"
"Vanished when I saw your face$"
"All I can say is it was enchanting to meet you$"
"Your eyes whispered, Have we met?$"
"Across the room, your silhouette$"
"Starts to make its way to me$"
"The playful conversation starts$"
"Counter all your quick remarks$"
"Like passing notes in secrecy$"
"And it was enchanting to meet you$"
"All I can say is I was enchanted to meet you$"
"This night is sparkling, don't you let it go$"
"I'm wonderstruck, blushing all the way home$"
"I'll spend forever wondering if you knew$"
"I was enchanted to meet you$"
"The lingering question kept me up$"
"2 a.m., who do you love?$"
"I wonder 'til I'm wide awake$"
"And now I'm pacing back and forth$"
"Wishing you were at my door$"
"I'd open up and you would say$"
"Hey, it was enchanting to meet you$"
"All I know is I was enchanted to meet you$"
"This night is sparkling, don't you let it go$"
"I'm wonderstruck, blushing all the way home$"
"I'll spend forever wondering if you knew$"
"This night is flawless, don't you let it go$"
"I'm wonderstruck, dancing around all alone$"
"I'll spend forever wondering if you knew$"
"I was enchanted to meet you$"
"This is me praying that$"
"This was the very first page$"
"Not where the storyline ends$"
"My thoughts will echo your name$"
"Until I see you again$"
"These are the words I held back$"
"As I was leaving too soon$"
"I was enchanted to meet you$"
"Please, don't be in love with someone else$"
"Please, don't have somebody waiting on you$"
"Please, don't be in love with someone else$"
"Please, don't have somebody waiting on you$"
"This night is sparkling, don't you let it go$"
"I'm wonderstruck, blushing all the way home$"
"I'll spend forever wondering if you knew$"
"This night is flawless, don't you let it go$"
"I'm wonderstruck, dancing around all alone$"
"I'll spend forever wondering if you knew$"
"I was enchanted to meet you$"
"Please, don't be in love with someone else$"
"Please, don't have somebody waiting on you$"   
song    ends



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
    scroll 0,0,0,25,80,50h;���ⴰ�ڣ�Ʒ���
    scroll 0,1,2,23,78,3fh;���ڴ��ڣ�ǳ�̵ף�����
    curse start_r,start_c
    call game
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
    
    
;��ʼ��Ϸ�ӳ���
game proc
   print string
   lea si,string
   curse start_r,start_c
   mov cx,20;ÿ�����20���ַ�
loop1:
   call process_input
   inc si
   call update_cursor
   loop loop1
   
   
   
   
   
   ret
game endp





;���¹��λ��
update_cursor proc
    push ax
    push dx
    push bx
    ;�����λ��
    mov ah,3
    mov bh,0
    int 10h
    inc dl
    ;�ù��λ��
    mov ah,2
    int 10h
    pop bx
    pop dx
    pop ax
    ret    
    
update_cursor endp
   
         
     
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
    
    
 