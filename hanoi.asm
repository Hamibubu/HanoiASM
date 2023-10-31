.data
.text
	# Inicializar el número de discos
	# s0 es el número de discos
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
	for:	blt s0, t1, continuar
		sw t1,0(s1)
		addi t1,t1,1
		addi s1,s1,4
		addi s2,s2,4
		addi s3,s3,4
		jal for
	continuar:	nop
	sub s1,s1,t0
	addi s2,s2,-4
	addi s3,s3,-4
	#hanoi(src,aux,dst)
	jal hanoi
	jal exit

hanoi:	nop
	addi t1,zero,1
	bne s0, t1, else # if (n==1)
		sw zero,0(s1) # POP
		addi s1,s1,4
		sw s0,0(s3)   # PUSH
		addi s3,s3,-4
	jalr ra # return
else:	nop
	# Guardamos ra, n y las torres
	addi sp, sp , -8
	sw ra, 0(sp)
	sw s0, 4(sp)
	# Efectuamos el n-1
	addi s0,s0,-1
	# hanoi(src,dst,aux)
	add s5,zero,s2
	add s2,zero,s3
	add s3,zero,s5
	jal hanoi
	add s6,zero,s2
	add s2,zero,s3
	add s3,zero,s6
	# Cargamos para la segunda recursividad
	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp,sp,8
	sw zero,0(s1) # POP
	addi s1,s1,4
	sw s0,0(s3)   # PUSH
	addi s3,s3,-4
	# Guardamos ra, n y las torres
	addi sp, sp , -8
	sw ra, 0(sp)
	sw s0, 4(sp)
	# Efectuamos el n-1
	addi s0,s0,-1
	add s7,zero,s2
	add s2,zero,s1
	add s1,zero,s7
	jal hanoi
	add s8,zero,s2
	add s2,zero,s1
	add s1,zero,s8
	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp,sp,8
	jalr ra

exit: nop	
	
	

	
	
