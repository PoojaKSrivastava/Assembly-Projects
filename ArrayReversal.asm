;Pooja Srivastava
;MASM

;Reversing an Array              

INCLUDE Irvine32.inc

.data
arrayTest DWORD 1, 3, 5, 7, 9, 2Ah, 4Ah, 6Ah, 8Ah

.code
main PROC
    mov esi, 0						;Points to the first index of the array
    mov edi, SIZEOF arrayTest - TYPE arrayTest		;Points to the last index of the array of any type of array
    mov ecx, LENGTHOF arrayTest/2			;Loop control variable

		
l1:							;Start of loop
    mov eax, arrayTest[esi]				;Elements of array at each specific index are stored into the array
    xchg eax, arrayTest[edi]				;Element is swapped for the last element in the array
    mov arrayTest[esi], eax				;Element that was in eax is now moved into the array at the esi index
    
    add esi, TYPE arrayTest				;Increment esi by adding 4 bytes from it
    sub edi, TYPE arrayTest				;Decrement edi by subtracting 4 bytes from it

    LOOP l1						;Call to loop

	mov esi, OFFSET arrayTest			;Start of the array is stored in esi
	mov ecx, LENGTHOF arrayTest			;The length of the array is moved into ecx 
	mov ebx, TYPE arrayTest				;The size of each array element is moved to ebx

	call DumpMem					;displays the reversed array to the screen

    exit

main ENDP
END main