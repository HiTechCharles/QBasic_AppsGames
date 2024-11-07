DECLARE SUB Alldone ()
DECLARE SUB DoRestore ()
DECLARE SUB GetBaseName ()
DECLARE SUB GetPartNum ()
DECLARE FUNCTION i2a$ (h)
DECLARE SUB SystemOption ()
DECLARE FUNCTION trim$ (ttt$)
DECLARE SUB WriteCommandFile ()
COMMON SHARED pn, backupfile$, NIF
ON ERROR GOTO ErrorHandler:

COLOR 15: CLS
	GetBaseName
	GetPartNum
	WriteCommandFile
	DoRestore
	Alldone


ErrorHandler:
	SELECT CASE ERR
		CASE IS = 0: SYSTEM
		CASE IS = 75: RESUME NEXT
		CASE ELSE: PRINT "ERROR #"; ERR; "OCCURED.": SYSTEM
	END SELECT

SUB Alldone
	COLOR 15: CLS
	PRINT "          Restore complete."
	PRINT
	PRINT "          The newly restored partition has been set"
	PRINT "          active.  Restarting the computer will allow"
	PRINT "          you to boot the restored operating system."
	PRINT "          Computer will immediately reboot; otherwise,"
	PRINT "          press the computer's power button to shutdown."
	PRINT
	PRINT
	CLS : SHELL "pqboot /p:" + i2a$(pn)
END SUB

SUB DoRestore
	SHELL "ghost.exe @_ghost.opt"
	KILL "_ghost.opt"
END SUB

SUB GetBaseName
	SHELL "dir /b /o:gn /-p *.gho > BK.dat"
	OPEN "BK.dat" FOR INPUT AS #1
	IF LOF(1) < 5 THEN GOTO NoImage:
	LINE INPUT #1, backupfile$
	CLOSE #1:  backupfile$ = LEFT$(backupfile$, LEN(backupfile$) - 4)

	SHELL "dir /b /o:gn /-p " + backupfile$ + ".* > BK.dat"
	OPEN "bk.dat" FOR INPUT AS #1
	
	DO UNTIL EOF(1)
		LINE INPUT #1, fi$: fi$ = trim$(fi$)
		IF fi$ = "" THEN EXIT DO ELSE NIF = NIF + 1
	LOOP
	CLOSE #1: KILL "bk.dat": EXIT SUB
	
NoImage:
	COLOR 15: CLS :
	PRINT "No Norton Ghost images found in this directory."
	PRINT "Run this program from a directory containing"
	PRINT "GHOST.EXE, and *.GHO image files.": SYSTEM
END SUB

SUB GetPartNum
GetPart:
	COLOR 15: CLS
	SHELL "pqboot.exe /s"
	PRINT
	PRINT
	PRINT "Select the partition to restore to by number, and hit ENTER:"
	INPUT ">", pn
	IF pn < 1 OR pn > 3 THEN GOTO GetPart:
END SUB

FUNCTION i2a$ (h)
	i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION trim$ (ttt$)
	trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

SUB WriteCommandFile
	OPEN "_ghost.opt" FOR OUTPUT AS #1
		IF NIF > 1 THEN PRINT #1, "-autoname"
		PRINT #1, "-clone,mode=PLOAD,src=" + backupfile$ + ".gho:1,dst=1:" + i2a$(pn)
		PRINT #1, "-fx"
	CLOSE #1
END SUB

