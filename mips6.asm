# Si scriva un programma in linguaggio assembly che definiti due numeri in memoria riporta la
# loro media (fra interi) in $t2 Esempio: Batman=5 Robin=8 media=(5+8)/2=6

.text
.globl main

main:
	lb $t0, Batman
	lb $t1, Robin
	add $t2, $t0, $t1
	div $t2, $t2, 2

li $v0, 10
syscall

.data
	Batman: .byte 5
	Robin: .byte 8