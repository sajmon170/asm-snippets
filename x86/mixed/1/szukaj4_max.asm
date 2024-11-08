.686
.model flat

public _szukaj4_max
public _liczba_przeciwna
public _odejmij_jeden

extern _qsort: PROC

.data

.code
; int compare(void* a, void* b)
compare PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov eax, [ebp + 8]
    mov eax, [eax]

    mov ebx, [ebp + 12]
    mov ebx, [ebx]

    xor ecx, ecx
    cmp eax, ebx
    setl cl

    mov eax, ecx

    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
compare ENDP

; int szukaj4_max(int a, int b, int c, int d)
_szukaj4_max PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    lea eax, [ebp + 8]
    push OFFSET compare
    push 4
    push 4
    push eax
    call _qsort
    add esp, 16

    mov eax, [ebp + 8]

    pop edi
    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
_szukaj4_max ENDP

; void liczba_przeciwna(int*)
_liczba_przeciwna PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov ebx, [ebp + 8]
    mov eax, [ebx]
    neg eax

    mov [ebx], eax
    
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_liczba_przeciwna ENDP

; void odejmij_jeden(int** liczba)
_odejmij_jeden PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov ebx, [ebp + 8]
    mov ebx, [ebx]

    mov eax, [ebx]
    dec eax
    mov [ebx], eax
    
    pop ebx
    pop esi
    pop edi

    mov esp, ebp
    pop ebp
    ret
_odejmij_jeden ENDP
END
