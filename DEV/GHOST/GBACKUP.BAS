DECLARE SUB Alldone ()
DECLARE SUB Cancel ()
DECLARE SUB CreateBackupDir ()
DECLARE FUNCTION DAYOFWEEK$ (m, d, y)
DECLARE SUB DoBackup ()
DECLARE SUB GetPartNum ()
DECLARE FUNCTION GhostPath$ ()
DECLARE FUNCTION i2a$ (h)
DECLARE FUNCTION Limitinput$ (AllowedChars, AllowedChars$, row, col, et$)
DECLARE SUB ParseDate ()
DECLARE SUB SystemOption ()
DECLARE FUNCTION trim$ (ttt$)
DECLARE FUNCTION WhatMonth$ (mt)
DECLARE SUB WriteCommandFile ()
COMMON SHARED pn, Folder$, bdrive$, gp$, mm, dd, yy, SysOpt$
ON ERROR GOTO ErrorHandler:

gp$ = GhostPath$
ParseDate
CreateBackupDir
GetPartNum
SystemOption
WriteCommandFile
DoBackup
Alldone


ErrorHandler:
	SELECT CASE ERR
		CASE IS = 0: SYSTEM
		CASE IS = 75: RESUME NEXT
		CASE ELSE: PRINT "ERROR #"; ERR; "OCCURED.": SYSTEM
	END SELECT

SUB Alldone
	SHELL "copy " + gp$ + "\ghost.exe " + Folder$ + " > nul"
	SHELL "copy " + gp$ + "\god.exe " + Folder$ + " > nul"
	SHELL "copy " + gp$ + "\pqboot.exe " + Folder$ + " > nul"
	SHELL "copy " + gp$ + "\grestore.exe " + Folder$ + " > nul"
	SHELL "copy " + gp$ + "\ghostexp.* " + Folder$ + " > nul"
	SHELL "copy " + gp$ + "\shutdown.com " + Folder$ + " > nul"

	IF SysOpt$ <> "P" THEN SHELL gp$ + "\Shutdown " + SysOpt$

	COLOR 15: CLS
	SHELL "DIR " + Folder$ + "\*.* /o:gn"
	PRINT
	PRINT
	PRINT "          Backup complete."
	PRINT
	PRINT
	SYSTEM
END SUB

SUB Cancel
	PRINT : PRINT : PRINT "Backup operation Canceled.":  PRINT : PRINT : SYSTEM
END SUB

SUB CreateBackupDir
BD:
	COLOR 15: CLS
	PRINT "Choose the desired drive for image file"
	PRINT "storage by letter, and hit ENTER:  >";
	bdrive$ = Limitinput$(1, "LETTERS", CSRLIN, POS(0), "")
	IF bdrive$ = CHR$(27) THEN Cancel

Make:
	SHELL bdrive$ + ":": SHELL "cd\"
	MKDIR "Backup": CHDIR "Backup"
	mm$ = i2a$(mm)
	dd$ = i2a$(dd)
	IF mm < 10 THEN mm$ = "0" + mm$
	IF dd < 10 THEN dd$ = "0" + dd$
	Folder$ = LEFT$(DAYOFWEEK$(mm, dd, yy), 3) + "_" + mm$ + dd$
	MKDIR Folder$
END SUB

FUNCTION DAYOFWEEK$ (m, d, y)
	DIM J$(7): J$(1) = "Sunday": J$(2) = "Monday": J$(3) = "Tuesday"
	J$(4) = "Wednesday": J$(5) = "Thursday": J$(6) = "Friday": J$(7) = "Saturday"

	k = INT(.6 + (1 / m)): L = y - k: O = m + 12 * k: P = L / 100: z1 = INT(P / 4)
	z2 = INT(P): z3 = INT((5 * L) / 4): z4 = INT(13 * (O + 1) / 5):
	z = z4 + z3 - z2 + z1 + d - 1: z = z - (7 * INT(z / 7))
	z = z + 1: DAYOFWEEK$ = J$(z): ERASE J$
END FUNCTION

SUB DoBackup
	SHELL gp$ + "\ghost.exe @_ghost.opt"
	KILL "_ghost.opt"
END SUB

SUB GetPartNum
GetPart:
	COLOR 15: CLS
	SHELL gp$ + "\pqboot.exe /s"
	PRINT
	PRINT
	PRINT "Select the partition to back up by number, and hit ENTER:"
	PRINT ">";
		pn = VAL(Limitinput$(1, "NUMERIC", CSRLIN, POS(0), ""))
		IF pn = 0 THEN Cancel
END SUB

FUNCTION GhostPath$
	SHELL "CD > D": OF = FREEFILE: OPEN "i", #OF, "D": LINE INPUT #OF, CD$
	GhostPath$ = trim$(UCASE$(CD$)):  CLOSE #OF: KILL "D": OF = 0: CD$ = ""
END FUNCTION

