.686
.model flat

public _roznica
public _kopia_tablicy
public _komunikat
public _szukaj_elem_min
public _szyfruj
public _kwadrat
public _liczba_procesorow
public _iloraz

extern _ExitProcess@4: PROC
extern _GetSystemInfo@4: PROC
extern _printf: PROC
extern _malloc: PROC
extern _calloc: PROC

.data
blad_str db "Blad."
blad_len dd $ - OFFSET blad_str
buf      db 1000 dup (?)
float43  dd 4.3
float25  dd 2.5

.code
; int roznica(int* odjemna, int** odjemnik)
_roznica PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov eax, [eax]

    mov edx, [ebp + 12]
    mov edx, [edx]
    mov edx, [edx]

    sub eax, edx

    mov esp, ebp
    pop ebp
    ret
_roznica ENDP

; int* kopia_tablicy(int tabl[], unsigned n)
_kopia_tablicy PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov eax, [ebp + 12]
    shl eax, 2
    push eax
    call _malloc
    add esp, 4

    if_successful_malloc:
        cmp eax, 0
        je end_if

        mov edi, eax
        mov esi, [ebp + 8]

        mov ecx, [ebp + 12]
        et:
            mov ebx, [esi]
            mov [edi], ebx

            add esi, 4
            add edi, 4
        loop et
    end_if:
    
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_kopia_tablicy ENDP

; int strlen(char* str)
_strlen PROC
    push ebp
    mov ebp, esp

    push esi

    mov esi, [ebp + 8]
    mov eax, 0

    while1: 
        cmp BYTE PTR [esi + eax], 0
        je end_while1

        inc eax
        jmp while1
    end_while1:
    
    pop esi

    mov esp, ebp
    pop ebp
    ret
_strlen ENDP

; char* komunikat(char* tekst)
_komunikat PROC
    push ebp
    mov ebp, esp

    sub esp, 4

    push ebx
    push esi
    push edi

    mov eax, [ebp + 8]
    push eax
    call _strlen
    add esp, 4
    add eax, blad_len
    ; eax = (strlen(blad) + strlen(string))

    push eax
    call _malloc
    add esp, 4
    mov [ebp - 4], eax

    mov edi, eax
    mov esi, OFFSET blad_str

    mov ecx, blad_len
    et1:
        mov al, [esi]
        mov [edi], al

        inc esi
        inc edi
    loop et1

    mov esi, [ebp + 8]
    push esi
    call _strlen
    add esp, 4
    mov ecx, eax
    et2:
        mov al, [esi]
        mov [edi], al

        inc esi
        inc edi
    loop et2

    mov eax, [ebp - 4]

    pop edi
    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
_komunikat ENDP

; int* szukaj_elem_min(int tablica[], int n)
_szukaj_elem_min PROC
    push ebp
    mov ebp, esp

    push esi

    mov esi, [ebp + 8]
    mov eax, [esi]
    add esi, 4
    
    mov ecx, [ebp + 12]
    dec ecx

    et:
        smaller?:
            cmp [esi], eax
            jge continue
            mov eax, [esi]
        continue:
        add esi, 4
    loop et

    pop esi

    mov esp, ebp
    pop ebp
    ret
_szukaj_elem_min ENDP

; int next_random(int previous)
next_random PROC
    push ebx
    xor ebx, ebx

    bt eax, 30
    setc bl

    bt eax, 31
    setc bh

    xor bl, bh
    xor bh, bh

    shl eax, 1
    and eax, ebx

    pop ebx
    ret
next_random ENDP

; void szyfruj(char* tekst)
_szyfruj PROC
    push ebp
    mov ebp, esp

    push esi

    mov eax, 052525252h
    call next_random

    mov esi, [ebp + 8]
    while1:
        cmp BYTE PTR [esi], 0
        je end_while1

        xor [esi], al
        call next_random

        inc esi
        jmp while1
    end_while1:

    xor [esi], al
    
    pop esi

    mov esp, ebp
    pop ebp
    ret
_szyfruj ENDP

