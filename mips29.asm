# Descrivere l'algoritmo che dato un numero intero maggiore di 2 (definito in memoria) stabilisca se il 
# numero è primo (valore 1 in $t2) o no (valore 2 in $t2). Provare ad implementare il programma in linguaggio 
# assemblativo MARS.
# Esempio numeri primi 1,3,5,7,11,13,...
# PS: un numero è primo solo se è divisibile per se stesso e per 1.

.text
.globl main

main:
    lw $t0, numeroV
    move $t1, $t0 # Copio il valore da verifica in t1 come valore temp
    li $t2, 1 # Definisco il risultato considerando che il numero da verificare sia positivo
    li $t4, 1               # Valore di confronto per il ciclo
    li $t6, 0               # Valore zero per il confronto
    
verifico:
    subi $t1, $t1, 1       # Decrementa $t1 di 1
    beq $t1, $t4, end      # Se $t1 è uguale a 1, termina il ciclo
    rem $t5, $t0, $t1      # Calcola il resto della divisione di $t0 per $t1
    beq $t5, $t6, setTwo  # Se il resto è zero, il numero non è primo
    j verifico              # Continua a verificare

setTwo:
    li $t2, 2              # Setto a 2

end:
    li $v0, 10
    syscall

.data
    numeroV: .word 13
