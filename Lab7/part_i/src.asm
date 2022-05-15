LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

org 00h
	ljmp main

org 000bh
	inc r6
	clr tf0
	reti

org 200h
	main:
	mov ie, #82h
	mov p1, #01h
	setb it0
	mov tmod, #11h
	acall lcd_init
	acall delay
	start:mov th0, #00h
	mov tl0, #00h
	mov r6,#00h
	mov a,#80h 	 
	acall lcd_command	 
	acall delay
	mov   dptr,#line1   
	acall lcd_sendstring
	acall delay
	mov a,#0c0h 	 
	acall lcd_command	 
	acall delay
	mov   dptr,#line2   
	acall lcd_sendstring
	acall delay_2s
	mov p1, #11h
	setb tr0
	repeat: jnb p1.0, repeat
	clr tr0
	mov p1, #00h
	/*mov a,#80h 	 
	acall lcd_command	 
	acall delay
	mov   dptr,#line6   
	acall lcd_sendstring
	acall delay
	mov a,#0c0h 	 
	acall lcd_command	 
	acall delay
	mov   dptr,#line3   
	acall lcd_sendstring
	acall delay
	mov 30h, r6
	acall hex2bin
	mov a, 60h
	acall lcd_senddata
	mov a, 61h
	acall lcd_senddata
	mov   dptr,#line4 
	acall lcd_sendstring
	acall delay
	mov 30h,th0
	acall hex2bin
	mov a, 60h
	acall lcd_senddata
	mov a, 61h
	acall lcd_senddata
	mov 30h,tl0
	acall hex2bin
	mov a, 60h
	acall lcd_senddata
	mov a, 61h
	acall lcd_senddata
	*/acall div_10
	acall div_10
	acall div_10; now val are in ms
	acall div_10; remainder r7 has ones digit
	mov 36h, r7 ; 1s digit
	acall div_10
	mov 35h, r7 ; 10s digit
	acall div_10
	mov 34h, r7 ; 100s digit
	acall div_10
	mov 33h, r7 ; 1000s digit
	acall div_10
	mov 32h, r7 ; 1000s digit
	
	
	mov a,#80h 	 
	acall lcd_command	 
	acall delay
	mov   dptr,#line6 
	acall lcd_sendstring
	mov a,#0c0h 	 
	acall lcd_command	 
	acall delay
	mov   dptr,#line3
	acall lcd_sendstring
	
	
	mov a, 32h
	add a, #30h
	acall lcd_senddata
	
	mov a, 33h
	add a, #30h
	acall lcd_senddata
	
	mov a, 34h
	add a, #30h
	acall lcd_senddata
	
	mov a, 35h
	add a, #30h
	acall lcd_senddata
	
	mov a, 36h
	add a, #30h
	acall lcd_senddata
	
	mov   dptr,#line5   
	acall lcd_sendstring
	acall delay_5s
	ljmp start
	
	
org 400h
	HEX2BIN:	
		MOV B, 30H
		MOV A, #0F0H
		ANL A, B
		SWAP A
		CJNE A, #09H, NOTEQ1
		LEQ1:MOV R1, #30H
		ADD A, R1
		MOV 60H, A
		SJMP RES1
		NOTEQ1:JC LEQ1
		GEQ1:MOV R1,#40H
		SUBB A,#09H
		ADD A, R1
		MOV 60H, A
		RES1:MOV A, #0FH
		ANL A, B
		CJNE A, #09H, NOTEQ2
		LEQ2:MOV R1, #30H
		ADD A, R1
		MOV 61H, A
		SJMP RES2
		NOTEQ2:JC LEQ2
		GEQ2:MOV R1,#40H
		SUBB A,#09H
		ADD A, R1
		MOV 61H, A
		RES2:
		RET
		
	div_10:
		mov a, tl0
		mov b, #0ah
		div ab
		mov r0, a
		mov r1, b
		
		mov a, th0
		mov b, #0ah
		div ab
		mov r2, a
		mov r3, b
		
		mov a, r6
		mov b, #0ah
		div ab
		mov r5, b
		
		mov r6, a
		
		mov a, #19h
		mov b, r5
		mul ab
		add a, r2
		mov r4, a
		mov a, #06h
		mov b, r5
		mul ab
		mov b, #0ah
		div ab
		mov r2, b
		add a, r4
		
		mov th0, a
		
		mov a, #19h
		mov b, r3
		mul ab
		add a, r0
		mov r0, a
		mov a, #06h
		mov b, r3
		mul ab
		mov b, #0ah
		div ab
		mov r4, b
		add a, r0
		mov r0, a
		mov a, r2
		mov b, #19h
		mul ab
		mov r5, a
		mov a, r2 
		mov b, #06h
		mul ab
		mov b, #0ah
		div ab
		add a, r0
		mov r0, b
		
		mov tl0, a
		
		mov a, r2
		add a, r4
		add a, r1
		mov b, #0ah
		div ab
		mov r7, b
		mov b, tl0
		add a, b
		mov tl0, a
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
	
	delay_5s:
		mov r0, #0c8h
		loop:mov th1, #3ch
		mov tl1, #0b0h
		clr tf1
		setb tr1
		wait:jnb tf1, wait
		back:djnz r0, loop
		ret
		
	delay_2s:
		mov r0, #50h
		loop3:mov th1, #3ch
		mov tl1, #0b0h
		clr tf1
		setb tr1
		wait2:jnb tf1, wait2
		back2:djnz r0, loop3
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
	
org 600h
line1:
        DB   "   Toggle SW1   ", 00H
line2:
        DB   "  if LED glows  ", 00H
line3:
		DB   "Count is ", 00H
line4:
        DB   " ", 00H
line5:
        DB   "ms", 00H
line6:
        DB   " Reaction Time  ", 00H
end