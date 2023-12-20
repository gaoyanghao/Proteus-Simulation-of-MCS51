
;18.设计单片机外扩LCD1602的接口电路。编写程序，在LCD1602上显示：“This is a display program”。

		ORG 0000H
	    LJMP START
	    ORG 0030H
START:  MOV SP,#60H
DISP:   LCALL LINIT
DP1:	MOV 3FH,#01H
	    MOV 3EH,#03H
	    MOV DPTR,#TAB1
	    MOV R7,#9
	    LCALL DIS0
DP3:	MOV 3FH,#02H
	    MOV 3EH,#01H
	    MOV DPTR,#TAB2
	    MOV R7,#15
	    LCALL DIS0
	    SJMP DP1
DIS0:   CLR A
	    MOVC A,@A+DPTR
	    MOV R1,A
	    LCALL WCH
	    INC 3EH
	    INC DPTR
	    DJNZ R7,DIS0
	    RET
RB:	    MOV P0,#0FFH
	    CLR P1.2
	    SETB P1.1
	    SETB P1.0
	    ANL P0,#7FH
	    JB P0.7,$
	    CLR P1.0
	    RET
WNC:    CLR P1.0
	    CLR P1.2
	    MOV P0,R0
	    CLR P1.1
	    SETB P1.0
	    NOP
	    CLR P1.0
	    LCALL DELAY1
	    RET
WCOM:   ACALL RB
	    LCALL WNC
	    RET
WDATA:  ACALL RB
	    CLR P1.0
	    SETB P1.2
	    MOV P0,R1
	    CLR P1.1
	    SETB P1.0
	    NOP
	    CLR P1.0
	    LCALL DELAY1
	    RET
LINIT:  MOV R0,#38H
	    LCALL WNC
	    MOV R0,#38H
	    LCALL WNC
	    MOV R0,#38H
	    LCALL WCOM
	    MOV R0,#0CH
	    LCALL WCOM
	    MOV R0,#06H
	    LCALL WCOM
	    MOV R0,#01H
	    LCALL WCOM
	    RET
WCH:    MOV R2,3FH
	    CJNE R2,#01H,WCH1
	    MOV A,#80H
	    SJMP WCH2
WCH1:   MOV A,#0C0H
WCH2:   ADD A,3EH
	    MOV R0,A
		ORL ACC,#080H
	    LCALL WCOM
	    LCALL WDATA
	    RET
DELAY1: MOV R6,#0FFH
DY:	    DJNZ R6,DY
	    RET
TAB1:   DB 'This is a'
TAB2:   DB 'display program'
	    END