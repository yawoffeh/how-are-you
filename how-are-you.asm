bits  32
section .data
quesforname db "Please enter your name", 0ax
lenques equ $- quesforname
msg db "Hello, "
lenmsg equ $- msg
ques db "How are you doing", 0xa
len equ $- ques
g: db "good"
reso: db "Great to hear", 0ax
lenreso equ $- reso
rest: db "Too bad ......"
lenrest equ $- rest

section .bss
name resb 32
response resb 32

section .text
  global _start
_start:
;Asking please enter your name
  mov edx,lenques
  mov ecx,quesforname
  mov ebx,1
  mov eax,4
  int 0x80
;collecting name
  mov edx,32
  mov ecx,name
  mov ebx,2
  mov eax,3
  int 0x80

;output "hello"
  mov edx,lenmsg
  mov ecx,msg
  mov ebx,1
  mov eax,4
  int 0x80

;output name
  mov edx,32        ;the name of the user is in name
  mov ecx,name
  mov ebx,1
  mov eax,4
  int 80h

;output how are you
  mov edx,len
  mov ecx,ques
  mov ebx,1
  mov eax,4
  int 0x80
;collect response
  mov edx,4
  mov ecx,response
  mov ebx,2
  mov eax,3
  int 0x80

  xor eax, eax
  mov ebx, [g]
  mov eax, [response]
  cmp eax, ebx
  je good
  jne bad

;responses
good:
  mov edx,lenreso
  mov ecx,reso
  mov ebx,1
  mov eax,4
  int 0x80

  jmp _exit

bad:
  mov edx,lenrest
  mov ecx,rest
  mov ebx,1
  mov eax,4
  int 0x80

  jmp _exit

;exit
_exit:
  xor ebx, ebx
  mov eax, 1
  int 80h
