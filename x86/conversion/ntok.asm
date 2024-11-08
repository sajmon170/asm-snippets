.686
.model flat

public ntok
extern ntobin: PROC
extern binton: PROC

.data

.code
; char* ntok(char* number, int n, int k)
ntok PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12] ; input base
    push eax
    mov eax, [ebp + 8]  ; input number
    push eax
    call ntobin
    add esp, 8

    mov ebx, [ebp + 16] ; output base
    push ebx
    push eax            ; ntobin result
    call binton
    add esp, 8
    
    mov esp, ebp
    pop ebp
    ret
ntok ENDP
END
