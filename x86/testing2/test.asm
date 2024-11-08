.686
.model flat

extern _MessageBoxA@16	: PROC
extern _ExitProcess@4	: PROC
extern _printf		: PROC

public _main

.data
title  db "Window Title"
text   db "An integer %d and a string %s.", 0AH, 0
output db "%d", 0AH, 0
num    dd 123123
string db "wololo"

.code

factorial PROC
		  enter 0, 0
		  mov eax, 1
		  mov ebx, [ebp+8]

	  add esp, 8
		  loop1:
		      mul ebx
			  dec ebx
			  cmp ebx, 1
			  jne loop1

		  leave
		  ret
factorial ENDP

foldr PROC
	  enter 0, 0
	  
	  leave
	  ret
foldr ENDP

fib PROC
	enter 2, 0
	mov [esp - 4], DWORD PTR 1
	mov [esp - 8], DWORD PTR 1
	
	cmp [esp + 8], DWORD PTR 1
	je exit
	cmp [esp + 8], DWORD PTR 8

	mov eax, [esp - 4]
	add eax, [esp - 8]
	je exit
	
exit:
	leave
	ret
fib ENDP

_main PROC
	  push 10
	  call factorial
	  add esp, 4

	  push eax
	  push OFFSET output
	  call _printf
	  add esp, 8

	  push 0
	  call _ExitProcess@4
_main ENDP
END
