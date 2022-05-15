LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

org 00h
	ljmp main
	
org 200h
	main:
	mov 70h, #12h
	mov 71h, #23h
	mov P2,#00h
	acall delay
	acall lcd_init
	acall delay
	mov tmod, #01h
	;------level 1------
	;----LCD-----;	
	start:mov a,#80h 	 
	acall lcd_command	 
	acall delay
	mov   dptr,#level1   
	acall lcd_sendstring
	acall delay
	mov a, #49h
	mov a,#0C4h		  
	acall lcd_command
	acall delay
	mov   dptr,#value
	acall lcd_sendstring
	mov a, 70h
	swap  a
	mov b, a
	acall send_val
	;------END LCD------;
	mov a, 70h
	swap  a
	mov p1, a
	acall delay_1s
	;----end level1----;
	
	;----level 2----------
	;----LCD-----;
	mov a,#80h 		 
	acall lcd_command	 
	acall delay
	mov   dptr,#level2  
	acall lcd_sendstring	   
	acall delay
	mov a,#0C4h		  
	acall lcd_command
	acall delay
	mov   dptr,#value
	acall lcd_sendstring
	mov b, 70h
	acall send_val
	;------END LCD------;
	mov p1, 70h
	acall delay_1s
	;----------end level2------;
	
	;------level 3-----
	;----LCD-----;
	mov a,#80h 		 
	acall lcd_command	 
	acall delay
	mov   dptr,#level3  
	acall lcd_sendstring	   
	acall delay
	mov a,#0C4h		  
	acall lcd_command
	acall delay
	mov   dptr,#value
	acall lcd_sendstring
	mov a, 71h 
	swap a
	mov b, a
	acall send_val
	;------END LCD------;
	mov a, 71h 
	swap a
	mov p1, a 	
	acall delay_1s
	;--------end level3--------
	
	;---------level 4---------
	;----LCD-----;
	mov a,#80h 		 
	acall lcd_command	 
	acall delay
	mov   dptr,#level4  
	acall lcd_sendstring	   
	acall delay
	mov a,#0C4h		  
	acall lcd_command
	acall delay
	mov   dptr,#value
	acall lcd_sendstring 
	mov b, 71h
	acall send_val
	;------END LCD------;
	mov p1, 71h
	acall delay_1s
	;--------end level4--------
	ljmp start
	
	
org 300h
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
	
	delay_1s:
		mov r0, #28h
		loop:mov th0, #3ch
		mov tl0, #0b0h
		clr tf0
		setb tr0
		wait:jnb tf0, wait
		back:djnz r0, loop
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
level1:
        DB   "    Level 1     ", 00H
level2:
        DB   "    Level 2     ", 00H
level3:
        DB   "    Level 3     ", 00H
level4:
        DB   "    Level 4     ", 00H
value:
		DB   "Value:", 00H

end