ORG 0
MAIN:
	MOV 50H,#1AH
	MOV 51H,#09H
	MOV 52H,#14H
	MOV 53H,#01H
	MOV R1, 50H
	ACALL DISPLAY
	MOV R1, 51H
	ACALL DISPLAY
	MOV R1, 52H
	ACALL DISPLAY
	MOV R1, 53H
	ACALL DISPLAY
	SJMP MAIN

ORG 200
DISPLAY: MOV A, #0F0H
	ANL A, R1
	MOV P1, A
	ACALL DELAY_1s
	MOV A, #0FH
	ANL A, R1
	SWAP A
	MOV P1, A
	ACALL DELAY_1s
	MOV P1, #0FFH
	ACALL DELAY_1s
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

END