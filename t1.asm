.686
.model flat, C
 option casemap:none

.data
public g
g DWORD 4
.code

public min

min:
    ;Setup
    push    ebp                     ; push old frame pointer
    mov    ebp, esp                ; set new frame pointer
    sub     esp, 4                  ; allocate space for 'v'
    push ebx

    ;Body
    mov     eax, [ebp+8]            ; move 'a' into eax
    mov     [ebp-4], eax            ; store 'a' in 'v'
    mov     eax, [ebp+12]           ; move 'b' into eax
    cmp     eax, [ebp-4]            ; compare 'a' and 'b'
    jge     min0                    ; skip to min0 if 'a' is less than 'b'
    mov     [ebp-4], eax            ; move 'b' to 'v'
min0:
    mov     eax, [ebp+16]           ; move 'c' into eax
    cmp     eax, [ebp-4]            ; compare 'v' and 'c'
    jge     min1                    ; skip to min1 if 'v' is less than 'c'
    mov     [ebp-4], eax            ; move 'c' to 'v'
min1:
    mov     eax, [ebp-4]            ; move return value to eax

    ;Return
    pop     ebx
    add     esp, 4                  ; deallocate space for v
    mov     esp, ebp                ; reset top of stack
    pop     ebp                     ; reset old frame pointer
    ret                             ; return



public p

p:
    ;Setup
    push 		ebp 				; push old frame pointer
    mov			ebp, esp 			; set new frame pointer
    push        ebx

    ;Body
    push		[g]					; push 'g' as first parameter
    push		[ebp+8]				; push 'a' as second parameter
    push		[ebp+12] 			; push 'j' as third parameter
    call 		min 				; function call
    add 		esp, 12 			; remove parameters from stack
    push 		eax					; push return value from min as first parameter
    push        [ebp+16] 		    ; push 'k'
    push        [ebp+20] 		    ; push 'l'
    call 		min

    ;Return
    pop         ebx
    mov 		esp, ebp            ; reset top of stack
    pop 		ebp                 ; reset old frame pointer
    ret                             ; return



public gcd

gcd:
    push        ebp                     ; push old frame pointer
    mov         ebp, esp                ; set new frame pointer
    cmp         DWORD PTR [ebp+12], 0   ; if (b == 0)
    jne         gcd0
    mov         eax, [ebp+8]            ; return a
    jmp         gcd1

gcd0:
    mov         eax, [ebp+8]            ; load 'a'
    cdq                                 ; sign extend
    idiv        DWORD PTR [ebp+12]      ;
    push        edx                     ; push modulus
    push        [ebp+12]                ; push b
    call        gcd
    add         esp, 8                  ; pop parameters

gcd1:
    mov         esp, ebp                ; restore esp
    pop         ebp                     ; pop old frame pointer
    ret                                 ; return

end
