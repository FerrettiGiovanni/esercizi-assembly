#Si scriva un programma in linguaggio assembly che definito un valore intero in memoria
# riporti in $t0 l’intero precedente, in $t1 il numero corrente e in $t2 il successivo

.text
.globl main

main:
	lw $t1, valore # inserisco la word nel registro $t1 prendendo il valore dalla memoria dati
	sub $t0, $t1, 1 # nel registro $t0 inserisco il risultato della sottrazione fra $t1 e 1
	addi $t2, $t1, 1 # nel registro $t2 sommo il valore in $t1 a 1

li $v0, 10
syscall #termino il programma
	
	
.data
	valore: .word 34 #valore nella memoria dati