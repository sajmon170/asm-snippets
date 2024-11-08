.686
.model flat

extern addlong: PROC
extern _scanf:  PROC
extern _printf: PROC
extern _ExitProcess@4: PROC

.data
A   db 1000 dup (0)
B   db 1000 dup (0)
fmt db "%s", 0
nl  db 0Dh, 0Ah, 0 

.code
_main PROC
    push OFFSET A
    push OFFSET fmt
    call _scanf
    add esp, 8

    push OFFSET B
    push OFFSET fmt
    call _scanf
    add esp, 8

    push OFFSET A
    push OFFSET B
    call addlong
    add esp, 8

    push eax
    call _printf
    add esp, 4

    push OFFSET nl
    call _printf
    add esp, 4

    push 0
    call _ExitProcess@4
_main ENDP
END
