.686
.model flat

public binton
extern _malloc: PROC

.data

.code
; coverts an int from CL to a char
encode_dl PROC
    cmp dl, 9
    jg to_text
    to_num:
        add dl ,'0'
        jmp to_end
    to_text:
        add dl, 'A' - 10
    to_end:
    ret
encode_dl ENDP

; char* binton(int number, int base)
binton PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ecx, 0

    while1:
        cmp eax, 0
        je end_while1

        xor edx, edx
        div DWORD PTR [ebp + 12]
        push edx
        
        inc ecx
        jmp while1
    end_while1:

    push ecx
    call _malloc
    pop ecx

    mov edi, 0
    while2:
        cmp edi, ecx
        je end_while2

        pop edx
        call encode_dl
        mov [eax + edi], dl
        
        inc edi
        jmp while2
    end_while2:

    mov BYTE PTR [eax + edi], 0
    
    mov esp, ebp
    pop ebp
    ret
binton ENDP
END
