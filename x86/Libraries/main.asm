.686
.model flat

public _main
extern strlen : PROC
extern _ExitProcess@4 : PROC
extern _printf : PROC

.data
test_str db "12345", 0
format   db "%d", 0DH, 0AH, 0

.code
_main PROC
	push OFFSET test_str
	call strlen
	add esp, 4

	push eax
	push OFFSET format
	call _printf
	add esp, 4

	push 0
	call _ExitProcess@4
_main ENDP
END
