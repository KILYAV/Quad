TestMacro macro r0,r1,t0
	call XMMFF
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

.code
NanOne proc
	TestMacro pnan, pone, pnan
	TestMacro pone, pnan, pnan
	
	TestMacro pnan, mone, pnan
	TestMacro mone, pnan, pnan
	
	TestMacro mnan, pone, pnan
	TestMacro pone, mnan, pnan
	
	TestMacro mnan, mone, pnan
	TestMacro mone, mnan, pnan
	
	ret
NanOne endp

NanInf proc
	TestMacro pnan, pinf, pnan
	TestMacro pinf, pnan, pnan
	
	TestMacro pnan, minf, pnan
	TestMacro minf, pnan, pnan
	
	TestMacro mnan, pinf, pnan
	TestMacro pinf, mnan, pnan
	
	TestMacro mnan, minf, pnan
	TestMacro minf, mnan, pnan
	
	ret
NanInf endp

NanNan proc
	TestMacro pnan, pnan, pnan
	TestMacro pnan, mnan, pnan
	TestMacro mnan, pnan, pnan
	TestMacro mnan, mnan, pnan
	
	ret
NanNan endp

XMMFF proc
	pcmpeqb xmm0,xmm0
	pcmpeqb xmm1,xmm1
	pcmpeqb xmm2,xmm2
	pcmpeqb xmm3,xmm3
	pcmpeqb xmm4,xmm4
	pcmpeqb xmm5,xmm5
	pcmpeqb xmm6,xmm6
	pcmpeqb xmm7,xmm7
	
	pcmpeqb xmm8,xmm8
	pcmpeqb xmm9,xmm9
	pcmpeqb xmm10,xmm10
	pcmpeqb xmm11,xmm11
	pcmpeqb xmm12,xmm12
	pcmpeqb xmm13,xmm13
	pcmpeqb xmm14,xmm14
	pcmpeqb xmm15,xmm15
	
	ret
XMMFF endp

ERROR proc
	mov rax,"ERROR"
ERROR endp