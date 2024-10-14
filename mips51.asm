# Scrivere un programma in assembly che definisca un vettore di word di lunghezza 6. 
# Determinare con una stringa in output se le componenti inserite sono strettamente crescenti
# (v[i+1] > v[i] per ogni i

.text
.globl main

main:
    # Carica la lunghezza del vettore dalla memoria
    lb $t0, lunghezzaVettore
    # Inizializza l'indice per il ciclo di inserimento
    li $t2, 0
    # Flag per determinare se la sequenza è crescente
    li $t8, 1

cicloIns:
    # Verifica se tutti gli elementi sono stati inseriti
    beq $t0, $t2, fineCicloIns
    # Leggi un numero intero da input
    li $v0, 5
    syscall
    move $t1, $v0

    # Calcola l'indirizzo del prossimo elemento del vettore
    la $t3, vettore
    mul $t4, $t2, 4
    add $t3, $t3, $t4
    sw $t1, ($t3)

    # Incrementa l'indice per il prossimo elemento
    addi $t2, $t2, 1
    j cicloIns

fineCicloIns:
    # Azzera i registri usati
    xor $t1, $t1, $t1
    xor $t2, $t2, $t2
    xor $t3, $t3, $t3
    xor $t4, $t4, $t4
    subi $t0, $t0, 1  # Decrementa la lunghezza per il confronto

verifico:
    # Confronta ogni elemento con il successivo
    beq $t2, $t0, endVerifica
    la $t3, vettore
    mul $t4, $t2, 4
    add $t3, $t3, $t4
    lw $t5, ($t3)
    lw $t6, 4($t3)
    addi $t2, $t2, 1
    blt $t5, $t6, verCresce
    beq $t5, $t6, niente
    bgt $t5, $t6, verDecresce

verCresce:
    # Se i numeri sono crescenti, continua
    li $t7, 0
    blt $t7, $t8, verifico
    j niente

verDecresce:
    # Se i numeri sono decrescenti, resetta il flag crescente
    li $t8, 0
    beq $t7, $t8, verifico
    j niente

niente:
    # Se i numeri non sono né strettamente crescenti né decrescenti
    li $v0, 4
    la $a0, nienteAsc
    syscall
    j end

endVerifica:
    # Determina quale messaggio stampare in base ai flag
    blt $t7, $t8, cresce
    beq $t7, $t8, decresce
    j niente

cresce:
    # Stampa che la sequenza cresce
    li $v0, 4
    la $a0, cresceAsc
    syscall
    j end

decresce:
    # Stampa che la sequenza decresce
    li $v0, 4
    la $a0, decresceAsc
    syscall
    j end

end:
    # Termina il programma
    li $v0, 10
    syscall

.data
    vettore: .space 24
    lunghezzaVettore: .byte 6
    nienteAsc: .asciiz "La sequenza NON cresce o NON decresce STRETTAMENTE"
    cresceAsc: .asciiz "La sequenza CRESCE"
    decresceAsc: .asciiz "La sequenza DECRESCE"
