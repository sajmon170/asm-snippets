.686
.model flat

public _main

extern _ExitProcess@4: PROC
extern _printf: PROC

.data
db 9 dup(?)
number dd 3.0

sizex = 10
sizey = 20
array dd sizex*sizey dup(?)
fmt   db "%f", 0Dh, 0Ah, 0

.code
; void initarray(int* asmarray, int sizex, int sizey)
initarray PROC
    push ebp
    mov ebp, esp

    mov edi, [ebp + 8]          ; array

    mov ecx, [ebp + 12]
    mul DWORD PTR [ebp + 16]
    mov edx, 0

    et:
        mov [edi + 4*edx], edx
        inc edx
    loop et

    mov esp, ebp
    pop ebp
    ret
initarray ENDP

_main PROC
    comment ! 
    ;Lea r32,[4*mem+coś]
    ;Jb etc
    ;Movzx r32,r16
    ;Etc:

    nop
    nop
    nop

;   lea eax, [0]
    db 10001101b, 00000101b, 0, 0, 0, 0
;   jb etc
    db 01110010b, 00000011b
;   movzx eax, cx
    db 00001111b, 10110111b, 11000001b
etc:
!
    et:
	nop
	nop
	nop
	loop et
    
    push 0
    call _ExitProcess@4
_main ENDP

END
