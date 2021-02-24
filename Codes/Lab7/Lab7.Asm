;王爽《8086汇编语言》练习，第8章 p173
;
;编写：VxerLee
;时间：2021年02月22日22:28:04
;心情：😿

;题目：编程，将data段中的数据按如下格式写入到table段中，并计算21年中的人均收入（取证），结果也按照
;下面的格式保存在table段中


;tips
;可将data段中的数据看成是多个数组，而将table中的数据看成是一个结构型数据的数组，
;每个结构型数据中包含多个数据项。可用bx定位每个结构型数据，用idata定位数据项，用si定位数组项中的每个
;元素，对于table中的数据的访问可采用[bx].idata和[bx].idata[si]的寻址方式。

;注意！！！
;这个程序是到目前为止最为复杂的程序，它几乎用到了我们以前学过的所有知识和编程技巧。
;所以，这个程序是对我们从前学习的最好的实践总结。请认真完成。


assume cs:codes,ds:data,es,table
;21年的各 年份、总收入、雇员人数
data segment
;代表21年中的21个字符串
db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
db '1993','1994','1995'

;代表21年公司总收入的 21个dword型数据
dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
dd 34580,590827,803530,1183000,1843999,2759000,3753000,4649000,5937000

;代表21年公司雇员人数的21个word型数据
dd 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
dd 11542,14430,15257,17800
data ends

table segment
    db 21 dup('year summ ne ?? ')
table ends

;年份 总收入 雇员数 人均收入 

codes segment
    ;代码段，main入口
start:
    ;初始化设置各段
    mov ax,data
    mov ds,ax
    mov ax,table
    mov es,ax

    ;循环21次
    mov bx,0
    mov si,0
    mov di,0
    mov cx,21
  s:
    ;分别计算出年份、总收入、雇员数的偏移
    ;总收入偏移: 21 * 4 = 0x54

    ;存放年份
    mov al,ds:[bx]
    mov es:[di],al
    mov al,ds:[bx+1]
    mov es:[di+1],al
    mov al,ds:[bx+2]
    mov es:[di+2],al
    mov al,ds:[bx+3]
    mov es:[di+3],al
    ;存放总收入
    mov ax,54h[bx];第一个年收入的基址 0x54h
    mov dx,56h[bx];double word 类型 4个字节 8086CPU只有16位寄存器
    mov es:5h[di],ax;5h表示table段的总收入基址
    mov es:7h[di],dx
    ;存放公司人数
    mov ax,0A8h[si];第一个人数的基址:0A8h
    mov es:0Ah[di],ax;人数刚好是word类型 16位  0Ah table段人数基址
    ;计算人均收入并存放
    mov ax,54h[bx]
    mov dx,56h[bx]

    div word ptr ds:0A8h[si];除以人数 ,运算结果会自动保存在ax寄存器中
    mov es:0dh[di],ax;0dh table段人均收入基址

    add bx,4 ;bx 4字节 确定年份 和 总收入的循环，这两个刚好的都是double word 4字节数据
    add si,2 ;si 2字节 确定公司人数的循环 ，因为人数刚好是word类型 
    add di,16 ;di 16字节，代表table段中的每一行 一行加上年份、收入、人数、人均收入 和空格刚好是16字节.
    loop s

    ;返回到控制函数
    mov ax,4c00h
    int 21h
codes ends

end start
