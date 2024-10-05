#  Si scriva un programma in linguaggio assemblativo MIPS/MARS che legge una sequenza di interi positivi da tastiera (la sequenza termina quando viene inserito il valore -1), 
# conta il numero complessivo dei numeri che sono multipli di 3, di 5 oppure di 7 compresi nella sequenza e stampa questo valore. Per esempio, nel caso la sequenza in ingresso è 
# "4 8 12 15 14 8", il programma stampa il valore 3.

.text
.globl main

main:
    lb $t0, confronto # Carico il valore che utilizzo per il confronto, sara' il valore che determinera' la chiusura del programma
    lb $t2, costante1 # Carico la prima costante da verificare
    lb $t3, costante2 # Carico la seconda costante da verificare
    lb $t4, costante3 # Carico la terza costante da verificare
    li $t5, 0 # Carico il valore 0 che mi servira' per gestire il resto
    li $t6, 0 # Questo e' il contatore che si incrementa ogni volta che trova un numero divisibile per le 3 costanti
    li $t7, 1 # Mi serve per i confronti

inserisci:

    li $v0, 5 # con Syscall inserisco un valore da tastiera
    syscall
    move $t1, $v0 # Sposto questo valore nel registro t1

    beq $t1, $t0, end # Faccio un branch se il valore inserito e' uguale a -1 andando direttamente alla fine del programma

verifica3: 
    xor $t5, $t5, $t5  # Per sicurezza mi resetto il registro t5 che mi serve per verificare se c'e' resto
    rem $t5, $t1, $t2	# in t5 inserisco il valore del resto per verificare la divisione con la costante
    bge $t5, $t7, verifica5 # Faccio un branch nel caso in cui il resto e' uguale o maggiore a 1 passando direttamente alla verifica della prossima costante
    addi $t6, $t6, 1 # altrimenti incremento  il contatore che mi restituisce il risultato e jumpo ad inserire un nuovo valore
    j inserisci

verifica5:
    xor $t5, $t5, $t5 # Per sicurezza mi resetto il registro t5 che mi serve per verificare se c'e' resto
    rem $t5, $t1, $t3 # in t5 inserisco il valore del resto per verificare la divisione con la costante
    bge $t5, $t7, verifica7 # Faccio un branch nel caso in cui il resto e' uguale o maggiore a 1 passando direttamente alla verifica della prossima costante
    addi $t6, $t6, 1 # altrimenti incremento  il contatore che mi restituisce il risultato e jumpo ad inserire un nuovo valore
    j inserisci
    
verifica7:
    xor $t5, $t5, $t5 # Per sicurezza mi resetto il registro t5 che mi serve per verificare se c'e' resto
    rem $t5, $t1, $t4 # in t5 inserisco il valore del resto per verificare la divisione con la costante
    bge $t5, $t7, inserisci # Faccio un branch nel caso in cui il resto e' uguale o maggiore a 1 passando a reinserire un nuovo valore da tastiera
    addi $t6, $t6, 1 # altrimenti incremento  il contatore che mi restituisce il risultato e jumpo ad inserire un nuovo valore
    j inserisci

end:
    sw, $t6, risultato # Metto il risultato in memoria dati
    li $v0, 10 # Termino il programma
    syscall

.data
    confronto: .byte -1
    costante1: .byte 3
    costante2: .byte 5
    costante3: .byte 7
    risultato: .word 0
