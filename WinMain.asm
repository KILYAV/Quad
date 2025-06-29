include Quad.asm
include Macro.asm
include Const.asm
include String.asm
include TestNan.asm
include TestInf.asm
include TestNumb.asm

.data
result dq 0,0

.code
WinMain proc
;	call NanNan
;	call NanInf
;	call NanOne
;	call NanZer
	
;	call ZerZer
	call Numb
	ret
WinMain endp

ERROR proc
	mov rax,"ERROR"
ERROR endp
end