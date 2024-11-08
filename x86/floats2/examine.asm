.686
.model flat

public _examine

.code
_examine PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    nop
    
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_examine ENDP
END
