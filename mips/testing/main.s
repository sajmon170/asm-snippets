.text
.global __start
__start:
  # Exit.
  move $a0, $zero
  dli $v0, 5058
  syscall
