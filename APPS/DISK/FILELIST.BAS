DECLARE FUNCTION trim$ (ttt$)
IF COMMAND$ <> "" THEN path$ = COMMAND$: GOTO cmd:
WIDTH 40, 25: COLOR 15: CLS : LOCATE 3, 1: INPUT "Path to the files:  ", path$

cmd:
path$ = LTRIM$(RTRIM$(UCASE$(path$)))
IF path$ = "." THEN path$ = ".\"
IF path$ = "" THEN path$ = ".\"
IF RIGHT$(path$, 1) <> "\" THEN path$ = path$ + "\"
SHELL "if exist " + path$ + "_list.txt del " + path$ + "_list.txt": OPEN path$ + "_list.txt" FOR APPEND AS #1
SHELL "DIR /a:-d /b /o:gn /-p " + path$ + "*.* >" + path$ + "_dir"
OPEN path$ + "_DIR" FOR INPUT AS #2
DO UNTIL EOF(2)
    INPUT #2, R$: R$ = UCASE$(trim$(R$))
    IF R$ = "_LIST.TXT" OR R$ = "_DIR" THEN GOTO EOL:
    PRINT #1, R$
EOL:
LOOP
CLOSE #1: CLOSE #2: SHELL "del " + path$ + "_dir":  SYSTEM

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

