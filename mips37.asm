# Scrivere un programma in linguaggio assembaltivo MIPS/MARS che Calcola la distanza tra due punti (x1,y1) (x2,y2).
# NB:i punti x1,y1,x2,y2 sono interi definiti in memoria; la distanza si ottine con la radice quadrata di 
# (x1-x2)^2+(y1-y2)^2
# ES: (1,1) (2,2) d=1.41421

.text
.globl main

main:
    # Carico le coordinate nel coprocessore 1
    lwc1 $f1, x1
    lwc1 $f2, y1
    lwc1 $f3, x2
    lwc1 $f4, y2

    # Converto i valori in modo che siano espressi in Single (float)
    cvt.s.w $f1, $f1
    cvt.s.w $f2, $f2
    cvt.s.w $f3, $f3
    cvt.s.w $f4, $f4

    # Eseguo le sottrazioni fra i due punti e li metto in dei registri
    sub.s $f5, $f1, $f3
    sub.s $f6, $f2, $f4

    # Devo fare il quadrato dei due valori ottenuti
    mul.s $f7, $f5, $f5
    mul.s $f8, $f6, $f6

    # Sommo i due valori ottenuti
    add.s $f9, $f7, $f8

    # Adesso eseguo la radice quadrata
    sqrt.s $f10, $f9
    
    # Stampo il risultato a terminale
    li $v0, 2
    mov.s $f12, $f10
    syscall
    
    # Termino il programma
    li $v0, 10
    syscall 

end:

.data
    x1: .word 1
    y1: .word 3
    x2: .word 2
    y2: .word 7
