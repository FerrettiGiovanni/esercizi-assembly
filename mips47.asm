# Dati tre dadi con facce numerate da 0 a 5. Lanciare tre dadi e scrivere su videoterminale se e' uscito un tris, 
# una coppia o tutti valori diversi.

.text
.globl main

main:

    li $v0, 42
    li $a0, 0
    li $a1, 5
    syscall
    move $t0, $a0

    xor $a0, $a0, $a0
    
    li $v0, 42
    li $a0, 0
    li $a0, 5
    syscall
    move $t1, $a0

    xor $a0, $a0, $a0

    li $v0, 42
    li $a0, 0
    li $a0, 5
    syscall
    move $t2, $a0

    xor $a0, $a0, $a0

verifica:
    beq $t0, $t1, verificaTris
    j verificaDue

verificaDue:
    beq $t1, $t2, trovataCoppia
    beq $t0, $t2, trovataCoppia
    j tuttiDiversi

verificaTris:
    beq $t1, $t2, trovatoTris
    j trovataCoppia

trovatoTris:
    li $v0, 4
    la $a0, tris
    syscall
    j end

trovataCoppia:
    li $v0, 4
    la $a0, coppia
    syscall
    j end

tuttiDiversi:
    li $v0, 4
    la $a0, niente
    syscall
    j end

end:
    li $v0, 10
    syscall

.data
    tris: .asciiz "E' uscito un tris"
    coppia: .asciiz "E' uscita una coppia"
    niente: .asciiz "Sono usciti tutti valori diversi"
