section .text

AdjustValueBasedOnFactors:			; void ([rcx], xmm1, xmm2)

	mov r8d, 0x428c0000				; 65.0f (modifier)
	mov r9d, 0x43490000				; 201.0f (new max level)
	mov r10d, 0x41A00000			; 20.0f (additional constant, see cpp code)

	movd xmm0, r8d
	movd xmm3, r9d
	movd xmm4, r10d
	movd xmm5, [rcx]

	ucomiss xmm5, xmm0
	jbe .L1

	subss xmm2, xmm0
	addss xmm2, xmm5

	ucomiss xmm2, xmm3
	jbe .L1

	movss xmm2, xmm3

.L1:
	movss xmm7, xmm2
	subss xmm7, xmm5
	divss xmm7, xmm2
	mulss xmm7, xmm7

	pxor xmm2, xmm2

	ucomiss xmm7, xmm7
	jp .exit

	ucomiss xmm1, xmm2
	jbe .exit
	ucomiss xmm1, xmm4
	ja .exit

	ucomiss xmm7, xmm2
	jbe .exit
	ucomiss xmm7, xmm4
	ja .exit

	mulss xmm7, xmm1
	addss xmm7, xmm5
	movss [rcx], xmm7

.exit: