# Si scriva un programma in linguaggio assembly che definiti due numeri in memoria riporta la
# loro media (fra interi) in $t2 Esempio: Batman=5 Robin=8 media=(5+8)/2=6

.text
.globl main

main:
	lb $t0, Batman #Inserisco il dato contenuto nella memoria dati definito in Batman in $t0
	lb $t1, Robin #Inserisco il dato contenuto nella memoria dati definito in Robin in $t1
	add $t2, $t0, $t1 #Eseguo un'operazione di somma che inserisco nel registro $t2
	div $t2, $t2, 2 # Effettuo la divisione intera per 2 del valore contenuto nel registro $t2

li $v0, 10
syscall #termino il programma

.data
	Batman: .byte 5
	Robin: .byte 8