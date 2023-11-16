section .data
text db 32   ; Độ dài tối đa của chuỗi văn bản
input_text db 32 dup(0)  ; Chuỗi văn bản nhập từ người dùng
output_text db 32 dup(0) ; Chuỗi văn bản in hoa

section .text
global _start

_start:
; Đọc chuỗi văn bản từ người dùng
mov eax, 3          
mov ebx, 2           
mov ecx, input_text 
mov edx, text       
int 0x80            

; Chuyển đổi chuỗi văn bản sang in hoa
xor esi, esi         
xor edx, edx        


convert_loop:
mov al, [input_text + esi]
cmp al, 0              
je done                

; Kiểm tra xem ký tự có nằm trong khoảng a-z không
cmp al, 'a'
jl not_lowercase
cmp al, 'z'
jg not_lowercase

; Nếu là ký tự thường, chuyển đổi sang ký tự hoa và lưu vào output_text
sub al, 32
mov [output_text + esi], al


not_lowercase:
inc esi
inc edx
jmp convert_loop

done:
; In ra chuỗi văn bản in hoa
mov eax, 4          
mov ebx, 1        
mov ecx, output_text  
mov edx, edx          
int 0x80
; Kết thúc chương trình
mov eax, 1            
xor ebx, ebx         
int 0x80
