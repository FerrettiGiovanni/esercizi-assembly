# Realizzare un programma che valuta il massimo fra due numeri x, y di tipo byte
# definiti in memoria. Riportare il risultato in memoria.

.text
.globl main

main:
	lb $t0, numeroA # carico il dato di NumeroA
	lb $t1, numeroB # carico il dato del secondo
	move $t2, $t1 #definisco NumeroB nel registro $t1 e lo considero il valore massimo
	blt $t0, $t1, max_B # eseguo un confronto: se numeroA è più piccolo di numeroB, salto a max_B
	move $t2, $t0 # altrimenti sposto in $t2 il valore numeroA
	

max_B:
	sb $t2, max # metto $t2 nella memoria dati max
	li $v0, 10
	syscall # termino il programma

.data
	numeroA: .byte 4
	numeroB:.byte 5
	max: .byte 0
