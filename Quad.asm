.code
align xmmword
QuadADD proc
; rcx = &result
; rdx = &A
; r8  = &B
	pxor xmm0,xmm0
	movd mm0,rcx
	
; if (mov(B) > mod(A))
;	swap(rdx,r8)
	mov r10,[rdx + qword]
	mov r11,[r8 + qword]
	btr r10,63
	btr r11,63
	
	cmp r10,r11
	cmove r10,[rdx]
	cmove r11,[r8]
	cmp r10,r11

	mov r9,rdx
	cmova r9,r8
	cmova r8,rdx
	
; ax = (exp(A) << 1) + (man(A) ? 1 : 0)
; eax = (sign << 10h) + ax
	mov rax,[r8 + qword]
	shl rax,10h
	or  rax,[r8]
	setnz al
	shr eax,1
	movzx eax,word ptr[r8 + word * 7]
	adc eax,eax
	
; if (ax == nan)
;	goto exit_nan
	cmp ax,0fffeh
ja	exit_nan

; if (ax == inf)
;	goto exit_inf
je	exit_inf

; if (ax == 0)
;	goto exit_zero
	test ax,ax
jz	exit_zero

	mov r11,[r9 + qword * 0]
	mov r10,[r9 + qword * 1]
	mov r9,[r8 + qword * 0]
	mov r8,[r8 + qword * 1]
	
; if ((-A) == B)
;	goto exit_zero
	mov rcx,r8
	mov rdx,r10
	btc rcx,63
	cmp rcx,rdx
	cmove rcx,r9
	cmove rdx,r11
	cmp rcx,rdx
jz	exit_zero

; if (mod(B) == 0)
;	goto exit_one
	mov rdx,r10
	btr rdx,63
	test rdx,rdx
	cmovz rdx,r11
	test rdx,rdx
jz	exit_one

; if (ax == 1)
;	goto exit_denorm
	cmp ax,1
je	exit_denorm

; if ((exp(A) - exp(B)) > 112)
;	goto exit_one
	mov rcx,r8
	sub rcx,r10
	shr rcx,47
	shr cx,1
	cmp cx,114
ja	exit_one

;-----------------------------
	rol r8,10h
	movzx edx,r8w
	add edx,edx
	shr dx,1
	shr r8,10h
	bts r8,48
;-----------------------------
	rol r10,10h
	movzx eax,r10w
	add eax,eax
	shr ax,1
	setnz al
	movzx eax,al
	shrd r10,rax,10h
;-----------------------------
	btc eax,0
	sub ecx,eax
	xor eax,eax
	btr ecx,10h
jc	QuadADD_sub
;-----------------------------
	shrd r11,r10,cl
	shr r10,cl
	bt ecx,6
	cmovc r11,r10
	cmovc r10,rax
;-----------------------------
	add r9,r11
	adc r8,r10
;-----------------------------
	btr r8,49
	setc cl
	movzx ecx,cl
	add edx,ecx
	mov eax,edx
	add ax,ax
	cmp dx,07fffh
je	exit_inf_too
;-----------------------------
	shrd r9,r8,cl
	shr r8,cl
	shl r8,10h
	shr eax,1
	shrd r8,rax,10h
jmp	exit_one
;-----------------------------
align xmmword
QuadADD_sub:
	shld r10,r11,15
	shld r8,r9,15
	shl r11,15
	shl r9,15
	shrd r11,r10,cl
	shr r10,cl
;-----------------------------	
	sub r9,r11
	sbb r8,r10
;-----------------------------
	bsr rcx,r8
	cmovz r8,r9
	cmovz r9,rax
	setz al
	shl eax,6
	bsr rcx,r8
	
	neg ecx
	add ecx,40h
	shld r8,r9,cl
	shl r9,cl
	dec ecx
	add ecx,eax
	sub dx,ax
;-----------------------------
align xmmword
exit_denorm:
	mov rax,r10
	btr r10,63
	xor rax,r8
jns	@f
	not r11
	not r10
	add r11,1
	adc r10,0

align xmmword
@@:	add r9,r11
	adc r8,r10
;-----------------------------
align xmmword
exit_one:
	movd rax,mm0
	movd xmm0,r9
	movd xmm1,r8
	punpcklqdq xmm0,xmm1
	movdqu [rax],xmm0
ret
;-----------------------------
align xmmword
exit_inf:
	movzx edx,word ptr[r9 + word * 7]
	add edx,edx
	cmp dx,0fffeh
	cmovne edx,eax
	cmp eax,edx
	mov edx,0ffffh
	cmovne eax,edx
;-----------------------------	
align xmmword
exit_nan:
exit_inf_too:
	shl eax,15
	movd xmm0,eax
	pslldq xmm0,12
;-----------------------------	
align xmmword
exit_zero:
	movd rax,mm0
	movdqu [rax],xmm0
ret
QuadADD endp
