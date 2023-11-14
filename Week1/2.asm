section .bss
num resb 32
section .text
global _start
done:
; Increment the pointers to move to the next character
inc esi
inc edi
jmp compare_loop
_start:
;Read and store the user input
mov eax, 3
mov ebx, 2
mov ecx, num
mov edx, 32
int 80h
; Load the addresses of the string into registers (e.g., esi and edi)
lea esi, [num]
compare_loop:
; Load characters from string into registers (e.g., al and bl)
mov al, [esi]
; Check for the null terminator (end of string)
cmp al, 0
je exit ; If string end, xuat

; Compare ' ';
cmp al, ' '
jl done
; Compare '}'
cmp al, '}'
jg done
xuat:
mov    edx, 1        ; message length
mov    ecx, esi      ; message to write
mov    ebx, 1        ; file descriptor (stdout)
mov    eax, 4        ; system call number (sys_write)
int    0x80        ; call kernel
jmp done
exit:
mov    eax, 1        ; system call number (sys_exit)
int    0x80        ; call kernel