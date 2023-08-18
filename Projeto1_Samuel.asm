.data

varg: .word 0x00FF00FE
.text
.globl main
.ent main
main:
# carga da vari�vel sobre o registrador $s1
lw $s1, varg
# zera o registrador $a1
li $a1, 0

loop: # in�cio do la�o
beq $a1, 32, stop
andi $t0, $s1, 0x80000000 # $t1 = $s1 AND 1
srl $t0, $t0, 31
jal imprime_bit # imprime bit representado por $t0
addi $a1, $a1, 1 # incrementa $a1
sll $s1, $s1, 1
j loop # volta pro in�cio do la�o
# procedimento de impress�o dos resultados (conte�do de $t0)
imprime_bit:
li $v0, 1 # imprime $t0
move $a0, $t0
syscall
li $v0, 11 # imprime espa�o
li $a0, ' '
syscall
jr $ra # retorna do procedimento
stop:
li $v0, 10
syscall # feito!
.end main


