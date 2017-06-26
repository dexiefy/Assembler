.model small
.386
.stack 100h
.code
start:
;ustawienie rejestrow
mov ax, 0
mov bh, 10
mov al, 255

;petla wkladajaca kolejne wyniki modulo 10 na stos
mov cx, 3
count:
div bh
mov bl, ah
add bl, 30h
mov dl, bl
push bx ;wlozenie na stos
mov dl, al
mov ax, 0
mov al, dl
dec cx
jnz count

;petla wypisujaca elementy stosu	
mov cx, 3
print:	
mov ax, 0
pop bx 	;sciagniecie ze stosu
mov al, bl
;wypisanie wartosci
mov ah, 0Eh
int 10h
dec cx
jnz print

mov ah, 4Ch
int 21h 
 	
end start