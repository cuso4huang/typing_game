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

get_time macro hour, minute,second,msec
    mov ah,2ch
    int 21h
    mov hour,ch
    mov minute, cl
    mov second, dh
    mov msec,dl 
        
endm 

 hex_to_dec_byte macro h
    
    local l1,output
    mov cx,0;������
    mov al,h
l1:    
    xor ah,ah
    mov dl,10
    div dl;����al��������ah
    mov dl,ah
    xor dh,dh
    push dx
    inc cx
    cmp al,0
    je output
    jmp l1
output:    
    pop dx
    add dl,'0'
    mov ah,2
    int 21h
    loop output 
    
hex_to_dec_byte    endm 
 
  hex_to_dec_word macro h
    
    local l1,output
    mov cx,0;������
    mov ax,h
l1:    
    mov dl,10
    div dl;����al��������ah
    mov dl,ah
    xor dh,dh
    push dx
    inc cx
    mov ah,0
    cmp al,0
    je output
    jmp l1
output:    
    pop dx
    add dl,'0'
    mov ah,2
    int 21h
    loop output 
    
hex_to_dec_word    endm 
 


date segment 

;db "Enchanted (Taylor's Version)$" 
;db "Taylor Swift$" 
 song1  db "There I wa$"
db "s again to$"
db "night Forc$"
db "ing laught$"
db "er, faking$"
db "smiles Sam$"
db "e old tire$"
db "d, lonelyp$"
db "lace Walls$"
db "of insince$"
db "rity$"
db "Shifting eyes and vacancy$"
db "Vanished when I saw your face$"
db "All I can say is it was enchanting to meet you$"
db "Your eyes whispered, Have we met$"  ;������ʺű�������˫����
db "Across the room, your silhouette$"
db "Starts to make its way to me$"
db "The playful conversation starts$"
db "Counter all your quick remarks$"
db "Like passing notes in secrecy$"
db "And it was enchanting to meet you$"
db "All I can say is I was enchanted to meet you$"
db "This night is sparkling, don't you let it go$"
db "I'm wonderstruck, blushing all the way home$"
db "I'll spend forever wondering if you knew$"
db "I was enchanted to meet you$"
db "The lingering question kept me up$"
db "2 a.m., who do you love$"
db "I wonder 'til I'm wide awake$"
db "And now I'm pacing back and forth$"
db "Wishing you were at my door$"
db "I'd open up and you would say$"
db "Hey, it was enchanting to meet you$"
db "All I know is I was enchanted to meet you$"
db "This night is sparkling, don't you let it go$"
db "I'm wonderstruck, blushing all the way home$"
db "I'll spend forever wondering if you knew$"
db "This night is flawless, don't you let it go$"
db "I'm wonderstruck, dancing around all alone$"
db "I'll spend forever wondering if you knew$"
db "I was enchanted to meet you$"
db "This is me praying that$"
db "This was the very first page$"
db "Not where the storyline ends$"
db "My thoughts will echo your name$"
db "Until I see you again$"
db "These are the words I held back$"
db "As I was leaving too soon$"
db "I was enchanted to meet you$"
db "Please, don't be in love with someone else$"
db "Please, don't have somebody waiting on you$"
db "Please, don't be in love with someone else$"
db "Please, don't have somebody waiting on you$"
db "This night is sparkling, don't you let it go$"
db "I'm wonderstruck, blushing all the way home$"
db "I'll spend forever wondering if you knew$"
db "This night is flawless, don't you let it go$"
db "I'm wonderstruck, dancing around all alone$"
db "I'll spend forever wondering if you knew$"
db "I was enchanted to meet you$"
db "Please, don't be in love with someone else$"
db "Please, don't have somebody waiting on you$"
db "#";������־   
    
    
    
    
    
    line1           db "++====+=====+=====+=====+=====+=====+====++$"
    author          db "||         Author:2022102151-hzq         ||$"
    welcome_prompt  db "||      Welcome to the typing game!      ||$"
    exit_prompt     db "|| Press the esc button to quit the game ||$"
    choice_prompt   db "||  Press number to choose your choice   ||$ "
    choice1         db "||          1.start the game             ||$"
    choice2         db "||          2.check my score             ||$"
    choice3         db "||          3.close the game             ||$"
    line2           db "++====+=====+=====+=====+=====+=====+====++$"
    your_choice     db "            Your choice:  $"   
    end_prompt      db "Congratulation!You hava pass the game!   $"
    stop_prompt     db "Press any key to continue..              $" 
    close_prompt    db "Good bye ,wish you hava a good time!     $"
ready_quit_prompt   db "Press 1 to quit,other keys to continue:  $"
    correct_count dw 0
    total_count dw 0
    start_r equ 23
    start_c equ 2 
    
    start_h db 0
    start_min db 0
    start_sec db 0
    start_msec db 0
    end_h db 0
    end_min db 0
    end_sec db 0
    end_msec db 0
    cost_h   dw 0
    cost_min dw 0
    cost_sec dw 0
    cost_msec dw 0 
    cnt db 0
     
    start_time_prompt   db "start:      $"  
    end_time_prompt     db "end:        $"
    cost_prompt         db "cost:       $"
    score_prompt        db "your score: $" 
    h_str               db " h $"
    min_str             db " min $"
    sec_str             db " s   $"
    msec_str            db " msec$" 
    
