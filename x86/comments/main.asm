.686
.model flat

public _main
public _uncomment

extern _printf: PROC
extern _ExitProcess@4: PROC

.data

string db "This is a string with /*a comment*/, //another comment", 0Dh, 0Ah
       db "/* another /* // comment */ Hello /* // inside a comment", 0Dh, 0Ah
       db "and it*/ also has // this and /*that*/ //", 0Dh, 0Ah
       db "and that's /* pretty cool.", 0Dh, 0Ah
       db "// ", 0

.code

remove_region PROC
    push esi
    inc ecx
    while1:
        mov al, [ecx]
        mov [esi], al
        
        if_null:
            cmp al, 0
            jne end_if

            while2:
                cmp BYTE PTR [esi + 1], 0
                je end_while2

                mov BYTE PTR [esi + 1], 0
                inc esi
                jmp while2
            end_while2:

            jmp end_while1
        end_if:

        inc esi
        inc ecx
        jmp while1
    end_while1:
    pop esi
    ret
remove_region ENDP

; esi: begin, ecx: pos
remove_single_line PROC
    mov ecx, esi
    while1:
        if_eof:
            cmp BYTE PTR [ecx], 0
            je remove
        if_cr:
            cmp BYTE PTR [ecx], 0Dh
            jne end_if
        if_comment_end:
            cmp BYTE PTR [ecx + 1], 0Ah
            jne end_if
        remove:
            dec ecx
            push ecx
            push esi
            call remove_region
            add esp, 8
            jmp end_while1
        end_if:

        inc ecx
        jmp while1
    end_while1:
    ret
remove_single_line ENDP

; esi: begin, ecx: end
remove_multiline PROC
    mov ecx, esi
    while1:
        if_mark:
            cmp BYTE PTR [ecx], '*'
            jne if_eof
        if_comment_end:
            cmp BYTE PTR [ecx + 1], '/'
            jne if_eof

            inc ecx
            push ecx
            push esi
            call remove_region
            add esp, 8
            jmp end_while1
        if_eof:
            cmp BYTE PTR [ecx], 0
            jne end_if

            jmp end_while1
        end_if:

        inc ecx
        jmp while1
    end_while1:
    ret 
remove_multiline ENDP

; void uncomment(char* string)
_uncomment PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi
    
    mov esi, [ebp + 8]
    mov eax, 0

    while1:
        cmp BYTE PTR [esi], 0
        je end_while1

        if_slash:
            cmp BYTE PTR [esi], '/'
            jne end_if
        if_single_line:
            cmp BYTE PTR [esi + 1], '/'
            jne if_multiline

            call remove_single_line
            
            jmp end_if
        if_multiline:
            cmp BYTE PTR [esi + 1], '*'
            jne end_if

            call remove_multiline

            jmp end_if
        end_if:
        
        inc esi
        jmp while1
    end_while1:
    
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_uncomment ENDP

_main PROC
    push OFFSET string
    call _uncomment
    add esp, 4

    push OFFSET string
    call _printf
    add esp, 4
    
    push 0
    call _ExitProcess@4
_main ENDP

END
