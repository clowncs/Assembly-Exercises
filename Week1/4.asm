section .data
text db 32   ; Độ dài tối đa của chuỗi văn bản
num1 db 32 dup(0)  ; Chuỗi văn bản nhập từ người dùng
num2 db 32 dup(0)  ; Chuỗi văn bản nhập từ người dùng
len1 db 11 dup(0)
len2 db 11 dup(0)
cur db 11 dup(0)
remain db 11 dup(0)
output_text db 32 dup(0)
final db 32 dup(0)


section .text
global _start

_start:
; Đọc số 1 từ người dùng
mov eax, 3          
mov ebx, 2           
mov ecx, num1 
mov edx, text       
int 0x80           
; Đọc số 2 từ người dùng
mov eax, 3          
mov ebx, 2           
mov ecx, num2 
mov edx, text       
int 0x80     

;len of num 1
xor esi, esi         
xor edx, edx        


lenof1:
mov al, [num1 + esi]
cmp al, 0              
je done1                

; Kiểm tra xem ký tự có nằm trong khoảng 0-9 không
cmp al, '0'
jl is_a_number
cmp al, '9'
jg is_a_number

is_a_number:
inc esi
inc edx
jmp lenof1

done1:
xor eax, eax
mov al, dl
add al, 47
mov [len1], al     








;len of num 2
xor esi, esi         
xor edx, edx        


lenof2:
mov al, [num2 + esi]
cmp al, 0              
je done2                

; Kiểm tra xem ký tự có nằm trong khoảng 0-9 không
cmp al, '0'
jl is_a_number2
cmp al, '9'
jg is_a_number2

is_a_number2:
inc esi
inc edx
jmp lenof2

done2:
xor eax, eax
mov al, dl
add al, 47
mov [len2], al     


; Xử lý chuỗi 
xor eax, eax
xor ebx, ebx
mov al, [len1]
mov bl, [len2]
cmp al, bl
jge len1lonhonlen2

;len 2 > len 1
xor eax, 0
xor ebx, 0

mov esi, [len2]
sub esi, 49
mov [len2], esi
mov al, [num2 + esi]
sub al, '0'

mov esi, [len1]
sub esi, 49
mov [len1], esi

mov bl, [num1 + esi]
sub bl, '0'

; chia 
add al,bl      
mov bl, 10           
div bl
add ah, '0'
; al là phân nguyên ah là phần dư 
xor esi, esi
mov [output_text + esi], ah
push eax
inc esi

;suy thi vcl
dmcs1:
xor eax, eax
xor ebx, ebx

mov ecx, [len2]
sub ecx, 1
mov [len2], ecx
mov al, [num2 + ecx]
sub al, '0'

mov ecx, [len1]
sub ecx, 1
mov [len1], ecx 
mov bl, [num1 + ecx]
sub bl, '0'

add al,bl
pop ebx
add al, bl
mov bl, 10
div bl
add ah, '0'
mov [output_text + esi], ah
inc esi
push eax
;check xem len 1 con khong
mov edx, [len1]
cmp edx, 0
je _remainof1
jmp dmcs1


_remain2:
pop ebx
cmp bl, 0
je endporn
mov [output_text + esi], bl
jmp endporn

_remainof1:
mov edx, [len1]
mov ecx, [len2]
cmp edx, ecx 
je _remain2

xor eax, eax
xor ebx, ebx

mov ecx, [len2]
sub ecx, 1
mov [len2], ecx
mov al, [num2 + ecx]
sub al, '0'
pop ebx
add al, bl
mov bl, 10
div bl
add ah, '0'
mov [output_text + esi], ah
inc esi
push eax
;check xem len 2 con khong
mov edx, [len2]
cmp edx, 0
je endporn
jmp _remainof1

; len 1 > len 2
len1lonhonlen2:
xor eax, 0
xor ebx, 0

mov esi, [len1]
sub esi, 49
mov [len1], esi
mov al, [num1 + esi]
sub al, '0'

mov esi, [len2]
sub esi, 49
mov [len2], esi

mov bl, [num2 + esi]
sub bl, '0'

; chia 
add al,bl      
mov bl, 10           
div bl
add ah, '0'
; al là phân nguyên ah là phần dư 
xor esi, esi
mov [output_text + esi], ah
push eax
inc esi

;suy thi vcl
dmcs:
xor eax, eax
xor ebx, ebx

mov ecx, [len1]
sub ecx, 1
mov [len1], ecx
mov al, [num1 + ecx]
sub al, '0'

mov ecx, [len2]
sub ecx, 1
mov [len2], ecx 
mov bl, [num2 + ecx]
sub bl, '0'

add al,bl
pop ebx
add al, bl
mov bl, 10
div bl
add ah, '0'
mov [output_text + esi], ah
inc esi
push eax
;check xem len 2 con khong
mov edx, [len2]
cmp edx, 0
je _remain
jmp dmcs


_remain1:
pop ebx
cmp bl, 0
je endporn
mov [output_text + esi], bl
jmp endporn

_remain:
mov edx, [len2]
mov ecx, [len1]
cmp edx, ecx 
je _remain1

xor eax, eax
xor ebx, ebx

mov ecx, [len1]
sub ecx, 1
mov [len1], ecx
mov al, [num1 + ecx]
sub al, '0'
pop ebx
add al, bl
mov bl, 10
div bl
add ah, '0'
mov [output_text + esi], ah
inc esi
push eax
;check xem len 1 con khong
mov edx, [len1]
cmp edx, 0
je endporn
jmp _remain






; reverse mang roi xuat
endporn:
mov ecx, 0
find_length:
    cmp byte [output_text + ecx], 0
    je  end_find_length
    inc ecx
    jmp find_length
end_find_length:
    dec ecx
    mov esi, output_text      
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

mov eax, 4          
mov ebx, 1        
mov ecx, final 
mov edx, 12          
int 0x80


mov eax, 1            
xor ebx, ebx         
int 0x80
