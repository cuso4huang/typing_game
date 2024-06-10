# 打字游戏设计方案



应该把完整的设计方案想清楚再去开发，才能事半功倍。

尽量模块化设计，多使用宏定义，宏定义不用再代码段中定义，在外面定义就行

多使用子程序，避免寄存器不够用



子程序

```
; 获取当前时间
get_time proc
    mov ah, 2Ch
    int 21h
    mov dx, cx
    ret
get_time endp

; 输出字符串
print_string proc
    lea dx, string
    mov ah, 09h
    int 21h
    ret
print_string endp

; 处理用户输入
process_input proc
    mov ah, 00h
    int 16h
    cmp al, [si]
    je correct_input
    call incorrect_input
    ret
correct_input:
    ; 更新正确计数
    inc correct_count
    inc total_count
    mov ah, 09h
    mov al, [si]
    mov bh, 0
    mov bl, 2     ; 绿色
    mov cx, 1
    int 10h
    ret
incorrect_input:
    ; 更新总计数
    inc total_count
    mov ah, 09h
    mov al, [si]
    mov bh, 0
    mov bl, 4     ; 红色
    mov cx, 1
    int 10h
    ret
process_input endp

; 更新光标位置
update_cursor proc
    ; 光标位置逻辑
    ret
update_cursor endp

; 滚动屏幕
scroll_screen proc
    mov ah, 06h
    mov al, 01h
    mov bh, 07h
    mov ch, 00h
    mov cl, 00h
    mov dh, 24h
    mov dl, 79h
    int 10h
    ret
scroll_screen endp

; 计算并显示得分
calculate_score proc
    ; 计算逻辑
    ret
calculate_score endp

; 显示持续时间
display_time proc
    ; 时间显示逻辑
    ret
display_time endp

```



### 字符问题

1.字符串存放在数据段中，就不要用文件了。

2.练习模式：先输出一个字符串，光标放在字符串的起始位置，键盘输入一个字符，如果字符相同，则把字符变为绿色，再输出，否则，把字符变为红色再输出。

3.上面用到了的是int 10h的9号功能，但是他不会自己移动光标，所以要手动移动光标，并且要手动换行

4.字符从最底下开始，每次刷新，屏幕上滚，但是光标还是可以设置在最左下角。

![image-20240602215806927](C:\Users\86132\AppData\Roaming\Typora\typora-user-images\image-20240602215806927.png)

* 字符串输出

  ```
  mov ah,09h
  int 21h
  ```

* 字符显示与光标移动 int 10h

**功能号：02h**

- 功能：设置光标位置。
- 输入：AH = 02h，BH = 页号，DH = 行号，DL = 列号。

```
assembly复制代码mov ah, 02h
mov bh, 00h  ; 页号（通常为0）
mov dh, 10h  ; 行号
mov dl, 20h  ; 列号
int 10h
```

**功能号：06h/07h**

- 功能：上滚/下滚窗口内容。
- 输入：AH = 06h/07h，AL = 行数，BH = 属性，CH = 左上角行号，CL = 左上角列号，DH = 右下角行号，DL = 右下角列号。

```
assembly复制代码mov ah, 06h   ; 上滚
mov al, 01    ; 滚动 1 行
mov bh, 07h   ; 用空白和属性填充
mov ch, 00h   ; 左上角行号
mov cl, 00h   ; 左上角列号
mov dh, 24h   ; 右下角行号
mov dl, 79h   ; 右下角列号
int 10h
```

**功能号：09h**

- 功能：写字符和属性（文本模式）。
- 输入：AH = 09h，AL = 字符，BH = 页号，BL = 属性，CX = 重复次数。

```
mov ah, 09h
mov al, 'A'   ; 要显示的字符
mov bh, 00h   ; 页号
mov bl, 07h   ; 属性（通常为白色）
mov cx, 1     ; 显示一次
int 10h


```

**颜色代码**

以下是常用颜色代码：

0 - 黑色
1 - 蓝色
2 - 绿色
3 - 青色
4 - 红色
5 - 品红
6 - 棕色
7 - 浅灰色
8 - 深灰色
9 - 浅蓝色
A - 浅绿色
B - 浅青色
C - 浅红色
D - 浅品红
E - 黄色
F - 白色

**功能号：0Ah**

- 功能：写字符（无属性）。
- 输入：AH = 0Ah，AL = 字符，BH = 页号，CX = 重复次数。

```
mov ah, 0Ah
mov al, 'B'   ; 要显示的字符
mov bh, 00h   ; 页号
mov cx, 1     ; 显示一次
```



## 时间与得分问题

开始的时候输出开始时间，按下esc的时候，再创建一个窗口，输出持续时间，以及得分，按任意键退出。回到主界面，只能在主界面退出。

得分，记录使用一个变量，记录打对字符数，得分为 答对字符数/已打字符数

```
   
get1:
   mov cx,76;置一行的字符数
   print string
   curse 2,2
   mov si,0
get2:
    mov ah,0;等待输入
    int 16h
    cmp al,esc_key;是否为esc键？
    jz exit       ;是，退出
    cmp al,[string+si]
    je corret
    mov bl,4fh
    
output: 
    push cx
    mov cx,1;显示一次
    mov bh,0
    mov ah,09h    ;显示输入的字符
    int 10h
    inc si
    pop cx
    loop get2
    scroll 2,1,2,23,78,2fh;上卷2行
    curse 1,2
    jmp get1
       
corret:
    mov bl,2fh

    jmp output   




```

