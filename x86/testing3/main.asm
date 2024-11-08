.686
.model flat

public _main

extern atoutf16: PROC
extern utf16toa: PROC
extern wstrlen:  PROC
extern strlen:   PROC
extern _printf:  PROC

; StdCall
extern _ExitProcess@4:  PROC
extern _MessageBoxW@16: PROC
extern _MessageBoxA@16: PROC

.data
string db "This is a string", 0
fmt db "%d", 0Dh, 0Ah, 0

.code
_main PROC
    mov ebp, esp
    sub esp, 4

    push OFFSET string
    call atoutf16
    add esp, 4
    
    push eax
    call utf16toa
    add esp, 4

    push 0
    push eax
    push eax
    push 0
    call _MessageBoxA@16

    push 0
    call _ExitProcess@4
_main ENDP
END
