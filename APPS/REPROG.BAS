
WIDTH 40, 25: COLOR 15: CLS : PRINT : PRINT
PRINT "ReProg -- Run a program or DOS command"
PRINT "multiple times       By Charles Martin"
PRINT : PRINT

IF COMMAND$ = "" THEN GOTO usage:

bol:
COLOR 15: CLS : COLOR 14: PRINT : PRINT "PROCEDURE:": PRINT COMMAND$: PRINT
IF REP = 0 THEN GOTO 6
PRINT "Operation has been repeated"; REP; "time";
IF REP <> 1 THEN PRINT "s." ELSE PRINT "."

6
COLOR 15: PRINT : PRINT : PRINT "Repeat the selected program"
PRINT "again?  (Press Y or N)"
rpn:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO rpg:
IF k$ = "n" THEN PRINT : PRINT "PRESS A KEY...": SLEEP: : SYSTEM
IF k$ = CHR$(27) THEN PRINT : PRINT "PRESS A KEY...": SLEEP: SYSTEM
GOTO rpn:

rpg:
COLOR 13: PRINT : PRINT : PRINT "様様様様様様様様様様様様様様様様様様様様"
PRINT : SHELL COMMAND$
COLOR 1
'PRINT : PRINT : PRINT "Error level was"
PRINT : PRINT : SHELL "pause": REP = REP + 1:  GOTO bol:

usage:
PRINT "USAGE:"
PRINT "REPROG <PROGRAM> <CMD-LINE OPTIONS"
PRINT "                  FOR <PROGRAM>>"
PRINT : PRINT
PRINT "EXAMPLES:"
PRINT "    REPROG scandisk a: /autofix"
PRINT "    REPROG format a: /q /u"
PRINT "    REPROG dir /w a:"
PRINT : PRINT : COLOR 13: PRINT "PRESS A KEY...": SLEEP: SYSTEM

