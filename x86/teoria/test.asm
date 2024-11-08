.686
.model flat

extern printf: PROC

.data

.code
_main PROC
    push ebp
    mov ebp, esp
    sub esp, 4
    

    mov eax, 0A

    mov esp, ebp
    pop ebp
    ret
_main ENDP
END
