.686
.model flat

public _multiply
extern _malloc: PROC
extern _printf: PROC

.data
fmt   db "%d ", 0
newln db 0Dh, 0Ah, 0

.code
; Matrix make_matrix(int a, int b)
_make_matrix PROC
    push ebp
    mov ebp, esp

    push ebx
    push edi

    mov eax, [ebp + 16]
    shl eax, 2
    call _malloc                ; malloc(b * sizeof(int))
    add esp, 4
    
    mov ebx, [ebp + 8]          ; return address
    mov [ebx + 0], eax

    mov eax, [ebp + 12]         ; a
    mov [ebx + 4], eax

    mov eax, [ebp + 16]
    mov [ebx + 8], eax          ; b

    mov eax, [ebp + 12]
    shl eax, 2
    push eax
    mov ebx, [ebx]
    mov edi, 0
    begin_while:
        cmp edi, [ebp + 16]
        je end_while

        call _malloc
        mov [ebx + 4*edi], eax

        inc edi
        jmp begin_while
    end_while:
    add esp, 4

    pop edi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
_make_matrix ENDP

; void print_matrix(Matrix m)
_print_matrix PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov ebx, [ebp + 8]
    mov esi, 0                  ; y_iter
    while1:
        cmp esi, [ebp + 16]
        je end_while1

        mov edi, 0              ; x_iter
        while2:
            cmp edi, [ebp + 12]
            je end_while2

            mov eax, [ebx + 4*esi]
            mov eax, [eax + 4*edi]

            push eax
            push OFFSET fmt
            call _printf
            add esp, 8
            
            inc edi
            jmp while2
        end_while2:

        push OFFSET newln
        call _printf
        add esp, 4

        inc esi
        jmp while1
    end_while1:

    pop edi
    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
_print_matrix ENDP

; Matrix multiply(Matrix a, Matrix b)
_multiply PROC
    push ebp
    mov ebp, esp

    sub esp, 16

    push ebx
    push esi
    push edi

    mov eax, [ebp + 12 + 20]    ; b.y
    push eax
    mov eax, [ebp + 12 + 4]     ; a.x
    push eax
    lea eax, [ebp - 12]
    push eax
    call _make_matrix
    add esp, 12

    mov eax, 0
    while1:
        cmp eax, [ebp + 12 + 4]
        je end_while1
        
        mov ebx, 0
        while2:
            cmp ebx, [ebp + 12 + 20]
            je end_while2

            mov ecx, 0
            mov DWORD PTR [ebp - 16], 0
            while3:
                cmp ecx, [ebp + 12 + 8] ; a.y
                je end_while3

                push eax

                mov esi, [ebp + 12]
                mov esi, [esi + 4*ecx]
                mov esi, [esi + 4*eax] ; a[ecx][eax]

                mov eax, esi
                
                mov esi, [ebp + 12 + 12]
                mov esi, [esi + 4*ebx]
                mov esi, [esi + 4*ecx] ; b[ebx][ecx]

                mul esi
                add [ebp - 16], eax    ; sum
                
                pop eax
                
                inc ecx
                jmp while3
            end_while3:

            mov edx, [ebp - 16]
            mov edi, [ebp - 12]
            mov edi, [edi + 4*ebx]
            mov [edi + 4*eax], edx ; c[ebx][eax]
            
            inc ebx
            jmp while2
        end_while2:

        inc eax
        jmp while1
    end_while1:

    mov edi, [ebp + 8]

    mov eax, [ebp - 12]
    mov [edi + 0], eax
    
    mov eax, [ebp - 8]
    mov [edi + 4], eax

    mov eax, [ebp - 4]
    mov [edi + 8], eax

    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_multiply ENDP
END
