# Scrivere in linguaggio assemblativo MIPS/MARS una funzione che riceve in ingresso due numeri interi a e b, 
# scrivere una funzione che restituisca il risultato di a elevato alla b; proporre quindi un adeguato main di 
# prova (i numeri possono essere definiti in memoria o - meglio - inseriti da tastiera). Il risultto deve essere
# mostrato su videoterminale.

.text
.globl main

main:
    # Inserisco il primo valore, la base
    li $v0, 5
    syscall
    move $a0, $v0
    move $a2, $v0
    
    # Inserisco il secondo valore, l'esponente
    li $v0, 5
    syscall
    move $a1, $v0

    # Salto a sub-routine
    jal POTENZA

    # Sposto il risultato in t0
    move $t0, $v0

    # Stampo il risultato a terminale
    li $v0, 1
    move $a0, $t0
    syscall
    
    # Termino il programma
    li $v0 10
    syscall

POTENZA:
    # Resetto il registro v0 con uno xor
    xor $v0, $v0, $v0
    
    # Faccio partire v0 da 1, preparo il registro per il ciclo
    addi $v0, $v0, 1
    
    # Ciclo della funzione
ciclo:
    beq $v0, $a1, fine
    mul $a0, $a0, $a2
    addi $v0, $v0, 1
    j ciclo
fine:
    move $v0, $a0
    jr $ra

.data
