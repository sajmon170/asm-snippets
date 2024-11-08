.686
.model flat

public _main
extern _printf: PROC
extern _MessageBoxA@16: PROC
extern _ExitProcess@4: PROC

.data
tytul dw 'ar', 'ch', 'it', 'ek', 'tu', 'ra'
      db 20 dup (0) 
tekst dd 'ek', 'tu', 'ra'

.code
_main PROC
    push 0
    push OFFSET tytul +27
    push OFFSET tekst
    push 0
    call _MessageBoxA@16

    push 0
    call _ExitProcess@4
_main ENDP
END
