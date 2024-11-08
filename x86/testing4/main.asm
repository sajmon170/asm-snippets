.686
.model flat

public _main
extern _printf: PROC
extern _ExitProcess@4: PROC

.code
_main PROC
    push OFFSET "%d\n"
    call _printf
_main ENDP
END
