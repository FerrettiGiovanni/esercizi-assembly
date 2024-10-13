# Da un bussolotto estarre 3 palline numerate e stampare su videoterminale il loro valore. 
# Le palline sono numerate da 0 a 90 e non sono ammesse ripetizioni.

.text
.globl main

main:
estrazioneUno:
    li $v0, 42
    li $a0, 0
    li $a1, 90
    syscall

    move $t0, $a0

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, space
    syscall

estrazioneDue:
    li $v0, 42
    li $a0, 0
    li $a1, 90
    syscall

    move $t1, $a0
    beq $t0, $t1, estrazioneDue

    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    j estrazioneTre

estrazioneTre:
    li $v0, 42
    li $a0, 0
    li $a1, 90
    syscall
    move $t2, $a0
    beq $t0, $t2, estrazioneTre
    beq $t1, $t2, estrazioneTre

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, space
    syscall

    j end

end:
    li $v0, 10
    syscall

.data
    space: .asciiz " "
