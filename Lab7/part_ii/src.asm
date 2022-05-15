LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

org 00h
	ljmp main

org 000bh
	ljmp wave

org 200h
	main:
	clr p0.7
	mov tmod, #11h
	mov ie, #82h
	acall lcd_init
	acall delay
	mov a,#80h 	 
	acall lcd_command	 
	acall delay
	mov   dptr,#line1   
	acall lcd_sendstring
	mov dptr, #11b5h ;220hz
	;mov dptr, #0fc6h ;247hz
	;mov dptr, #0d39h ;294hz
	;mov dptr, #0a85h ;370hz
	;mov dptr, #0bcdh ;330hz
	mov r1,#03h  ;250*Tms
	;mov r1,#02h  ;250*Tms
	;mov r1,#04h  ;250*Tms
	mov a, dph
	cpl a
	mov dph, a
	mov a, dpl
	cpl a
	mov dpl, a
	inc dptr
	mov th0, dph
	mov tl0, dpl
	acall begin
	
	;mov dptr, #11b5h ;220hz
	mov dptr, #0fc6h ;247hz
	;mov dptr, #0d39h ;294hz
	;mov dptr, #0a85h ;370hz
	;mov dptr, #0bcdh ;330hz
	mov r1,#03h  ;250*Tms
	;mov r1,#02h  ;250*Tms
	;mov r1,#04h  ;250*Tms
	mov a, dph
	cpl a
	mov dph, a
	mov a, dpl
	cpl a
	mov dpl, a
	inc dptr
	mov th0, dph
	mov tl0, dpl
	acall begin
	
	;mov dptr, #11b5h ;220hz
	;mov dptr, #0fc6h ;247hz
	mov dptr, #0d39h ;294hz
	;mov dptr, #0a85h ;370hz
	;mov dptr, #0bcdh ;330hz
	mov r1,#03h  ;250*Tms
	;mov r1,#02h  ;250*Tms
	;mov r1,#04h  ;250*Tms
	mov a, dph
	cpl a
	mov dph, a
	mov a, dpl
	cpl a
	mov dpl, a
	inc dptr
	mov th0, dph
	mov tl0, dpl
	acall begin
	
	;mov dptr, #11b5h ;220hz
	mov dptr, #0fc6h ;247hz
	;mov dptr, #0d39h ;294hz
	;mov dptr, #0a85h ;370hz
	;mov dptr, #0bcdh ;330hz
	mov r1,#03h  ;250*Tms
	;mov r1,#02h  ;250*Tms
	;mov r1,#04h  ;250*Tms
	mov a, dph
	cpl a
	mov dph, a
	mov a, dpl
	cpl a
	mov dpl, a
	inc dptr
	mov th0, dph
	mov tl0, dpl
	acall begin
	
	;mov dptr, #11b5h ;220hz
	;mov dptr, #0fc6h ;247hz
	;mov dptr, #0d39h ;294hz
	mov dptr, #0a85h ;370hz
	;mov dptr, #0bcdh ;330hz
	;mov r1,#03h  ;250*Tms
	;mov r1,#02h  ;250*Tms
	mov r1,#04h  ;250*Tms
	mov a, dph
	cpl a
	mov dph, a
	mov a, dpl
	cpl a
	mov dpl, a
	inc dptr
	mov th0, dph
	mov tl0, dpl
	acall begin
	
	mov dptr, #0000h
	;mov dptr, #11b5h ;220hz
	;mov dptr, #0fc6h ;247hz
	;mov dptr, #0d39h ;294hz
	;mov dptr, #0a85h ;370hz
	;mov dptr, #0bcdh ;330hz
	;mov r1,#03h  ;250*Tms
	mov r1,#02h  ;250*Tms
	;mov r1,#04h  ;250*Tms
	mov a, dph
	cpl a
	mov dph, a
	mov a, dpl
	cpl a
	mov dpl, a
	inc dptr
	mov th0, dph
	mov tl0, dpl
	acall begin

	;mov dptr, #11b5h ;220hz
	;mov dptr, #0fc6h ;247hz
	;mov dptr, #0d39h ;294hz
	mov dptr, #0a85h ;370hz
	;mov dptr, #0bcdh ;330hz
	;mov r1,#03h  ;250*Tms
	;mov r1,#02h  ;250*Tms
	mov r1,#04h  ;250*Tms
	mov a, dph
	cpl a
	mov dph, a
	mov a, dpl
	cpl a
	mov dpl, a
	inc dptr
	mov th0, dph
	mov tl0, dpl
	acall begin
	
	;mov dptr, #11b5h ;220hz
	;mov dptr, #0fc6h ;247hz
	;mov dptr, #0d39h ;294hz
	;mov dptr, #0a85h ;370hz
	mov dptr, #0bcdh ;330hz
	;mov r1,#03h  ;250*Tms
	;mov r1,#02h  ;250*Tms
	mov r1,#04h  ;250*Tms
	mov a, dph
	cpl a
	mov dph, a
	mov a, dpl
	cpl a
	mov dpl, a
	inc dptr
	mov th0, dph
	mov tl0, dpl
	acall begin
	
	
	
