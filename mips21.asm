#Scrivere un programma in linguaggio assemblativo MARS che legge un valore intero da tastiera e restituisce su 
# la memoria il valore del bit alla posizione specificata da un altro numero acquisito da tastiera 
# successivamente (si può assumere che il secondo valore immesso sia un numero compreso tra 0 e 31).

.text
.globl main

main:
    # Prendo valore intero da tastiera in t0
    li $v0, 5
    syscall
    move $t0, $v0 

    # Prendo un altro valore da tastiera per specificare la posizione che voglio leggere
    li $v0, 5
    syscall
    move $t1, $v0     

    # Questo mi serve per definire nel registro t2 il valore che usero' per il confronto
    li $t2, 1 # ovvero 0000 0000 0000 0000 0000 0000 0000 0001 (in binario)
    
    #Adesso devo far scorrere l'uno che uso per il confronto di t1 posizioni a sinistra
    sllv $t3, $t2, $t1 # Shifto t2 di t1 posizioni a sinistra e salvo in t3

    and $t4, $t0, $t3 # Eseguo in confronto con il comando and

    srlv $t5, $t3, $t1 # Adesso che ho il valore, lo rishifto a destra per renderlo piu' consultabile

    sb $t5, risultato # Faccio store del risultato

.data
    risultato: .byte 0