date ends

stack segment
   db 32 dup(0)

stack ends


code segment
start:
    ;��ʼ����Ƶģʽ��80*25�ı�ģʽ
    mov ax, 03h
    int 10h
    mov ax,date
    mov ds,ax
    mov ax,stack
    mov ss,ax

    call start_view
    


      
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
    print exit_prompt
    curse 13,19
    print choice_prompt
    curse 14,19
    print choice1
    curse 15,19
    print choice2
    curse 16,19
    print choice3
    curse 17,19
    print line2
    curse 18,19
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
    call check
    print stop_prompt
    mov ah,1
    int 21h
    call start_view
    
    
close_game:
    ;�ر���Ϸ
    scroll 0,1,2,23,78,3fh;���ڴ��ڣ�ǳ�̵ף�����
    curse 12,19
    print close_prompt
    mov ax,4c00h
    int 21h
error:
    call start_view
    ret
start_view endp
    
    
;��ʼ��Ϸ�ӳ���
;��ʼ��Ϸ�ӳ���
game proc
   ;��յ÷�
   mov ax,0
   mov [correct_count],ax
   mov [total_count],ax
   get_time start_h,start_min,start_sec,start_msec
   lea bx,song1
l1:  
   print bx
   mov si,bx
   curse start_r,start_c
l2:   
   call process_input
   inc si
   call update_cursor
   cmp [si],'$'
   je update
   jmp l2
update:
    ;�Ϲ�һ�У�����λ
    mov al,0
    mov [cnt],al
    scroll 1,1,2,23,78,3fh
    curse start_r,start_c 
    inc si
    cmp [si],'#'
    je congratulation
    mov bx,si
    jmp l1
congratulation: 
    get_time end_h,end_min,end_sec,end_msec
    scroll 0,1,2,23,78,3fh;����
    curse 9,19
    print end_prompt
    curse 10,19
    print stop_prompt
    mov ah,1
    int 21h
    call check
    print stop_prompt
    mov ah,1
    int 21h
    call start_view
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
back:

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
    mov bl,02h;��ɫ��������ɫ����
    mov cx,1
    int 10h
    inc cnt
    jmp e1
incorrect_input: 
    cmp al,1bh;�ǲ���esc��
    je quit
    ;�����ܼ��� 
    inc total_count    
    mov ah,09h
    mov al,[si]
    mov bh,0
    mov bl,04h;��ɫ��������ɫ����
    mov cx,1
    inc cnt
    int 10h
e1:  
    pop cx
    pop bx
    pop ax
    ret

quit:
    scroll 0,1,2,6,78,3fh;
    curse 1,2
    print ready_quit_prompt
    mov ah,1
    int 21h
    cmp al,'1'
    jne quit1
    jmp quit2
 quit1:
    scroll 0,1,2,6,78,3fh; 
    mov al,cnt
    add al,start_c
    curse start_r,al 
    jmp back
 quit2:
    get_time end_h,end_min,end_sec,end_msec
    call start_view

check proc
    ;�鿴�ɼ��ӳ���
    ;������
    scroll 0,1,2,23,78,3fh; 
    curse 9,19

    lea dx,start_time_prompt
    mov ah,9
    int 21h
    
    hex_to_dec_byte start_h
    call display_colon
    hex_to_dec_byte start_min
    call display_colon
    hex_to_dec_byte start_sec 
    call display_colon
    hex_to_dec_byte start_msec
    
    curse 10,19
    lea dx,end_time_prompt
    mov ah,9
    int 21h
    hex_to_dec_byte end_h
    call display_colon
    hex_to_dec_byte end_min
    call display_colon
    hex_to_dec_byte end_sec    
    call display_colon
    hex_to_dec_byte end_msec
    
    curse 11,19
    print cost_prompt
    call cost_time
    hex_to_dec_word cost_h
    print h_str
    hex_to_dec_word cost_min
    print min_str
    hex_to_dec_word cost_sec
    print sec_str
    hex_to_dec_word cost_msec
    print msec_str
    
    curse 12,19
    ;�������
    print score_prompt
    hex_to_dec_word correct_count 
    
    mov dl,"/"
    mov ah,2
    int 21h
    hex_to_dec_word total_count
    curse 13,19
    ret
check   endp   
     
     
cost_time proc
    mov al,[end_h]
    sub al,[start_h]
    mov ah,0 
    mov [cost_h],ax
    
   
    
    mov al,end_min
    sub al,start_min
    cmp al,0
    jl jm0
    jmp jm1

jm0:
    add al,60
    dec [cost_h]
jm1:
    mov [cost_min],ax

    
    mov al,end_sec
    sub al,start_sec
    cmp al,0
    jl jm2
    jmp jm3
jm2:
    add al,60
    dec [cost_min]
jm3:
    mov [cost_sec],ax   
    
    mov al,end_msec
    sub al,start_msec
    cmp al,0
    jl jm4
    jmp jm5
jm4:
    add al,100
    dec [cost_sec]
jm5:
    mov [cost_msec],ax
    ret
cost_time    endp






display_colon proc 
    mov dl,':'
    mov ah,2
    int 21h
    ret
display_colon    endp  

code ends
end start
    
    
 