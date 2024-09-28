# Calcola fattoriale di un numero

.text
.globl main

main:
    lw $t0, numero # Inserisco nel registro t0 il valore "numero" definito nella memoria dati
    lw $t1, temp # Inserisco nel registro t1 il valore "temp" definito nella memoria dati
    
fattoriale:
    ble	$t0, 1, end # Verifico se il valore del registro t1 che corrisponde a "temp" sia minoe o uguale a 1, nel caso vado nella parte terminale del codice
    mul $t1, $t1, $t0 # Se così non fosse, moltiplico il valore nel registro t1 con t0 che corrisponde al valore "numero"
    subi $t0, $t0, 1  # Decremento il valore di "numero" 
    j fattoriale # Salto nuovamente all'inzio di fattoriale, creando un ciclo

end:
    sw $t1, risultato # Store del valore di t1 in "risultato"
    li $v0, 10 # termino il programma
    syscall


.data
    numero: .word 5
    temp: .word 1
    risultato: .word 1
