;Pooja Srivastava
;MASM

;Perform calculations using a menu driver             

INCLUDE Irvine32.inc
.data

;Output Menu Driver
displayMenu			db "Please make one of the following selections: ", 0ah, 0dh			
				db 'M - Calculate the actual miles per gallon or MPG', 0ah, 0dh
				db 'D - Calculate the max distance you can travel', 0ah, 0dh
				db 'G - Calculate the gals required for a trip', 0ah, 0dh
				db 'Q - Quit the program', 0ah, 0dh
				db 'Choice: ',0;

askGals				db 'Enter the gallons: ', 0			;OUTPUT - ask for gallons 
askMiles			db 'Enter the miles: ', 0			;OUTPUT - ask for miles
askMpg				db 'Enter the MPG: ', 0				;OUPPUT - ask for mpg
outputMPG			db 'Your actual MPG is: ',0			;OUTPUT - Output total mpg
outputMiles			db 'Max distance you can travel: ',0		;OUTPUT - Output max distance
outputGallons			db ' Gallons needed for the trip.',0ah, 0dh	;OUTPUT - Output gallons needed			

.data?

gals				dd	?		;Unitialized variable to hold gallons
miles				dd	?		;Unitialized variable to hold miles
mpg				dd	?		;Unitialized variable to hold mpg
milesPerGallon			dd	?		;Unitialized variable to hold milesPerGallon
maxDistanceCanTravel		dd	?		;Unitialized variable to hold maxDistanceCanTravel
gallonsRequired			dd	?		;Unitialized variable to hold gallonsRequired


.code
main PROC
	
	;Displays menu
	mov edx, offset displayMenu			;Records string displayMenu in edx
	call WriteString				;Outputs string message
	

Menu:
	call ReadChar					;Input - Read in menu choice
	call WriteChar					;Output - Output menu choice

	;Calculate MPG
	.if al == "m" || al == "M"			;Checks user input
			
		call Crlf				;New line
		mov edx, offset askMiles		;Records string askmiles in edx
		call WriteString			;Outputs string message
		call ReadInt				;Reads in miles
		mov miles, eax				;Load eax into miles

		mov edx, offset askGals			;Records string askGals in edx
		call WriteString			;Outputs string message
		call ReadInt				;Reads in gallons
		mov gals, eax				;Load eax into gals

		mov eax, milesPerGallon			;Variable stored into eax
		mov eax, miles				;Miles is moved into eax
		xor edx, edx				;zero out the register
		div gals				;divide miles by gallon
		
		mov edx, offset outputMPG		;Records string message in edx
		Call WriteString			;Outputs string message
		Call WriteDec				;Outputs mpg
		Call Crlf				;New line

		jmp main				;Jumps back to main

	.elseif al == "d" || al == "D"			;Checks user input

		call Crlf				;New line
		mov edx, offset askMPG			;Records string askMPG in edx
		call WriteString			;Outputs string message
		call ReadInt				;Reads in mpg
		mov mpg, eax				;Load eax into mpg

		mov edx, offset askGals			;Records string askGals in edx
		call WriteString			;Outputs string message
		call ReadInt				;Reads in gallons
		mov gals, eax				;Load eax into gals

		mov eax, milesPerGallon			;Variable stored into eax
		mov eax, mpg				;Mpg is moved into eax
		mul gals				;Mpg is multiplied by gals
		
		mov edx, offset outputMiles		;Records string message in edx
		Call WriteString			;Outputs string message
		Call WriteDec				;Outputs max miles traveled
		Call Crlf				;New line
			
		jmp main				;Jumps back to main

	;To calculate max gallons
	.elseif al == "G" || al == "g"			;Checks user input

		call Crlf				;New Line
		mov edx, offset askMiles		;Records string askMiles in edx
		call WriteString			;Outputs string message
		call ReadInt				;Reads in miles
		mov miles, eax				;Load eax into miles

		mov edx, offset askMPG			;Records string askMpg in edx
		call WriteString			;Outputs string message
		call ReadInt				;Reads in mpg
		mov mpg, eax				;Load eax into mpg

		mov eax, milesPerGallon			;Variable stored into eax	
		mov eax, miles				;Miles is moved into eax
		xor edx, edx				;zero out the register
		div mpg					;Gallons is divided by mpg

		Call WriteDec				;Outputs max gallons needed
		mov edx, offset outputGallons		;Records string message in edx
		Call WriteString			;Outputs string message
		Call Crlf				;New line

		jmp main				;Jumps back to main
		
	;To exit the program
	.elseif al == "q"				;Checks user input
		exit					;exits the program
			
	.endif						;ends if statements 

    exit
main ENDP								
END main	