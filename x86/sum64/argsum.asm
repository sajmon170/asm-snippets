public argsum

extern printf: PROC
extern ExitProcess: PROC

.data
output db "%lld", 0Dh, 0Ah, 0

.code
; uint64_t argsum(uint64_t argc, ...)
argsum PROC
    push rbp
    mov rbp, rsp

    mov rax, 0
    is_argc_1:
        cmp rcx, 1
        add rax, rdx
        ja is_argc_2
        jmp end_if
    is_argc_2:
        cmp rcx, 2
        add rax, r8
        ja is_argc_3
        jmp end_if
    is_argc_3:
        cmp rcx, 3
        add rax, r9
        ja is_above
        jmp end_if
    is_above:
        sub rcx, 3
        sum:
            add rax, [rbp + 8*rcx + 40]
        loop sum
    end_if:
    
    mov rsp, rbp
    pop rbp
    ret
argsum ENDP

COMMENT @
WinMain PROC
    mov rcx, 5
    mov rdx, 10
    mov r8, 1
    mov r9, 3
    push 4
    push 20
    sub rsp, 20h
    call argsum
    add rsp, 20h
    add rsp, 16

    mov rcx, OFFSET output
    mov rdx, rax
    call printf

    push 0
    call ExitProcess
WinMain ENDP
@
END
