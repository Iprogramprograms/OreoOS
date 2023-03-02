org 7c00h
mov ax, 13h
int 10h
xor ax, ax
mov ds, ax
mov ss, ax
mov sp, 0x8000
jmp switch_to_pm
GDT_start:
GDT_null:
dd 0x0
dd 0x0
GDT_code:
dw 0xffff
dw 0x0
db 0x0
db 10011010b
db 11001111b
db 0x0
GDT_data:
dw 0xffff
dw 0x0
db 0x0
db 10010010b
db 11001111b
db 0x0
GDT_end:
GDT_descriptor:
dw GDT_end - GDT_start - 1
dd GDT_start
CODE_SEG equ GDT_code - GDT_start
DATA_SEG equ GDT_data - GDT_start
switch_to_pm:
cli
lgdt [GDT_descriptor]
mov eax, cr0
or  eax, 1  ; Set PE=1
mov cr0, eax
mov ax, DATA_SEG
mov ds, ax
jmp CODE_SEG:init_pm
use32
init_pm:
mov ebx, 0xA0000000
mov esi, 50
mov edi, 100
mov eax, esi       ; eax = y
imul eax, 320      ; eax = y * 320
add eax, edi       ; eax = y * 320 + x
add ebx, eax       ; ebx = 0xA0000000 + y * 320 + x
mov byte [ebx], 7  ; set pixel color to white
hlt
jmp $-1
times 510-($-$$) db 0
dw 0xAA55