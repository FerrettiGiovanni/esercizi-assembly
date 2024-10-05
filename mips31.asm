# Si scriva un programma in linguaggio assemblativo MIPS/MARS che letto un numero intero positivo dallo 
# standard input (tastiera), restituisce il cubo del numero stesso facendo uso soltanto 
# di operazioni di somma.

.text
.globl main

main:
    li $v0, 5 # Definisco l'input in t0
    syscall
    move $t0, $v0

    lw $t1, cubo # Cubo
    move $t2, $t1 # Contatore  quanto CUBO
    move $t3, $t0 # Appoggio input
    move $t4, $t0 # Appoggio Risultato

    li $t5, 1 # Mi serve per i confronti

verifica:
    beq $t2, $t5, end # Verifica se il contatore di appoggio è 0
    
    move $t6, $t4 # registro d'appogio che mi serve per eseguire le somme nel ciclo annidato

potenza:
    beq $t3, $t5, endVerifica # Devo eseguire questo for annidato per N Volte l'input inserito
    add $t4, $t4, $t6 # Eseugo n-1 somme

    subi $t3, $t3, 1 # Decremento il valore d'appogio di n
    j potenza # Salto incondizionato all'inizio di potenza

endVerifica:
    move $t3, $t0 # Ripristino il valore d'appoggio
    subi $t2, $t2, 1 # Decremento il contatore del CUBO
    j verifica

end:
    sw $t4, risultato # Faccio Store del Risultato
    li $v0, 10	      # Termino il proramma
    syscall

.data
    cubo: .word 3
    risultato: .word 0
