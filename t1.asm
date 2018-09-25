section .data
g       dd 4

section .text
public min, p, gcd

min:
		;Setup
	 	push 	ebp 					; push old frame pointer
		move 	ebp, esp				; set new frame pointer
		sub 	esp, 4 					; allocate space for 'v'

		;Body
		mov 	ebx, [ebp+8]   			; move 'a' into ebx
		mov 	[esp-4], ebx   			; store 'a' in 'v'
		mov 	ebx, [ebp+12]   		; move 'b' into ebx
		cmp  	ebx, [ebp-4]   			; compare 'a' and 'b'
		jge 	min0            		; skip to min0 if 'a' is less than 'b'
		mov 	[ebp-4], ebx    		; move 'b' to 'v'
min0:	
		mov 	ebx, [ebp+16]   		; move 'c' into ebx
		cmp 	ebx, [ebp-4]    		; compare 'v' and 'c'
		jge 	min1            		; skip to min1 if 'v' is less than 'c'
		mov 	[ebp-4], ebx    		; move 'c' to 'v'
min1:	
		mov 	eax, [ebp-4]			; move return value to eax
		
		;Return
		add 	esp, 4            		; deallocate space for v
    	mov 	esp, ebp        		; reset top of stack
    	pop 	ebp            			; reset old frame pointer
		ret 							; return




p:	
		;Setup
		push 		ebp 				; push old frame pointer
		mov			ebp, esp 			; set new frame pointer

		;Body
		mov 		ebx, [g]			; load 'g'
		push		ebx					; push 'g' as first parameter
		mov 		ebx, [ebp+8]		; load 'a'
		push		ebx					; push 'a' as second parameter
		mov 		ebx, [ebp+12] 		; load 'j'
		push		ebx 				; push 'j' as third parameter
		call 		min 				; function call
		add 		esp, 12 			; remove parameters from stack
		push 		eax					; push return value from min as first parameter
		mov 		ebx, [ebp+16] 		; load 'k'
		push 		ebx 				; push 'k' as second parameter
		mov 		ebx, [ebp+20] 		; load 'l'
		push 		ebx 				; push 'l' as third parameter
		call 		min

		;Return
		mov 		esp, ebp        	; reset top of stack
    	pop 		ebp            		; reset old frame pointer
		ret 							; return




gcd:	
		;Setup
		push      	ebp            	   ;push old frame pointer
    	mov   	    ebp, esp     	   ;set new frame pointer
    	sub	        esp, 4        	   ;declare local variable

    	;Body
    	mov 		ebx, [ebp+12]		; load 'b'		
    	cmp 		ebx, 0 				; compare with 0
    	jne 		gcd1				; jump to gcd1 if not equal
    	mov 		eax, [ebp+8]  		; move 'a' to eax
    	ret 							; return a
gcd1:	
		push 		ebx 				; push 'b' as first parameter


		;Unfinished





































