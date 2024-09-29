# Scrivere un programma che, definiti due numeri appartenenti all'intervallo [-32768,32767] in memoria, X e Y, determina le seguenti informazioni:
# $t0=0 se X è un numero positivo o $t0=1 se X è un numero negativo (non usare l'istruzione di salto)
# $t1=0 se Y è pari $t1=1 se Y è dispari (non usare operazioni logiche-aritmetiche e istruzioni di salto)
# $t2 riporta X+Y

.text
.globl main

main:
    lh $t4, x 
    lh $t5, y 

    sra $t0, $t4, 15 # Posso prendere il bit piu' significativo e shiftarlo fino a farlo diventare il bit meno significativo, che sara' 1 nel caso negativo e 0 se positivo
    andi $t0, $t0, 0x00000001 # Normalizza il risultato a 0 o 1
    
    rem $t1, $t5, 2 # Se Y e' dispari il resto sara' 1 se e' pari invece sara' 0 
    andi $t1, $t1, 0x00000001 # Normalizza il risultato a 0 o 1

    add $t2, $t4, $t5 # Semplice somma fra due valori 

.data
    x: .half 23489
    y: .half -23422
