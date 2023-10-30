.data
.text
	# Inicializar el número de discos
	addi s0, zero, 3
	# Apuntador al inicio de la RAM para la primera torre
	lui s1, 0x10010 
	addi t0, zero, 4
	mul t0, s0, t0
	# Inicializamos las 2 torres restantes
	add s2, t0, s1
	add s3, t0, s2
	