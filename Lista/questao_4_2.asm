.data

		source: .asciiz "Texto usado de base para testes."
		destination: .space 250
		num: .word 11
	
.text

		main:
    			la $a0, source 						# carrega o endereço de source em $a0
    			la $a1, destination 				# carrega o endereço de destination em $a1
    			lw $a2, num							# adiciona um valor ao "contador"
  				jal memcpy							# chama a função memcpy 
    			jal imprimeString					# chama a função imprimeString
    
    			j fim								# chama a função fim (Encerra o programa)

# - - - - - - - - - - - - - Inicio memcpy - - - - - - - - - - - - - 
		memcpy:
    			beqz $a2, retornoMemcpy 			# verifica se o contador ($a2) está em 0, se sim, executa o retorno
    			
    			lb $t0, ($a0) 						# carrega um byte de source em $t0
    			sb $t0, ($a1)  						# armazena o mesmo byte carregado em destination
    			
    			addi $a0, $a0, 1 					# incrementa o endereço da source
    			addi $a1, $a1, 1 					# incrementa o endereço do destination
    			subi $a2, $a2, 1 					# decrementa o contador
    			
    			j memcpy 							# repete o loop

		retornoMemcpy:
    			la $v0, destination					# $v0 = destination (String modificada)
    			jr $ra 								# volta ao endereço de chamada da função
# - - - - - - - - - - - - - Fim memcpy - - - - - - - - - - - - - 

# Imprime a String que estiver em $v0, sem perder o valor de $a0
		imprimeString:
				move $t0, $a0						# guarda o valor de $a0 em $t0
				move $a0, $v0						# move o valor de $v0 em $a0
    			li $v0, 4							# Comando Imprimir String
    			syscall
    			move $a0, $t0						# devolve o valor de $a0 que foi guardado em $t0
    			jr $ra								# volta ao endereço de chamada da função

# Encerra o programa
		fim:
    			li $v0, 10							# Comando Encerrar Programa
    			syscall
