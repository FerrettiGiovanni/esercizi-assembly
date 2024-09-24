#Implementare la somma di due numeri definiti in memoria e riportare il risultato nel registro $t0

.text
.globl main

main:
	lw $t1,pippo # Carica il valore memorizzato nell'etichetta 'pippo' nel registro $t1
	lw $t2,paperino # Carica il valore memorizzato nell'etichetta 'paperino' nel registro $t2
	add $t0,$t1,$t2 # Somma i valori nei registri $t1 e $t2, salva il risultato in $t0
	
li $v0, 10 # Carica il codice di sistema 10 (terminate il programma) nel registro $v0
syscall	# Esegui la system call per terminare il programma

.data 
pippo: .word 4 # Definisce la variabile 'pippo' e assegna il valore 4
paperino: .word 6 # Definisce la variabile 'paperino' e assegna il valore 6