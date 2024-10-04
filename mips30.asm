# Scrivere un programma in linguaggio assemblativo MARS che acquisito un intero positivo (da 0 a 255) inserito 
# da tastiera, scrivere il valore binario al contrario
# Esempio
# INPUT : 5 (cioè 00000101)
# OUTPUT: 160 (10100000)

# INPUT : 105 (cioè 01101001)
# OUTPUT: 150 (10010110)

.text
.globl main

main:
    li $v0, 5
    syscall
    move $t1, $v0 # Valore

    li $t2, 7 # Carico il contatore  
    move $t3, $t1 # Appoggio

    lb $t4, bitSommare  # Bit da sommare
    lb  $t5, risultato # Risultato a 0

verify:
    # Verifico se il contatore e' uguale a 0, nel caso vado alla parte terminale del codice
    beqz $t2, end
    
    # Faccio l'AND fra il valore di $t3 e 1, in modo da verificare il bit meno significativo
    andi $t4, $t3, 1 # t4 risultato dell and

    # Il valore in t4 sara' 0 o 1. Prendo questo valore e lo sommo a risultato
    add $t5, $t5, $t4 

    # Adesso ruoto a destra il bit meno significativo in modo da avere il nuovo bit meno significativo da scrivere
    rol $t5, $t5, 1 

    # Shifto verso destra i bit
    sra $t3, $t3, 1
    
    # Decremento il contatore t2 - 1
    subi $t2, $t2, 1 

    # Resetto il t4     
    xor $t4, $t4, $t4  # Questo setta tutti i bit in $t4 a 00000000

    # Salto all'inizio di verify
    j verify

end:
    sb $t5, invertito
    li $v0, 10 # Termino il programma
    syscall
 
.data
	invertito: .byte 0
	bitSommare: .byte 0
	risultato: .byte 0

