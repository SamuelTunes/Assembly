 # Programa que encontra o valor máximo e minímo de um vetor de números
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
la $t0, vetor # $t0 contém o endereço do vetor
lw $t1, len # $t1 contém o comprimento do vetor
lw $s2, 0($t0) # max, $s2 recebe vetor[0]
lw $s3, 0($t0) # min, $s3 recebe vetor[0]

	li $t1,0
loop:   lw $t4, 0($t0)#recebe elemento vetor[n]
	bge $s2, $t4, naomax  # compara se s2 é maior que o número atual, se não´irá para o naomax
	move $s2, $t4 # faz s2 valer o número atual
	
naomax: ble $s3, $t4, naomin # compara se s3 é menor que o número atual, se não´irá para o naomin
	move $s3, $t4 # faz s3 valer o número atual
	
naomin: add $t0,$t0,4 #altera os valores a se comparae
	add $t1, $t1, 1 #soma o tamanho atual em 1
	
	blt $t1, 15,loop #Verificação loop, se o tamanho é menor que 15
	
	la $a0, msgMax #Mensagem Máxima
	li $v0, 4
	syscall

	move $a0,$s2 #Número Máximo
	li $v0,1
	syscall
	
	la $a0, newLine #Mensagem Pular Linha
	li $v0, 4
	syscall
	
	la $a0, msgMin #Mensagem Mínima
	li $v0, 4
	syscall
	
	move $a0,$s3 #Número Mínima
	li $v0,1
	syscall