DECLARE SUB center (row!, text$)
DECLARE SUB GetFraction ()
DECLARE FUNCTION I2a$ (h!)
DECLARE SUB IntroScreen ()
DECLARE FUNCTION limitinput$ (AllowedChars)
DECLARE SUB PrintFraction ()
DECLARE SUB ProcCmdLine ()
DECLARE SUB ReduceIt ()
COMMON SHARED N, D, NA, DA, fpos, fln, ona, oda, HI, X, st, et

WIDTH 40, 25: CLS
IF COMMAND$ <> "" THEN ProcCmdLine: ReduceIt: GOTO con:

TOF:
IntroScreen
GetFraction
ReduceIt

con:
IF et > 0 THEN LOCATE 2, 1: PRINT USING "###.####"; et; : PRINT " SECONDS TO REDUCE THIS FRACTION"
SELECT CASE LEN(COMMAND$)
   CASE IS < 3
   COLOR 10: center 21, "Compute another fraction?"
   center 22, "(Press Y or N):"
AFON:
   k$ = LCASE$(INKEY$)
   IF k$ = "y" THEN CLEAR : GOTO TOF:
   IF k$ = "n" THEN SYSTEM
   IF k$ = CHR$(27) THEN SYSTEM
GOTO AFON:
   CASE ELSE
   COLOR 10: center 21, "Press any key...": SLEEP: SYSTEM
END SELECT
'N and D are the original fraction parts, NA, DA  is the reduced fraction

SUB center (row, text$)
    col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB GetFraction
    VIEW PRINT 10 TO 23
GIB:
    CLS : LOCATE 21, 37: COLOR 30, 8: PRINT "ÛÛÛÛ"
    LOCATE 22, 37: COLOR 15, 8: PRINT "ÄÄÄÄ"
    LOCATE 14, 1: COLOR 14: PRINT "What is the TOP number?"
    LOCATE 15, 1: PRINT "AKA the numerator)   "; : COLOR 15, 8: PRINT ">";
    N = VAL(limitinput$(4))
        IF N = 0 THEN PRINT : PRINT :  PRINT "Between -9,999 and 9,999 please!": SLEEP 3: GOTO GIB:
        IF N = 1 THEN RANDOMIZE TIMER: N = INT(RND * 999) + 1: D = INT(RND * 999) + 1: EXIT SUB

GTD:
    LOCATE 21, 37: COLOR 14, 8: PRINT USING "####"; N
    LOCATE 22, 37: COLOR 15, 8: PRINT "ÄÄÄÄ"
    LOCATE 23, 37: COLOR 29, 8: PRINT "ÛÛÛÛ"

    LOCATE 18, 1: COLOR 13: PRINT "What is the BOTTOM number?"
    LOCATE 19, 1: PRINT "(AKA the Denominator)   "; : COLOR 15, 8: PRINT ">";
    D = VAL(limitinput$(4))
        IF D = 0 THEN PRINT : PRINT : PRINT "Between -9,999 and 9,999 please!": SLEEP 3: CLS : GOTO GTD:
    LOCATE 22, 37: COLOR 13, 8: PRINT USING "####"; D
END SUB

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB IntroScreen
    COLOR 13:  CLS : center 2, "REDUCE"
    COLOR 15: center 3, "By Charles Martin"
    COLOR 11: LOCATE 7, 1:
    PRINT "Type in the parts of a fraction,"
    PRINT "and it will be reduced to lowest"
    PRINT "terms.  (AKA: Simplified form)"
END SUB

FUNCTION limitinput$ (AllowedChars)

tc = 0: Contents$ = "": CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
TOS:
     DO
     LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
     LOOP WHILE CHAR$ = ""
     SELECT CASE ASC(CHAR$)
         CASE IS = 8
            IF Contents$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
            IF Contents$ <> "" THEN Contents$ = LEFT$(Contents$, LEN(Contents$) - 1): tc = tc - 1
         CASE IS = 13: limitinput$ = Contents$: EXIT FUNCTION
         CASE ELSE:
         SELECT CASE tc
              CASE IS < AllowedChars: PRINT CHAR$; : tc = tc + 1: Contents$ = Contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l9B": GOTO TOS:
         END SELECT
     END SELECT
LOOP

END FUNCTION

SUB PrintFraction
    PF$ = "####": IF fpos > 40 THEN fpos = 1: fln = fln + 5
        IF fpos <> 1 THEN LOCATE fln, fpos - 2: COLOR 15: PRINT "="

    SELECT CASE DA
        CASE IS <> 1:
            COLOR 14: LOCATE fln - 1, fpos, 0: PRINT USING PF$; NA
            COLOR 15: LOCATE fln, fpos: PRINT "ÄÄÄÄ"
            COLOR 13: LOCATE fln + 1, fpos: PRINT USING PF$; DA
            COLOR 11: LOCATE fln - 4, fpos + 1: PRINT "ö"; I2a$(X)
        CASE IS = 1: COLOR 15: LOCATE fln, fpos: PRINT NA
    END SELECT

    fpos = fpos + 7
END SUB

SUB ProcCmdLine
    LOS = LEN(COMMAND$)
    FOR LTR = 1 TO LOS
        CH$ = MID$(COMMAND$, LTR, 1)
        SELECT CASE CH$
            CASE IS = "/": N = VAL(WSF$): WSF$ = ""
            CASE ELSE:  WSF$ = WSF$ + CH$
        END SELECT
    NEXT LTR

    D = VAL(WSF$)
        IF N = 0 OR D = 0 THEN GOTO USAGE ELSE EXIT SUB

USAGE:
    COLOR 15: PRINT : PRINT "REDUCE": PRINT "By Charles Martin"
    PRINT : PRINT :
    PRINT "You can OPTIONALLY put a fraction"
    PRINT "on the command line.  Look"
    PRINT "at the examples below:": PRINT : PRINT
    PRINT "     REDUCE <NUMERATOR/DENOMINATOR"
    PRINT "     REDUCE 89/79      REDUCE 24/14"
    PRINT "     REDUCE 127/60     REDUCE 18/32"
    COLOR 14: PRINT : PRINT "PRESS ANY KEY...": SLEEP: SYSTEM
END SUB

SUB ReduceIt
    VIEW PRINT: CLS : fln = 9: fpos = 1: NA = N: DA = D:  PrintFraction
    LOCATE 5, 1: PRINT SPACE$(5): st = TIMER

        IF NA > DA THEN HI = NA ELSE HI = DA

    FOR X = HI TO 2 STEP -1
        IF NA > DA THEN
            HI = NA: lo = DA
        ELSE
            HI = DA: lo = NA
       END IF
       IF NA MOD X = 0 AND DA MOD X = 0 THEN MA = 1 ELSE MA = 0
    SELECT CASE MA
        CASE IS <> 1: GOTO EOL:
        CASE IS = 1: NA = NA / X: DA = DA / X: PrintFraction: ona = NA: oda = DA
    END SELECT
EOL:
        IF N = D THEN NA = 1: DA = 1: GOTO GotIt:
NEXT X

GotIt:
    et = TIMER - st
        IF NA <> N AND DA <> D THEN
        IF ona <> NA AND oda <> DA THEN PrintFraction:  ELSE EXIT SUB
    ELSE
       COLOR 15: LOCATE 9, 7: PRINT "Already in simplified form!"
    END IF
END SUB

