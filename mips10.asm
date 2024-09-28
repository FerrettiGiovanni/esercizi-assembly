# Realizzare un programma che in linguaggio MIPS definisca un valore di tipo byte residente in 
# memoria e metta in $t2 il valore 1 o 2 se il numero è rispettivamente multiplo di 7 o no

.text
.globl main

main:	
	lb $t0, valoreA #Inserisco il valoreA nel registro $t0
	li $t2, 2 # Definisco il registro $t2 come se lo considerassi non multiplo di 7
	rem $t1, $t0, 7 # Metto nel registro $t1 il valore del resto fra il valore nel registro $t0 e 7
	beq $t1, 0, multiplo # Salto condizionato, se $t1 è uguale a 0, salto nella label multiplo, altrimenti eseguo la fine del programma

end:
	li $v0, 10 
	syscall	# Termino il programma

multiplo:
	li $t2, 1 # Se entro in questo label significa che ho verificato la condizione in cui il valore di $t1 è multiplo, quindi setto $t2 a 1
	j end # Salto incondizionato alla fine del programma
	
.data
	valoreA: .byte 12
