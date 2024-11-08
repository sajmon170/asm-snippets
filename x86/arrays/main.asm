.686
.model flat

extern _ExitProcess@4 : PROC

.data
array db (10 * 20) dup (?)

.code
;arg1 = byte* array, arg2 = sx, arg3 = sy
fillarray PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]

    begin:
    
    jmp begin
    
    mov esp, ebp
    pop ebp
fillarray ENDP

_main PROC
_main ENDP
