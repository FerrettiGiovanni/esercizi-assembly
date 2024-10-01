# Esempio di somma tra due numeri reali definiti in memoria

.text
.globl main

main:
    lwc1 $f1, numeroA # carico il dato numeroA nel coprocessore che permette di gestire i numeri reali
    lwc1 $f2, numeroB # faccio la stessa cosa con il numeroB
    add.s $f0, $f1, $f2 # Eseguo la soma aggiungendo .s ad add dato che eseguo una somma fra due numeri 
                        # rappresentati in single precision (sono dei float)

    li $v0, 10 # Termino il programma
    syscall

.data
    numeroA: .float 3.45
    numeroB: .float -6.79