# Scrivere un programma che tramite l'utilizzo di una funzione restituisca il massimo fra tre numeri
# (Piccolo Esempio di utilizzo di Funzione)

.text
.globl main

main:
    # Inserisco i 3 numeri da terminale
    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 5
    syscall
    move $t2, $v0

    li $v0, 5
    syscall
    move $t3, $v0

    # Adesso sposto questi valori nei 3 registri che mi servono ad inserire i valori all'interno della funzione
    move $a0, $t1
    move $a1, $t2
    move $a2, $t3
    # Eseguo un salto a sub-routine
    jal massimo
    
    # Copio il risultato della mia funzione in t1
    move $t1, $v0
    
    # Eseguo un stampa dell'intero massimo fra i 3 valori inseriti
    li $v0, 1
    move $a0, $t1
    syscall
    
    # Termino il programma
    li $v0, 10
    syscall

#Funzione per determinare il massimo fra i 3 valori
massimo:
    ble $a0, $a1, max1 # se a0 e' minore uguale ad a1, imposto a1 come max
    move $a1, $a0      # altrimenti li inverto
max1:
    move $v0, $a1      # a1 adesso e' il mio massimo che confrontero con l'altro numero a disposizione
    ble $v0, $a2, max2 # nel caso in cui a2 sia piu' grande, lo definisco come nuovo max
    move $a2, $v0      
max2:
    move $v0, $a2
    jr $ra
    
.data

