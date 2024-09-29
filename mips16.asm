# Scrivere un programma che converta un valore da scala Celsius a scala Fahrenheit ( °F = (°C * 9/5) + 32 )
# Definire in memoria una variabile intera (word) riportante il valore in scala Celsius
# Riportare il risultato in scala Fahrenheit in $t0 e in una cella in memoria
# ES: gradoC=38 quindi $t0=100
# OSS: Utilizzare le operazione tra interi (il valore risultante puo' essere approssimato)

.text
.globl main

main:
    lw $t1, gradoC	# Carico i valori nei registri 
    li $t2, 9		# Decido di caricare le costanti con dei load immediate
    li $t3, 5
    li $t4, 32
    
    mul $t1, $t1, $t2 	# Moltiplico per 9
    div $t1, $t3	# Divido per 5
    mflo $t1		# Approssimo il risultato prendendo la parte lo del valore restituito
    add $t1, $t1, $t4	# A questo valore aggiungo 32 come da formula
    move $t0, $t1	# Sposto il risultato nel registro t0

.data
    gradoC: .word 38
