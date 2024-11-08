.686
.model flat

.data

.code
; unsigned abs(int num)
abs PROC
    push ebp
    mov ebp, esp

    mov eax, 0
    sub eax, [ebp + 8]
    
    mov esp, ebp
    pop ebp
    ret
abs ENDP

END
