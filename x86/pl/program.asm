.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data
tekst db 10, 'Nazywam si', 0A9H, '...', 10
	  db 'M', 0A2H, 'j pierwszy 32-bitowy program '
	  db 'asemblerowy dzia', 088H, 'a ju', 0BEH, ' poprawnie', 10, 0

.code
_main PROC
	  mov ecx, 85

	  push ecx
	  push dword PTR OFFSET tekst
	  push dword PTR 1
	  call __write
	  add esp, 12

	  push dword PTR 0
	  call _ExitProcess@4
_main ENDP
END
