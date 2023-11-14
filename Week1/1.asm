global _start
section .data
msg db "Hello World"
len equ $-msg
section .text
_start:
mov edx,len     ; do dai doan tin nhan
mov ecx,msg     ; tin nhan
mov ebx,1       ; file descriptor (stdout)
mov eax,4       ; system call number (sys_write)
int 0x80        ; call kernel
mov eax,1       ; system call number (sys_exit)int 0x80        ; call kernel