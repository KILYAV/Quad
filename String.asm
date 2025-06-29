.data
string db "0x0123'4567'89ab'cdef'FEDC'BA98'7654'3210"

.code
StrToNumb proc
	movd mm0,rcx
	xor eax,eax
	mov ecx,8
	sub rdx,word
	
align xmmword
@@:	add rdx,dword
	cmp byte ptr[rdx],"'";27h
	sete al
	add rdx,rax
	dec ecx
	
	pslldq xmm1,4
	pshufd xmm0,xmm0,10010011b
	movss xmm1,xmm0
	movd xmm2,dword ptr[rdx]
	movss xmm0,xmm2
jnz	@b
	
	mov rax,0727304041476167h
	movd xmm5,rax
	punpcklbw xmm5,xmm5
	pshufhw xmm4,xmm5,01010000b
	pshufhw xmm5,xmm5,11111010b
	mov ecx,3
align xmmword
outer_loop:
	movdqa xmm2,xmm0
	movdqa xmm0,xmm1
	movdqa xmm1,xmm2
	
inner_loop:
	pshufd xmm5,xmm5,10110001b
	pshuflw xmm2,xmm5,01010000b
	pshufd xmm3,xmm2,0
	pshufd xmm2,xmm2,01010101b
	
	pcmpgtb xmm2,xmm1
	pcmpgtb xmm3,xmm1
	pandn xmm2,xmm3
	pshufd xmm3,xmm5,10101010b
	pand xmm2,xmm3
	psubb xmm1,xmm2
	
	btc ecx,0
jc	inner_loop

	pshufd xmm2,xmm4,11111111b
	pshufd xmm3,xmm4,10101010b
	pcmpgtb xmm2,xmm1
	pcmpgtb xmm3,xmm1
	pandn xmm2,xmm3
	pmovmskb eax,xmm2
	not ax
	test eax,eax
jnz	exit_nan
	
	pshufhw xmm1,xmm1,10110001b
	pshuflw xmm1,xmm1,10110001b
	pshufd xmm2,xmm4,11111111b
	psubb xmm1,xmm2
	movdqa xmm2,xmm1
	psllw xmm2,12
	por xmm1,xmm2
	psrlw xmm1,8
	
	btc ecx,1
jc	outer_loop

	packuswb xmm0,xmm1
	movd rax,mm0
	movdqu [rax],xmm0
	ret

exit_nan:
	mov eax,7ff80000h
	movd xmm0,eax
	pslldq xmm0,12
	movd rax,mm0
	movdqu [rax],xmm0
	ret
StrToNumb endp
