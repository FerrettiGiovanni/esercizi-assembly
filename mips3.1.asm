# Scambio dei valori contenuti in due registri

.text
.globl main

main:
	lb $t0, pippo
	lb $t1, paperino
	move $t2, $t0
	move $t0, $t1
	move $t1, $t2
	xor $t2, $t2, $t2

li $v0, 10
syscall

.data
	pippo: .byte 1
	paperino: .byte 2