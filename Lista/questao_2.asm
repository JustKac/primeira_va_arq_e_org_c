#Questao 2
.data
	msg: .asciiz "Por favor digite uma String: "
	str: .space 1024
.text

.main:
	#imprimir mensagem para o usuario
	la $a0, msg				#Chamar a mensagem
	li $v0, 4				#imprimir ela no console
	syscall					#fazer a funcao
	
	#leitura do str
	li $v0, 8				#Ler a string que o usuario vai passar
	la $a0, str				#salva no str
	la $a1, 1024				#tamanho da String que e aceito
	
	move $t0, $a0   			# Salva a string digitada em $t0
	
	syscall					#fazer o solicitado
	
	 li $t1,0				#aqui to chamando o null da tabela ascii

contador:					#fazendo a funcao de contagem
	lb  $a0, ($t0)				#aqui estamos pegando letra por letra e comparando com 0/null
	beq $a0,0,termina			#quando fizer essa condicao $a0 igual a 0 vai para termina
	addi $t2,$t2,1				#vai adicionando cada vez que ele percorre para verifcar
        add $t0,$t0,1				#faz com que va subindo as letras para comparar
        j   contador				#Um jump para contador

termina:
	sub $t2,$t2,1				#aqui tiramos 1, pois provalvemente estou contando ou 0 ou a pulo da linha 
	li $v0, 1				#imprimo um inteiro
	la $a0, ($t2)				#digo qual inteiro e pra imprimir 
	syscall					# faca
	li $v0, 10  				# Encerra o programa
        syscall					#faca
