.model small
.386
.stack 100h
.data
    box dd 0 									;zmienna do przetrzymania wartosci eax by moc jej uzyc do kolejnych obliczen
	binary db 32,"binarnie",32,61,32,"$" 		;32-> spacja, 61-> znak rownosci 
	decimal db 32,"dziesietnie",32,61,32,"$"
	octal db 32,"osemkowo",32,"$"
.code

start:

mov ax, @data
mov ds, ax

;Czyszczenie ekranu(czysto dla estetyki)
	mov ah,0fh
	int 10h
	mov ah,0
	int 10h
      
;Ustawienie zmiennych		
mov eax, 159753  						;<-WARTOSC DO KONWERSJI!!  
mov ebx, 10							;modulo systemu dzisietnego
mov cx, 0							;wyzerowanie licznika petli
mov box, eax						;zapamietanie wartosci eax

;POSTAC DZIESIETNA
	decimalcountloop:
		inc cx 						;inkrementacja licznika petli
		mov edx,0					;wyzerowanie rejestru edx by dzielenie dalo dobry wynik
		div ebx						;eax=wynik edx=reszta
		push edx					;wrzucenie reszty na stos
		cmp eax,0		    		;porownanie rejestru eax z zerem
		jne decimalcountloop		;jesli wartosci nie sa rowne to skok do poczatku petli


	decimalshowloop:
		pop edx						;sciagniecie wartosci edx ze stosu
		add edx, 30h	 			;+48 dla ASCII
		mov ah, 0Eh		 			;wyswietlanie reszty z dzielenia
		mov al, dl
		int 10h
		loop decimalshowloop


;TEXT DLA LICZBY W FORMIE DZISIETNEJ
    mov ah, 9
	mov dx, offset decimal
    int 21h
	mov eax, box
   

;ZMIANA SYSTEMU NA BINARNY
	mov ebx, 2
	mov cx,0


;POSTAC BINARNA
	binarycountloop:
		inc cx 						
		mov edx,0
		div ebx			 			
		push edx			 		

		cmp eax,0		 			
		jne binarycountloop			

	binaryshowloop:
		pop edx			 			
		add edx, 30h	 			
		mov ah, 0Eh		 			
		mov al, dl
		int 10h
		loop binaryshowloop

;TEXT DLA LICZBY W FORMIE BINARNEJ
	mov ah, 9
	mov dx, offset binary
    int 21h
	mov eax, box
   
   
;ZMIANA SYSTEMU NA OSEMKOWY
	mov ebx, 8
	mov cx,0
	

;POSTAC OSEMKOWA
	octalcountloop:
		inc cx 						
		mov edx,0
		div ebx			 			
		push edx			 		

		cmp eax,0		 			
		jne octalcountloop			

	octalshowloop:
		pop edx			 			
		add edx, 30h	 			
		mov ah, 0Eh					
		mov al, dl
		int 10h
		loop octalshowloop

;TEXT DLA LICZBY W FORMIE OSEMKOWEJ
		mov ah, 9
        mov dx, offset octal
        int 21h

;ZAKONCZENIE PROGRAMU
mov ah, 4Ch		 
int 21h
end start

