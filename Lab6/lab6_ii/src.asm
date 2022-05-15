org 00h 
	ljmp main

org 200h
	main:
	mov 30h, #01h
	mov tmod, #01h
	mov a, #28h
	mov b, 30h
	mul ab
	again:mov p1, #0ffh
	mov 31h, a
	acall delay_Ts
	mov p1, #00h
	mov 31h, a
	acall delay_Ts
	sjmp again
	
org 300h
	delay_Ts:
	loop:mov th0, #3ch
	clr tf0
	mov tl0, #0b0h
	setb tr0
	wait:jnb tf0, wait
	back:djnz 31h, loop
	exit:ret

end