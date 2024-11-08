.686
.model flat

extern _ExitProcess@4: PROC

.code
_main PROC
    mov ecx, 3003h
egz:
    dec cl
    jnc egz

    push 0
    call _ExitProcess@4
_main ENDP

END
