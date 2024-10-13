# Supponeno che testa sia 0 e croce sia 1. Lanciare una moneta cento volte e stampare su videoterminale 
# quante teste sono uscite e quante croci.

.text
.globl main

main:
    li $t0, 100 # Lanciare una moneta 100 volte
    li $t4, 0
    li $t5, 0
    li $t6, 2

lancio:
    beq $t4, $t0, end
    li $v0, 42
    move $a0, $t5 # Testa
    move $a1, $t6 # Croce
    syscall
    move $t1, $a0
    beq $t6, $a1, croce
    addi $t2, $t2, 1
    addi $t4, $t4, 1
    j lancio

croce:
    addi $t3, $t3, 1
    addi $t4, $t4, 1
    li $v0, 1
    j lancio

end:
    li $v0, 4
    la $a0, esceTesta
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    
    li $v0, 4
    la $a0, accapo
    syscall

    li $v0, 4
    la $a0, esceCroce
    syscall
    li $v0, 1
    move $a0, $t3
    syscall

.data
    esceTesta: .asciiz "Testa: "
    esceCroce: .asciiz "Croce: "
    spazio: .asciiz " "
    accapo: .asciiz "\n"
