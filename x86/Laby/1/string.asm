.686
.model flat

public strlen

.code
strlen PROC                     ;arg1: string
    push ebp
    mov ebp, esp

    mov eax, 0
    mov ebx, [ebp + 8]
    begin:
        cmp BYTE PTR [ebx + eax], 0
        jz end_loop
        inc eax
        jmp begin
    end_loop:

    inc eax

    mov esp, ebp
    pop ebp
    ret
strlen ENDP
END
