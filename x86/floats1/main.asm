.686
.model flat

extern _printf: PROC
extern _ExitProcess@4: PROC

.data
;float1 dd 2342.23324
;float2 dd 324235.311
float1 dd 5.0
float2 dd 7.3
result dq ?
fmt    db "%f", 0Dh, 0Ah, 0

.code
_main PROC
    finit
    fld float2
    fld float1
    fdiv
    fstp result

    mov eax, DWORD PTR [result + 4]
    push eax
    mov eax, DWORD PTR [result]
    push eax
    
    push OFFSET fmt
    call _printf
    add esp, 12

    push 0
    call _ExitProcess@4
_main ENDP
END
