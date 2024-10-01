# Si scriva un programma in linguaggio assembly che letti quattro
# numeri interi da tastiera effettua la media dei primi due numeri
# e la media dei secondi due numeri e pone in $t9 il valore 1 se la
# prima media e' maggiore della seconda altrimento $t9 e'
# impostato a 0

.text
.globl main

main:
# Inserisco i 4 valori da tastiera
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

# Carico il valore che mi servirà a dividere per fare la media
    lwc1 $f12, valoreA

# Sposto tutti e 4 i valori 
    mtc1 $t0, $f0
    mtc1 $t1, $f2
    mtc1 $t2, $f4
    mtc1 $t3, $f6

# Converto tutti e 4 i valori in single
    cvt.s.w $f0, $f0
    cvt.s.w $f2, $f2
    cvt.s.w $f4, $f4
    cvt.s.w $f6, $f6

# Faccio le somme che servono per poi fare la media
    add.s $f8, $f0, $f2
    add.s $f10, $f4, $f6

# Eseguo le divisioni per calcolare la media
    div.s $f8, $f8, $f12
    div.s $f10, $f10, $f12

# Adesso eseguo i confronti per mettere il flag, e nel caso in cui sia $f10 e' minore di $f8
# dovro' impostare a 1 $t9 
    c.lt.s 1, $f10, $f8

# Se il flag 1 è false , salto altrimenti imposto $t9 a 1
    bc1f 1, end
    li $t9, 1

end:
    li $v0, 10
    syscall

.data
    valoreA: .float 2.0
