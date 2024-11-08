.global main

.data
my_str: .string "Hello, world!\n"
LEN = . - my_str

.text
print_array:
	# return address
	mv s3, ra

	# current pos
	mv s0, a0

	# final address
	addi s1, s0, LEN

loop:
	lb a0, 0(s0)
	call putchar
	addi s0, s0, 1
	bne s0, s1, loop

	mv ra, s3
	jalr x0, ra


main:
	la a0, my_str
	jal ra, print_array

	addi a0, x0, 0
	addi a7, x0, 93
	ecall
