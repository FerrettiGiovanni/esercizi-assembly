# Traccia 2. Scrivere un programma in linguaggio assemblativo MARS che definiti cinque interi positivi definiti in memoria ne calcoli la media aritmetica (per valori interi). Riportare il risultato in $t0 o stamparlo su videoterminale.
# Esempio
# INPUT: a=0,b=11;c=7;d=1982;e=10051980
# OUTPUT:2010796

.text
.globl main

main:
    lw $t0, a # Carico tutti i valori nei registri
    lw $t1, b
    lw $t2, c
    lw $t3, d
    lw $t4, e
    li $t6, 5 # Faccio load immediate per il valore che serve per effettuare la divisione
    
    add $t5, $t0, $t1 #Sommo i valori
    add $t5, $t5, $t2
    add $t5, $t5, $t3
    add $t5, $t5, $t4
    
    div $t5, $t6 # Faccio la media
    mflo $t5 # Prendo il quoziente e lo sposto su t5 da LO

    li $v0, 10
    syscall
    
.data
    a: .word 0
    b: .word 11
    c: .word 7
    d: .word 1982
    e: .word 10051980
