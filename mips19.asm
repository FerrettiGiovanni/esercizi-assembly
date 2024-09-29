# Scrivere un programma in linguaggio assemblativo MARS che, preso un intero n in memoria, calcola la somma dei primi n interi.
# ES:
# INPUT: n=5
# OUTPUT: 15 cioe' (5+4+3+2+1)

# L'idea che vorrei adottare e' quella di prendere il valore di n, mettere lo stesso valore in una variabile temporanea, verifico se temp e' uguale a 1, se si allora stampo il risultato 
# altrimenti decremento temp di 1 e lo sommo a n; continuo cosi fino a quando temp e' uguale a 1 e a quel punto faccio store del risultato che sara uguale a n

# SCHEMA IN MERMAID:
# flowchart TD
#   A[Start] --> B{temp = 1?}
#   B -- No --> C[Decrement temp]
#   C --> D[Add temp to n]
#   D --> B
#   B -- Yes --> E[Print/Store n]
#   E --> F[End]


.text
.globl main

main:
    lw $t1, n
    lw $t0, risultato
    li $t3, 1
    move $t2, $t1 # Copio n su quello che sara' la mia variabile di appoggio, tipo fosse temp

verifica:    
    beq $t2, $t3, end
    subi $t2, $t2, 1
    add $t1, $t1, $t2
    j verifica

end:
    move $t0, $t1
    sw $t0, risultato
    li $v0, 10
    syscall

.data
    n: .word 5
    risultato: .word 0

