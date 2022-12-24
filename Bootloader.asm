org 7c00h
start:
mov ah, 00h
mov al, 13h
mov ax, 13h
int 10h
mov cx, 64000
putpixel:
mov ax, 0A000h
mov es, ax
mov ax, cx
mov di, ax
mov dl, 0x35
mov [es:di], dl
loop putpixel
mov cx, 3200
putpixel2:
mov ax, 0A000h
mov es, ax
mov ax, cx
mov di, ax
mov dl, 0x0f
mov [es:di], dl
loop putpixel2
times 510-($-7c00h) db 0
db 055h, 0AAh
