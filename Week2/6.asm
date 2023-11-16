section .data
text db 256 dup(0)
len dd 256
final db 256 dup(0)
len1 dd 256

section .text
global _start

_start:
; Đọc số 1 từ người dùng
mov eax, 3          
mov ebx, 2           
mov ecx, text 
mov edx, [len]       
int 0x80    
call reversestring

print:
mov eax, 4
mov ebx, 1
mov ecx, final
mov edx, [len1]
int 0x80    
jmp exit


reversestring:
mov ecx, 0
find_length:
    cmp byte [text + ecx], 0
    je  end_find_length
    inc ecx
    jmp find_length
end_find_length:
    dec ecx
    mov esi, text      
    lea edi, [final + ecx]  
reverse_loop:
    cmp ecx, 0
    jl end_reverse

    mov al, [esi]
    mov [edi], al

    inc esi
    dec edi
    dec ecx

    jmp reverse_loop

end_reverse:

ret

exit:
mov eax, 1            
xor ebx, ebx         
int 0x80
