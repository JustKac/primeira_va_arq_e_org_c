 .data 
		quebraDeLinha: .byte 10						# valor em byte para quebra de linha
		shell: .asciiz "\nMJJ-shell>> "				# texto utilizado após quebra de linha para simular um terminal
.text
		# Endereços Terminal MMIO
		# Reciever Control - 0xffff0000  	->  Guarda os valores:  0 = não tem input | 1 = tem input
		# Reciever Data - 0xffff0004		->  Guarda o valor do input (caso tenha input)
	
		# Endereços Display MMIO
		# Transmiter Control - 0xffff0008	->  Guarda os valores:  0 = display pronto | 1 = display não está pronto
		# Transmiter Data - 0xffff000c		->  Guarda os valores a serem exibidos no display

		lb $a1, quebraDeLinha
	
		aguardaEntrada:
				lw $t0,0xffff0000             		# $t0 = valor de controle(0 ou 1) do Reciever Control
				andi $t0,$t0,1               		# extrai o bit de controle
				beqz $t0,aguardaEntrada       		# se for zero(não tem input), aguarda

				lw $a0,0xffff0004                 	# $a0 = valor do input(data) do Reciever Data
				beq $a0, $a1, casoQuebraLinha		# $a0 == $a1 (se for uma quebra de linha), imprime o "shell"

		aguardaDisplay:
				lw $t1,0xffff0008	                # $t1 = valor de controle(0 ou 1) do Transmiter Control
				andi $t1,$t1,1               		# extrai o bit de controle
    			beqz $t1,aguardaDisplay   			# se for zero(display não está pronto), aguarda

    			sw $a0,0xffff000c                 	# Transmiter Data = $a0

    			j aguardaEntrada					# reinicia o loop
    		
    	
    	casoQuebraLinha:
    			la $t0, shell 						# carrega o endereço da string em $t0

		imprime:
 				lb $a0, ($t0) 						# carrega um caractere da string em $a0
  				beqz $a0, aguardaEntrada 			# se for zero (fim da string), sai do loop

		aguarda:
  				lw $t1, 0xffff0008 					# $t1 = valor de controle(0 ou 1) do Transmiter Control
  				andi $t1, $t1 , 1 					# extrai o bit de controle
  				beqz $t1, aguarda 					# se for zero(display não está pronto), aguarda

  				sw $a0, 0xffff000c 					# Transmiter Data = $a0
   				addi $t0, $t0, 1 					# incrementa o endereço da string
  				j imprime 							# reinicia o loop
