.data
    S1: .asciiz "eu gosto de assembly   "
    encontrou: .asciiz "Encontrou o caracter"
    nao_encontrou: .asciiz "Nao encontrou"

# observa��es:
# 1) endere�o base de S1 est� em $a1
# 2) $a2 ser� 0 se n�o encontrar o caracter, e 1 se encontrar

# lembrar que caracteres apenas ocupam 1 byte na mem�ria

.text
main:
    #l� endere�os dos strings na mem�ria	
    la $a1, S1  
 
    jal encontra_caracter
    
    beq $a2, $zero, nao  # testa se n�o encontrou
    la $a0, encontrou 
    li $v0, 4 	 
    syscall
    j feito
nao: la $a0, nao_encontrou 
    li $v0, 4 	 
    syscall
feito:    li $v0, 10
    syscall # feito!

encontra_caracter:   
        add  $t0, $zero, $zero   # i = 0
        add  $a2, $zero, $zero   # zerar o registrador $a2
    L1: add  $t1, $a1, $t0       # 
        lb   $t2, 0($t1) 
        bne $t2, 97, senao       #  se $t2 = 'a' (97d	0141octal	0x61h)
        or   $a2, $a2, 1         #  ent�o setar o registrador $a2 com 1	
 senao: beq  $t2, $zero, out     # se caracter for '\0' deixar o la�o      
        addi $t0, $t0, 1         # i = i + 1 
        j    L1                  # volta pro come�o do loop
    out: 
        jr   $ra                 # termina o procedimento

.end main
