# Realizzare un contatore da 0 a 100

.text
.globl main

main:
	lw $t0, numeroA # Inserisco nel registro $t0 il valore contenuto in numeroA
	lw $t1, numeroArrivo #Inserisco nel registro $t1 il valore contenuto in numeroArrivo
	
ciclo: # Qua viene implementata la logica di ciclo simile ad un while
	beq $t0, $t1, fine # Verifico se il valore del registro $t0 è uguale a $t1, se sì vado a "fine" (Salto Condizionato)
	addi $t0, $t0, 1 #Se non vado a fine, incremento il valore nel registro $t0
	j ciclo # eseguo un salto incondizionato per permettere al programma di ciclare
	
fine:
	sw $t0, numeroA # Inserisco la word contenuta in $t0 nella parte di memoria dati "numeroA"
	li $v0, 10 # Concludo il programma a terminale
	syscall
		

.data
	numeroA: .word 0 
	numeroArrivo: .word 100
