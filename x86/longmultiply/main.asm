.686
.model flat

public _main

extern transform: PROC
extern decode:    PROC
extern encode:    PROC
extern strlen:    PROC

; C
extern _printf: PROC
extern _scanf:  PROC
extern _malloc: PROC
extern _free:   PROC

; StdCall
extern _ExitProcess@4: PROC

.data
fmt  db "%s", 0
fmt2 db "%u", 0DH, 0AH, 0

.code
; char* multiply(char* num1, char* num2, int base)
multiply PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    push eax
    call strlen
    add esp, 4
    mov ebx, eax

    mov eax, [ebp + 12]
    push eax
    call strlen
    add esp, 4
    add eax, ebx

    push eax
    call _malloc
    add esp, 4

    mov esp, ebp
    pop ebp
    ret
multiply ENDP

_main PROC
    mov ebp, esp
    sub esp, 1000

    lea eax, [ebp - 1000]
    push eax
    push OFFSET fmt
    call _scanf
    add esp, 8
 
    lea eax, [ebp - 1000]
    push eax
    call strlen
    add esp, 4
    
    push eax
    push OFFSET fmt2
    call _printf

    push 0
    call _ExitProcess@4
_main ENDP
END
