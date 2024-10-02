# Confrontare due interi positivi a e b, definiti in memoria, e mettere in $t0 il valore 0 se a e' 
# maggiore di b, 1 altrimenti. Non e' possibile utilizzare l'istruzione di comparazione tra valori: operare 
# sui singoli bit dei valori.

.text
.globl main

main:
    lw $t1, interoA
    lw $t2, interoB
    li $t0, 0
   
    # Sottraggo B ad A, cosi' se il numero ricevuto e' negativo significa che il bit piu' significativo , vuol dire che B
    # e' piu' grande di A
    sub $t1, $t1, $t2 
    srl $t4, $t1, 31
    and $t3, $t4, 1 # Faccio AND per verificare se il bit piu' significativo che ho shiftato e' uguale a 1
    # Se fosse cosi' t3 si setta ad 1
    
    # Copio il risultato nel registro t3
    move $t0, $t3

    # Termino il programma
    li $v0, 10
    syscall
    

.data
    interoA: .word 4
    interoB: .word 5
