# Provare a fare un programma in Assembly dove definisco due byte, 100 e 101 fare la somma e vedere cosa esce

.text
.globl main

main:
	lb $t0, pippo # Inserisco il valore che è nella memoria dati, nel registro $t0 come dato di tipo byte
	lb $t1, paperino # Inserisco il valore che è nella memoria dati, nel registro $t1 come dato di tipo byte
	add $t2, $t1, $t0 #eseguo la somma dei valori con il comando add
	
li $v0, 10 # Carica il codice di sistema 10 (terminate il programma) nel registro $v0
syscall	

.data
	pippo: .byte 100 # assegno alla variabile pippo il valore 100
	paperino: .byte 101 #assegno alla variabile paperino il valore 101