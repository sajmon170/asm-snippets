.686
.model flat

public _main

extern ato16: PROC
extern 8to16: PROC

extern _scanf: PROC
extern _MessageBoxW@16: PROC
extern _ExitProcess@4: PROC

.data
buffer db 1000 dup (?)

.code
_main PROC
    push OFFSET string
    call ato16
    add esp, 4

    push 0
    push eax
    push eax
    push 0
    call _MessageBoxW@16

    push 0
    call _ExitProcess@4
_main ENDP
END
