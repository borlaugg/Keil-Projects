LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable
ORG 00H
LJMP MAIN

ORG 30H
MAIN:ACALL lcd_init 
	ACALL STATE0
	ACALL STATE1
	ACALL STATE2
	ACALL STATE3
	HERE: SJMP HERE
	
ORG 200H
	
STATE0:
	SETB P1.7
	SETB P1.6
	SETB P1.5
	SETB P1.4
	MOV R1, #80H
	ACALL lcd_command	 ;send command to LCD
	ACALL delay
	MOV   DPTR,#S0   ;Load DPTR with sring1 Addr
	ACALL lcd_sendstring	   ;call text strings sending routine
	ACALL delay
	MOV R1,#0C0h		  
	ACALL lcd_command
	ACALL delay
	MOV   DPTR,#DEF
	ACALL lcd_sendstring
	ACALL DELAY_1s
	SETB P1.7
	SETB P1.6
	SETB P1.5
	SETB P1.4
	RET

STATE1:

	MOV R1, #80H
	CLR P1.7
	CLR P1.6
	CLR P1.5
	CLR P1.4
	ACALL lcd_command	 
	ACALL delay
	MOV   DPTR,#S1   
	ACALL lcd_sendstring	  
	ACALL delay

	MOV R1,#0C0h
	ACALL lcd_command
	ACALL delay
	MOV   DPTR,#DEF
	ACALL lcd_sendstring
	ACALL delay
	SETB P1.7
	SETB P1.0
	SETB P1.1
	SETB P1.2
	SETB P1.3
	
	ACALL DELAY_2s
	CLR P1.7
	MOV A, P1
	SWAP A
	ANL A,#0F0H
	SETB P1.6
	SETB P1.0
	SETB P1.1
	SETB P1.2
	SETB P1.3
	
	ACALL DELAY_2s
	CLR P1.6
	MOV B, P1
	ANL B, #0FH
	ADD A,B
	MOV 30H, A
	SETB P1.5
	SETB P1.0
	SETB P1.1
	SETB P1.2
	SETB P1.3
	
	ACALL DELAY_2s
	CLR P1.5
	MOV A, P1
	SWAP A
	ANL A,#0F0H
	SETB P1.4
	SETB P1.0
	SETB P1.1
	SETB P1.2
	SETB P1.3
	
	ACALL DELAY_2s
	CLR P1.4
	MOV B, P1
	ANL B, #0FH
	ADD A,B
	MOV 31H, A
	CLR P1.3
	CLR P1.2
	CLR P1.1
	CLR P1.0
	RET
	
STATE2:
	MOV R1, #80H
	ACALL lcd_command	 ;send command to LCD
	ACALL delay
	MOV   DPTR,#S2   ;Load DPTR with sring1 Addr
	ACALL lcd_sendstring	   ;call text strings sending routine
	ACALL delay
	CLR P1.7
	CLR P1.6
	CLR P1.5
	CLR P1.4
	MOV R1,#0C0h
	ACALL lcd_command
	ACALL delay
	MOV DPTR,#NUM1   
	ACALL lcd_sendstring	  
	ACALL delay
	
	MOV 34H, 30H
	ACALL HEX2BIN
	MOV A, 60H
	ACALL lcd_senddata
	MOV A, 61H
	ACALL lcd_senddata
	
	MOV   DPTR,#COMM   ;Load DPTR with sring1 Addr
	ACALL lcd_sendstring	   ;call text strings sending routine
	ACALL delay
	
	MOV DPTR,#NUM2   ;Load DPTR with sring1 Addr
	ACALL lcd_sendstring	   ;call text strings sending routine
	ACALL delay
	
	MOV 34H, 31H
	ACALL HEX2BIN
	MOV A, 60H
	ACALL lcd_senddata
	MOV A, 61H
	ACALL lcd_senddata	   ;call text strings sending routine
	
	MOV A, 31H
	MOV B, 30H
	MUL AB
	MOV 50H, A
	MOV 51H, B
	RET
	
STATE3:
	MOV R1, #80H
	ACALL lcd_command	 ;send command to LCD
	ACALL delay
	MOV DPTR, #S3  ;Load DPTR with sring1 Addr
	ACALL lcd_sendstring	   ;call text strings sending routine
	ACALL delay
	
	MOV 34H, 51H
	ACALL HEX2BIN
	MOV A, 60H
	ACALL lcd_senddata
	MOV A, 61H
	ACALL lcd_senddata
	
	MOV 34H, 50H
	ACALL HEX2BIN
	MOV A, 60H
	ACALL lcd_senddata
	MOV A, 61H
	ACALL lcd_senddata
	
	MOV DPTR,#space  
	ACALL lcd_sendstring	   
	ACALL delay
	
	MOV R1,#0C0h
	ACALL lcd_command
	ACALL delay
	MOV DPTR,#NUM1   
	ACALL lcd_sendstring	  
	ACALL delay
	
	MOV 34H, 30H
	ACALL HEX2BIN
	MOV A, 60H
	ACALL lcd_senddata
	MOV A, 61H
	ACALL lcd_senddata
	
	MOV   DPTR,#COMM   ;Load DPTR with sring1 Addr
	ACALL lcd_sendstring	   ;call text strings sending routine
	ACALL delay
	
	MOV DPTR,#NUM2   ;Load DPTR with sring1 Addr
	ACALL lcd_sendstring	   ;call text strings sending routine
	ACALL delay
	
	MOV 34H, 31H
	ACALL HEX2BIN
	MOV A, 60H
	ACALL lcd_senddata
	MOV A, 61H
	ACALL lcd_senddata
	
	ACALL DELAY_2s
	RET
	
HEX2BIN:	
	MOV B, 34H
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
         mov   LCD_data,R1     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
		 acall delay
    
         ret  
	     
 lcd_senddata:
         mov   LCD_data,A     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         acall delay
		 acall delay
         ret                  ;Return from busy routine
		 
delay:	 push 0
		 push 1
         mov r0,#1
loop2:	 mov r1,#255
loop1:	 djnz r1, loop1
		 djnz r0, loop2
		 pop 1
		 pop 0 
	ret
	
DELAY_2S:PUSH 00H
	MOV R3, #10 
	h5: ACALL DELAY_200ms 
	DJNZ R3, h5
	POP 00h 
	RET
DELAY_1s:PUSH 00h 
	MOV R4, #5 
	h4: ACALL DELAY_200ms 
	DJNZ R4, h4
	POP 00h 
	RET

DELAY_200ms: PUSH 00h
	MOV R5, #20
	h3: ACALL DELAY_10ms 
	DJNZ R5, h3 
	POP 00h 
	RET
	
DELAY_10ms:PUSH 00h 
	MOV R6, #40 
	h2: ACALL delay_250us 
	DJNZ R6, h2 
	POP 00h 
	RET

delay_250us: push 00h 
	mov r7, #244 
	h1: djnz r7, h1 
	pop 00h 
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
		 
org 300h	
S0:
         DB   "  ENTER INPUTS  ", 00H
S1:
         DB   " READING INPUTS ", 00H
S2:
         DB   "COMPUTING RESUTS", 00H
S3:
         DB   " RESULT = ", 00H
DEF:
		 DB   "   EE337-2022   ", 00H
NUM1:
		 DB   "NUM1:", 00H
NUM2:
		 DB   " NUM2:", 00H
COMM:
		 DB   ",", 00H		
space:
		 DB   "  ", 00H
END