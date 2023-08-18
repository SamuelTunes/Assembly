 # Programa que encontra o valor m�ximo e min�mo de um vetor de n�meros
.data
vetor: .word 13, 34, 16, 61, 28
.word 24, 58, 11, 26, 41
.word 19, 7, 38, 12, 13
len: .word 15 # comprimento do vetor
mensagem: .asciiz "\nPrograma exemplo para encontrar max e min \n"
newLine: .asciiz "\n"
msgMin: .asciiz "min = "
msgMax: .asciiz "max = "

.text
.globl main
.ent main
main:
# registradores utilizados pelo programa
# $t0 - endere�o do vetor
# $t1 - contador de elementos
# $s2 - min
# $s3 - max
# $t4 - cada palavra do vetor
# Mensagem de inicializa��o
la $a0, mensagem
li $v0, 4
syscall
# Encontra o max e o min do vetor.
# Set max e min como o primeiro elemento do vetor e ent�o
# percorre o vetor para comparar cada elemento com o min e o max, atualizando seus
# valores quando necess�rio
la $t0, vetor # $t0 cont�m o endere�o do vetor
lw $t1, len # $t1 cont�m o comprimento do vetor
lw $s2, 0($t0) # max, $s2 recebe vetor[0]
lw $s3, 0($t0) # min, $s3 recebe vetor[0]

	li $t1,0
loop:   lw $t4, 0($t0)#recebe elemento vetor[n]
	bge $s2, $t4, naomax  # compara se s2 � maior que o n�mero atual, se n�o�ir� para o naomax
	move $s2, $t4 # faz s2 valer o n�mero atual
	
naomax: ble $s3, $t4, naomin # compara se s3 � menor que o n�mero atual, se n�o�ir� para o naomin
	move $s3, $t4 # faz s3 valer o n�mero atual
	
naomin: add $t0,$t0,4 #altera os valores a se comparae
	add $t1, $t1, 1 #soma o tamanho atual em 1
	
	blt $t1, 15,loop #Verifica��o loop, se o tamanho � menor que 15
	
	la $a0, msgMax #Mensagem M�xima
	li $v0, 4
	syscall

	move $a0,$s2 #N�mero M�ximo
	li $v0,1
	syscall
	
	la $a0, newLine #Mensagem Pular Linha
	li $v0, 4
	syscall
	
	la $a0, msgMin #Mensagem M�nima
	li $v0, 4
	syscall
	
	move $a0,$s3 #N�mero M�nima
	li $v0,1
	syscall