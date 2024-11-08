.686
.model flat

extern _printf: PROC
extern _ExitProcess@4: PROC

.data
array dd -5, 20, 34, -40, 5, 324, 2, 15
len   dd ($ - OFFSET array)/4
fmt   db "%d ", 0
clrf  db 0Dh, 0Ah, 0

.code
swap PROC
    push ebp
    mov ebp, esp

    push eax
    push ebx
    push ecx
 
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, [ebx]

    xchg [eax], ecx
    xchg [ebx], ecx

    pop ecx
    pop ebx
    pop eax
    
    mov esp, ebp
    pop ebp
    ret
swap ENDP

;arg1 = array, arg2 = size
insertionSort PROC
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]          ; esi = array
    
    mov eax, 0
    begin_outer:
        cmp eax, len
        je end_outer

        mov edi, eax
        begin_inner:
            cmp edi, len
            je end_inner

            mov ebx, [esi + 4*eax]
            cmp [esi + 4*edi], ebx
            jnl skip

            lea ecx, [esi + 4*eax]
            push ecx
            lea ecx, [esi + 4*edi]
            push ecx
            call swap
            add esp, 8
            
            skip:
            inc edi
            jmp begin_inner
        end_inner:
        
        inc eax
        jmp begin_outer
    end_outer:
    
    mov esp, ebp
    pop ebp
    ret
insertionSort ENDP

;arg1 = array, arg2 = size
printArray PROC
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]
    
    mov eax, 0
    begin_loop:
        cmp eax, [ebp + 12]
        je end_loop

        push eax
        push esi
        
        push [esi + 4*eax]
        push OFFSET fmt
        call _printf
        add esp, 8

        pop esi
        pop eax 
        
        inc eax
        jmp begin_loop
    end_loop:

    push OFFSET clrf
    call _printf
    add esp, 4

    mov esp, ebp
    pop ebp
    ret
printArray ENDP

_main PROC
    push len
    push OFFSET array
    call printArray
    add esp, 8

    push len
    push OFFSET array
    call insertionSort
    add esp, 8

    push len
    push OFFSET array
    call printArray
    add esp, 8

    push 0
    call _ExitProcess@4
_main ENDP
END
