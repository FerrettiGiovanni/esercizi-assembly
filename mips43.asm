# Scrivere in linguaggio assemblativo MIPS/MARS un programma che dato in input base altezza di un triangolo
# rettangolo passi tali valori ad una funzione attraverso la quale si possano stabilire ipotenusa, area e 
# perimetro del triangolo.

.text
.globl main

main:
    # Inserimento dei dati
    li $v0, 5
    syscall
    move $a0, $v0

    li $v0, 5
    syscall
    move $a1, $v0

    # Chiamata alla funzione calcoliTriangolo
    jal calcoliTriangolo

    # Uscita dal programma
    li $v0, 10
    syscall

calcoliTriangolo:
    # Salvataggio di $ra
    move $t5, $ra

    # Esecuzione di sub-funzioni
    jal calcolaIpotenusa
    move $t0, $v0  # risultato ipotenusa

    jal calcolaArea
    move $t1, $v0  # risultato area

    jal calcolaPerimetro
    move $t2, $v0  # risultato perimetro

    # Ripristino di $ra
    move $ra, $t5

    jr $ra  # ritorno al chiamante

end: # Termino il Programma
    li $v0, 10
    syscall


calcolaIpotenusa:
    mul $t0, $a0, $a0   # base^2
    mul $t1, $a1, $a1   # altezza^2
    add $t2, $t0, $t1   # somma dei quadrati
    mtc1 $t2, $f0
    cvt.s.w $f0, $f0
    sqrt.s $f0, $f0
    mov.s $f12, $f0
    li $v0, 2
    syscall    
    move $t3, $a0
    la $a0, newline   # Carica l'indirizzo della stringa di newline in $a0
    li $v0, 4         # Syscall per stampare la stringa
    syscall
    move $a0, $t3
    jr $ra

calcolaArea:
    mul $t2, $a0, $a1   # base * altezza
    li $t3, 2
    mtc1 $t2, $f0
    cvt.s.w $f0, $f0
    mtc1 $t3, $f1
    cvt.s.w $f1, $f1
    div.s $f2, $f0, $f1   # area = (base * altezza) / 2
    mov.s $f12, $f2
    li $v0, 2
    syscall
    move $t3, $a0
    la $a0, newline   # Carica l'indirizzo della stringa di newline in $a0
    li $v0, 4         # Syscall per stampare la stringa
    syscall
    move $a0, $t3
    jr $ra

calcolaPerimetro: # In questa parte c'e' un errore
    add $t0, $a2, $a3   # somma base e altezza
    add $t0, $t0, $a0   # aggiunge l'ipotenusa al totale
    mtc1 $t0, $f0
    cvt.s.w $f0, $f0
    mov.s $f12, $f0
    li $v0, 2           # syscall per stampare float
    syscall
    jr $ra              # ritorna alla funzione chiamante

.data
    newline: .asciiz "\n"


