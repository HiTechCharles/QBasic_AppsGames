begin:
WIDTH 40, 25: COLOR 15: CLS
LOCATE 2, 1: PRINT "This program will raise a"
PRINT "number to a power."

DO UNTIL INKEY$ = "": LOOP
COLOR 9: LOCATE 6, 1: PRINT "(Type 0 to quit)"
LOCATE 5, 1: INPUT "What is the base?  ", B
IF B <> 0 THEN GOTO EX:
IF B = 0 THEN SYSTEM

EX:
COLOR 10: LOCATE 8, 1: PRINT B; : INPUT "to what power?  ", p
IF B > 8.5 AND p > 9 THEN GOTO begin:
IF p <> 0 THEN GOTO FP:
IF p = 0 THEN CLS : GOTO EX:

FP:
IF B <> 0 AND p <> 0 THEN N& = B ^ p

COLOR 14: LOCATE 12, 1: PRINT B; "to the power"; p
PRINT " is "; : PRINT USING " #,###,###,###"; N&

COLOR 13: LOCATE 16, 1: PRINT "Press any key.": SLEEP: GOTO begin:

