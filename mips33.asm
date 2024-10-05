# Scrivere un programma in linguaggio assemblativo MIPS/MARS che, letti tre numeri interi da tastiera stampa su videoterminale la sequenza dei tre numeri in ordine monotono 
# non decrescente.
# Esempio: a = 10, b = 7, c = 9 deve dare in uscita 7 9 10.

.text
.globl main

main:  

    li $v0, 5                  # Imposta $v0 per la syscall di lettura di un intero
    syscall                    # Esegue la syscall che legge un intero dall'input e lo pone in $v0
    move $t4, $v0              # Trasferisce il valore letto in $t4

    li $v0, 5                  # Imposta nuovamente $v0 per la stessa syscall di lettura
    syscall                    # Esegue la syscall, legge il secondo intero
    move $t5, $v0              # Trasferisce il secondo valore letto in $t5

    li $v0, 5                  # Imposta ancora $v0 per un'altra lettura
    syscall                    # Esegue la syscall, legge il terzo intero
    move $t6, $v0              # Trasferisce il terzo valore letto in $t6

verifica1:
    # Verifica se t4 è minore o uguale a t5
    ble $t4, $t5, verifica2    # Se t4 è minore o uguale a t5, salta a verifica2
    move $t7, $t4              # Altrimenti, scambia t4 e t5 utilizzando t7 come temporaneo
    move $t4, $t5              # Completa lo scambio di t4 con t5
    move $t5, $t7              # Completa lo scambio di t5 con t7 (originariamente t4)

verifica2:
    # Verifica se t5 è minore o uguale a t6
    ble $t5, $t6, store        # Se t5 è minore o uguale a t6, procedi al salvataggio (assumendo che "store" sia definito altrove)
    move $t7, $t5              # Altrimenti, scambia t5 e t6 utilizzando t7 come temporaneo
    move $t5, $t6              # Completa lo scambio di t5 con t6
    move $t6, $t7              # Completa lo scambio di t6 con t7 (originariamente t5)
    xor $t7, $t7, $t7          # Resetta t7 a zero
    j verifica1                # Ritorna a verifica1 per garantire che l'ordine sia corretto


store:
    # Trasferimenti dei valori tra registri
    move $t0, $t4          # Copia il valore da $t4 a $t0
    move $t1, $t5          # Copia il valore da $t5 a $t1
    move $t2, $t6          # Copia il valore da $t6 a $t2
    
    # Salvataggio dei valori nei rispettivi spazi di memoria
    sw $t0, primovalore    # Salva il contenuto di $t0 nella memoria all'indirizzo di primovalore
    sw $t1, secondovalore  # Salva il contenuto di $t1 nella memoria all'indirizzo di secondovalore
    sw $t2, terzovalore    # Salva il contenuto di $t2 nella memoria all'indirizzo di terzovalore

end: 
    li $v0, 1           # Imposta syscall per stampare intero
    move $a0, $t0       # Trasferisce il valore da $t0 a $a0
    syscall    
    
    # Stampa uno spazio
    li $v0, 4           # Imposta syscall per stampare stringa
    la $a0, space       # Carica l'indirizzo della stringa spazio
    syscall
    
    li $v0, 1           # Imposta syscall per stampare intero
    move $a0, $t1       # Trasferisce il valore da $t0 a $a0
    syscall   
    
    # Stampa uno spazio
    li $v0, 4           # Imposta syscall per stampare stringa
    la $a0, space       # Carica l'indirizzo della stringa spazio
    syscall
    
    li $v0, 1           # Imposta syscall per stampare intero
    move $a0, $t2       # Trasferisce il valore da $t0 a $a0
    syscall   
    
    li $v0, 10
    syscall 
    
    
    
.data
    primovalore: .word 0   # Alloca spazio per il primo valore
    secondovalore: .word 0 # Alloca spazio per il secondo valore
    terzovalore: .word 0   # Alloca spazio per il terzo valore
    space: .asciiz " "
