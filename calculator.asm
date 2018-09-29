%include "/usr/local/share/csc314/asm_io.inc"


segment .data


segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
	; 	gets the two integers and the operator
	call 	read_int		
	mov 	ebx, eax	; A = EBX
	call	read_char	; clears \n

	call 	read_char	; 
	mov 	cl, al		; operator = CL
	call 	read_char	; clears \n
	

	call 	read_int	;
	mov		esi, eax	; b = esi
	call 	read_char	; clears \n
	
	;******  print out the equation ********* A (operator) B = 
	
	mov		eax, ebx	; eax = A
	call	print_int	; print A
	mov		al, cl		; al = operator
	call	print_char	; print operator
	mov		eax, esi	; eax = B
	call	print_int	; print B
	mov		al,'='		; al = "="
	call	print_char	; print =

	; A = EBX, B = ESI, operator = cl
		
	;************* chooses and completes the operation********
	; switch on the operators	

	cmp 	cl, '*'
	je		caseMult
	cmp		cl, '/'
	je 		caseDiv
	cmp		cl, '+'
	je		caseAdd
	cmp		cl, '-'
	je 		caseMinus
	cmp		cl, '%'
	je		caseMod
	cmp		cl, '^'
	je		caseExp		
	
	; end switch cases
	

	; start switch instructions

	caseMult:				; multiplication
		mov 	eax, ebx
		imul	esi			; eax = A*B
		call	print_int	; prints the result
		jmp		endswitch

	caseDiv:
		mov		eax, ebx	; mov A to eax
		cdq					; eax -> edx:eax
		idiv 	esi			; eax =  A / B
		call	print_int	; prints the result
		jmp		endswitch

	caseAdd:
		add		esi, ebx
		mov		eax, esi	; eax = A + B
		call 	print_int	; prints the result
		jmp		endswitch

	caseMinus:
		sub		esi, ebx
		mov		eax, esi	; eax = A - B
		call 	print_int	; prints the result
		jmp		endswitch

	caseMod:
		mov		eax, ebx	; mov A to eax
		cdq					; eax -> edx:eax
		idiv 	esi			; eax =  A / B
		mov		eax, edx	; move the remainder to eax
		call 	print_int	; prints the result
		jmp		endswitch

	caseExp:
			; handling edge cases
			cmp		esi, 0
			je		caseZero
			cmp		esi, 1
			je		caseOne
			
			; dowhile loop for exponents >= 2

			mov		eax, ebx	; mov A to eax for multiplications
			doLoop:				 
				imul	ebx		; Num * A
				dec		esi		; esi - 1
				cmp		esi, 1	
				jg		doLoop				

			call	print_int
			jmp endswitch
			
			caseZero:
				mov eax, 1
				call print_int	; prints the result
				jmp endswitch
			caseOne:
				mov eax, ebx
				call print_int	; prints the result
	
		jmp		endswitch

	endswitch:
		call	print_nl

	; end switch


	

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret









