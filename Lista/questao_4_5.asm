.data

	source: .asciiz " para testes."
	destination: .asciiz "Texto usado de base"
	
.text

	main:
    		la $a0, source 						# carrega o endere�o de source em $a0
    		la $a1, destination 					# carrega o endere�o de destination em $a1
  		jal strcat						# chama a fun��o strcat 
    		jal imprimeString					# chama a fun��o imprimeString
    
    		j fim							# chama a fun��o fim (Encerra o programa)

# - - - - - - - - - - - - - Inicio strcat - - - - - - - - - - - - - 
	strcat:
		la $t0, ($a1)  						# carrega o endere�o de $a1(source) em $t0
		la $t1, ($a0)  						# carrega o endere�o de $a0(destination) em $t0
	preparaDestino:
    		lb $t2, ($t0)  						# carrega um byte de $t0(destination) em $t2
    		beqz $t2, concatena  					# se o byte de destination for 0(nulo), come�a a concatenar
    		addi $t0, $t0, 1 					# incrementa o endere�o em $t0(destination)
    		j preparaDestino       					# repete o loop

	concatena:
    		lb   $t2, ($t1)  					# carrega um byte de $t1(source) em $t2
    		beqz $t2, retornoStrcat   				# se o byte de destination for 0(nulo),come�a o retorno
    		sb   $t2, ($t0)  					# carrega o byte no endere�o de $t0(destination)
   	 	addi $t0, $t0, 1 					# incrementa o endere�o em $t0(destination)
    		addi $t1, $t1, 1 					# incrementa o endere�o em $t1(source)
    		j concatena       					# repete o loop

	retornoStrcat:
		la $v0, destination					# $v0 = $v0
		jr $ra          					# volta ao endere�o de chamada da fun��o 
# - - - - - - - - - - - - - Fim strcat - - - - - - - - - - - - - 

# Imprime a String que estiver em $v0, sem perder o valor de $a0
	imprimeString:
		move $t0, $a0						# guarda o valor de $a0 em $t0
		move $a0, $v0						# move o valor de $v0 em $a0
    		li $v0, 4						# Comando Imprimir String
    		syscall
    		move $a0, $t0						# devolve o valor de $a0 que foi guardado em $t0
    		jr $ra							# volta ao endere�o de chamada da função

# Encerra o programa
	fim:
    		li $v0, 10						# Comando Encerrar Programa
    		syscall
    			
