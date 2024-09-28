# Verificare se un numero e' primo, registro t2 se primo 0 se non e' primo 1

#flowchart TD
#    A[Start] --> B{Il numero n e' <= 1?}
#    B -->|Si| C[Non e' primo]
#    B -->|No| D{Verifica divisori da 2 fino a un certo numero}
#    D --> E{Divisore trovato senza resto?}
#    E -->|Si| F[Non e' primo]
#    E -->|No| G[Verifica il divisore successivo]
#    G --> H{Verificati tutti i divisori?}
#    H -->|No| D
#    H -->|Si| I[E' primo]
#    C --> J[End]
#    F --> J
#    I --> J

.text
.globl main

main:
    lw $t0, numero #Carico il valore numerico su registro t0 [Assegnazione]
    li $t1, 2 # Definisco il primo valore che utilizzo per effettuare le divisioni [Assegnazione]
    li $t2, 0 # Definisco il numero come primo assegnando al registro t2 0 [E' primo]
    ble $t0, 1, assegna # Salto condizionale, se il numero e' minore o uguale a 1, salta ad assegna {Il numero n e' <= 1?}
    div $t4, $t0, 2 # Divido per 2 il valore massimo da verificare in fase di confronto di divisioni
    addi $t4, $t4, 1 # Aggiungo 1 in modo che divido per potro' fare n/2 + 1

verifica:
    beq $t1, $t4, end # In t4 ho il valore massimo da raggiungere e lo confronto con il valore che incrementa, se sono uguali esce dal ciclo 
    		      # {Verificati tutti i divisori?}
    rem $t3, $t0, $t1 # Calcolo il resto {Verifica divisori da 2 fino a un certo numero} 
    beq $t3, 0, assegna # Se il resto e' 0 allora non e' un numero primo {Divisore trovato senza resto?}
    addi $t1, $t1, 1 #altrimenti provo il prossimo divisore [Verifica il divisore successivo]
    j verifica

assegna:
    li $t2, 1 # Il numero non e' primo [Non e' primo]

end:
    li $v0, 10
    syscall # Termino il programma

.data
    numero: .word 10831


