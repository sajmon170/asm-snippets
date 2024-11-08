.686
.model flat

extern _ExitProcess@4 : proc
extern _scanf         : proc
extern _printf        : proc

public _main

argcount macro args:VARARG
    local cnt
    cnt = 0
    for item, <args>
    cnt = cnt + 1
    endm
    exitm %cnt
endm

printf macro args:vararg
    for arg, <args>
        push arg
    endm
    call _printf
    add esp, (4 * argcount(args))
endm

scanf macro args:vararg
    for arg, <args>
        push arg
    endm
    call _scanf
    add esp, (4 * argcount(args))
endm

ExitProcess macro
    push 0
    call _ExitProcess@4
endm

.data
range_0_10   db "0 <= %d < 10", 0DH, 0AH, 0
range_10_20  db "10 <= %d < 20", 0DH, 0AH, 0
range_20_inf db "%d >= 20", 0DH, 0AH, 0

lets_see     db "Let's see...", 0DH, 0AH, 0
favorite_num db "You've picked one of my favorite numbers!", 0DH, 0AH, 0
ur_num_sux   db "Your number sucks :(", 0DH, 0AH, 0

input_format db "%d", 0
var          dd ?

.code
_main proc
    scanf OFFSET var, OFFSET input_format

    .if var < 10
        printf var, OFFSET range_0_10
    .elseif var <= 20
        printf var, OFFSET range_10_20
    .else
        printf var, OFFSET range_20_inf
    .endif

    printf OFFSET lets_see

    .if var == 12 || var == 16
        printf OFFSET favorite_num
    .else
        printf OFFSET ur_num_sux
    .endif 

    ExitProcess
_main endp
end
