# Scrivere un programma in assembly che definisca un vettore di word di lunghezza 10. Legga i numeri immessi 
# da tastiera dall'utente. Stampa i valori immessi nel vettore.

.text
.globl main
main:
    li $t3, 0  # Inizializza l'indice del ciclo

cicloIns:
    li $t0, 10  # Definisce la lunghezza del vettore
    beq $t3, $t0, cicloPrint  # Passa alla stampa quando tutti i numeri sono stati inseriti

    li $v0, 5  # Codice per leggere un intero
    syscall

    la $t2, vettore
    mul $t4, $t3, 4  # moltiplica l'indice per 4 (offset per word)
    add $t2, $t2, $t4
    sw $v0, ($t2)  # Salva direttamente il valore letto

    addi $t3, $t3, 1
    j cicloIns

cicloPrint:  # Ciclo per stampare i valori
    li $t3, 0  # Reset dell'indice per la stampa

printLoop:
    li $t0, 10
    beq $t3, $t0, end  # Termina dopo aver stampato tutti gli elementi
    la $t2, vettore
    mul $t4, $t3, 4  # Calcola l'offset per l'elemento corrente
    add $t2, $t2, $t4
    lw $a0, ($t2)  # Carica il valore da stampare
    li $v0, 1
    syscall  # Stampa il valore

    addi $t3, $t3, 1
    j printLoop

end:
    li $v0, 10  # Termina il programma
    syscall

.data
    vettore: .space 40  # Alloca spazio per 10 word
    lunghezzaVettore: .byte 10
