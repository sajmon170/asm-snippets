.686
.model flat

extern _printf:        PROC
extern _malloc:        PROC
extern _free:          PROC
extern _ExitProcess@4: PROC

.data
array dd -5, 12, 58, -4, 3, 0, 8, 39, 32, 12, 43, -34

split dd -20, -4, 0, 12, -3, -1, 21
ssize dd $ - OFFSET split
mid   dd 4

asize dd ($ - OFFSET array) / 4

.code
;void copy(int* dest, int* source, int size)
copy PROC
    push ebp
    mov ebp, esp

    mov esi, [ebp + 12]
    mov edi, [ebp + 8]
    mov ecx, [ebp + 16]

    rep movsb
    
    mov esp, ebp
    pop ebp
    ret
copy ENDP

;void merge(int* array, int split, int size)
merge PROC
    push ebp
    mov ebp, esp
    sub esp, 6 * 4

    mov eax, [ebp + 8]
    mov [ebp - 4], eax          ; int* pos1

    add eax, [ebp + 12]
    mov [ebp - 8], eax          ; int* pos2

    mov eax, [ebp + 16]
    mov ebx, 4
    mul ebx
    push eax
    call _malloc
    add esp, 4
    mov [ebp - 12], eax         ; int* temp

    mov DWORD PTR [ebp - 16], 0           ; int i
    mov DWORD PTR [ebp - 20], 0           ; int j
    mov DWORD PTR [ebp - 24], 0           ; int k
    mov edx, [ebp + 16]
    sub edx, [ebp + 12]         ; size - split

    begin_loop1:
        mov eax, [ebp - 16]
        cmp eax, [ebp + 12]
        jge end_loop1           ; i < split

        mov eax, [ebp - 20]
        cmp ebx, edx
        jge end_loop1           ; j < size - split

        lea ecx, [ebp - 4]
        mov edx, [ebp - 16]
        mov eax, [ecx + edx]    ; pos1[i]
        lea ecx, [ebp - 8]
        mov edx, [ebp - 20]
        mov ebx, [ebx + edx]    ; pos2[j]
        
        mov ecx, [ebp - 12]
        mov edi, [ebp - 24]
        cmp eax, ebx
        begin_if1:
            jnle else_if1
            mov [ecx + edi], eax
            inc DWORD PTR [ebp - 16]
            inc DWORD PTR [ebp - 24]
            jmp end_if1
        else_if1:
            mov [ecx + edi], ebx
            inc DWORD PTR [ebp - 20]
            inc DWORD PTR [ebp - 24]
        end_if1:
        jmp begin_loop1
    end_loop1:

    begin_loop2:
        lea ebx, [ebp - 4]
        mov esi, [ebp - 16]
        cmp esi, [ebp + 12]
        jnle end_loop2
        
        mov eax, [ebp - 12]
        mov edi, [ebp - 24]

        mov ecx, [ebx + esi]
        mov [eax + edi], ecx

        inc DWORD PTR [ebp - 24]
        inc DWORD PTR [ebp - 20]
        jmp begin_loop2
    end_loop2:

    begin_loop3:
        lea ebx, [ebp - 8]
        mov esi, [ebp - 20]
        mov ecx, [ebp + 16]
        sub ecx, [ebp + 12]
        cmp esi, ecx
        jnle end_loop3
        
        mov eax, [ebp - 12]
        mov edi, [ebp - 24]

        mov ecx, [ebx + esi]
        mov [eax + edi], ecx

        inc DWORD PTR [ebp - 24]
        inc DWORD PTR [ebp - 16]
        jmp begin_loop3
    end_loop3:

    push [ebp + 16]
    push [ebp - 12]
    push [ebp + 8]
    call copy
    add esp, 12
    
    mov esp, ebp
    pop ebp
    ret
merge ENDP

_main PROC
    push ssize
    push mid
    push OFFSET split
    call merge
    add esp, 12
    
    push 0
    call _ExitProcess@4
_main ENDP
END
