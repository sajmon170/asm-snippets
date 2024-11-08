.686
.model flat

public _main

extern _ExitProcess@4: PROC

.data
float dd 01000000111110000000000000000000b

.code

_main PROC
    fld DWORD PTR float

    push 0
    call _ExitProcess@4
_main ENDP

END
