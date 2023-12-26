section .data
S db 102 dup(0)
C db 102 dup(0)
text db 102
lenS db 102 dup(0)
lenC db 102 dup(0)
index db 200 dup(0)
total db 102 dup(0)
last db 102 dup(0)
sum db 102 dup(0)
idx db 102 dup(0)
section .text 
global _start

_start:

; Đọc chuỗi S từ người dùng
mov eax, 3          
mov ebx, 2           
mov ecx, S 
mov edx, text       
int 0x80           

; Đọc chuỗi C từ người dùng
mov eax, 3          
mov ebx, 2           
mov ecx, C 
mov edx, text       
int 0x80   

; khoi tao sum = 0 

xor eax, eax
mov [sum], eax
mov [idx], eax
; len of string S

xor esi, esi         

lenofS:
mov al, [S + esi]
cmp al, 0              
je doneS                
inc esi
jmp lenofS
doneS:
dec esi
mov [lenS], esi

xor esi, esi         
; len of string C
lenofC:
mov al, [C + esi]
cmp al, 0              
je doneC                
inc esi
jmp lenofC
doneC:
dec esi
mov [lenC], esi

xor esi, esi
mov al, [lenS]
mov bl, [lenC]
sub al, bl
inc al
mov [last], al


scan:
call find_substring
mov al, [total]
mov bl, [lenC]
cmp al, bl
je found
xor eax, eax
mov al, [last]
cmp eax, esi
je print
inc esi
jmp scan

found:
mov al, [sum]
inc al
mov [sum], al

mov ebx, [idx]
add esi, '0'
mov [index + ebx], esi
sub esi, '0'

inc ebx
mov eax, 32
mov [index + ebx], eax
inc ebx
mov [idx], ebx

inc esi
jmp scan


; luc nay la xuat ne XD 
print:
mov al, [sum]
add al, '0'
mov [sum], al

mov eax, 4          
mov ebx, 1        
mov ecx, sum
mov edx, 102
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, 32
push ecx
mov ecx, esp
mov edx, 1
int 0x80

mov eax, 4          
mov ebx, 1        
mov ecx, index
mov edx, 200
int 0x80

mov eax, 1            
xor ebx, ebx         
int 0x80


find_substring:
xor edx, edx
mov edi, esi ; index of S
xor ecx, ecx
compare:
mov al, [C + edx]
mov bl, [S + edi]
cmp al, bl
je check
jmp returntotal

check:
inc ecx
mov eax, [lenC]
dec eax
cmp edx, eax
je returntotal
inc edx
inc edi
jmp compare

returntotal:
mov [total], ecx
ret

printable_convert:
