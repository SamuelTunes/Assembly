.data
origem: .asciiz "Qualquer texto a ser copiado"

.text
main:
# copia o conteúdo de memória utilizado pelo string origem para uma
# área de memória alocada dinamicamente
#
# $s0 conterá o endereço do string (dados) origem
# $s1 conterá o endereço dos dados de destino da cópia
# imprime string origem
	la $a0, origem
	li $v0, 4
	syscall

	move $s0, $a0 #$s0 contem o endereço do string origem
	# imprime '/'
	li $a0, 47
	li $v0, 11
	syscall
	
	jal memcpy
	
 	# imprime o conteúdo da área destino
	move $a0, $s1
	li $v0, 4
	syscall

	li $v0, 10
	syscall # feito!	
	
	
	memcpy :
			# aloca memória para receber a cópia
	li $a0, 256 	# $a0 contem o número de bytes a serem alocados
			# (deve ser múltiplo de 4)
	li $v0,9 	# codigo 9 == aloca memória
	syscall 	# chama o serviço

			# $v0 <-- endereço do primeiro byte do bloco alocado dinamicamente
	move $s1, $v0 	#$s1 contem o endereço do destino dos dados copiados
	
	# salvar o conteúdo de todos os registradores utilizados do procedimento
	 addi $sp,$sp,-16   	# ajusta a pilha p/ novos 4 itens
         sw $t0, 12($sp)   	# salva $t0 para ser restaurado
         sw $t1, 8($sp)		# salva $t1 para ser restaurado
         sw $t2, 4($sp)		# salva $t2 para ser restaurado
         sw $t3, 0($sp) 	# salva $t3 para ser restaurado
	
	add $t0, $zero, $zero	# i=0
	
L1: 	add $t1, $s0,$t0	# na instrução t1 receberá byte por byte da mensagem($s0)
	add $t3, $s1, $t0	# na instrução t3 receberá byte por byte do endereço da mensagem($s1)
	sb  $t2, 0($t3)		# t2 está sendo carregado pelo t3
	beq $t2, $zero, out	# se t2 for zero finaliza, ou seja se não tiver mais mensagem
	addi $t0, $t0, 1	# soma constante do t0 por 1
	j L1			#retorna ao loop
	
out:		
	add $s1, $t1,$zero 	# Agora %s1 será igual ao %t1, onde $t1 foi alocado dinamicamente
	
	# recuperando o conteúdo de todos os registradores utilizados do procedimento
	lw  $t0,12($sp)
	lw  $t1,8($sp)
	lw  $t2,4($sp)
	lw  $t3,0($sp)
	addi    $sp,$sp,16 
	
 	jr $ra
.end main