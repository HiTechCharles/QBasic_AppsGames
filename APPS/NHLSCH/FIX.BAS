DECLARE FUNCTION Squeeze$ (Orig$, Char$)
DECLARE FUNCTION trim$ (ttt$)
GetTeamCode:
    WIDTH 80, 25: COLOR 15: CLS
    INPUT "Which team?  (3 letters):   >", team$
    team$ = UCASE$(trim$(team$))

    OPEN "TXT\" + team$ + ".txt" FOR INPUT AS #1
    OPEN "txt\" + team$ + ".xyz" FOR APPEND AS #2

    DO UNTIL EOF(1)
        LINE INPUT #1, origline$: origline$ = trim$(origline$)

        IF origline$ = "" OR RIGHT$(origline$, 6) = ".html>" THEN GOTO EOL:  ELSE PRINT #2, origline$
        IF INSTR(origline$, "Planning") > 0 THEN EXIT DO

EOL:
    LOOP

CLOSE 1, 2
KILL "TXT\" + team$ + ".txt"
NAME "TXT\" + team$ + ".xyz" AS "TXT\" + team$ + ".txt"
SHELL "edit TXT\" + team$ + ".txt"
SYSTEM

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

