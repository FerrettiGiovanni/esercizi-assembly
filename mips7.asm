# Scrivere un programma che definito in memoria il prezzo al dettaglio e lo sconto e riporta in
# $t2 il prezzo scontato (arrotondato all’intero)
# 25:100=x:124

.text
.globl main

main:
	lw $t0, dettaglio # Carica il prezzo al dettaglio dalla memoria in $t0
	lw $t1, sconto # Carica lo sconto dalla memoria in $t1
	mul $t2, $t0, $t1 # Moltiplica il prezzo al dettaglio ($t0) per lo sconto ($t1)
	div $t2, $t2, 100 # Divide il risultato ($t2) per 100 per calcolare il valore dello sconto
    			  # Questo valore ora rappresenta lo sconto applicato al prezzo

li $v0, 10
syscall	# Termino il programma

.data
	dettaglio: .word 124
	sconto: .word 25