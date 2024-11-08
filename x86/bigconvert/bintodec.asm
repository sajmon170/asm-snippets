.686
.model flat

public bintodec
extern _malloc:  PROC

.code
; char* bintodec(int num)
bintodec PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]          ; number
    mov ebx, 10
    mov ecx, 0

    while1:
        mov edx, 0
        cmp eax, 0
        je end_while1

        div ebx
        push edx
        
        inc ecx
        jmp while1
    end_while1:
    
    inc ecx 
    push ecx
    call _malloc
    pop ecx
    dec ecx

    mov edi, 0
    while2:
        cmp edi, ecx
        je end_while2

        pop ebx
        add ebx, '0'
        mov BYTE PTR [eax + edi], bl

        inc edi
        jmp while2
    end_while2:

    mov BYTE PTR [eax + edi], 0
    
    mov esp, ebp
    pop ebp
    ret
bintodec ENDP
END
