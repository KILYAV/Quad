TestMacro macro r0,r1,t0
	lea rcx,result
	lea rdx,r0
	lea r8,r1
	call QuadADD
	
	movdqu xmm0,[rax]
	movdqu xmm1,xmmword ptr t0
	pcmpeqb xmm0,xmm1
	pmovmskb eax,xmm0
	not ax
	test eax,eax
jnz	ERROR
endm