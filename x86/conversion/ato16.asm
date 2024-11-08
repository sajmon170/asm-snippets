.686
.model flat

public ato16

extern _calloc: PROC
extern _strlen: PROC

.code
; char* ato16(char* string)
ato16 PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, eax                ; set ebx as source pointer

    push ebx
    push esi

    push eax
    call _strlen
    add esp, 4 

    mov ecx, eax                ; set ecx as source length
    shl eax, 1                  ; multiply strlen(string) by two

    push ecx
    push eax
    call _calloc                ; set eax as destination
    add esp, 4
    pop ecx

    mov esi, 0                  ; set esi as source index
    while1:
        cmp esi, ecx
        je end_while1

        movzx dx, BYTE PTR [ebx + esi]
        mov [eax + 2*esi], dx
        
        inc esi
        jmp while1
    end_while1:

    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
ato16 ENDP
END
