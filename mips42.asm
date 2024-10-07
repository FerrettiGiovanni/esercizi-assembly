# Scrivere in linguaggio assemblativo MIPS/MARS una funzione che riceve in ingresso tre numeri interi h, m e s 
# che rappresentano ore minuti e secondi e restituisce il numero di secondi trascorsi dalla mezzanotte.

.text
.globl main

main:
    lw $t4, hours
    lw $t5, minutes
    lw $t6, seconds
    
    # Inserisco l'ora in un range accettabile
insertHour:
    li $v0, 5
    syscall
    move $t0, $v0
    bgt	$t0, $t4, insertHour    

    # Inserisco i minuti in un range accettabile
insertMinutes:
    li $v0, 5
    syscall
    move $t1, $v0
    bgt	$t1, $t5, insertMinutes

    # Inserisco i secondi inun range accettabile
insertSeconds:
    li $v0, 5
    syscall
    move $t2, $v0
    bgt	$t1, $t6, insertMinutes

    move $a0, $t0 # Copio in a0 il valore che si trova in t0
    move $a1, $t1 # Copio in a1 il valore che si trova in t1
    move $a2, $t2 # Copio in a2 il valore che si trova in t2

    jal calculateSecFromHours
    jal calculateSecFromMinutes

    move $a0, $v0
    move $a1, $v1

    jal calculateSecTotal
    
    move $a0, $v0
    
end:
    li $v0, 1
    syscall

    li $v0, 10
    syscall

calculateSecFromHours:
    xor $t2, $t2, $t2
    addi $t2, $t2, 60
    mul $v0, $a0, $t2
    mul $v0, $v0, $t2
    jr $ra

calculateSecFromMinutes:
    xor $t2, $t2, $t2
    addi $t2, $t2, 60
    mul $v1, $a1, $t2
    jr $ra

calculateSecTotal:
    xor $v0, $v0, $v0
    add $t3, $a0, $a1
    add $v0, $t3, $a2
    jr $ra

.data
	hours: .word 23
	minutes: .word 59
	seconds: .word 59
