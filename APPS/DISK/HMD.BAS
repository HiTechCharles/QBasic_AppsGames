DECLARE FUNCTION I2a$ (h!)
DECLARE SUB center (row, text$)
DECLARE SUB ChooseDiskSize ()
DECLARE SUB ClearLines (lo, hi)
DECLARE SUB HowManyDisks ()
DECLARE SUB HowMuchData ()
DECLARE FUNCTION I2a$ (h)
DECLARE SUB LoadFromINI ()
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
DECLARE SUB Menu ()
DECLARE FUNCTION RoundUp (NTR)
DECLARE FUNCTION Trim$ (ttt$)

'NOD=Number of different disk types   DT=Disk Type (# for DiskType$ and DiskSize
COMMON SHARED NOD, dt
DIM SHARED disktype$(25), disksize(25)

LoadFromINI
Menu

SUB center (row, text$)
	col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB ChooseDiskSize
WIDTH 40, 25
COLOR 13: CLS : PRINT "##  Disk Type"; TAB(27); "Size  (MB)"
COLOR 15
FOR I = 1 TO NOD
	PRINT USING "##  "; I; : PRINT disktype$(I); TAB(27); USING "#,###,###.##"; disksize(I)
NEXT I
othersize = NOD + 1
PRINT USING "##  "; othersize; : PRINT "ÄOTHER DISK SIZEÄ"

GetType:
ClearLines 22, 23
COLOR 14: LOCATE 22, 1: PRINT "Type the NUMBER next to"
		  LOCATE 23, 1: PRINT "desired disk type:  >"; : COLOR 9

dt = VAL(Limitinput$(2, "0123456789", 23, 22, ""))
IF dt < 1 OR dt > othersize THEN SOUND 400, 4: GOTO GetType:

NewDiskType:
IF dt = othersize THEN
	COLOR 14: ClearLines 22, 23
	LOCATE 22, 1: PRINT "Describe the disk in words:"
	PRINT ">"; : COLOR 9: INPUT "", dt$: dt$ = Trim$(dt$)
	IF LEN(dt$) < 3 OR LEN(dt$) > 20 THEN
		ClearLines 22, 23: SOUND 420, 2: LOCATE 22, 1: PRINT "Between 3 and 20 characters, please": SLEEP 3: GOTO NewDiskType:
	END IF

disksize:
	disktype$(othersize) = dt$
	ClearLines 22, 23: COLOR 14: LOCATE 22, 1: PRINT "How much does this type of disk hold?"
	PRINT "(in MB)    >"; : COLOR 9: INPUT "", DS
	IF DS <= 0 OR DS > 9999999 THEN SOUND 800, 3: SOUND 0, 2: SOUND 800, 3: GOTO disksize:
	disksize(othersize) = DS

	IS$ = disktype$(othersize) + "=" + I2a$(disksize(othersize))

	OPEN "HMD.ini" FOR APPEND AS #1
	PRINT #1, IS$: CLOSE #1: NOD = NOD + 1
END IF

END SUB

SUB ClearLines (lo, hi)
	FOR LL = lo TO hi
		LOCATE LL, 1: PRINT SPACE$(40)
	NEXT LL
END SUB

SUB HowManyDisks

ChooseDiskSize

HowMuchData:
COLOR 11: CLS : LOCATE 2, 1: PRINT "TYPE:  "; disktype$(dt)
PRINT "SIZE:  "; I2a$(disksize(dt)); " MB"

COLOR 13: : PRINT : PRINT : PRINT "How much data needs to be stored?"
PRINT ">"; : COLOR 14: dat = VAL(Limitinput$(12, "0123456789.", CSRLIN, POS(0), ""))
IF dat <= 0 OR dat > 9999999 THEN GOTO HowMuchData:

NumDisks = RoundUp(dat / disksize(dt))
ClearLines 4, 23
COLOR 11: LOCATE 4, 1: PRINT "DATA:  "; I2a$(dat); " MB"

COLOR 15: center 13, "You will need"
center 14, I2a$(NumDisks) + " disks."

COLOR 10: center 18, "Press any key...": SLEEP
END SUB

SUB HowMuchData

ChooseDiskSize

