;Pooja Srivastava
;MASM
;Purpose: To create a program that reads in text and counts the number of times each character is inputted


INCLUDE Irvine32.inc

BUFMAX = 132     	; maximum charString size

.data

inputMsg		BYTE	 "Enter the plain text: ",0			;prompt
totalCountMsg		BYTE	 "The character counts are:          ",0	;prompt		
format			BYTE	 " - ", 0					;format
times			BYTE	 " times", 0					;format
charInput		BYTE	 BUFMAX+1 DUP(0)				;input str
temp			BYTE	 ?						
strSize			DWORD	 ?						;input str size
dupCount		DWORD	 1						;Counter variable
charArray		DWORD	 26 dup (?)					; store 26 chars


.code
main PROC
	call    InputTheString				; input the plaintext
	mov	edx, OFFSET totalCountMsg		; display encrypted message	
	call	charCount  				; calc char count
	call	crlf

	exit
main ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for input text. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov		edx, OFFSET inputMsg	; display a prompt
	call		WriteString				
	mov		ecx,BUFMAX		; maximum character count
	mov		edx, OFFSET charInput; point to the charString
	call		ReadString         		; input the string
	mov		strSize,eax		; save the length
	call		Crlf
	popad
	ret
InputTheString ENDP

;-----------------------------------------------------
charCount PROC
;
; Counts the number of times each character appears in 
; the string.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad

	mov		esi,0				; index 0 in charString
		
L1:
	mov		ecx,strSize			; loop counter
	mov		al, charInput[esi]		; AL holds first char of string 
	call		Writechar			; displays char thats being counted
	mov		edx, OFFSET format		; display string	
	call    WriteString			
	
	L2:
	.if al == charInput[ecx]			; compares first character to entire text
		mov	 temp, al			; stores temp to check for repeat chars
		inc	 dupCount			; increments count if equal

	.endif

	loop L2						; loops to L2 to display count

L3:	
	
	mov		eax, dupCount			; display count
	Call		Writedec				
	mov		edx, OFFSET times		; display format
	call		Writestring
	call    	crlf
	mov		dupCount, 0			; reset count to 0
	inc		esi				; increase index
	cmp		esi, strSize			; compare to see if its the last char in text
	jl L1						; jump for the next char
	

popad
ret

charCount ENDP
END main