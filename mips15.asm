# Scrivere un programma in linguaggio assemblativo MARS che, definiti due numeri (word) in memoria spazio e tempo, 
# che fanno riferimento ad un punto mobile nello spazio, determina : La velocità del punto che si muove in modo rettilineo uniforme (risultato in $t0)

.text
.globl main

main:
    lw $t1, spazio	# Carico nei registri i relativi valori 
    lw $t2, tempo
    
    div $t1, $t2	# Divido il valore attuando la formula Velocita' = Spazio / Tempo
    mflo $t0  		# Prendo solo la parte intera facendo una approssimazione

    li $v0, 10		# Termino il programma
    syscall

.data
    spazio: .word 900
    tempo: .word 150
