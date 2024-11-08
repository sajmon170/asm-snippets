.686
.model flat

extern _ExitProcess@4: PROC
public _generate

.data
state dd 15

.code
_generate PROC
	push ebp
	mov ebp, esp

	push ebx

	mov eax, state
	mov ebx, 69069
	mul ebx
	inc eax
	mov ebx, 1
	shl ebx, 31
	div ebx

	mov state, edx
	mov eax, edx
	
	pop edi

	mov esp, ebp
	pop ebp
	ret
_generate ENDP
END
