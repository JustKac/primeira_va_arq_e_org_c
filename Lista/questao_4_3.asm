.data

		str1: .asciiz "helicoptero"
    	str2: .asciiz "heliopato"
	
.text

		main:
    			la $a0, str1 						# carrega o endereço de str1 em $a0
    			la $a1, str2 						# carrega o endereço de str2 em $a1
  				jal strcmp							# chama a função strcmp 
    			jal imprimeInteiro					# chama a função imprimeInteiro
    
    			j fim

# - - - - - - - - - - - - - Inicio strcmp - - - - - - - - - - - - - 
		strcmp:
    			lb $t0, ($a0) 						# carrega um byte de str1 em $t0
    			lb $t1, ($a1) 						# carrega um byte de str2 em $t1
    			
    			beqz $t0, verificaSegundo 			# se o byte de str1 é 0(nulo), verifica str2
    			beqz $t1, primeiroMaior 			# se o byte de str2 é 0(nulo), str1 string é maior
    			bne $t0, $t1, verificaMaior 		# verifica se os bytes são diferentes. se sim, verifica qual é maior
    			
    			addi $a0,$a0 , 1 					# incrementa o endereço de str1
    			addi $a1,$a1 , 1 					# incrementa o endereço de str2
    			j strcmp 							# repete o loop

		verificaSegundo:
    			beqz $t1, iguais 					# se ambos forem 0(nulo), os bytes são iguais
    			j segundoMaior 						# se não, o byte atual de str2 é maior

		verificaMaior:
    			sgt $v0, $t0, $t1					# verifica se o byte atual de str1 é maior do que str2. se sim 1, se não 0
    			beqz $v0, segundoMaior				# se 0, $str2 é maior
    			j primeiroMaior 					# se 1, $str1 é maior

		iguais:
    			li   $v0 ,  0   					# $v0 = 0 (Strings são iguais)
    			jr   $ra         					# volta ao endereço de chamada da função

		primeiroMaior:
    			li   $v0 ,  1   					# $v0 = 1 (Primeira String é maior)
    			jr   $ra         					# volta ao endereço de chamada da função

		segundoMaior:
    			li   $v0 , -1   					# $v0 = -1 (Segunda String é maior)
    			jr   $ra         					# volta ao endereço de chamada da função
# - - - - - - - - - - - - - Fim strcmp - - - - - - - - - - - - - 


# Imprime o Inteiro que estiver em $v0
		imprimeInteiro:
				move $a0, $v0						# $a0 = $v0
    			li $v0, 1							# Comando Imprimir Inteiro
    			syscall

# Encerra o programa
		fim:
    			li $v0, 10
    			syscall
