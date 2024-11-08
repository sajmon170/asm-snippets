.686
.model flat

public _main
public _divide32
extern _ExitProcess@4: PROC
extern _printf: PROC
extern _calloc: PROC

.data
number dd 011223344h, 0AABBCCDDh,  012345678h
len = ($ - OFFSET number) / 4
num2   dd 089ABCDEFh
fmt    db "%X", 0
newln  db 0Dh, 0Ah, 0

.code
; int* divide32(int len, int* a, int b)
_divide32 PROC
    push ebp
    mov ebp, esp
    sub esp, 4

    push ebx
    push esi
    push edi

    mov eax, [ebp + 8]
    shl eax, 2
    push eax
    call _calloc
    add esp, 4
    mov [ebp - 4], eax
    
    mov edi, eax
    mov esi, [ebp + 12]
    mov ebx, [ebp + 16]

    xor edx, edx
    mov ecx, [ebp + 8]
    et:
        mov eax, [esi]
        div ebx
        mov [edi], eax
        add esi, 4
        add edi, 4
    loop et 

    mov eax, [ebp - 4]
    
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_divide32 ENDP

_main PROC
    push num2
    push OFFSET number
    push len
    call _divide32

    mov ecx, len
    mov edi, eax
    et:
        push ecx
        
        mov eax, [edi]
        push eax
        push OFFSET fmt
        call _printf
        add esp, 8
        
        add edi, 4
        pop ecx
    loop et

    push OFFSET newln
    call _printf
    add esp, 4

    push 0
    call _ExitProcess@4
_main ENDP
END
