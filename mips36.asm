# Sullo stipendio dei lavoratori lo stato applica una trattenuta fiscale in base alla seguente tabella: 
# 10000-28000 euro 23%
# 28001-50000 euro 28%
# 50001 ed oltre 43%
# Scrivere un programma in linguaggio assemblativo MIPS/MARS che, dato in input da tastiera lo stipendio di 
# un dipendente, calcola la trattenuta da versare.
# NB: Lo stipendio Ã¨ immesso da tastiera come numero intero.

.text
.globl main

main:
    # Legge un numero intero dall'input utente
    li $v0, 5
    syscall
    move $t0, $v0   # Sposta il valore letto in $t0 per ulteriori confronti

    # Converte il numero intero in virgola mobile per il calcolo successivo
    mtc1 $t0, $f0   # Trasferisce il valore da $t0 a $f0 (registro di floating point)
    cvt.s.w $f0, $f0  # Converte il valore in $f0 da word (intero) a single precision (float)

    # Imposta i valori di soglia per le varie fasce di calcolo
    li $t1, 10000
    li $t2, 28000
    li $t3, 28001
    li $t4, 50000
    li $t5, 50001

    # Valuta in quale fascia di reddito si trova il valore e salta alla label corrispondente
    ble $t0, $t1, fasciazero  # Se il valore è minore o uguale a 10000, salta a fasciazero
    ble $t0, $t2, fasciabassa  # Se il valore è minore o uguale a 28000, salta a fasciabassa
    ble $t0, $t4, fasciamedia  # Se il valore è minore o uguale a 50000, salta a fasciamedia
    bge $t0, $t5, fasciaalta  # Se il valore è maggiore o uguale a 50001, salta a fasciaalta

fasciazero:
    # Nessun calcolo da eseguire per questa fascia
    j end  # Salta direttamente alla fine del programma

fasciabassa:
    # Calcola la trattenuta per la fascia bassa
    lwc1 $f1, fasciaBassa  # Carica il coefficiente di trattenuta per la fascia bassa
    mul.s $f2, $f0, $f1   # Moltiplica il reddito per il coefficiente
    j end  # Salta alla fine del programma

fasciamedia:
    # Calcola la trattenuta per la fascia media
    lwc1 $f1, fasciaMedia
    mul.s $f2, $f0, $f1
    j end

fasciaalta:
    # Calcola la trattenuta per la fascia alta
    lwc1 $f1, fasciaAlta
    mul.s $f2, $f0, $f1
    j end

end:
    # Prepara il testo da stampare
    li $v0, 4
    la $a0, testo
    syscall

    # Stampa il valore del calcolo precedente
    li $v0, 2               # Imposta il codice di syscall per stampare un numero float
    mov.s $f12, $f2         # Assicura che il valore da stampare sia in $f12
    syscall 

.data
    testo: .asciiz "La trattenuta da versare e' "
    fasciaBassa: .float 0.23
    fasciaMedia: .float 0.28
    fasciaAlta: .float 0.43
