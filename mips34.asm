# Si scriva un programma in linguaggio assemblativo MIPS/MARS per calcolare il massimo comun divisore (MCD) di due numeri interi positivi. Il MCD è definito come il massimo tra i 
# divisori comuni ai due numeri.
# Suggerimento. Si considerino due numeri interi N1 e N2. Il MCD di N1 e N2 è il massimo tra i numeri che sono divisori (con resto uguale a zero) sia di N2 che di N1. In particolare, 
# si supponga che sia N1 minore di N2. Il MCD è il massimo tra i numeri compresi tra 1 e N1 che sono divisori (con resto uguale a zero) sia di N1 che di N2.

.text
.globl main

main:
    li $v0, 5                   # Imposta $v0 a 5 per preparare la syscall di input intero
    syscall                     # Esegue la syscall; il risultato (numero intero) e' salvato in $v0
    move $t1, $v0               # Trasferisce il valore letto da $v0 a $t1

    li $v0, 5                   # Imposta nuovamente $v0 a 5 per un'altra lettura di input intero
    syscall                     # Esegue la syscall; il secondo numero intero e' salvato in $v0
    move $t2, $v0               # Trasferisce il secondo valore letto da $v0 a $t2

    li $t3, 1                   # Carica il valore 1 in $t3, presumibilmente per un uso successivo nel programma

    ble $t1, $t2, sposto        # Branch if Less or Equal: salta all'etichetta 'sposto' se $t1 <= $t2
                                # Se $t1 e' minore o uguale a $t2, esegue il salto e salta le istruzioni di scambio

    move $t6, $t1               # Usa $t6 come registro temporaneo per tenere il valore di $t1
    move $t1, $t2               # Scambia i valori di $t1 e $t2: ora $t1 contiene il valore di $t2
    move $t2, $t6               # Completa lo scambio: ora $t2 contiene il valore originale di $t1

sposto:    
    move $t4, $t1              # Copia il valore di $t1 in $t4
    move $t5, $t2              # Copia il valore di $t2 in $t5

    xor $t6, $t6, $t6          # Azzera il registro $t6 usando l'operazione XOR su se stesso

    rem $t7, $t2, $t1          # Calcola il resto della divisione di $t2 per $t1 e salva il risultato in $t7
    beqz $t7, risultatot1      # Se $t7 e' zero (cioe' se $t2 e' divisibile per $t1), salta all'etichetta "risultatot1"

    move $t9, $t1              # Copia il valore di $t1 in $t9. (Attenzione: qui c'e' un errore di sintassi, manca la virgola dopo $t9)

    xor $t7, $t7, $t7          # Azzera nuovamente il registro $t7


trovoMcd:
    subi $t9, $t9, 1          # Sottrae 1 da $t9, decrementando il contatore o l'indice
    beq $t9, $t3, end         # Verifica se $t9 e' uguale a $t3; se vero, salta all'etichetta 'end'
    rem $t6, $t1, $t9         # Calcola il resto della divisione di $t1 per $t9 e lo memorizza in $t6
    beqz $t6, verificat2      # Se $t6 e' zero (cioe' se $t1 e' divisibile per $t9), salta all'etichetta 'verificat2'
    j trovoMcd                # Salta all'etichetta 'trovoMcd' per continuare il processo di ricerca dell'MCD


verificat2:
    rem $t7, $t2, $t9
    beqz $t7, trovatoMcd
    j trovoMcd

trovatoMcd:
    sw $t9, risultato 
    
    li $v0, 4           # Imposta syscall per stampare stringa
    la $a0, testo      # Carica l'indirizzo della stringa
    syscall
    
    li $v0, 1           # Imposta syscall per stampare intero
    move $a0, $t9       # Trasferisce il valore da $t0 a $a0
    syscall 
      
    j end

risultatot1:
    sw $t1, risultato
    
    li $v0, 4           # Imposta syscall per stampare stringa
    la $a0, testo      # Carica l'indirizzo della stringa
    syscall
    
    li $v0, 1           # Imposta syscall per stampare intero
    move $a0, $t1       # Trasferisce il valore da $t0 a $a0
    syscall 
    
    j end

end:
    li $v0, 10
    syscall

.data
    risultato: .word 1
    testo: .asciiz "Il Massimo Comune Divisore e':  "
