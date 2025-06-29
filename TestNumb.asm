.const
p0071 db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,071h,000h
p0070 db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,070h,000h

m7ffe db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,0feh,0ffh

mthr db 0,0,0,0,0,0,0,0,0,0,0,0,0,080h,000h,0c0h

mtoo db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,000h,0c0h
ptoo db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,000h,040h

mmin db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,001h,080h
pmin db 0,0,0,0,0,0,0,0,0,0,0,0,0,000h,001h,000h

mden db 0,0,0,0,0,0,0,0,0,0,0,0,0,080h,000h,080h
pden db 0,0,0,0,0,0,0,0,0,0,0,0,0,080h,000h,000h

.code
ZerZer proc
	TestMacro mzer, mzer, pzer
	TestMacro mzer, pzer, pzer
	TestMacro pzer, mzer, pzer
	TestMacro pzer, pzer, pzer
	ret
ZerZer endp

Numb proc
	TestMacro mtoo, pone, mone
	
	ret
Numb endp