# Scrivere un programma in assembly che definisca un vettore di word di lunghezza 6. 
# Il programma deve ricavare il vettore inverso, cio√® un vettore che ha le componenti invertite e, infine, 
# stampi il vettore ricavato.
# Esempio 156 432 5332 -23 0 688
# invertito 688 0 -23 5332 432 156

.text
.globl main

main:
    li $t0, 0
    lb $t1, lunghezzaVettore # Carica la lunghezza del vettore

cicloIns:
    beq $t0, $t1, preparaPrint
    li $v0, 5
    syscall
    move $t4, $v0           # Memorizza il valore letto in $t4

    la $t2, vettore
    sll $t3, $t0, 2         # $t3 = $t0 * 4
    add $t2, $t2, $t3
    sw $t4, 0($t2)          # vettore[$t0] = $t4

    addi $t0, $t0, 1
    j cicloIns

preparaPrint:
    li $t0, 0               # Resetta $t0 per il ciclo di stampa

cicloPrint:
    beq $t0, $t1, end       # Termina se $t0 Ë uguale alla lunghezza del vettore
    la $t2, vettore
    sll $t3, $t0, 2
    add $t2, $t2, $t3
    lw $a0, 0($t2)

    li $v0, 1
    syscall                 # Stampa il valore

    li $v0, 4
    la $a0, space
    syscall                 # Stampa uno spazio

    addi $t0, $t0, 1        # Incrementa l'indice
    j cicloPrint

end:
    li $v0, 10
    syscall

.data
    vettore: .space 24
    lunghezzaVettore: .byte 6
    space: .asciiz " "