FUNCTION i2a$ (h)
	i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION Limitinput$ (AllowedChars, AllowedChars$, row, col, et$)
	allowesc = 1   'allow escape to be pushed during input

	'---------
	alc$ = UCASE$(AllowedChars$)
		SELECT CASE alc$
			CASE "ALL", "": AllowedChars$ = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+`~[]{};:'" + CHR$(34) + ",<.>/?\| "
			CASE "LETTERS": AllowedChars$ = "CDEFGHIJKLMNOPQRSTUVWXYZcdefghijklmnopqrstuvwxyz"
			CASE "NUMERIC", "NUMBERS": AllowedChars$ = "123456789"
		END SELECT
	LOCATE row, col: PRINT et$; : CONTENTS$ = et$
	LT$ = CHR$(0) + CHR$(75): RT$ = CHR$(0) + CHR$(77)
	AllowedChars$ = AllowedChars$ + CHR$(13) + CHR$(8)
	IF allowesc <> 0 THEN AllowedChars$ = AllowedChars$ + CHR$(27) + LT$ + RT$
	TC = LEN(et$): char$ = ""
	DO UNTIL INKEY$ = "": LOOP
	DO
tos:
		DO
			LOCATE CSRLIN, POS(0), 1: char$ = INKEY$
			EndCol = LEN(CONTENTS$): CurCol = POS(0)
		LOOP WHILE char$ = ""
		IF INSTR(AllowedChars$, char$) = 0 THEN GOTO tos:
		SELECT CASE char$
			CASE IS = CHR$(8)
				IF CONTENTS$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
				IF CONTENTS$ <> "" THEN CONTENTS$ = LEFT$(CONTENTS$, LEN(CONTENTS$) - 1): TC = TC - 1
			CASE IS = CHR$(13): Limitinput$ = CONTENTS$: EXIT FUNCTION
			CASE IS = CHR$(27)
				IF allowesc = 1 THEN Limitinput$ = CHR$(27): EXIT FUNCTION
			CASE IS = LT$: IF TC > 0 THEN PRINT CHR$(29); : TC = TC - 1
			CASE IS = RT$: IF TC <= AllowedChars THEN PRINT CHR$(28); : TC = TC + 1
			CASE ELSE:
				SELECT CASE TC
				  CASE IS < AllowedChars: PRINT char$; : TC = TC + 1: CONTENTS$ = CONTENTS$ + char$
				  CASE ELSE: PLAY "o2 t120 l29B": GOTO tos:
				END SELECT
		END SELECT
		LOOP
END FUNCTION

SUB ParseDate
	mm = VAL(LEFT$(DATE$, 2))
	dd = VAL(MID$(DATE$, 4, 2))
	yy = VAL(RIGHT$(DATE$, 2))
END SUB

SUB SystemOption
	PRINT : PRINT
	PRINT "When the backup is complete, what should the system do:"
	PRINT "     P.  Return to the DOS command prompt"
	PRINT "     R.  Restart"
	PRINT "     S.  ShutDown  (complete power off)": LOCATE , , 0
AfterBackup:
	k$ = UCASE$(INKEY$)
		IF k$ = "P" OR k$ = "R" OR k$ = "S" THEN SysOpt$ = k$: EXIT SUB
		IF k$ = CHR$(27) THEN Cancel
	GOTO AfterBackup:
END SUB

FUNCTION trim$ (ttt$)
	trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

FUNCTION WhatMonth$ (mt)
	SELECT CASE mt
		CASE IS = 1: WhatMonth$ = "January"
		CASE IS = 2: WhatMonth$ = "Feburary"
		CASE IS = 3: WhatMonth$ = "March"
		CASE IS = 4: WhatMonth$ = "April"
		CASE IS = 5: WhatMonth$ = "May"
		CASE IS = 6: WhatMonth$ = "June"
		CASE IS = 7: WhatMonth$ = "July"
		CASE IS = 8: WhatMonth$ = "August"
		CASE IS = 9: WhatMonth$ = "September"
		CASE IS = 10: WhatMonth$ = "October"
		CASE IS = 11: WhatMonth$ = "November"
		CASE IS = 12: WhatMonth$ = "December"
	END SELECT
END FUNCTION

SUB WriteCommandFile
	OPEN "Backups.txt" FOR APPEND AS #1: PRINT #1, DAYOFWEEK$(mm, dd, yy) + ", " + WhatMonth$(mm) + " " + i2a$(dd) + ", " + RIGHT$(DATE$, 4): CLOSE #1

	OPEN "_ghost.opt" FOR OUTPUT AS #1
		PRINT #1, "-autoname"
		PRINT #1, "-clone,mode=PDUMP,src=1:" + i2a$(pn) + ",dst=" + Folder$ + "\" + Folder$ + ".gho"
		PRINT #1, "-fx"
		PRINT #1, "-split=699"
		PRINT #1, "-z9"
	CLOSE #1
END SUB

