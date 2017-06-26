.model small
.386          
.data
;program wyswietla tylko jedno obliczenie
;przy dodawaniu kolejnych procedur liczacych wychodzily kosmiczne wyniki
;takze program niedokonczony -powod-brak sily w srodku nocy
;tylko druga podana zmienna zostanie obliczona k*k+1
napis DB 32,32,32,32,32,"Podaj dwie liczby: ","$"
wynik DB "  k*k+1=","$"

.code
.stack 100h


program:							;POCZATEK PROGRAMU
mov ax, @data
mov ds,ax
mov si, 0							;zmienna kontrolujaca powtorzenia glownej petli


petla:								;GLOWNA PETLA PROGRAMU

	inc si							
	mov ebx, 0

	call info  
	call wczytaj
	gotowe: nop
	call licz						;wywolanie procedury liczacej n*n+1

		kon:
		cmp si,5
		je iec

		loop petla
		iec:
		call koniec

;========================================PROCEDURY PROGRAMU================================
info PROC							;wypisywanie prosby o podanie liczb
	push ax     
	lea dx, napis	
	mov ah,09h
	int 21h
	pop ax     
	ret
info ENDP

wczytaj PROC   						; wczytanie pierwsze zmiennej z klawiatury
	mov ah,01h
	int 21h
	cmp al, 13						;przerwanie pobierania w momencie wcisniecia entera
	jz wczytaj2
	mov cl, al
	sub cl, '0'
	mov eax, ebx
	mov ebx, 10
	mul ebx
	mov ebx, eax
	mov eax, 0
	mov al, cl
	add ebx, eax
	mov ebx, 0
	jmp wczytaj	
wczytaj ENDP

wczytaj2 PROC   					;wczytanie drugiej zmiennej z klawiatury
	mov ah,01h
	int 21h
	cmp al, 13						;przerwanie w momencie wcisniecia entera
	jz gotowe						;instrukcja pusta
	mov cl, al
	sub cl, '0'
	mov eax, ebx
	mov ebx, 10
	mul ebx
	mov ebx, eax
	mov eax, 0
	mov al, cl
	mov edx, ebx
	add ebx, eax
	mov ecx,0
	jmp wczytaj2	
wczytaj2 ENDP


nastos PROC 						;Procedura wrzucajaca podzielona liczbe na stos
	mov edx, 0
	mov ebp, 10
	div ebp
	push edx
	inc cl
	cmp eax, 0
	jz wyswietl
	jmp nastos
nastos ENDP

wyswietl PROC						;Procedura wyswietlajaca elementy stosu
	cmp cl,0
	jz kon								
	dec cl
	mov edx, 0
	pop edx
	add dl,30h
	mov ah,02h	
	int 21h
	jmp wyswietl	
wyswietl ENDP


licz PROC							;Procedura n*n+1
	lea dx, wynik      
	mov ah,09h
	int 21h 
	mov eax,ebx
	mul ebx
	add eax, 1

	mov ebx,eax
	call nastos
licz ENDP

koniec PROC 						;ZAKONCZENIE DZIALANIA PROGRAMU
	mov ah, 4CH 
	int 21H
koniec ENDP

end program							;end