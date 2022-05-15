org 00h
ljmp main

org 000bh
	mov p1, #0ffh 
	reti
	
org 200h
	main:
	mov ie, #82h
	mov p1, #00h
	acall timer_sub
	here:sjmp here
	
	
org 300h
	timer_sub:
	mov tmod, #01h
	mov a, 30h
	cpl a
	mov dph, a
	mov a, 31h
	cpl a
	mov dpl, a
	inc dptr
	mov tl0, dpl
	mov th0, dph
	clr tf0
	setb tr0
	ret

end