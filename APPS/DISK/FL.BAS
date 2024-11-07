CLS
c$ = LTRIM$(RTRIM$(COMMAND$))
IF c$ = "" OR c$ = "/?" OR c$ = "-?" THEN GOTO usage:

OPEN c$ FOR INPUT AS #6

DO UNTIL EOF(6)
IF EOF(6) THEN GOTO alldone:
LINE INPUT #6, X$: L = L + 1: LOOP

alldone:
PLAY "o3l15cga"
COLOR 15: PRINT : PRINT "The file "; c$
PRINT "contains"; : PRINT USING "###,###,###"; L; : PRINT " lines."
SYSTEM

usage:
PRINT : PRINT "BottomLine by Charles Martin": PRINT
PRINT "This program counts how many lines"
PRINT "of text/code are in a file."
PRINT
PRINT "USAGE:"
PRINT "FL <FileName>"

