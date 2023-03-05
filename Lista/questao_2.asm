.data
	msg: .asciiz "Por favor digite uma String: "
	str: .space 1024
.text

.main:
	#imprimir mensagem para o usuario
	la $a0, msg
	li $v0, 4
	syscall
	
	#leitura do str
	li $v0, 8
	la $a0, str
	la $a1, 1024
	
	move $t0, $a0   # Salva a string digitada em $t0
	
	syscall
	
	 li $t1,0

contador:
	lb  $a0, ($t0)
	beq $a0,0,termina
	bne $a0,$t1,proximo
	
proximo:
	addi $t2,$t2,1
        add $t0,$t0,1
        j   contador

termina:
	sub $t2,$t2,1
	li $v0, 1
	la $a0, ($t2)
	syscall
	li $v0, 10  # Encerra o programa
        syscall