org 300h
	wave:
		clr tf0
		mov th0, dph
		mov tl0, dpl
		cpl p0.7
		RETI
		
	begin:
		clr tf0
	    clr tf1
		acall delay_Tms
		ret
		
	lcd_init:
         mov   LCD_data,#38H  ;Function set: 2 Line, 8-bit, 5x7 dots
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
	     acall delay

         mov   LCD_data,#0CH  ;Display on, Curson off
         clr   LCD_rs         ;Selected instruction register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay
         mov   LCD_data,#01H  ;Clear LCD
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay

         mov   LCD_data,#06H  ;Entry mode, auto increment with no shift
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en

		 acall delay
         
         ret                  ;Return from routine

	lcd_command:
         mov   LCD_data,A     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
		 acall delay
    
         ret  
	
	 lcd_senddata:
         mov   LCD_data,a     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         acall delay
		 acall delay
         ret     
		 
	lcd_sendstring:
		push 0e0h
		lcd_sendstring_loop:
		clr   a                 ;clear Accumulator for any previous data
		movc  a,@a+dptr         ;load the first character in accumulator
		jz    exit              ;go to exit if zero
		acall lcd_senddata      ;send first char
		inc   dptr              ;increment data pointer
		sjmp  LCD_sendstring_loop    ;jump back to send the next character
		exit:    pop 0e0h
		ret        
	
	delay:push 0
		 push 1
		 mov r2,#1
		 loop2:	 mov r1,#255
		 loop1:	 djnz r1, loop1
		 djnz r2, loop2
		 pop 1
		 pop 0 
		 ret
	
	delay_Tms:
		mov b, #0ah
		mov a, r1
		mul ab
		mov r0, a
		setb tr0
		setb p0.7
		loop:mov th1, #3ch
		mov tl1, #0b0h
		clr tf1
		setb tr1
		wait:jnb tf1, wait
		back:djnz r0, loop
		clr tr1
		clr tr0
		ret
	
	send_val:
		jnb b.7, zero3
		mov a, #31h
		sjmp send3
		zero3:mov a, #30h
		send3: acall lcd_senddata
		acall delay
		jnb b.6, zero2
		mov a, #31h
		sjmp send2
		zero2:mov a, #30h
		send2: acall lcd_senddata
		acall delay
		jnb b.5, zero1
		mov a, #31h
		sjmp send1
		zero1:mov a, #30h
		send1: acall lcd_senddata
		acall delay
		jnb b.4, zero0
		mov a, #31h
		sjmp send0
		zero0:mov a, #30h
		send0: acall lcd_senddata
		acall delay
		ret
	
org 400h
line1:
        DB   "  ROLLING TIME  ", 00H

end