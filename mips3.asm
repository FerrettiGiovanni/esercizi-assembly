# Scambio dei valori contenuti in due registri

.text
.globl main

main:
	li $t0, 1
	li $t1, 2
	move $t2, $t0
	move $t0, $t1
	move $t1, $t2
	xor $t2, $t2, $t2

li $v0, 10
syscall