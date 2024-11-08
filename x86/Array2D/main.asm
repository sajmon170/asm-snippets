.686
.model flat

extern _ExitProcess@4 : PROC
extern _printf        : PROC
; modyfikuje: eax, ecx

.data
integer db "%3d ", 0
newline db 0DH, 0AH, 0

sizex = 10
sizey = 20
array dd (sizex * sizey) dup (?)
len   = $ - OFFSET array

; arg1 = array, arg2 = sizex, arg3 = sizey
.code
fill2d PROC
    push ebp
    mov ebp, esp
    sub esp, 12

    mov ebx, [ebp + 8]          ; array
    mov edi, 0                  ; iter_y

    outer:
        cmp edi, [ebp + 16]     ; sizey
        jge end_outer

        mov ecx, 0              ; iter_x
        inner:
            cmp ecx, [ebp + 12] ; sizex
            jge end_inner

            mov eax, ecx
            mul edi
            mov [ebx + 4*eax], eax
            
            push ecx
            push [ebx + 4*eax]
            push OFFSET integer
            call _printf
            add esp, 8
            pop ecx
            
            inc ecx
            jmp inner
        end_inner:

        lea esi, [ecx + eax] 
        push esi
        push OFFSET newline
        call _printf
        add esp, 8

        inc edi
        jmp outer
    end_outer:
    
    mov esp, ebp
    pop ebp
    ret
fill2d ENDP

_main PROC
    push sizey
    push sizex
    push OFFSET array
    call fill2d
    add esp, 12

    push 0
    call _ExitProcess@4
_main ENDP
END