HowMany:
COLOR 11: CLS : LOCATE 2, 1: PRINT " TYPE:  "; disktype$(dt)
PRINT " SIZE:  "; I2a$(disksize(dt)); " MB"

COLOR 13: : PRINT : PRINT : PRINT "How many disks?  >";
COLOR 14: dsk = VAL(Limitinput$(12, "0123456789.", CSRLIN, POS(0), ""))
IF dsk <= 0 OR dat > 9999999 THEN GOTO HowMany:

dat = disksize(dt) * dsk

ClearLines 4, 23: COLOR 11: LOCATE 4, 1: PRINT "DISKS:  "; I2a$(dsk)
COLOR 15: center 13, "You can store"
center 14, I2a$(dat) + " MB of data."

COLOR 10: center 18, "Press any key...": SLEEP

END SUB

FUNCTION I2a$ (h)
	I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)

allowesc = 1   'allow escape to be pushed during input

'---------
LOCATE row, col: PRINT et$; : CONTENTS$ = et$
LT$ = CHR$(0) + CHR$(75): RT$ = CHR$(0) + CHR$(77)
ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8)
IF allowesc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27) + LT$ + RT$
TC = LEN(et$): CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
tos:
	 DO
	 LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
	  EndCol = LEN(CONTENTS$): CurCol = POS(0)
	LOOP WHILE CHAR$ = ""
	 IF INSTR(ALLOWEDCHARS$, CHAR$) = 0 THEN GOTO tos:
	 SELECT CASE CHAR$
		 CASE IS = CHR$(8)
			IF CONTENTS$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
			IF CONTENTS$ <> "" THEN CONTENTS$ = LEFT$(CONTENTS$, LEN(CONTENTS$) - 1): TC = TC - 1
		 CASE IS = CHR$(13): Limitinput$ = CONTENTS$: EXIT FUNCTION
		 CASE IS = CHR$(27)
			IF allowesc = 1 THEN Limitinput$ = CHR$(27): EXIT FUNCTION
		 CASE IS = LT$: IF TC > 0 THEN PRINT CHR$(29); : TC = TC - 1
		 CASE IS = RT$: IF TC <= ALLOWEDCHARS THEN PRINT CHR$(28); : TC = TC + 1
		 CASE ELSE:
		 SELECT CASE TC
			  CASE IS < ALLOWEDCHARS: PRINT CHAR$; : TC = TC + 1: CONTENTS$ = CONTENTS$ + CHAR$
			  CASE ELSE: PLAY "o2 t120 l29B": GOTO tos:
		 END SELECT
	 END SELECT
LOOP


END FUNCTION

SUB LoadFromINI
	OPEN "HMD.ini" FOR INPUT AS #1
	DO UNTIL EOF(1)
		INPUT #1, ln$: ln$ = Trim$(ln$)
		IF ln$ = "" OR LEFT$(ln$, 1) = ";" THEN GOTO EOL:
		poe = INSTR(ln$, "="): NOD = NOD + 1
		disktype$(NOD) = LEFT$(ln$, poe - 1)
		disksize(NOD) = VAL(RIGHT$(ln$, LEN(ln$) - poe))
EOL:
	LOOP
CLOSE #1
END SUB

SUB Menu

MBEGIN:
WIDTH 40, 25: COLOR 9: CLS : center 2, "How Many Disks?"
COLOR 14: center 3, "By Charles Martin"

LOCATE 7, 1: COLOR 10
PRINT "What do you want to know?": COLOR 15
PRINT "     1. How many disks are needed to"
PRINT "        hold a known amount of data?"
PRINT
PRINT "     2. How much data will a known"
PRINT "        amount of disks hold?"
PRINT
PRINT "     3. Exit"

COLOR 13: center 17, "Press a number to choose"
		  center 18, "the desired option:"
LOCATE , , 0
gq:
	k$ = INKEY$
	 IF k$ = "1" THEN HowManyDisks: GOTO MBEGIN:
	IF k$ = "2" THEN HowMuchData: GOTO MBEGIN:
	IF k$ = "3" THEN SYSTEM
	IF k$ = CHR$(27) THEN SYSTEM
GOTO gq:

END SUB

FUNCTION RoundUp (NTR)
	RoundUp = -INT(-NTR)
END FUNCTION

FUNCTION Trim$ (ttt$)
	Trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

