public WinMain

extern printf: PROC
extern ExitProcess: PROC

.data
output db "Hello, world!", 0Dh, 0Ah, 0

.code
WinMain PROC
    mov rcx, OFFSET output
    
    sub rsp, 20h
    call printf
    add rsp, 20h

    push 0
    call ExitProcess
WinMain ENDP
END
