ORG 0H
	
LJMP MAIN

ORG 100H

MAIN:
CALL SEARCH
HERE: SJMP HERE
ORG 130H

SEARCH:
// Add your code here.
MOV 33H, #0EH
MOV R2, 31H
START: 
CJNE R2, #0, CONTINUE
SJMP BACK
CONTINUE:MOV A, R2
MOV B, #2
DIV AB
MOV R2, A
ADD A, 30H
MOV R0, A
MOV A, @R0
CJNE A, 32H, CHECK
MOV 33H, R0
SJMP BACK
CHECK: JC GREATER
LESSER: MOV 31H, R2
SJMP START
GREATER:MOV A, R2
ADD A, B
SUBB A, #1
MOV 31H, A
MOV R2, A
MOV A, R0
ADD A, #1
MOV 30H, A
SJMP START
BACK:RET

END