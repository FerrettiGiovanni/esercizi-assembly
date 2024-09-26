# Realizzare un programma che in linguaggio MIPS prenda un valore residente in memoria (di tipo byte) 
# e metta 0 o 1 se il numero è rispettivamente pari o dispari

.text
.globl main

main:
	lb $t0, valore #load byte prende il valore nella memoria dati e lo inserisce nel registro $t0
	rem $t1, $t0, 2 #qua prendiamo il resto della divisione fra il valore in $t0 e 2
	andi $t2, $t1, 1	# and serve a verificare se sia $t1 che 1 sono uguali, nel caso significa che è dispari e quindi $t2 diventa 1, altrimenti è 0
	
li $v0, 10
syscall #termina il programma

.data
	valore: .byte 7