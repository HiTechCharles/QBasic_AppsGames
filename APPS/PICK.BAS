DECLARE SUB center (row!, text$)
COLOR 15
IF COMMAND$ = "" THEN GOTO usage:
IF COMMAND$ = "/?" OR COMMAND$ = "?" THEN GOTO usage:
C$ = LTRIM$(RTRIM$(COMMAND$)): OPEN C$ FOR INPUT AS #6: RANDOMIZE TIMER
DO UNTIL EOF(6): IF EOF(6) THEN GOTO AllDone:
LINE INPUT #6, X$: l = l + 1: LOOP
AllDone:
CLOSE #6: OPEN C$ FOR INPUT AS #6: skip = INT(RND * (l - 1))
IF skip = 0 THEN GOTO GetIt:
DO UNTIL skip < 1: skip = skip - 1: LINE INPUT #6, X$: LOOP
GetIt:
PRINT : PRINT : LINE INPUT #6, item$: item$ = UCASE$(item$):
item$ = LTRIM$(RTRIM$(item$)): center CSRLIN, "The chosen item is..."
center CSRLIN, item$: PRINT : PRINT : SYSTEM

usage:
PRINT : PRINT "PICK-ONE By Charles Martin"
PRINT : PRINT "Randomly picks an item out of"
PRINT "the user-specified list."
PRINT : PRINT "USATE:  PICK <List FileName>": PRINT : SYSTEM

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

