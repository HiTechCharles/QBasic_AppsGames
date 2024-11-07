DECLARE SUB center (row!, text$)

HY:
WIDTH 40, 25: COLOR 12: CLS : center 2, "Battle Calculator": COLOR 15: center 4, "By Charles Martin"

bcb:
COLOR 14:
LOCATE 8, 1: PRINT SPACE$(40)
LOCATE 8, 1: INPUT "Points to go:  ", togo
IF togo < 1 OR togo > 999999 THEN GOTO bcb:

PB:
LOCATE 11, 1: PRINT SPACE$(40)
COLOR 13: : LOCATE 10, 1: PRINT "How many points do you expect"
INPUT "to gain each battle?  ", perbattle
IF perbattle < 1 OR perbattle > togo THEN GOTO PB:

gil:
COLOR 11: LOCATE 13, 1: PRINT "Does the game you're playing"
PRINT "use money?  (Press Y or N):"
igp:
K$ = LCASE$(INKEY$)
IF K$ = "y" THEN GOTO GetGold:
IF K$ = "n" THEN GOTO calc:
IF K$ = CHR$(27) THEN GOTO calc:
GOTO igp

GetGold:
VIEW PRINT 12 TO 23: CLS : VIEW PRINT:  COLOR 2:
LOCATE 13, 1: PRINT SPACE$(40)
LOCATE 13, 1: PRINT "About how much gold will"
INPUT "you get in each battle?  ", gil
IF gil < 0 OR gil > 9999 THEN GOTO GetGold:

calc:
tofight = INT(togo / perbattle)
IF gil > 0 THEN GoldGain = INT(tofight * gil)

COLOR 11: CLS : center 4, "Battle Calculations"
COLOR 10: LOCATE 10, 5: PRINT "To get"; : PRINT USING "###,###"; togo; : PRINT " points, you will"
LOCATE 12, 5: PRINT "need to fight about"; tofight; "battles";
IF gil = 0 THEN PRINT "."
IF gil > 1 THEN PRINT ",": LOCATE 14, 5: PRINT "and gain about"; : PRINT USING "#,###,###"; GoldGain; : PRINT " in gold."

COLOR 12: LOCATE 18, 1: PRINT "Run this program again?  (Y/N):"
rayn:
K$ = LCASE$(INKEY$)
IF K$ = "y" THEN gil = 0: GOTO HY:
IF K$ = "n" THEN SYSTEM
IF K$ = CHR$(27) THEN SYSTEM
GOTO rayn:

SUB center (row, text$)

col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

