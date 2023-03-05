# Questao 1
.data

	i: .asciiz "Digite uma palavra ou texto: "
	ii: .asciiz "Digite um caractere que faca parte fa palavra ou texto: "
	iii: .asciiz "\nDigite outro caractere que faca parte fa palavra ou texto: "
	v: .asciiz "\nA nova palavra ou texto é: "
	
	palavra: .space 250
	
.text 

	# Pirmeira parte da questão 1
	
	li $v0, 4 		# imprimir uma String
	la $a0, i		# $a0 = "Digite uma palavra ou texto: "
	syscall
	
	li $v0, 8		# Ler uma String
	la $a0, palavra		# $a0 = Entrada do usuario
	la $a1, 250		# Define o tamanho permitido pela entrada do usuário
	syscall 
	
	la $t0, palavra		# Move a entrada (String) do usuario para $t0
	
	# Segunda parte da questão 1
	
	li $v0, 4 		# imprimir uma String
	la $a0, ii		# $a0 = "Digite um caractere que faca parte fa palavra ou texto: "
	syscall
	
	li $v0, 12		# Ler um char
	syscall 
	
	move $t1, $v0		# Move a entrada (String) do usuario para $t1
	
	# Terceira parte da questão 1
	
	li $v0, 4 		# imprimir uma String
	la $a0, iii		# $a0 = "Digite outro caractere que faca parte fa palavra ou texto: "
	syscall
	
	li $v0, 12		# Ler um char
	syscall 
	
	move $t2, $v0		# Move a entrada (String) do usuario para $t2
	
	# Quarta parte da questão 1
	
	loop:
  	lb $a0, ($t0)  		# carrega o próximo caractere da string em $a0
  	beq $t1, $a0, altera	
  	beqz $a0, continue 	# se o caractere for nulo, sair do loop
  	addi $t0, $t0, 1  	# incrementa o endereço da string
  	j loop   		# volta para o início do loop
  	
  	altera:
  	sb $t2, ($t0)
  	j loop
	
	# Quinta parte da questão 1
	 
	continue:
	
	li $v0, 4 		# imprimir uma String
	la $a0, v		# $a0 = "A nova palavra é: "
	syscall
	
	li $v0, 4		# Imprimir uma String
	la $a0, palavra		# $a0 = entrada do usuário alterada
	syscall 
	
  	li $v0, 10   		# define o valor da syscall para sair do programa
  	syscall      		# chama a syscall para sair do programa
