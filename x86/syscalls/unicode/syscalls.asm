.686
.model flat
extern _ExitProcess@4   : PROC
extern _MessageBoxW@16  : PROC
public _main

.data
header		dw 'H', 'e', 'l', 'l', 'o', 0
;content	dw 0D83DH, 0DC08H, 0
content		dw 0D80CH, 0DD68H, 0

.code
_main PROC
      mov ecx, 85
	  
      push 0
      push OFFSET header
      push OFFSET content
      push 0
      call _MessageBoxW@16
      add esp, 16
	  
      push dword PTR 0
      call _ExitProcess@4
_main ENDP
END
