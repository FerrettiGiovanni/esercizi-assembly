# Realizzare un programma in assembly MARS che, definite due stringhe in memoria di ugual lunghezza, calcola 
# la similitudine tra due stringhe. La similitudine e' data dal numero dei ceratteri uguali alla stessa posizione 
# diviso la lughezza della stringa.

.text
.globl main

main:
    xor $t0, $t0, $t0 # Contatore 
    lb $t1, lunghezzaStringhe
    la $t2, stringaUno
    la $t3, stringaDue

cicloCheck:
    beq $t0, $t1, fineCicloCheck
    mul $t4, $t0, 1
    add $t5, $t2, $t4 # Indirizzo elemento in stringaUno
    add $t6, $t3, $t4 # Indirizzo elemento in stringaDue

    xor $t4, $t4, $t4

    lb $t4, ($t5)
    lb $t7, ($t6)

    addi $t0, $t0, 1
    beq $t4, $t7, incrementaContatore
    j cicloCheck
    
incrementaContatore:
    addi $s0, $s0, 1
    j cicloCheck

fineCicloCheck:
    xor $t0, $t0, $t0 #Resetto i registri
    xor $t4, $t4, $t4
    xor $t5, $t5, $t5
    xor $t6, $t6, $t6
    xor $t7, $t7, $t7
    xor $t0, $t0, $t0

    move $t4, $s0

similitudine:
    mtc1 $t4, $f0
    cvt.s.w $f0, $f0
    mtc1 $t1, $f1
    cvt.s.w $f1, $f1
    div.s $f0, $f0, $f1

    li $v0, 2
    mov.s $f12, $f0
    syscall

end:
    li $v0, 10
    syscall

.data
    stringaUno: .asciiz "oiusaconaosicunoascuinuscoiansicusanosucioasocoiasncoiusacoasicunsociauncoiauscn"
    stringaDue: .asciiz "oasoicuanscoiasucaosucnaosicunaoscoiausncoiasnucoaisuncoaisucnoaisuncoaisucnoaso"
    lunghezzaStringhe: .byte 100
