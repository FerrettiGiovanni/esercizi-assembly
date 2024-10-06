# La ridotta n-esima della serie armonica è definita come: Hn =1+ 1/2 + 1/3 +...+ 1/n Si scriva un programma in 
# linguaggio assemblativo MIPS/MARS che ripeta i passi seguenti:
# legga da tastiera un numero intero n
# se il numero è minore o uguale a 0 termina l'esecuzione
# se il numero è maggiore di 0 stampa Hn (cioè la somma dei primi n termini della serie)

.text
.globl main

main:
    li $v0, 5                   # Imposta syscall per leggere un intero da tastiera
    syscall                     # Esegui syscall
    move $t0, $v0               # Sposta il valore letto in $t0
    
    blez $t0, end               # Se $t0 <= 0, vai alla fine del programma
    
    addi $t0, $t0, 1            # Incrementa $t0 di 1 per usare nel ciclo

    mtc1 $t0, $f0               # Carica $t0 nel registro del coprocessore $f0
    cvt.d.w $f0, $f0            # Converte il valore in $f0 da intero a double
    
    li $t1, 1                   # Imposta $t1 a 1
    mtc1 $t1, $f4               # Carica $t1 nel registro del coprocessore $f4
    cvt.d.w $f4, $f4            # Converte il valore in $f4 da intero a double
    mov.d $f6, $f4              # Copia il valore di $f4 in $f6 per usare come denominatore

ridotta:
    add.d $f2, $f2, $f4         # Aggiunge il valore in $f4 a $f2 (inizialmente zero)
    c.eq.d $f0, $f2             # Confronta $f0 con $f2 per vedere se hanno raggiunto il valore n
    bc1t printResult            # Se sono uguali, salta a printResult
    div.d $f6, $f6, $f2         # Divide $f6 per $f2, aggiornando $f6 per il prossimo termine
    add.d $f8, $f8, $f6         # Aggiunge il nuovo termine calcolato a $f8
    j ridotta                   # Ripeti il ciclo

printResult:
    li $v0, 3                   # Imposta syscall per stampare un float/double
    mov.d $f12, $f8             # Muove $f8 in $f12, preparandolo per la stampa
    syscall                     # Esegui la syscall per stampare

end:
    li $v0, 10                  # Imposta syscall per terminare il programma
    syscall                     # Esegui syscall

