DECLARE FUNCTION I2a$ (h!)
DECLARE SUB GLOCATE (xxp, yyp)
       top = 6: bp = 8
       left = 6

y = top: x = left

SCREEN 13: CLS
OPEN "gfx.TXT" FOR INPUT AS #1:  GLOCATE x, y

DO
top:
    IF EOF(1) THEN EXIT DO
    GLOCATE x, y
    LINE INPUT #1, h$

    FOR i = 1 TO LEN(h$)
        GLOCATE x, y
        c$ = MID$(h$, i, 1)
        SELECT CASE c$
            CASE IS = "w": DRAW "c9 br4 u4 l8 d8 r8 u4 bl4": PAINT STEP(0, 0), 9, 9
            CASE IS = "c": CIRCLE STEP(0, 0), bp - 3, 15: PAINT STEP(0, 0), 15, 15

            CASE IS = "1": CIRCLE STEP(0, 0), bp - 3, 44: PAINT STEP(0, 0), 44, 44
            CASE IS = "2": CIRCLE STEP(0, 0), bp - 3, 9: PAINT STEP(0, 0), 9, 9
            CASE IS = "3": CIRCLE STEP(0, 0), bp - 3, 4: PAINT STEP(0, 0), 4, 4
            CASE IS = "4": CIRCLE STEP(0, 0), bp - 3, 13: PAINT STEP(0, 0), 13, 13
            CASE IS = "5": CIRCLE STEP(0, 0), bp - 3, 42: PAINT STEP(0, 0), 42, 42
            CASE IS = "6": CIRCLE STEP(0, 0), bp - 3, 2: PAINT STEP(0, 0), 2, 2
            CASE IS = "7": CIRCLE STEP(0, 0), bp - 3, 6: PAINT STEP(0, 0), 6, 6
            CASE IS = "8": CIRCLE STEP(0, 0), bp - 3, 8: PAINT STEP(0, 0), 8, 8
            CASE IS = "9": CIRCLE STEP(0, 0), bp - 3, 48: PAINT STEP(0, 0), 48, 48
            CASE ELSE:
        END SELECT
        x = x + bp
    NEXT i
    x = left: y = y + bp: GOTO top:
LOOP

CLOSE #1: SLEEP

SUB GLOCATE (xxp, yyp)
    xxp$ = I2a$(xxp): yyp$ = I2a$(yyp): DRAW "bm" + xxp$ + "," + yyp$
END SUB

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

