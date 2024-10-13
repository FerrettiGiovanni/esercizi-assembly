# Considerate la regola di Collatz: dato un numero intero positivo n, se n e' pari lo si divide per 2, 
# se e' dispari lo si moltiplica per 3 e si aggiunge 1 al risultato. Quando n e' 1 ci si ferma.
# Ad esempio, la sequenza di Collatz di 7 e': 7 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1
# E' un noto problema aperto stabilire se ogni sequenza di Collatz termina (cioe', se arriva a 1). 
# Scrivere in linguaggio assemblativo MIPS/MARS una funzione che, dato un numero, dia il successivo in 
# una sequenza di Collatz. Quindi, usare la funzione in un programma che chiede all'utente un numero e mostra 
# la sequenza di Collatz del numero e la lunghezza.
# Esempi di funzionamento
# Numero: 7
# 7 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1
# Lunghezza: 17
# Numero: 9 9 28 14 7 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1
# Lunghezza: 20

.text
.globl main

main:
    # Carico l'intero da terminale
    li $v0, 5
    syscall
    move $t0, $v0
    # Imposto una frase iniziale da stampare per far capire cosa sono i numeri stampati successivamente
    li $v0, 4
    la $a0, fraseIniziale
    syscall
    # Sposto il valore inserito su registro a0, dato che lo stesso registro lo avevo utilizzato per la syscall
    move $a0, $t0
    # Chiamo la funzione che ho creato , chiamata regolaDiCollatz
    jal regolaDiCollatz
    # Consideriamo di avere in a0 il nostro input
    
end: 
    # Stampo a video la frase finale
    la $a0, fraseFinale     # Carica l'indirizzo della stringa "hello" in $a0
    li $v0, 4         # Imposta il codice di syscall per la stampa di stringhe
    syscall 
    # Stampo a video la lunghezza della sequenza
    li $v0, 1
    move $a0, $t4
    syscall
    # Termino il programma
    li $v0, 10
    syscall


regolaDiCollatz:
    # Entro nella mia funzione, con una syscall stampo subito il primo valore inserito che fa parte della sequenza e incremento il 
    # contatore
    li $v0, 1
    syscall
    # Sposto il valore da a0 a t3 perchè devo liberare il registro a0 che mi servira' per stampare la stringa
    move $t3, $a0
    # Stampo la stringa per inserire uno spazio
    la $a0, spazio     # Carica l'indirizzo della stringa "spazio" in $a0
    li $v0, 4         # Imposta il codice di syscall per la stampa di stringhe
    syscall 
    # Incremento t4 che sara' il mio contatore per contare gli elementi presenti nella sequenza
    addi $t4, $t4, 1
    # Sposto in a0 il valore contenuto in t3 per ripristinare lo stato di a0 che avevo momentaneamente utilizzato per fare la syscall
    move $a0, $t3
inizio:    
    # Apro un ciclo all'interno del quale verifico subito se a0 e' uguale a 1, nel caso devo andare nella parte finale della funzione
    beq $a0, 1, fineFunzione
    #altrimenti per sicurezza mi salvo il valore del registro ra in t1
    move $t1, $ra # Salvo il valore di ra contenuto in t1 ; penso non serva perche' non faccio funzioni annidate
    # Calcolo il resto fra a0 e il numero 2
    rem  $t2, $a0, 2
    # Se il resto e' uguale a 0 allora vado nella parte della funzione che si occupa di gestire i numeri pari
    beqz $t2, divPerDue
    # Altrimenti significa che e' dispari e faccio una moltiplicazione per il valore 3
    mul $a0, $a0, 3
    # E poi compio una somma con 1
    addi $a0, $a0, 1
    # A questo punto stampo a schermo il valore contenuto in a0
    li $v0, 1
    syscall
    # E incremento il contatore
    addi $t4, $t4, 1
    # Poi sposto il valore di a0 in t3
    move $t3, $a0
    # Aggiungo uno spazio
    la $a0, spazio     # Carica l'indirizzo della stringa spazio in $a0
    li $v0, 4         # Imposta il codice di syscall per la stampa di stringhe
    syscall 
    # e ripristino il valore di a0 che mi è momentaneamente servito per la syscall
    move $a0, $t3
    j inizio # torno alla parte iniziale della funzione

divPerDue:
    # Divido a0 per 2
    div $a0, $a0, 2
    # Stampo a terminale il valore ottenuto
    li $v0, 1
    syscall
    # Incremento il contatore degli elementi sulla sequenza
    addi $t4, $t4, 1
    # Copio il valore di a0 in t3 momentanemente perchè a0 mi servirà per la syscall
    move $t3, $a0
    # Stampo a video lo spazio
    la $a0, spazio     # Carica l'indirizzo della stringa spazio in $a0
    li $v0, 4         # Imposta il codice di syscall per la stampa di stringhe
    syscall 
    # ripristino il valore di a0
    move $a0, $t3
    # Torno all'inizio della funzione
    j inizio

fineFunzione:
    # Alla fine della funzione sposto il valore calcolato dal contatore in v1 (che e' un output)
    move $v1, $t4
    # e ripristino il valore di ra che avevo storato all'inizio per assicurarmi che jr mi riporti allo stesso punto del codice
    # main di quando lo avevo interrotto
    move $ra, $t1
    jr $ra


.data
    spazio: .asciiz " "
    fraseFinale: .asciiz "\nLa lunghezza della sequenza di Collatz e': "
    fraseIniziale: .asciiz "La sequenza di Collatz per il valore inserito e':\n"