; unsigned kwadrat(unsigned a)
_kwadrat PROC
    push ebp
    mov ebp, esp

    push ebx

    mov ebx, [ebp + 8]

    if_0:
        cmp ebx, 0
        jne if_1
        mov eax, 0
        jmp exit
    if_1:
        cmp ebx, 1
        jne end_if
        mov eax, 1
        jmp exit
    end_if:

    add ebx, ebx
    add ebx, ebx
    sub ebx, 4        ; ebx = 4*arg - 4

    mov eax, [ebp + 8]
    sub eax, 2
    push eax
    call _kwadrat
    add esp, 4

    add eax, ebx
    
exit:
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_kwadrat ENDP

_iteracja PROC
    push ebp
    mov ebp, esp
    mov al, [ebp+8]
    sal al, 1
    ; SAL wykonuje przesuniecie logiczne
    ; w lewo
    jc zakoncz
    inc al
    push eax
    call _iteracja
    add esp, 4
    pop ebp
    ret

    zakoncz:
    rcr al, 1
    ; rozkaz RCR wykonuje przesunięcie
    ; cykliczne w prawo przez CF
    pop ebp
    ret
_iteracja ENDP

; void memcpy(void* dest, void* src, int size)
_asmcpy PROC
    push ebp
    mov ebp, esp

    push esi
    push edi

    mov ecx, [ebp + 16]
    mov edi, [ebp + 8]
    mov esi, [ebp + 12]
    rep movsb    

    pop edi
    pop esi

    mov esp, ebp
    pop ebp
    ret
_asmcpy ENDP

_liczba_procesorow PROC
    SYSTEM_INFO_SZ = (8*4 + 2*2)
    PROCESSOR_POS  = (5*4)

    push ebp
    mov ebp, esp

    sub esp, 4

    push SYSTEM_INFO_SZ
    call _malloc
    add esp, 4
    
    mov [ebp - 4], eax

    push eax
    call _GetSystemInfo@4

    mov eax, [ebp - 4]
    mov eax, [eax + PROCESSOR_POS]

    mov esp, ebp
    pop ebp
    ret
_liczba_procesorow ENDP

_iloraz PROC
    push ebp
    mov ebp, esp

    sub esp, 4
    
    finit
    NUM1 = 01000000100000000000000000000000b
    NUM2 = 11000000000000000000000000000000b
    mov DWORD PTR [ebp - 4], NUM1
    fld DWORD PTR [ebp - 4]
    mov DWORD PTR [ebp - 4], NUM2
    fld DWORD PTR [ebp - 4]
    fdiv
    fst DWORD PTR [ebp - 4]

    mov eax, [ebp - 4]

    mov esp, ebp
    pop ebp
    ret
_iloraz ENDP

; void pole_kola(float*)
_pole_kola PROC
    push ebp
    mov ebp, esp

    sub esp, 4

    mov eax, [ebp + 8]
    mov eax, [eax]
    mov [ebp - 4], eax

    finit
    fld DWORD PTR [ebp - 4]
    fld st(0)
    fmulp
    fldpi
    fmulp
    fst DWORD PTR [ebp - 4]

    mov eax, [ebp + 8]
    mov ecx, [ebp - 4]
    mov [eax], ecx

    mov esp, ebp
    pop ebp
    ret
_pole_kola ENDP

; void f32to64(float* src, double* dest)
_f32to64 PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov esi, [ebp + 8]
    mov edi, [ebp + 12]
    mov DWORD PTR [edi], 0
    mov DWORD PTR [edi + 4], 0
    
    mov ebx, [esi]              ; kopia
    mov eax, ebx                ; maska

; Zapisanie bitu znaku
    shr eax, 31
    shl eax, 31
    or [edi + 4], eax

; Zapisanie wykładnika
    mov eax, ebx
    shl eax, 1
    shr eax, 1+24
    shl eax, 32 - (1+11)
    or [edi + 4], eax

; Zapisanie pierwszej części mantysy
    mov eax, ebx
    shl eax, 8
    shr eax, 8+4
    or [edi + 4], eax

; Zapisanie drugiej części mantysy
    mov eax, ebx
    shl eax, 8
    shr eax, 8+20
    shl eax, 32 - 4
    or [edi], eax

    pop edi
    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
_f32to64 ENDP

_test PROC
    push ebp
    mov ebp, esp

    finit
    fld float43
    fsub float25
    
    mov esp, ebp
    pop ebp
    ret
_test ENDP

END
