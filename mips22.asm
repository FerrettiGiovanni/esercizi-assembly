# Scrivere un programma in linguaggio assemblativo MARS che legge un valore intero da tastiera e scrive su 
# data in risultato il numero di 1 che compongono il numero acquisito.
# Esempio
# INPUT: 521 (in binario 1000001001)
# OUTPUT:3

.text
.globl main

main:
    li $v0, 5
    syscall
    move $t0, $v0  # Legge l'input dall'utente

    lw $t1, risultato     # Inizializza il risultato (numero di bit impostati a 1)
    li $t2, 1      # Inizializza il bit di controllo a 1 (000...0001)
    li $t4, 32     # Inizializza il contatore di bit a 32 (per un intero di 32 bit)

verifica:
    beq $t4, 0, end # Se ho controllato tutti i bit, termina il loop
    and $t3, $t0, $t2 # Esegue AND tra il numero e il bit di controllo
    bnez $t3, incrementa # Se c'è un bit impostato, va a incrementare
    next_bit:
    sll $t2, $t2, 1 # Passa al prossimo bit
    subi $t4, $t4, 1 # Decrementa il contatore di bit
    j verifica # Ripete il ciclo

incrementa:
    addi $t1, $t1, 1 # Incrementa il contatore di bit impostati
    j next_bit # Va a controllare il prossimo bit

end:
    sw $t1, risultato
    # Termina il programma
    li $v0, 10
    syscall

.data
    risultato: .word 0
