.686
.model flat

public strlen
public wstrlen
public atoutf16
public utf16toa
public transform
public decode
public encode
public uppercase

extern _calloc: PROC

.code

; int strlen(char* string)
strlen PROC
    push ebp
    mov ebp, esp

    push ebx

    mov eax, 0
    mov ebx, [ebp + 8]
    begin:
        cmp BYTE PTR [ebx + eax], 0
        jz end_loop
        inc eax
        jmp begin
    end_loop:

    pop ebx

    mov esp, ebp
    pop ebp
    ret
strlen ENDP

; int wstrlen(wchar_t* string)
wstrlen PROC
    push ebp
    mov ebp, esp

    push ebx

    mov eax, 0
    mov ebx, [ebp + 8]
    begin:
        cmp WORD PTR [ebx + 2*eax], 0
        jz end_loop
        inc eax
        jmp begin
    end_loop:

    pop ebx

    mov esp, ebp
    pop ebp
    ret
wstrlen ENDP

; wchar_t* ato16(char* string)
atoutf16 PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, eax                ; set ebx as source pointer

    push ebx
    push esi

    push eax
    call strlen
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
atoutf16 ENDP

;char* 16toa(wchar_t* string)
utf16toa PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, eax                ; set ebx as source pointer

    push ebx
    push esi

    push eax
    call wstrlen
    add esp, 4 

    mov ecx, eax                ; set ecx as source length

    push ecx
    push eax
    call _calloc                ; set eax as destination
    add esp, 4
    pop ecx

    mov esi, 0                  ; set esi as source index
    while1:
        cmp esi, ecx
        je end_while1

        mov dx, WORD PTR [ebx + 2*esi]
        mov [eax + esi], dl
        
        inc esi
        jmp while1
    end_while1:

    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
utf16toa ENDP

; int transform(char* data, void (func*)(char*))
transform PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi

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

    pop esi
    pop ebx

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
