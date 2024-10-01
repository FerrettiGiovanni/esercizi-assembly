# Esercizio: Calcolo della Media Ponderata
# Obiettivo: Scrivi un programma in linguaggio assembly MIPS che calcoli la media ponderata di quattro numeri reali letti 
# da tastiera. I pesi per ciascun numero sono definiti staticamente nel programma.
# Specifiche:
# Leggi quattro numeri reali da tastiera.
# Usa i pesi definiti per calcolare la media ponderata.
# Se la media ponderata è maggiore di un certo valore soglia, imposta t9 a 1, altrimenti a 0.

# (x1p1 + x2p2 + x3p3 + x4p4)/(p1+p2+p3+p4) Formula Media Ponderata

.text
.globl main

main:
    # Inserisco i valori da tastiera
    li $v0, 5
    syscall
    move $t0, $v0
    li $v0, 5
    syscall
    move $t1, $v0
    li $v0, 5
    syscall
    move $t2, $v0
    li $v0, 5
    syscall
    move $t3, $v0

    # Sposto i valori nel coprocessore
    mtc1 $t0, $f0
    mtc1 $t1, $f1
    mtc1 $t2, $f2
    mtc1 $t3, $f3

    # Converto i valori 
    cvt.s.w $f0, $f0
    cvt.s.w $f1, $f1
    cvt.s.w $f2, $f2
    cvt.s.w $f3, $f3

    # Carico i valori di peso che mi serviranno per calcolare la media ponderata
    lwc1 $f4, peso1
    lwc1 $f5, peso2
    lwc1 $f6, peso3
    lwc1 $f7, peso4

    # Carico la soglia
    lwc1 $f14, soglia

    # Eseguo le somme dei pesi e inserisco tutto in f8
    add.s $f8, $f4, $f5
    add.s $f8, $f8, $f6
    add.s $f8, $f8, $f7

    # Eseguo le moltiplicazioni fra il valore e il peso (risultato da f9 a f12)
    mul.s $f9, $f4, $f0
    mul.s $f10, $f5, $f1
    mul.s $f11, $f6, $f2
    mul.s $f12, $f7, $f3

    # Eseguo le somme delle moltiplicazioni appena effettuate (risultato in f13)
    add.s $f13, $f9, $f10
    add.s $f13, $f13, $f11
    add.s $f13, $f13, $f12

    # Eseguo la divisione per effettuare la media ponderata (risultato in f13)
    div.s $f13, $f13, $f8

    # Verifico se la media ponderata e' superiore ad una certa soglia (def in f14) e flaggo t9 a 1 altrimenti 0
    # Equivale a dire che verifico se la soglia e' inferiore alla media ponderata
    c.lt.s 1, $f14, $f13

    # Adesso controllo il flag, mi serve per impostare o no il valore di t9 a 1
    bc1f 1, end # Se il valore del flag 1 è 0, vado alla parte terminale del codice
    li $t9, 1 # altrimenti imposto il valore di t9 a 1

end:
    li $v0, 10
    syscall


.data
    peso1: .float 6
    peso2: .float 9
    peso3: .float 12
    peso4: .float 9
    soglia: .float 25
