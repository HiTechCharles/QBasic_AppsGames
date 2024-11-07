DECLARE SUB GetFileList ()
DECLARE SUB PrintCol (stp$)
DECLARE SUB PrintList ()
DECLARE FUNCTION Trim$ (ttt$)
COMMON SHARED CN, longmode, PBS

IF INSTR(COMMAND$, "/L") > 0 THEN longmode = 1
IF INSTR(COMMAND$, "/P") > 0 THEN PBS = 1

COLOR 15
GetFileList
PrintList
SYSTEM

DATA EXE, COM, BAT, VBS, CMD, VBE, JS, JSE, WSF, WSH, MSC, END

SUB GetFileList
	RESTORE:  'kill "fl"
	DO UNTIL r$ = "END"
		READ r$
		SHELL "dir /b *." + r$ + " >> FL"
	LOOP
END SUB

SUB PrintCol (stp$)
	IF longmode = 1 THEN PRINT stp$: EXIT SUB

	SELECT CASE CN
		CASE IS = 0: CN = 1: HP = 1
		CASE IS = 1: HP = 1
		CASE IS = 2: HP = 15
		CASE IS = 3: HP = 29
	END SELECT

	PRINT TAB(HP); stp$;
	CN = CN + 1
	IF CN > 3 THEN CN = 1: PRINT
END SUB

SUB PrintList
	PRINT : OPEN "fl" FOR INPUT AS #1
	DO UNTIL EOF(1)
		LINE INPUT #1, r$
		r$ = UCASE$(Trim$(r$))
		IF r$ = "" OR EOF(1) THEN EXIT DO
		PrintCol r$: fr = fr + 1: lp = lp + 1
		IF longmode = 1 THEN lplimit = 22 ELSE lplimit = 66
		IF lp = lplimit AND PBS = 1 THEN
			COLOR 31: PRINT "/\/\/\/\/Press any key for more\/\/\/\/\": SLEEP
			COLOR 15: lp = 1: NC = 1
			LOCATE 23, 1: PRINT SPACE$(40): LOCATE 23, 1
		END IF
	LOOP
20  CLOSE #1: KILL "FL"
	IF fr = 0 THEN PRINT "No executable files found."
	PRINT
END SUB

FUNCTION Trim$ (ttt$)
	Trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

