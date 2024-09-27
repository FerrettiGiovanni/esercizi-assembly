# Realizzare un programma che valuta il massimo fra due numeri x, y di tipo byte
# definiti in memoria. Riportare il risultato in memoria.

.text
.globl main

main:
	lb $t0, NumeroA # carico il dato di NumeroA
	lb $t1, NumeroB # carico il dato del secondo
	move $t2, $t1 #sposto il valore da un indirizzo ad un altro
	blt $t0, $t1, Max # eseguo un confronto
	move $t2, $t0 # sposta in caso di necessità
	
li $v0, 10
syscall

.data
	NumeroA: .byte 4
	NumeroB:.byte 5
	Max: .byte 0