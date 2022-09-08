;**************** Stepper Motor *************
; 2-bit Control input S1, S0 (P1.1, P1.0) in R2
;S1S0 -> 00 - Clock wise
;S1S0 -> 01 - Anticlock wise
;S1S0 -> 1x - STOP
; Stepper Motor interfaced to P0.3 downto P0.0
;*************************************************
        ORG		00h
		SJMP	main
		
;************** Main routine begins ***********
		ORG		64h
MAIN:
        ACALL   INIT
CONTINUE:
        ACALL   READ_CI
        ACALL   STEP_ROT
        SJMP    CONTINUE
;************** Main routine ends ***********

INIT:
        ;Configure Port 0 and 1 as inputs
        MOV     P1, #0xFF
        RET

READ_CI:
        ;Read control inputs from Port-1 to R2
        MOV     A, P1
        ANL     A, #0x3
        MOV     R2, A
        RET 
        
STEP_ROT:
        ;As per the control inputs in R2 
        ;Rotate stepper motor
        CJNE    R2, #0x0, N1
        ACALL   CLKW
        RET
N1:
        CJNE    R2, #0x1, N2
        ACALL   ACLKW
        RET
N2:     
        RET

        ;clock wise rotation of stepper motor
CLKW:
        MOV     P0, #8
        ACALL   DELAY
        MOV     P0, #4
        ACALL   DELAY
        MOV     P0, #2
        ACALL   DELAY
        MOV     P0, #1
        ACALL   DELAY
        RET
        
        ;Anti clock wise rotation of stepper motor
ACLKW:
        MOV     P0, #2
        ACALL   DELAY
        MOV     P0, #4
        ACALL   DELAY
        MOV     P0, #8
        ACALL   DELAY
        MOV     P0, #1
        ACALL   DELAY
        RET
        
DELAY:
        DJNZ    R4, DELAY
        DJNZ    R5, DELAY
        DJNZ    R6, DELAY
        RET
        
        END
        
        
