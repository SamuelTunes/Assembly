#O programa basicamente carrega um número da variável varg, desloca os bits individualmente e 
#imprime cada bit usando a função imprime_bit. O programa continua fazendo isso até imprimir 
#todos os 32 bits do número. Cada bit é impresso na saída padrão, seguido por um espaço. O programa então encerra a execução.
.data

varg: .word 0x00FF00FE
.text
.globl main
.ent main
main:
# carga da variável sobre o registrador $s1
lw $s1, varg
# zera o registrador $a1
li $a1, 0

loop: # início do laço
beq $a1, 32, stop
andi $t0, $s1, 0x80000000 # $t1 = $s1 AND 1
srl $t0, $t0, 31
jal imprime_bit # imprime bit representado por $t0
addi $a1, $a1, 1 # incrementa $a1
sll $s1, $s1, 1
j loop # volta pro início do laço
# procedimento de impressão dos resultados (conteúdo de $t0)
imprime_bit:
li $v0, 1 # imprime $t0
move $a0, $t0
syscall
li $v0, 11 # imprime espaço
li $a0, ' '
syscall
jr $ra # retorna do procedimento
stop:
li $v0, 10
syscall # feito!
.end main


