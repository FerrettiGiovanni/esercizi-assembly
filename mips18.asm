# Scrivere un programma in linguaggio assemblativo MARS che pone in t0 il valore 1 se l'operando definito in memoria Batman è maggiore dell'operando definito in memoria Robin.

.text
.globl main

main:
    lw $t1, batman  # Definisco il registro con il dato Batman
    lw $t2, robin   # Definisco il registro con il dato Robin
    li $t0, 1       # Load Immediate del valore 1 
    blt $t2, $t1, end # Nel caso in cui Robin fosse piu' piccolo di Batman, vado direttamente alla parte terminale del codice
    li $t0, 0       # Altrimenti assegno prima il valore 0 a t0

end:
    li $v0, 10      # Termino il programma
    syscall         # Ho utilizzato questa logica in modo da risparmiarmi 1 saltro incondizionato e una label, ho fatto il ragionamento inverso

.data
    batman: .word 4 
    robin: .word 2
