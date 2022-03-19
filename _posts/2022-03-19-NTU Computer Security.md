---
layout: post
title: NTU Computer Security
date: 2022-03-19
Author: LuYee6813
tags: [knowlodge]
toc: true
---
## 1. Program Structure

>ELF結構圖

![](https://i.imgur.com/fQz0NMN.png)

### 1-1. Text
>存放 Binary Code。
1. 可讀
2. 不可寫
3. 可執行

### 1-2. Data
>存放初始化過後的變數

### 1-3. BSS
>存放尚未初始化的變數
### 1-4. Heap
>動態記憶體配置相關區塊，記憶體位置由低位往高位長
### 1-5. Stack
>存放區域變數、暫存、參數、回傳值、等資料…，記憶體位置由高位往低位長

### 對照圖
>Section 對照圖
![](https://i.imgur.com/Yi30ZLR.png)

---
## 2. Stack Data structure
Stack 的資料結構採==先進後出==（FILO, First-in-Last-out），主要動作就是放（Push）、拿（Pop），可以想像成是品客洋芋片，想拿到最底部的，就必須先把上面的都拿出來。

## 3. Basic Assembly Code
### 3-1. MOV
將 0x1 放至 RAX，相較於程式語言的指定 rax = 0x1。
```Text
MOV RAX, 0x1
```
### 3-2. PUSH
將 0x1 推到 Stack
```Text
PUSH 0x1
```
### 3-3. POP
將 0x1 從 Stack 移除
```Text
POP 0x1
```
### 3-4. LEA
取位址，將 MEM+0x8 的記憶體位置存入 RAX
```Text
LEA RAX, [MEM+0x8];
```
### 3-5. ADD/SUB
將 RAX 加/減 0x1 之後，存入 RAX
```Text
ADD/SUB RAX, 0x1
```
### 3-6. AND/OR/XOR
且/或/互斥或 0x1 後，存入 RAX
```Text
AND/OR/XOR RAX, 0x1
```
### 3-7. JMP
無條件轉跳至目標記憶體位置
```Text
JMP Address
```
### 3-8. CALL
執行 Function => func
```Text
CALL func;
```
### 3-9. RET
轉跳回進入點的下一行指令，相較於使用 JMP 指令
```Text
RET
```
---

## 4. Pointer
這邊指的 Pointer 簡單的說就是指標，在 Assembly 中的指標並沒有向 C/C++ 上的直觀，好比說 DWORD PTR [ebp+eax*4-0x34], edx 就是變數的起始位置為 0x34，而陣列的 index 由 eax 控制
## 5. Register
因應各個不同位元的系統，可以使用的 Register 也不相同，參照下方資料。
```Text
General Purpose Registers (GPRs)
64 bit: rax, rbx, rcx, rdx, rdi, rsi, r8 - r15
32 bit: eax, ebx, ecx, edx, edi, esi, r8d - r15d
16 bit: ax, bx, cx, dx, di, si, r8w - r15w
8  bit: ah, bh, ch, dh, al, bl, cl, dl, dil, sil, r8b - r15b
```
>Register 名稱對應如下
```Text
RAX – accumulator
RBX – base
RCX – count
RDX – data
RSI – source index
RDI – destination index
RBP – base pointer
RSP – stack pointer
RFLAGS – Condition
```


## 6. Calling Convention
要把值當成參數送入 Function 中，需要一定的模式，其遞值方式是從==最後一個參數==開始，舉個簡單的例子。
```Text
void func(arg1, arg2)
```
其參數會先處理 arg2，接著才處理 arg1，此外 x86、x64 的參數處理方法不一，下方是 x86、x64 的差異。
```Text
x86  => Stack
x64  => rdi, rsi ,rdx ,rcx, r8, r9, Stack
```
x86 的遞值方式皆是透過 Stack，而 x64 可以使用六個暫存器，一旦參數超過六個，後方的參數會先 Push 到 Stack 上。
>示意圖:
>![](https://i.imgur.com/aeQMKtZ.png)


## 7. Stack Frame
在上頭 Register 的部分有提到，RBP 是指向 Stack 的底端，而 RSP 指向的是 Stack 的頂端，在 RBP 與 RSP 間的範圍，可以稱作是一個 Function 的區域，至於運作的，可以分成 Prologue、Epilogue 兩個部分做解釋。
### 7-1. Function Prologue
> 為 Function 的起頭，一個 Function 被呼叫時的起手式。
```Text
0x4004d7 PUSH  RBP
0x4004d8 MOV   RBP  RSP
0x4004de SUB   RSP  0x10
```
第一行：PUSH RBP 會將上一個 RBP POP 到 STACK 上，又稱作 Seave RBP。

第二行：接著將上一個 RBP 移動到目前 RSP 的位置（此時 RBP、RSP 指向同一個位置）。

第三行：SUB RSP 0x10 相較於 PUSH 了 0x10 次，原因在於 Stack 是由高往低位長，RSP 又是指向最頂端（最低位），此時在往下減就如同 Push，通常是用來存放區域變數空間。

---

### 7-2. Function Epilogue
>為 Function 的結尾，一個 Function 結束生命周期之後的行為，簡單的說就是 Prologue 的逆向，怎麼開始，就怎麼結束。

```Text
 0x400508 LEAVE 
 0x400509 RET
```
首先 LEAVE 會做兩件事情，所以將其去簡化如下。

```Text
MOV RSP, RBP
POP RBP
RET
```

第一行：是將 RSP 指向 RBP 的位置（Function 的底端）。

第二行：會將該 Function 的資料都拿（POP）掉。

第三行：返回到進入點的下一行指令處。

---

## 8. Security Options
像這樣的問題老早就存在了，至於有沒有什麼除了開發者原先就須具備資安意識以外，還是有機制上防範方法，名稱如下。

- Stack Canary
- RELRO(==Rel==ocation ==R==ead-==O==nly)
- NX(==N==o-e==X==ecute)
- ASLR
- PIE (==P==osition-==I==ndependent ==E==xecutable)

### 8-1. Stack Canary
### 8-2. RELRO
### 8-3. NX
### 8-4. ASLR
### 8-5. PIE


