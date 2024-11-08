.global main


.data
# Convolution data padded with zeros
padded_nums:
.word 0,  0,  0,  0,  0,  0,  0,  0
.word 0,  0,  0,  0,  0,  0,  0,  0
nums:
.word 1,  2,  3,  4,  5,  6,  7,  8
.word 9,  10, 11, 12, 13, 14, 15, 16
.word 17, 18, 19, 20, 21, 22, 23, 24
.word 25, 26, 27, 28, 29, 30, 31, 32
.equ PADDED_SZ, 48
.equ NUM_SZ, 32
padded_end:

# Convolution kernel
kernel:
.word 1,  1,  1,  1,  1,  1,  1,  1
.word 1,  1,  1,  1,  1,  1,  1,  1
.equ KERN_SZ, 14
kernel_end:

fmt:
.string "%d "

.bss
# Convolution result
.lcomm result, NUM_SZ * 4
.equ result_end, result + NUM_SZ * 4


.text
main:
	# Register map:
	# r1 - data start ptr
	# r2 - const data end ptr
	# r3 - kernel start ptr
	# r4 - const kernel end ptr
	# r5 - result ptr
	# 
	# r6 - calculation result
	# r7 - current data ptr
	# r8 - data[current data ptr]
	# r9 - kernel[current kernel ptr]
	# r10 - current kernel ptr

	la r1, padded_nums + 4
	la r2, padded_end
	la r3, kernel
	la r4, kernel_end
	la r5, result
	
outer:
	add r6, r0, r0
	mv r7, r1
	mv r10, r3
	
	inner:
		lw r8, 0(r7)
		lw r9, 0(r10)

		mul r8, r8, r9
		add r6, r6, r8

		addi r7, r7, 4
		addi r10, r10, 4
		bne r10, r4, inner

	sw r6, 0(r5)
	addi r5, r5, 4
	addi r1, r1, 4
	bne r1, r2, outer

	la r1, fmt
	la r2, result
	la r3, result_end
print_array:
	mv a0, r1
	lw a1, 0(r2)
	call printf
	addi r2, r2, 4
	bne r2, r3, print_array
	
	li a0, '\n
	call putchar
	
	addi a0, r0, 0
	addi a7, r0, 93
	ecall
