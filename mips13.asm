# Sommatoria. Svolgere il totale di valori (interi) immessi da tastiera con terminazione quando il valore e' zero

.text
.globl main

main:
    lw $t1, risultato # Inserisco il valore di risultato nel registro $t1
    li $t0, 0 # Definisco a 0 il valore del registro $t0 che mi servira' per i confronti

while:
    li $v0, 5 # Serve per inserire dei valori da tastiera
    syscall
    beq $v0, $t0, end # Se il valore inserito e' 0, termina il programma
    add $t1, $t1, $v0 # altrimenti aggiunge il valore inserito da tastiera al valore contenuto in t1
    j while # salto incondizionato per ripetere fino a quando non inserisco uno zero
    
end:
    sw $t1, risultato # Store del registro t1 nella memoria "risultato"
    li $v0, 10
    syscall

.data  
    risultato: .word 0
