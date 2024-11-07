DECLARE SUB Alldone ()
DECLARE SUB CopyHelperApps ()
DECLARE SUB CreateBurnSet ()
DECLARE SUB GetBaseName ()
DECLARE FUNCTION i2a$ (h)
DECLARE FUNCTION trim$ (ttt$)
COMMON SHARED backupfile$, NIF
ON ERROR GOTO ErrorHandler:

COLOR 15: CLS
	GetBaseName
	CreateBurnSet
	Alldone


ErrorHandler:
	SELECT CASE ERR
		CASE IS = 0: SYSTEM
		CASE IS = 75: RESUME NEXT
		CASE ELSE: PRINT "ERROR #"; ERR; "OCCURED.": SYSTEM
	END SELECT

SUB Alldone
	COLOR 15: CLS
	KILL "*.exe": KILL "*.com"
	SYSTEM
END SUB

SUB CopyHelperApps
		IF NIF = 1 THEN SHELL "move ghostexp.* cd1"
		SHELL "copy ghost.exe cd" + i2a$(NIF) + " > nul"
		SHELL "copy grestore.exe cd" + i2a$(NIF) + " > nul"
		SHELL "copy pqboot.exe cd" + i2a$(NIF) + " > nul"
		SHELL "copy shutdown.com cd" + i2a$(NIF) + " > nul"
END SUB

SUB CreateBurnSet
	SHELL "dir /b /o:gn /-p " + backupfile$ + ".0* >> BK.dat"
	OPEN "bk.dat" FOR INPUT AS #1

	DO UNTIL EOF(1)
		LINE INPUT #1, fi$: fi$ = trim$(fi$)
		IF fi$ = "" THEN EXIT DO ELSE NIF = NIF + 1

		MKDIR "CD" + i2a$(NIF)
		SHELL "move " + fi$ + " CD" + i2a$(NIF)

		IF NIF = 1 THEN CopyHelperApps
	LOOP
	CLOSE #1: CopyHelperApps: KILL "bk.dat"
END SUB

SUB GetBaseName
	SHELL "dir /b /o:gn /-p *.gho > BK.dat"
	OPEN "BK.dat" FOR INPUT AS #1
	IF LOF(1) < 4 THEN GOTO NoImage:
	LINE INPUT #1, backupfile$
	CLOSE #1:  backupfile$ = LEFT$(backupfile$, LEN(backupfile$) - 4)
	EXIT SUB
	
NoImage:
	COLOR 15: CLS
	PRINT "No Norton Ghost images found in this directory."
	PRINT "Run this program from a directory containing"
	PRINT "GHOST.EXE, and  *.GHO image files.": SYSTEM
END SUB

FUNCTION i2a$ (h)
	i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION trim$ (ttt$)
	trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

