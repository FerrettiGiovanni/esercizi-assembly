# Si scriva un programma in linguaggio assembly che definiti due
# numeri reali in memoria r1 e r2 riporta la media (fra reali) in $f2

.text
.globl main

main:
    lwc1 $f0, r1 # Carico nel coprocessore il dato r1
    lwc1 $f1, r2 # Carico nel coprocessore il dato r2
    li $t0, 2 # Carico nel registro $t0 il valore 2
    mtc1 $t0, $f4 # Copio il valore di $t0 in $f4 nel coprocessore
    cvt.s.w $f4, $f4 # Converto il valore di $f4 in un valore single precision
    add.s $f2, $f0, $f1 # Faccio la somma fra i due float
    div.s $f2, $f2, $f4 # Divido il totale per il valore storato nel registro $f4

    li $v0, 10 # Termino il programma
    syscall

.data
    r1: .float 6.5
    r2: .float 2.5
