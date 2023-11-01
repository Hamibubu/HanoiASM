.data
.text
	# Inicializar el numero de discos
	# s0 es el numero de discos
	addi s0, zero, 3
	# Apuntador al inicio de la RAM para la primera torre
	lui s1, 0x10010
	slli t0, s0, 2 # t0 Es donde se guarda el espacio para cada torre
	# Inicializamos las 2 torres restantes
	add s2, t0, s1 
	add s3, t0, s2
	# s1, s2, s3 es donde se guardan las torres
	addi t1, t1, 1
	# t1 es mi i
	for:	blt s0, t1, continuar # Aqu� en el for vamos a meter los valores a la primera torre y adem�s 
		sw t1,0(s1)		# inicializar apuntadores en memoria de forma que que quede apuntando as�:
		addi t1,t1,1		#  Pointer de primera torre hasta el tope, "Para eso se hace sub s1,s1,t0" 
		addi s1,s1,4		#  |
		addi s2,s2,4		# |1 |2 |3|                        |0x0|0x0|0x0| 
		addi s3,s3,4		#				               |		
		jal for			# En las dem�s torres                     Pointer de la segunda apuntando hasta al "fondo"
	continuar:
	sub s1,s1,t0
	# hanoi(src,aux,dst)
	jal hanoi
	jal exit # Finalizaci�n

hanoi:	nop
	addi t1,zero,1
	bne s0, t1, else # if (n==1)
		sw zero,0(s1) # POP
		addi s1,s1,4  # Debemos sumar cuatro al hacer el pop para recorrer el top hasta el siguiente valor
		addi s3,s3,-4 # Debemos hacer -4 antes del push para poder subir a donde guardaremos el valor
		sw s0,0(s3)   # PUSH
		nop	      # Breakpoint para ver la posicion de los discos
	jalr ra # return
else:	nop
	# Guardamos ra, n (las torres no por la t�cnica usada de restar y sumar memoria al hacer push y pop)
	addi sp, sp , -8
	sw ra, 0(sp)
	sw s0, 4(sp)
	# Efectuamos el n-1
	addi s0,s0,-1
	# hanoi(src,dst,aux)
	# Hacemos el swap de aux -> dst y dst -> aux
	add s5,zero,s2
	add s2,zero,s3
	add s3,zero,s5
	jal hanoi
	# Debido a la t�cnica usada debemos resetar el valor de las torres
	add s6,zero,s2
	add s2,zero,s3
	add s3,zero,s6
	# Cargamos los valores del return address y n
	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp,sp,8
	sw zero,0(s1) # POP
	addi s1,s1,4 # Debemos sumar cuatro al hacer el pop para recorrer el top hasta el siguiente valor
	addi s3,s3,-4 # Debemos hacer -4 antes del push para poder subir a donde guardaremos el valor
	sw s0,0(s3)   # PUSH
	# Guardamos ra, n y las torres
	addi sp, sp , -8
	sw ra, 0(sp)
	sw s0, 4(sp)
	# Efectuamos el n-1
	addi s0,s0,-1
	# Hacemos el swap de aux -> src src -> aux
	add s7,zero,s2
	add s2,zero,s1
	add s1,zero,s7
	jal hanoi
	# Debido a la t�cnica usada debemos resetar el valor de las torres
	add s8,zero,s2
	add s2,zero,s1
	add s1,zero,s8
	# Cargamos los valores del return address y n
	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp,sp,8
	jalr ra

exit: nop # FIN
