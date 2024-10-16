# Scrivere un programma in assembly che definsice un vettore di 10 elementi con numeri casuali compresi 
# tra 0 e 999 e calcoli alcuni dati statistici:
# 1) somma
# 2) media
# 3) min
# 4) max
# PS: si consiglia di usare uan funzione per ogni analisi statistica

.text
.globl main

main:
	xor $t0, $t0, $t0 # Questo mi serve per avere un contatore che inizia da 0
	lb $t1, lunghezzaVettore # Qua inserisco la lunghezza del vettore 
	
# Prima di tutto creo il mio vettore che attualmente non esiste; ci devono essere 10 elementi quindi il mio contatore
# si deve incrementare fino ad arrivare al valore 10; ogni valore generato randomicamente lo salvo nel relativo address
randIns:
	# Verifico se il contatore ha raggiunto il numero di elementi da inserire
	beq $t0, $t1, fineRandIns
	# Genero un numero casuale facendo una syscall con il comando 42
	li $v0, 42
	li $a0, 0
	li $a1, 1000
	syscall
	
	move $t2, $a0 # Prendo il valore generato e lo copio sul registro t2
	
	# Adesso mi devo occupare di prendere i valori e di collocarli all'indirizzo giusto: per farlo e' sufficiente
	# fare load address di "vettore"; una volta ottenuto l'address posso sommare questo valore a base*indice in modo
	# che posso iterare a tutti gli indirizzi successivi necessari
	
	la $t3, vettore
	mul $t4, $t0, 2 # utilizzo 2 come base perche' sto operando con valori half
	add $t5, $t3, $t4 # Questo sara' il mio indirizzo dove vado ad inserire il valore in questa specifica iterazione
	sh $t2, ($t5) # Prendo il valore che avevo copiato in t2 generato randomicamente, e lo metto all'address t5
	
	addi $t0, $t0, 1 # Incremento il contatore per effettuare l'iterazione
	
	j randIns
	
fineRandIns:
	# Una volta generata la mia sequenza, resetto i registri in modo da poterli utilizzare durante lo svolgimento del
	# programma
	xor $v0, $v0, $v0
	xor $a0, $a0, $a0
	xor $a1, $a1, $a1
	xor $t2, $t2, $t2
	xor $t4, $t4, $t4
	xor $t5, $t5, $t5
	
# Adesso chiamo la funzione che si occupera' di effettuare la somma predisponendo gli input di cui avro' bisogno
	move $a0, $t3 # Ho bisogno anche dell'indirizzo del vettore
	move $a1, $t1 # La lunghezza del vettore mi serve all'interno della funzione
	
	jal somma
	
	# Stampo la somma
	move $t3, $v0
	li $v0, 1
	move $a0, $t3
	syscall

# Adesso chiamo la funzione che si occupera' di eseguire la media degli input; preparo i dati in input
	la $t3, vettore
	move $a0, $t3 # Ho bisogno dell'indirizzo del vettore
	lb $t1, lunghezzaVettore
	move $a1, $t1 # La lunghezza del vettore mi serve all'interno della funzione
	
	jal media 
	
	move $t3, $v0	
	li $v0, 4
	la $a0, spazio
	syscall
	move $v0, $t3
	
	# Stampo la media
	move $t3, $v0
	li $v0, 1
	move $a0, $t3
	syscall
	
# Adesso chiamo la funzione che si occupera' di calcolare il minimo, preparo i dati in input
	la $t3, vettore
	move $a0, $t3 # Anche in questo caso ho bisogno dell'indirizzo del vettore
	lb $t1, lunghezzaVettore
	move $a1, $t1 #La lunghezza del vettore mi serve all'interno della funzione
	
	jal min
	
	move $t3, $v0	
	li $v0, 4
	la $a0, spazio
	syscall
	move $v0, $t3
	
	# Stampo il minimo
	move $t3, $v0
	li $v0, 1
	move $a0, $t3
	syscall
	
# Adesso chiamo la funzione che si occupera' di calcolare il massimo, preparo i dati in input
	la $t3, vettore
	move $a0, $t3 # Anche in questo caso ho bisogno dell'indirizzo del vettore
	lb $t1, lunghezzaVettore
	move $a1, $t1 #La lunghezza del vettore mi serve all'interno della funzione
	
	jal max
	
	move $t3, $v0	
	li $v0, 4
	la $a0, spazio
	syscall
	move $v0, $t3
	
	# Stampo il massimo
	move $t3, $v0
	li $v0, 1
	move $a0, $t3
	syscall
	
end:
	li $v0, 10
	syscall

# Funzione somma, mi serve per prendere tutti i valori contenuti nel vettore per sommarli in un totalizzatore
somma:
	xor $t2, $t2, $t2 # Questo registro lo utilizzo come totalizzatore all'interno della mia funzione
	xor $t0, $t0, $t0 # Definisco il contatore
