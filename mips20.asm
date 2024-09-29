# Scrivere un programma in linguaggio assemblativo MARS che legga un valore intero da tastiera e scriva su registro t1 se il bit alla terza posizione 
# meno significativa del numero acquisito ha un 1.

.text
.globl main

main:

    # Prepara una syscall per leggere un intero. Syscall 5 è per la lettura di un intero dalla console.
    li $v0, 5  # Syscall code for read_int
    syscall    # Esegue la syscall; il risultato sarà in $v0

    # Sposta il valore letto dalla syscall (conservato in $v0) in $t0.
    move $t0, $v0  # Copia il valore letto in $t0

    # Esegue un AND bit a bit tra il valore in $t0 e 0x04 per isolare il terzo bit meno significativo.
    # 0x04 in binario è 0000 0100, quindi questa operazione isola il bit alla terza posizione meno significativa.
    andi $t1, $t0, 0x04  # Isola il terzo bit meno significativo di $t0 e salva il risultato in $t1

    # Prepara una syscall per terminare il programma. Syscall 10 è per la terminazione del programma.
    li $v0, 10  # Syscall code for exit
    syscall     # Esegue la syscall per terminare il programma


.data

