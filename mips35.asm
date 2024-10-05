# Scrivere un programma in linguaggio assembaltivo MIPS/MARS che legga da tastiera cinque numeri interi e 
# stampi su videoterminale il risultato della media tra i cinque numeri

.text
.globl main

main:
    # Legge il primo numero float
    li $v0, 6                   # Imposta syscall per leggere un numero float
    syscall                     # Legge il numero da tastiera
    mov.s $f1, $f0              # Salva il primo numero in $f1

    # Legge il secondo numero float
    li $v0, 6
    syscall
    mov.s $f2, $f0              # Salva il secondo numero in $f2

    # Legge il terzo numero float
    li $v0, 6
    syscall
    mov.s $f3, $f0              # Salva il terzo numero in $f3

    # Legge il quarto numero float
    li $v0, 6
    syscall
    mov.s $f4, $f0              # Salva il quarto numero in $f4

    # Legge il quinto numero float
    li $v0, 6
    syscall
    mov.s $f5, $f0              # Salva il quinto numero in $f5
    
    li $t0, 5                   # Carica un valore immediato 5 in $t0
    mtc1 $t0, $f6		# Devo spostare il valore nel coprocessore per effettuare calcoli in float
    cvt.s.w $f6, $f6		# Per usare quella word, devo convertire il valore in float

    add.s $f0, $f1, $f2		# Eseguo le somme
    add.s $f0, $f0, $f3
    add.s $f0, $f0, $f4
    add.s $f0, $f0, $f5 

    div.s $f0, $f0, $f6		# Effettuo la divisione per trovare la media
    
    li $v0, 2           # Imposta syscall per stampare float
    mov.s $f12, $f0       
    syscall 

end:

.text
