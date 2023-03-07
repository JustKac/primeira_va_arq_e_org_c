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

    add $a0, $v0, $zero				#addicionar o numero do resultado de Fibonacci ao $a0 para poder imprimir
    li  $v0, 1					#chamar a impresao de um inteiro
    syscall					#fazer

    li $v0, 10					#instrucao para encerrar o programa
    syscall					#faca

fibonacci:					#declarando a funcao
   sub $a0,$a0,1
   beq $a0, $zero, terminar			#aqui vamos jogar para o fim
   beq $t1, $zero, comeca			#aqui vamos declarar o comeco
   beq $t1, 1, calcular				#aqui joga para calcular
   
   jal fibonacci

comeca:						#definido o nome da funcao
   add $t1,$t1,1 				#pegando o primeiro resistrador 1
   beq $t1, 1, calcular				#jogar parqa calcular
 
   jal fibonacci

calcular:
   add $t2,$t1,$t2
   move $t3, $t1
   add $t3,$t1,$t2   


   #sub $t1,$t1,$t2
   
   jal fibonacci
 
terminar:
    li $v0, 10					#instrucao para encerrar o programa
    syscall					#faca
