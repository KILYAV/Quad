.const
mnan db 0,0,0,0,0,0,0,0,0,0,0,0,0,080h,0ffh,0ffh
pnan db 0,0,0,0,0,0,0,0,0,0,0,0,0,080h,0ffh,07fh

minf db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,0ffh,0ffh
pinf db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,0ffh,07fh

mone db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,0ffh,0bfh
pone db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,0ffh,03fh

mzer db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,000h,080h
pzer db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,000h,000h

.code
NanZer proc
	TestMacro pnan, pzer, pnan
	TestMacro pzer, pnan, pnan
	
	TestMacro pnan, mzer, pnan
	TestMacro mzer, pnan, pnan
	
	TestMacro mnan, pzer, pnan
	TestMacro pzer, mnan, pnan
	
	TestMacro mnan, mzer, pnan
	TestMacro mzer, mnan, pnan
	ret
NanZer endp

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
