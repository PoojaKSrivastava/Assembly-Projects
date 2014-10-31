;Pooja Srivastava
;MASM
;Purpose: To create a program that reads in text, encrypts it, and decrypts


INCLUDE Irvine32.inc

BUFMAX = 128     	; maximum buffer size
CIPHERMAX = 128     	; max buffer size

.data

sPrompt			BYTE	 "Enter the plain text: ",0
cipherPrompt		BYTE 	 "Enter the key: ", 0
sEncrypt		BYTE	 "Cipher text:          ",0
sDecrypt		BYTE	 "Decrypted:            ",0
buffer			BYTE	 BUFMAX+1 DUP(0)
bufSize			DWORD	 ?
cipherStr		BYTE     CIPHERMAX+1 DUP(0)
keySize		   	DWORD	 ?

.code
main PROC
	call  		InputTheString			; input the palin text
	call		InputCipherText			; input the plain text
	call		TranslateBuffer			; encrypt the buffer
	mov		edx, OFFSET sEncrypt		; display encrypted message
	call		DisplayMessage			
	call		TranslateBuffer  		; decrypt the buffer
	mov		edx, OFFSET sDecrypt		; display decrypted message
	call		DisplayMessage

	exit
main ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a encryption key. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov		edx, OFFSET sPrompt		; display a prompt
	call		WriteString				
	mov		ecx,BUFMAX			; maximum character count
	mov		edx, OFFSET buffer		; point to the buffer
	call		ReadString         		; input the string
	mov		bufSize,eax			; save the length
	call		Crlf
	popad
	ret
InputTheString ENDP

;-----------------------------------------------------
InputCipherText PROC
;
; Prompts user for a encryption key. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov		edx,OFFSET cipherPrompt	; display a prompt
	call		WriteString
	mov		ecx,CIPHERMAX		; maximum character count
	mov		edx,OFFSET cipherStr 	; point to the buffer
	call		ReadString         	; input the string
	mov		keySize,eax		; save the length
	call		Crlf
	popad
	ret
InputCipherText ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
	pushad
	call		WriteString
	mov		edx,OFFSET buffer	; display the buffer
	call		WriteString
	call		Crlf
	call		Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov		ecx,bufSize		; loop counter
	mov		esi,0			; index 0 in buffer
	mov 		edi, 0			; index 0 in the key

L1:
	mov		al, cipherStr[edi]
	xor		buffer[esi],al	; translate a byte
	inc		esi				; point to next byte
	inc		edi 			; next key byte
	cmp		edi, keySize
	jb L2
	mov		edi, 0			;reset to begining

L2:	loop	L1

	popad
	ret
TranslateBuffer ENDP
END main