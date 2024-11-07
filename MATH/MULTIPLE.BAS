WIDTH 40, 25: COLOR 10: CLS
PRINT "This program shows you the multiples of"
PRINT "a number.  For Example:  NUMBER is 3,"
PRINT "computer responds:  3, 6, 9, 12, 15,"
PRINT "18 ,21...  Press any key to quit"
PRINT "after choosing a number."

PRINT : PRINT
INPUT "NUMBER:  ", n: ns = n

OPEN "Multiple.txt" FOR APPEND AS #1: PRINT #1, nc
COLOR 15: CLS : st = TIMER
DO WHILE INKEY$ = ""
    PRINT n;
    n = n + ns
    PRINT #1, n
    nom = nom + 1
LOOP

COLOR 14: PRINT : PRINT #1, "": PRINT #1, STRING$(79, "-")
PRINT #1, "": PRINT TIMER - st; "s   "; nom; "multiples of"; ns: CLOSE #1
SYSTEM

