.686
.xmm
.model flat

public _szybki_max
extern _malloc: PROC

.data

.code
_szybki_max PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov edi, [ebp + 16]

    mov ecx, [ebp + 20]
    shr ecx, 2            ; ecx/4

    et:
        movupd xmm0, [eax]
        movupd xmm1, [ebx]
        pmaxsd xmm0, xmm1
        movupd [edi], xmm0

        add eax, 4*4
        add ebx, 4*4
        add edi, 4*4
    loop et

    pop edi
    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
_szybki_max ENDP

_szybki_max2 PROC
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
    pmaxsw xmm0, xmm1
    movups [edi], xmm0

    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_szybki_max2 ENDP
END
