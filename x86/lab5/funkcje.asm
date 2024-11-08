.686
.xmm
.model flat

public _mul_at_once

.data
f_90 dd 90.0
g    dd 9.81
temp dd ?

.code
_find_max_range PROC
    push ebp
    mov ebp, esp

    finit
    fild DWORD PTR [ebp + 12]
    fld f_90
; st(0) = alpha (deg)
    fdivp
    fldpi
    fmulp
    fsin
; st(0) = sin(2alpha (rad))
    
    fmul DWORD PTR [ebp + 8]
    fmul DWORD PTR [ebp + 8]
    fdiv DWORD PTR g

    fst DWORD PTR [temp]
    mov eax, temp

    mov esp, ebp
    pop ebp
    ret
_find_max_range ENDP

_mul_at_once PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov edi, [ebp + 8]
    mov eax, [ebp + 12]
    mov ebx, [ebp + 16]

    movups xmm0, [eax]
    movups xmm1, [ebx]
    pmulld xmm0, xmm1

    movups [edi], xmm0
    
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_mul_at_once ENDP

END
