.686
.model flat, C
 option casemap:none

includelib
legacy_stdio_definitions.lib

extrn printf:near

.data
public g
g DWORD 4
.code

public minX64

minX64:
    mov         rax, rcx            ; move 'a' into shadow space 'v'
    cmp         rdx, rax            ; compare 'b' and 'v'
    jge         min0                ; skip if 'v' < 'b'
    mov         rax, rdx            ; move 'b' to 'v'
min0:
    cmp         r8, rax             ; compare 'c' and 'v'
    jge         min1                ; skip if 'v' < 'c'
    mov         rax, r8             ; move 'c' to 'v'
min1:
    ret                             ; return


public pX64

pX64:
    sub         rsp, 32            ; allocate shadow space

    mov         [rsp+64], r9       ; l
    mov         [rsp+56], r8       ; k
    mov         r8, rdx            ; j param 3
    mov         rdx, rcx           ; i param 2
    mov         rcx, g             ; g param 1
    call        min
    mov         rcx, rax           ; sum param 1
    mov         rdx, [rsp+56]      ; k param 2
    mov         r8, [rsp+64]       ; l param 3
    call        min
    add         rsp, 32            ; deallocate shadow space
    ret                            ; return


public gcdX64

gcdX64:

    cmp         rdx, 0             ; if (b == 0) return 'a'
    jne         gcd0
    mov         rax, rcx           ; return a
    jmp         gcd1

gcd0:
    mov         r8, rcx            ; load 'a'
    mov         rax, rcx           ; load 'a'
    mov         rcx, rdx           ; load 'b'
    cqo
    idiv        QWORD ptr rcx
    call        gcd

gcd1:
    ret                            ; return gcd(b, a % b)


public qX64

qX64:
	sub         rsp, 64
    lea         rax, [rcx+rdx]     ; a+b
    add         rax, r8            ; a+b+c
	add         rax, r9            ; a+b+c+d
	mov         r10, [rsp+104]     ; 
	add         rax, r10           ; sum

	mov         [rsp+48], rax      ; sum
	mov         [rsp+40], r10      ; e
	mov         [rsp+32], r9       ; d
	mov         r9, r8             ; c
	mov         r8, rdx            ; b
	mov         rdx, rcx           ; a
    lea         rcx, fq            ; 
    mov         rbx, rax           ; move sum to rbx to preserve
    call        printf             ; call printf

    mov         rax, rbx           ; put sum back into rax 
    add         rsp, 64            ; deallocate shadow space    
    ret                            ; return


fq0     db  "qns",  0AH, 00H
public qns

qns:
    lea        rcx, fq0
    sub        rsp, 32
    call       printf
    add        rsp, 32
    mov        rax, 0
    ret

end