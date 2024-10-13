# Dati due dadi con facce numerate da 0 a 5. Lanciare due dadi e scrivere su videoterminare se Ã¨ 
# uscita una coppia.

.text
.globl main

main:
    li $t2, 1 # Devo effettuare 2 tiri di dado

tiraDadi:
    li $a0, 0 # Definisco il limite minimo
    li $a1, 5 # Definisco il limite massimo
    li $v0 42 # Faccio la syscall per la generazione di numeri randomici
    syscall
    beq $t0, $t2, verifica # Verifico se t2 e' uguale a t0
    move $t1, $a0 # Sposto a0 in t1
    addi $t0, $t0, 1 # Sommo t0 di una unita'
    xor $a0, $a0, $a0 # Resetto a0 perchè devo essere sicuro che sia impostato su 0
    j tiraDadi

verifica:
    beq $t1, $a0, coppia # Verifico se t1 e' uguale a a0 , nel caso vado in coppia
    li $v0 4 # syscall per stampare su terminale che non era una coppia
    la $a0, nonTrovato
    syscall
    j end

coppia:    
    li $v0, 4 # Syscall per stampare a terminale che e' uscita una coppia
    la $a0, trovato
    syscall

end:
    li $v0, 10
    syscall

.data
    nonTrovato: .asciiz "Mi dispiace non e' uscita una coppia"
    trovato: .asciiz "Ottimo! E' uscita una coppia!"
