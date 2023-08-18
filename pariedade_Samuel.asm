# Programa que calcula o bit de paridade para o ajuste de
# paridade par de uma palavra de 32 bits armazenada em $s0.
# O valor do bit de paridade calculado será representado
# pelo bit menos significativo de $a1.
.data
 	erroPariedade: .asciiz"-Erro de Pariedade-"
 	newLine: .asciiz "\n"
.text
	li $s0, 0x0000101f # $s0 contem a palavra
		# cuja paridade se quer calcular
	li $t0, 1 # $t0 conterá a máscada de bit rotativa
	li $t1, 0 # $t1 contem o contador de iterações

	 and $a2, $s0, $t0 # $a2 contém o valor do bit testado
	move $a1, $a2 # $a1 contém o valor da paridade
		# (xor acumulativo)
	loop: sll $t0, $t0, 1 # posiciona a máscara sobre o bit
		# a ser testado
	and $a2, $s0, $t0 # testa o bit de $s0
	sgt $a2, $a2, 0 # retorna o bit de $a2 (resultado do teste)
		# para o LSB de $a2 (se $a2>0, então $a2 =1)
	xor $a1, $a1, $a2 # atualiza o XOR acumulativo
	addi $t1, $t1, 1 # incrementa o contador de iterações
	bne $t1, 30, loop # termina depois de 30 iterações
		# (os primeiros 2 bits foram testados
		# na primeira iteração)
		# imprime o valor do bit de paridade calculado
	li $v0, 1
	move $a0, $a1
	syscall


	and $a2, $s0, 1	# $a2 contém o valor do bit da palavra a ser testado
	
	la $a0, newLine #Mensagem Pular Linha
	li $v0, 4
	syscall
	
	li $v0, 1	#mostrar o valor do bit da palavra a ser testado
	move $a0, $a2
	syscall

	la $a0, newLine #Mensagem Pular Linha
	li $v0, 4
	syscall
	
	xor $a1, $a1,$a2 #operação d verificar
	
	li $v0, 1	#motrar valor final da operação
	move $a0, $a1
	syscall
	
	bne $a1, 1, feito
	#caso tenha um erro de pariedade
	la $a0, newLine #Mensagem Pular Linha
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, erroPariedade
	syscall 
	
feito: li $v0, 10
syscall
.text
