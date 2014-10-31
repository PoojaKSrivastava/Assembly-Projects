;Pooja Srivastava
;MASM 
;Reversing an Array with indirect addressing              

INCLUDE Irvine32.inc

.data
Source BYTE "This is the source string", 0	;string declaration
target BYTE SIZEOF source DUP('#')		;taget string declaration 

.code
main PROC

    mov esi, OFFSET source + SIZEOF source -2	;fills esi registers											
    mov edi, OFFSET target			;Records memory of target and stores into edi
    mov ecx, SIZEOF source			;Loop control variable

		
l1:						;Start of loop

	mov bl, [esi]				;Moves character string into reg
	mov [edi], bl				;Character string is moved into edi reg
	inc edi					;Pointer to target string
	dec esi					;Pointer to source string
	
    LOOP l1					;Call to loop

	mov esi, OFFSET target			;offset of the variable
	mov ebx, 1				;byte format
	mov cx, SIZEOF target - 1		;counter

	call DumpMem				;displays the reversed array to the screen

    exit

main ENDP
END main