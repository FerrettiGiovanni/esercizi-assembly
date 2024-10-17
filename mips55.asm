# Realizzare un programma in assembly MARS che, definita una stringa in memoria e letto un carattere da 
# tastiera, calcola il numero di occorrenze del carattere nella stringa.

.text
.globl main

main:
    li $t0, 0 # Definisco il contatore che utilizzero' per il ciclo che mi serve a verificare la stringa
    lb $t1, lunghezzaStringa # In questo registro inserisco il valore numerico della lunghezza della stringa

insChar:
    # In questa parte di codice gestisco l'inserimento del carattere da terminale
    li $v0, 12
    syscall
    move $t2, $v0 # in t2 inserisco il carattere inserimento

cicloVerifica:
    beq $t0, $t1, end # Se il contatore raggiunge la lunghezza della stringa, termina il ciclo

    la $t3, stringaMemory
    mul $t4, $t0, 1
    add $t5, $t3, $t4
    lb $t6, ($t5)

    beq $t6, $t2, contaChar
    addi $t0, $t0, 1
    j cicloVerifica

contaChar:
    addi $t7, $t7, 1
    addi $t0, $t0, 1
    j cicloVerifica

end:
    # Stampo il numero di occorrenze del carattere nella stringa
    move $a0, $t7
    li $v0, 1
    syscall

    li $v0, 10
    syscall

.data
    stringaMemory: .asciiz "Questa super stringa in memoria"
    lunghezzaStringa: .byte 31
