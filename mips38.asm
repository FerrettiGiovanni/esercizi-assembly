# Scrivere un programma in linguaggio assembaltivo MIPS/MARS che legga da tastiera tre numeri interi indicanti 
# il raggio di altrettanti cerchi, calcola l'area di ciascun cerchio e riporta in $f0 l'area pi? grande, $f1 la 
# mediana e $f2 la pi? piccola. (Area del cerchio (pi x (r ^2))

.text
.globl main

main:
    # Richiede all'utente di inserire il primo numero intero
    li $v0, 5  # Imposta la syscall per la lettura di un intero
    syscall    # Esegue la syscall
    move $t0, $v0  # Sposta il numero letto nel registro $t0
    mtc1 $t0, $f0  # Trasferisce il valore da $t0 al coprocessore, nel registro $f0
    cvt.d.w $f0, $f0  # Converte il valore in $f0 da word a double

    # Ripete i passaggi per il secondo numero intero
    li $v0, 5
    syscall
    move $t0, $v0
    mtc1 $t0, $f2
    cvt.d.w $f2, $f2

    # Ripete i passaggi per il terzo numero intero
    li $v0, 5
    syscall
    move $t0, $v0
    mtc1 $t0, $f4
    cvt.d.w $f4, $f4

    # Carica il valore di pi greco dal segmento di memoria .data
    ldc1 $f6, pi

    # Calcola l'area dei cerchi utilizzando la formula area = ? * r^2
    mul.d $f8, $f0, $f0  # Calcola r^2 per il primo raggio
    mul.d $f8, $f8, $f6  # Moltiplica r^2 per ?
    mul.d $f10, $f2, $f2  # Calcola r^2 per il secondo raggio
    mul.d $f10, $f10, $f6  # Moltiplica r^2 per ?
    mul.d $f12, $f4, $f4  # Calcola r^2 per il terzo raggio
    mul.d $f12, $f12, $f6  # Moltiplica r^2 per ?

ordina:
    # Confronta e ordina le aree dei cerchi
    c.le.d $f8, $f10  # Confronta l'area del primo cerchio con il secondo
    bc1f swap1  # Se f8 > f10, vai a swap1
    c.le.d $f10, $f12  # Confronta l'area del secondo cerchio con il terzo
    bc1f swap2  # Se f10 > f12, vai a swap2
    j converti  # Se le aree sono già ordinate, va alla conversione

swap1:
    # Scambia f8 e f10 se non in ordine
    mov.d $f14, $f8
    mov.d $f8, $f10
    mov.d $f10, $f14
    j ordina  # Ritorna al controllo ordine

swap2:
    # Scambia f10 e f12 se non in ordine
    mov.d $f14, $f10
    mov.d $f10, $f12
    mov.d $f12, $f14
    j ordina  # Ritorna al controllo ordine

converti:
    # Converte i valori double in float per la memorizzazione nei registri $f0, $f1, $f2
    cvt.s.d $f0, $f12  # Converte il maggiore (ora in f12) in float e lo mette in f0
    cvt.s.d $f1, $f10  # Converte il valore mediano (ora in f10) in float e lo mette in f1
    cvt.s.d $f2, $f8  # Converte il più piccolo (ora in f8) in float e lo mette in f2

end:
    # Termina il programma
    li $v0, 10
    syscall

.data
    # Memorizza il valore di pi greco come double
    pi: .double 3.14159265358979323846
