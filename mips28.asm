# Scrivere un programma in linguaggio assemblativo MARS che legge da input un intero positivo a>2 (word) 
# ed un intero positivo (word) b>1 e ne restituisca in output il prodotto (axb) 
# senza utilizzare l'istruzione mul.

# Esempio INPUT (a): 10 INPUT (b): 5 OUTPUT: 50

.text
.globl main

main:
    lw $t1, interoA # Inserisco il valore di interoA in t1
    lw $t2, interoB # Inserisco il valore di interoB in t2
    li $t4, 1 # Carico con load immediate il numero 1
    move $t5, $t1 # Copio in t5 il valore di t1
    move $t3, $t2 # Copio in t3 il valore di t2

multiply:
    # Per fare la moltiplicazione senza usare mul, posso ciclare delle addizioni con un variabile temporanea
    beq  $t3, $t4, end # Se i valori sono uguali termino il codice, vado alla parte terminale del codice
    add  $t1, $t1, $t5 # Aggiungo il valore di t5 su t1
    subi $t3, $t3, 1 # Decremento il contatore
    j multiply # Salto incondizionato a multiply

end:
    li $v0, 10
    syscall


.data
    interoA: .word 10 # Che sia maggiore di 2
    interoB: .word 60 # Che sia maggiore di 1
