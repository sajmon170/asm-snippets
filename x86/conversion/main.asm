.686
.model flat

public _main

extern ato16:  PROC
extern ntobin: PROC
extern binton: PROC

; C
extern _printf: PROC
extern _scanf:  PROC
extern _strlen: PROC
extern _malloc: PROC

; StdCall
extern _ExitProcess@4:  PROC
extern _MessageBoxW@16: PROC

.data
input  db "%s", 0
output db "%d", 0DH,0AH, 0
number db 100 dup (0)
mtitle dw 'A', 'k', 'o', 0

.code
wczytaj_EAX_U2_b14 PROC
    push ebp
    mov ebp, esp
    NUMSIZE = 24
    sub esp, NUMSIZE

    push OFFSET number
    push OFFSET input
    call _scanf
    add esp, 8

    push 14
    push OFFSET number
    call ntobin
    
    mov esp, ebp
    pop ebp
    ret
wczytaj_EAX_U2_b14 ENDP

wyswietl_EAX_U2_b14 PROC
    push ebp
    mov ebp, esp

    push 14
    push eax
    call binton
    add esp, 8

    push eax
    call ato16
    add esp, 4

    push 0
    push OFFSET mtitle
    push eax
    push 0
    call _MessageBoxW@16
    
    mov esp, ebp
    pop ebp
    ret
wyswietl_EAX_U2_b14 ENDP

_main PROC
    mov eax, -32326
    call wyswietl_EAX_U2_b14

    push 0
    call _ExitProcess@4
_main ENDP
END
