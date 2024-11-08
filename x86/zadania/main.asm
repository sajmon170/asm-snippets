.686
.model flat

public _main

; cdecl
extern _printf: PROC

; StdCall
extern _ExitProcess@4: PROC

.data
fmt db "EDX: %X, EBX: %X, EAX: %X", 0DH, 0AH, 0

.code
_main PROC
    mov edx, 4385384
    mov ebx, -23425
    mov eax, -1

    xor ecx, ecx
    
    shl eax, 1
    setc cl
    push ecx
    
    shl ebx, 1
    setc cl
    push ecx
    
    shl edx, 1
    setc cl
    push ecx

    pop ecx
    or eax, ecx

    pop ecx
    or ebx, ecx

    pop ecx
    or edx, ecx

    push eax
    push ebx
    push edx
    push OFFSET fmt
    call _printf
    add esp, 16
    
    push 0
    call _ExitProcess@4
_main ENDP
END
