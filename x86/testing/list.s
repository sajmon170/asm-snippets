# PURPOSE: This program finds the largest number in a static list

# Variables:
#
# %edi - holds the list index
# %ebx - holds the largest value
# %eax - holds current item
#
# items - contains the list data, with 0 as a final value


.section .data
items:
	.long 4, 1, 5, 123, 12, 8, 9, 234, 78, 0


.section .text

.globl _start
_start:
	movl $0, %edi                      #movl - move long
	movl items(, %edi, 4), %eax        #indexed addressing mode
	movl %eax, %ebx                    #general syntax: ARRAY(, INDEX, WORD_SIZE),

loop:
	cmpl $0, %eax                      #cmpl - compare long, stores comparison in the %eflags register
	je   exit                          #je   - jump if equal, uses data from $eflags register
	incl %edi                          #incl - increment long
	movl items(, %edi, 4), %eax
	cmpl %ebx, %eax
	jle  loop                          #jle  - jump if <=
	movl %eax, %ebx
	jmp  loop                          #jmp  - unconditional jump

exit:
	movl $1, %eax
	int  $0x80                         #int  - interrupt (not integer!!!)
