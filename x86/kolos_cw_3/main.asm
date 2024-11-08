.686
.model flat

public _main
extern _ExitProcess@4: PROC

.code
_main PROC
    db 01110101b, 00001000b
    db 66h, 10001011b, 00100100b, 10110101b, 34h, 12h, 00h, 00h
    db 66h, 00000001b, 01011100b, 00100100b, 0FEh
    
    push 0
    call _ExitProcess@4
_main ENDP
END
