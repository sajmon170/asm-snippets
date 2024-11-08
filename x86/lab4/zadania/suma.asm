public suma_kwadratow

; i64 suma_kwadratow(i64 a, i64 b)

.code
suma_kwadratow PROC
    push rbx
    mov r8, rdx
    mov rdx, 0
    
    mov rbx, 0
    
    mov rax, rcx
    imul rax
    add rbx, rax

    mov rax, r8
    imul rax
    add rbx, rax

    mov rax, rbx

    pop rbx
    ret
suma_kwadratow ENDP

END
