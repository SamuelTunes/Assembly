 # Programa que encontra o valor máximo e minímo de um vetor de números
.data
vetor: .word 13, 34, 16, 61, 28
.word 24, 58, 11, 26, 41
.word 19, 7, 38, 12, 77
len: .word 15
mensagem: .asciiz "\nPrograma exemplo para encontrar max e min \n"
newLine: .asciiz "\n"
msgMin: .asciiz "min = "
msgMax: .asciiz "max = "

.text
.globl main
.ent main
main:
# registradores utilizados pelo programa
# $t0 - endereço do vetor
# $t1 - contador de elementos
# $s2 - min
# $s3 - max
# $t4 - cada palavra do vetor
# Mensagem de inicialização
la $a0, mensagem
li $v0, 4
syscall
# Encontra o max e o min do vetor.
# Set max e min como o primeiro elemento do vetor e então
# percorre o vetor para comparar cada elemento com o min e o max, atualizando seus
# valores quando necessário
la $s0,vetor
la $t0,len
lw $s1, ($t0)
lw $s2, ($t0)
	li $t0,1
	lw $s3,0($s0)
	add $s0,$s0,4
loop:  lw $t1,0($s0)
	bge $s3,$t1,salta
	move $s3,$t1
salta:	add $s0,$s0,4
	add $t0,$t0,1
	
	blt $t0, $s1,loop
	

	la $a0, msgMax
	li $v0, 4
	syscall

	move $a0,$s3
	li $v0,1
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall


	li $v0,10
	syscall
