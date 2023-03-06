.data
msg: .asciiz "Digite um numero, por favor: " 	#mensagem que vai aparecer para o usuario

.text
main:
    li $v0,  4  				#imprimir um string
    la $a0,  msg				#Buscar a mensagem e por ela em $a0, pois so imprime em $a0
    syscall             			#Faca
    li $v0,  5					#para ler um inteiro
    syscall            				#faca
    add $a0, $v0, $zero 			#mover de $v0 para $a0

    jal fibonacci             			#chamar a funcao Fibonacci

    add $a0, $v0, $zero
    li  $v0, 1
    syscall

    li $v0, 10
    syscall

fibonacci:
    #save in stack
    addi $sp, $sp, -12 
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)

    add $s0, $a0, $zero

    addi $t1, $zero, 1
    beq  $s0, $zero, return0
    beq  $s0, $t1,   return1

    addi $a0, $s0, -1

    jal fib

    add $s1, $zero, $v0         # $s1 = fib(y - 1)

    addi $a0, $s0, -2

    jal fib                     # $v0 = fib(n - 2)

    add $v0, $v0, $s1           # $v0 = fib(n - 2) + $s1

    exitfib:

        lw   $ra, 0($sp)        # read registers from stack
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        addi $sp, $sp, 12       # bring back stack pointer
        jr $ra

    return1:
        li $v0,1
        j exitfib

    return0:     
        li $v0,0
        j exitfib