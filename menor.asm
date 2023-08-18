.data
vetor: .word 13, 34, 16, 61, 28
.word 24, 58, 11, 26, 41
.word 19, 7, 38, 12, 77
tam: .word 15

.text
	la $s0,vetor
	la $t0,tam
	lw $s1,0($t0)
	li $t0,1
	lw $s3,0($s0)
	add $s0,$s0,4
volta:  lw $t1,0($s0)
	
	bge $s3,$t1,salta
	move $s3,$t1
salta:	add $s0,$s0,4
	add $t0,$t0,1
	
	blt $t0, $s1,volta
	
	move $a0,$s3
	li $v0,1
	syscall
	
	li $v0,10
	syscall