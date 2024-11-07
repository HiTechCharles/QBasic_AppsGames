DECLARE SUB bignum (number, spot, clr)
DECLARE SUB center (row, text$)
DECLARE FUNCTION i2a$ (H)
DECLARE SUB SplitNum (nts)
COMMON SHARED digits
DIM SHARED split(6)

ip:
CLEAR : VIEW PRINT: WIDTH 40, 25: COLOR 13: CLS : RANDOMIZE TIMER
center 2, "Random Number Generator"
center 3, "By Charles Martin"

COLOR 14: LOCATE 9, 1: INPUT "How  low can the number be?  ", lo
          IF lo < 0 THEN GOTO ip:
ghd:
LOCATE 11, 1: PRINT SPC(39); : LOCATE 11, 1: INPUT "How HIGH can the number be?  ", hi
               IF hi < 0 THEN GOTO ghd:
               IF lo > hi THEN SWAP lo, hi
               IF hi > 999999 THEN PRINT : PRINT "Between 0 and 999999, please.": SLEEP 3: GOTO ip: 
               IF hi - lo < 2 THEN GOTO ip:

CRD:
CLS : COLOR 10: center 3, "Picking a number between"
center 4, i2a$(lo) + " and " + i2a$(hi)

COLOR 13: center 8, "NUMBER CHOSEN:"

COLOR 9: LOCATE 21, 1: PRINT "     PRESS     C to change settings"
                       PRINT "           ENTER for another number"
                       PRINT "          ESCape to quit"
VIEW PRINT 8 TO 18

GTN:
rn = INT(RND * hi) + lo
IF rn < lo OR rn > hi THEN GOTO GTN:
rp = rp + 1: SOUND 720, .75


CLS : SplitNum rn
SP = 12
FOR I = digits TO 1 STEP -1
    bignum split(I), SP, 15
    SP = SP - 1
NEXT I

cs$ = i2a$(rp) + " random number"
IF rp <> 1 THEN cs$ = cs$ + "s"
cs$ = cs$ + " picked so far": COLOR 11, 8: center 18, cs$

aron:
k$ = LCASE$(INKEY$)
IF k$ = "c" THEN GOTO ip:
IF k$ = CHR$(13) OR k$ = " " THEN GOTO GTN:
IF k$ = CHR$(27) THEN SYSTEM
GOTO aron:

SUB bignum (number, spot, clr)
SELECT CASE spot
    CASE IS = 0: EXIT SUB
    CASE IS = 1: SR = 1: sc = 1: GOTO SetNum:
    CASE IS = 2: SR = 1: sc = 7: GOTO SetNum:
    CASE IS = 3: SR = 1: sc = 13: GOTO SetNum:
    CASE IS = 4: SR = 1: sc = 19: GOTO SetNum:
    CASE IS = 5: SR = 1: sc = 25: GOTO SetNum:
    CASE IS = 6: SR = 1: sc = 31: GOTO SetNum:
    CASE IS = 7: SR = 9: sc = 1: GOTO SetNum:
    CASE IS = 8: SR = 9: sc = 7: GOTO SetNum:
    CASE IS = 9: SR = 9: sc = 13: GOTO SetNum:
    CASE IS = 10: SR = 9: sc = 19: GOTO SetNum:
    CASE IS = 11: SR = 9: sc = 25: GOTO SetNum:
    CASE IS = 12: SR = 9: sc = 31: GOTO SetNum:
    CASE IS = 13: SR = 17: sc = 1: GOTO SetNum:
    CASE IS = 14: SR = 17: sc = 7: GOTO SetNum:
    CASE IS = 15: SR = 17: sc = 13: GOTO SetNum:
    CASE IS = 16: SR = 17: sc = 19: GOTO SetNum:
    CASE IS = 17: SR = 17: sc = 25: GOTO SetNum:
    CASE IS = 18: SR = 17: sc = 31: GOTO SetNum:
    CASE ELSE: PRINT : PRINT "Pos # out of range of 1-18": SYSTEM
END SELECT

SetNum:
    COLOR clr, clr
    SELECT CASE number
        CASE IS = -1: : COLOR 0, 0: FOR I = 0 TO 6: LOCATE SR + I, sc: PRINT "     ": NEXT I: EXIT SUB
        CASE IS = 0
            LOCATE SR, sc: PRINT "ллллл"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "л": NEXT I
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "л": NEXT I
            LOCATE SR + 6, sc: PRINT "ллллл"
            EXIT SUB

        CASE IS = 1: FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "л": NEXT I: EXIT SUB

        CASE IS = 2
            LOCATE SR, sc: PRINT "ллллл": LOCATE SR + 3, sc: PRINT "ллллл": LOCATE SR + 6, sc: PRINT "ллллл"
            FOR I = 1 TO 2: LOCATE SR + I, sc + 4: PRINT "л": NEXT I: FOR I = 4 TO 5: LOCATE SR + I, sc: PRINT "л": NEXT I: EXIT SUB

        CASE IS = 3:
            LOCATE SR, sc: PRINT "ллллл": LOCATE SR + 3, sc: PRINT "ллллл": LOCATE SR + 6, sc: PRINT "ллллл"
            FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "л": NEXT I: EXIT SUB

        CASE IS = 4:
            FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "л": NEXT I: LOCATE SR + 3, sc: PRINT "ллллл"
            FOR I = 0 TO 2: LOCATE SR + I, sc: PRINT "л": NEXT I: EXIT SUB

        CASE IS = 5:
            LOCATE SR, sc: PRINT "ллллл": LOCATE SR + 3, sc: PRINT "ллллл": LOCATE SR + 6, sc: PRINT "ллллл"
            FOR I = 1 TO 2: LOCATE SR + I, sc: PRINT "л": NEXT I: FOR I = 4 TO 5: LOCATE SR + I, sc + 4: PRINT "л": NEXT I: EXIT SUB

        CASE IS = 6:
            LOCATE SR, sc: PRINT "ллллл"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "л": NEXT I
            LOCATE SR + 3, sc: PRINT "ллллл"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "л": NEXT I
            LOCATE SR + 6, sc: PRINT "ллллл"
            COLOR 0, 0: LOCATE SR + 1, sc + 4: PRINT " "
            LOCATE SR + 2, sc + 4: PRINT " "
            EXIT SUB

        CASE IS = 7: LOCATE SR, sc: PRINT "ллллл": FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "л": NEXT I: EXIT SUB

        CASE IS = 8:
            LOCATE SR, sc: PRINT "ллллл"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "л": NEXT I
            LOCATE SR + 3, sc: PRINT "ллллл"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "л": NEXT I
            LOCATE SR + 6, sc: PRINT "ллллл"
            EXIT SUB

        CASE IS = 9:
            LOCATE SR, sc: PRINT "ллллл"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "л": NEXT I
            LOCATE SR + 3, sc: PRINT "ллллл"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "л": NEXT I
            LOCATE SR + 6, sc: PRINT "ллллл"
            COLOR 8, 8: LOCATE SR + 4, sc: PRINT " "
            LOCATE SR + 5, sc: PRINT " "
            EXIT SUB
      
        CASE ELSE: PRINT : PRINT "Number out of range of 0-9": SYSTEM
    END SELECT


END SUB

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

FUNCTION i2a$ (H)
i2a$ = LTRIM$(RTRIM$(STR$(H)))
END FUNCTION

SUB SplitNum (nts)
nts$ = i2a$(nts): ERASE split: digits = LEN(nts$)

FOR I = 1 TO digits
    split(I) = VAL(MID$(nts$, I, 1))
NEXT I

END SUB

