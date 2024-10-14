# Scrivere un programma in assembly che crei un vettore di 50 interi contenente numeri casuali compresi 
# tra 0-50. Successivamente il programma chiede all'utente di inserire un numero compreso tra 0-50 e ricerca 
# tale numero nel vettore. Per ogni occorrenza stampa la posizione in cui è stato trovato e alla fine della 
# ricerca riporta anche il numero di elementi trovati.

.text
.globl main

main:
    # Inizializzazione indice del ciclo a zero
    li $t0, 0
    # Carica la lunghezza del vettore dalla memoria
    lb $t1, lunghezzaVettore

cicloIns:
    # Termina il ciclo quando l'indice raggiunge la lunghezza del vettore
    beq $t0, $t1, fineCicloIns
    # Genera un numero casuale tra 0 e 50
    li $v0, 42
    li $a0, 0
    li $a1, 51
    syscall
    move $t2, $a0

    # Calcola l'indirizzo corrente nel vettore dove inserire il numero
    la $t3, vettore
    add $t3, $t3, $t0

    # Memorizza il numero casuale nel vettore
    sb $t2, ($t3)

    # Azzera $a0 per sicurezza e incrementa l'indice del vettore
    xor $a0, $a0, $a0
    addi $t0, $t0, 1
    j cicloIns

fineCicloIns:
    # Resetta i registri per il ciclo di ricerca
    xor $t0, $t0, $t0
    xor $a0, $a0, $a0
    xor $t3, $t3, $t3
    xor $t2, $t2, $t2

insVal:
    # Richiede all'utente di inserire un valore da cercare
    li $v0, 5
    syscall
    move $t2, $v0

cicloRicerca:
    # Verifica se sono stati controllati tutti gli elementi
    beq $t0, $t1, fineRicerca

    # Calcola l'indirizzo corrente da verificare
    la $t3, vettore
    add $t4, $t3, $t0

    # Carica il valore dal vettore
    lb $t5, ($t4)

    # Confronta il valore con quello inserito dall'utente
    beq $t2, $t5, match

    # Incrementa l'indice e continua la ricerca
    addi $t0, $t0, 1
    j cicloRicerca

match:
    # Incrementa il contatore di match trovati
    addi $t6, $t6, 1
    
    # Stampa la stringa di match
    li $v0, 4
    la $a0, matchString
    syscall

    la $t7, ($t4)

    # Stampa l'indirizzo del match
    li $v0, 1
    move $a0, $t7
    syscall
    
    # Vai a nuova linea
    li $v0, 4
    la $a0, accapo
    syscall

    # Continua la ricerca dopo il match trovato
    addi $t0, $t0, 1
    j cicloRicerca

fineRicerca:
    # Stampa il numero totale di match trovati
    li $v0, 4
    la $a0, occorrenze
    syscall

    # Stampa il conteggio dei match
    li $v0, 1
    move $a0, $t6
    syscall

end:
    # Termina il programma
    li $v0, 10
    syscall

.data
    vettore: .space 50  # Spazio per 50 byte (un vettore di 50 numeri)
    lunghezzaVettore: .byte 50
    matchString: .asciiz "Trovato all'indirizzo: "
    accapo: .asciiz "\n"
    occorrenze: .asciiz "Sono stati trovati: "
