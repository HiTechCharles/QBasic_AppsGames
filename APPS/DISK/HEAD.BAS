ON ERROR GOTO ErrorHandler:
COLOR 15: PRINT : PRINT : IF COMMAND$ = "" THEN GOTO usage:

OPEN COMMAND$ FOR INPUT AS #4
DO UNTIL L > 10 OR EOF(4)
    IF EOF(4) THEN EXIT DO
    L = L + 1: INPUT #4, L$: PRINT L$
LOOP
PRINT : PRINT : SYSTEM

usage:
PRINT "HEAD - Displays the first"
PRINT "10 lines of a file."
PRINT
PRINT "   USAGE:  HEAD <Filename.ext>"
PRINT "EXAMPLES:  HEAD readme.txt"
PRINT "           HEAD file_id.diz"
PRINT : PRINT : SYSTEM

ErrorHandler:
SELECT CASE ERR
    CASE IS = 53: PRINT "THE FILE "; CHR$(34); COMMAND$; CHR$(34); " COULD NOT BE FOUND.": SYSTEM
    CASE ELSE: PRINT "ERROR #"; ERR: SYSTEM
END SELECT