cicloSomma:
	beq $t0, $a1, fineCicloSomma
	mul $t4, $t0, 2 # utilizzo 2 come base perche' sto operando con valori half
	add $t5, $a0, $t4 # Questo sara' il mio indirizzo dove vado ad prendere il valore in questa specifica iterazione
	lh $t6, ($t5) # Prendo il valore che avevo all'indirizzo t5, e lo metto in t6
	
	add $t2, $t2, $t6 #Eseguo la somma del valore appena recuperato, nel totalizzatore
	
	addi $t0, $t0, 1 # Incremento il contatore per effettuare l'iterazione
	
	j cicloSomma

fineCicloSomma:
	# Termino il mio ciclo sposto il risultato in v0
	move $v0, $t2
	jr $ra

# Funzione Media, fondamentalmente devo fare una somma e dividere per il numero di elementi contenuti nel vettore; il modo
# piu' facile per farlo e' avere una funzione somma che effettuera' il calcolo da un determinato indirizzo fino al numero
# di elementi che vogliamo includere quindi ho bisogno di due dati, l'indirizzo e il numero di elementi
media:
	# Salva i registri che verranno modificati
    	addi $sp, $sp, -8
    	sw $ra, 4($sp)
   	sw $a1, 0($sp)
	
	jal somma
	
	# Ripristina $a1 e prepara i dati per il calcolo della media
  	lw $a1, 0($sp)
        lw $ra, 4($sp)
        addi $sp, $sp, 8
	
	move $t6, $v0 # Prendo l'output della funzione somma, che andra' divisa per il numero di elementi
	# Per effettuare un calcolo corretto, devo spostare i dati nel coprocessore matematico Coproc1 in modo da poter
	# effettuare calcoli in virgola mobile dato che vado a dividere un valore per la lunghezza del vettore e questo
	# prevedibilmente mi restituira' un valore con la virgola
	and $t7, $t6, 0xffff # Questo mi serve a fare una maschera di 16 bit per effettuare la conversione in word
	mtc1 $t7, $f1 # Sposto il valore in f1
	cvt.s.w $f1, $f1
	move $t1, $a1
	and $t5, $t1, 0xffff # Trasformo $t1, in word
	mtc1 $t5, $f2
	cvt.s.w $f2, $f2
	div.s $f3, $f1, $f2 # Effettuo la divisione mettendo il risultato in f3
	cvt.w.s $f3, $f3
	mfc1 $t2, $f3
	move $v0, $t2 # Metto il risultato della media in v0
	move $sp, $s1 # richiamo lo stack pointer che avevo storato
	jr $ra # termino la mia funzione
	
min:
	xor $t2, $t2, $t2 # Questo registro lo utilizzo come totalizzatore all'interno della mia funzione
	xor $t0, $t0, $t0 # Definisco il contatore

	lh $t7, ($a0) # Prendo il valore che avevo all'indirizzo t5, e lo metto in t6
	

cicloMin:
	beq $t0, $a1, fineCicloMin
	mul $t4, $t0, 2 # utilizzo 2 come base perche' sto operando con valori half
	add $t5, $a0, $t4 # Questo sara' il mio indirizzo dove vado ad prendere il valore in questa specifica iterazione
	lh $t6, ($t5) # Prendo il valore che avevo all'indirizzo t5, e lo metto in t6
	blt $t6, $t7, trovatoMin
	
incrementoMin:	
	addi $t0, $t0, 1 # Incremento il contatore per effettuare l'iterazione
	j cicloMin
	
trovatoMin:
	move $t7, $t6
	j incrementoMin

fineCicloMin:
	# Termino il mio ciclo sposto il risultato in v0
	move $v0, $t7
	jr $ra
	
max:
	xor $t2, $t2, $t2 # Questo registro lo utilizzo come totalizzatore all'interno della mia funzione
	xor $t0, $t0, $t0 # Definisco il contatore

	lh $t7, ($a0) # Prendo il valore che avevo all'indirizzo t5, e lo metto in t6

cicloMax: 
	beq $t0, $a1, fineCicloMax
	mul $t4, $t0, 2 # utilizzo 2 come base perche' sto operando con valori half
	add $t5, $a0, $t4 # Questo sara' il mio indirizzo dove vado ad prendere il valore in questa specifica iterazione
	lh $t6, ($t5) # Prendo il valore che avevo all'indirizzo t5, e lo metto in t6
	bgt $t6, $t7, trovatoMax
incrementoMax:	
	addi $t0, $t0, 1 # Incremento il contatore per effettuare l'iterazione
	j cicloMax
	
trovatoMax:
	move $t7, $t6
	j incrementoMax

fineCicloMax:
	# Termino il mio ciclo sposto il risultato in v0
	move $v0, $t7
	jr $ra

.data
    vettore: .space 20 # Perche' saranno valori half
    lunghezzaVettore: .byte 10
    fraseSomma: .asciiz "La somma dei valori nel vettore e': "
    spazio: .asciiz " "
