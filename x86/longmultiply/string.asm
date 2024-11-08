.686
.model flat

public strlen
public transform
public decode
public encode
public uppercase

.data

.code
; int strlen(char* string)
strlen PROC
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [ebp + 8]
    mov eax, 0
    iterate:
        cmp BYTE PTR [ebx + eax], 0
        je end_iterate

        inc eax
        jmp iterate
    end_iterate:

    pop ebx
    mov esp, ebp
    pop ebp
    ret
strlen ENDP

; int transform(char* data, void (func*)(char*))
transform PROC
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    mov esi, 0
    iterate:
        cmp BYTE PTR [ebx + esi], 0
        je end_iterate

        lea eax, [ebx + esi]
        push eax
        call DWORD PTR [ebp + 12]
        add esp, 4
        
        inc esi
        jmp iterate
    end_iterate:

    mov eax, esi

    mov esp, ebp
    pop ebp
    ret
transform ENDP

; void decode(char* character)
decode PROC
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]
    mov cl, [eax]
    
    cmp cl, '9'
    jg if_text
    if_number:
        sub cl, '0'
        jmp end_if
    if_text:
        sub cl, 'A'
        add cl, 10
    end_if:

    mov [eax], cl
    
    popa
    mov esp, ebp
    pop ebp
    ret
decode ENDP

; void encode(byte* character)
encode PROC
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]
    mov cl, [eax]
    
    cmp dl, 9
    jg to_text
    to_num:
        add dl ,'0'
        jmp to_end
    to_text:
        add dl, 'A' - 10
    to_end:

    mov [eax], cl
    
    popa
    mov esp, ebp
    pop ebp
    ret
encode ENDP

uppercase PROC
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]
    mov cl, [eax]

    cmp cl, 'a'
    jnge end_if
    if_lowercase:
        sub cl, 'a' - 'A'
        mov [eax], cl
    end_if:

    popa
    mov esp, ebp
    pop ebp
    ret
uppercase ENDP
END
