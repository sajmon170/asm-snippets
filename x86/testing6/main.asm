.686
.model flat

public _main

extern _printf: PROC
extern _ExitProcess@4: PROC

.data
msg  db "MyName"
temp dd $ - msg

.code
_main PROC
    mov ax, 8000h
    neg ax
    
    push 0
    call _ExitProcess@4
_main ENDP
END
