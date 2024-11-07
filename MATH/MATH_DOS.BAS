DECLARE SUB RealTime (nos)
DECLARE SUB printrealtime (rx, cx)
DECLARE FUNCTION CurrentTime$ ()
DECLARE FUNCTION DAYOFWEEK$ (m, d, y)
DECLARE FUNCTION I2a$ (h!)
DECLARE SUB ADD ()
DECLARE SUB bignum (number$, spot!, clr!)
DECLARE SUB MENU ()
DECLARE FUNCTION CurrentDate$ (StylFe)
DECLARE SUB MULTIPLY ()
DECLARE SUB SUBTRACT ()
COMMON SHARED L$, m$, R$, a, B, na$, NB$, NC$, NC, hrs, min, sec

OPEN "MATH.LOG" FOR APPEND AS #1
IF COMMAND$ = "" THEN NC = 15 ELSE NC = VAL(COMMAND$)
MENU

SUB ADD

ad:
COLOR 15, 8: CLS : RANDOMIZE TIMER
begin1:
WRONG = 0: right = 0

COLOR 11: : LOCATE 3, 13: PRINT "Addition Tutor"
LOCATE 5, 13: PRINT "By Charles Martin"

COLOR 15: LOCATE 8, 1: INPUT "How many problems?  (1-99):  ", probs
IF n > 1 AND n < 100 THEN GOTO lloop1:
IF probs < 1 OR probs > 99 THEN PRINT : PRINT "Between 1 and 99 probs, please.": SLEEP 2: GOTO ad:

GEN:
PRINT : PRINT : LINE INPUT "What is your name?  ", name$
IF LEN(name$) < 2 OR LEN(name$) > 10 THEN CLS : GOTO GEN:

50
PRINT : PRINT "What is the highest number that can be  in a problem?  (2-499):  "; : INPUT "", h
IF h <= 1 THEN h = 100
IF h > 499 THEN PRINT : PRINT "Between 2 and 499, please.": SLEEP 3: CLS : GOTO 50
st = TIMER
lloop1:
FOR P = 1 TO probs
CLS : a = 0: B = 0: rightanswer = 0: ua = 0: m$ = ""

a = INT(RND * h) + 1: B = INT(RND * h) + 1
na$ = LTRIM$(STR$(a)): NB$ = LTRIM$(STR$(B)): NC$ = LTRIM$(STR$(a + B))

L$ = LEFT$(na$, 1): R$ = RIGHT$(na$, 1)
IF a > 99 THEN zz$ = LEFT$(na$, 2): m$ = RIGHT$(zz$, 1)

bignum R$, 4, NC
IF a < 10 THEN GOTO 1500
IF m$ = "" THEN bignum L$, 3, NC
IF m$ <> "" THEN bignum m$, 3, NC: bignum L$, 2, NC

1500
m$ = "": L$ = LEFT$(NB$, 1): R$ = RIGHT$(NB$, 1)
IF B > 99 THEN zz$ = LEFT$(NB$, 2): m$ = RIGHT$(zz$, 1)

COLOR NC, NC: LOCATE 12, 2: PRINT "€€€": LOCATE 11, 3: PRINT "€": LOCATE 13, 3: PRINT "€"
bignum R$, 10, NC
IF B < 10 THEN GOTO 3000
IF m$ = "" THEN bignum L$, 9, NC
IF m$ <> "" THEN bignum m$, 9, NC: bignum L$, 8, NC

3000
m$ = "": R$ = ""
COLOR 15, 8: LOCATE 16, 6: PRINT "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
rightanswer = a + B: : COLOR 13: LOCATE 3, 25: PRINT a; "+"; B; "= ??"
LOCATE 2, 26: PRINT "#"; P; "OF"; probs

ch1:
LOCATE 20, 1: COLOR 11: PRINT "What is the answer?  "; : INPUT "", ua
IF ua < 2 THEN GOTO ch1:
LOCATE 20, 1: PRINT SPACE$(40)

m$ = "": R$ = ""
L$ = LEFT$(NC$, 1): R$ = RIGHT$(NC$, 1)
IF rightanswer > 99 THEN zz$ = LEFT$(NC$, 2): m$ = RIGHT$(zz$, 1)

bignum R$, 16, NC
IF rightanswer < 10 THEN GOTO 4500
IF m$ = "" THEN bignum L$, 15, NC
IF m$ <> "" THEN bignum m$, 15, NC: bignum L$, 14, NC

4500
COLOR , 8
IF ua <> rightanswer THEN GOTO wrong1:  ELSE GOTO right1:

wrong1:
COLOR 10: LOCATE 8, 26: PRINT a; "+"; B: LOCATE 9, 26: PRINT " is not"; ua
LOCATE 12, 26: PRINT "The correct": LOCATE 13, 26: PRINT "answer is"; rightanswer
WRONG = WRONG + 1: GOTO ep1:

right1:
COLOR 12: LOCATE 8, 25: PRINT "THAT'S RIGHT!!": LOCATE 9, 24: PRINT a; "+"; B; "="; rightanswer
right = right + 1

ep1:
COLOR 14: LOCATE 16, 29: PRINT "Press ENTER": LOCATE 17, 29: PRINT "to continue."
DO UNTIL INKEY$ = CHR$(13): LOOP
NEXT P

morea1:
et = TIMER - st: CLS : LOCATE 2, 1: PRINT name$; " is doing addition problems."
COLOR 15
PRINT : PRINT : PRINT "You answered"; right; "out of"; probs; "correctly."

pc = (100 * (right / probs))
PRINT : PRINT "That means you got "; I2a$(INT(pc)); "% correct."

COLOR 9
LOCATE 11, 1: PRINT "Elapsed time:"
CALL RealTime(et): printrealtime 11, 15

PRINT : PRINT : PRINT
PRINT #1, "             MATH TYPE:  ADDITION"
PRINT #1, "                  NAME:  "; UCASE$(name$)
PRINT #1, "         # OF PROBLEMS:  "; USING "###"; probs
PRINT #1, "     HIGHEST # ALLOWED:  "; USING "###"; h
PRINT #1, "# OF INCORRECT ANSWERS:  "; USING "###"; WRONG
PRINT #1, "       PERCENT CORRECT:  "; USING "###.##"; pc
PRINT #1, "                  DATE:  "; CurrentDate$(1)
PRINT #1, "                  TIME:  "; CurrentTime$
PRINT #1, STRING$(40, 205)
PRINT #1, ""
PRINT #1, ""

COLOR 10: LOCATE 21, 1: PRINT "More problems?  (Press Y or N)"
lex1:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN CLS :  GOTO begin1:
IF k$ = "n" THEN MENU
IF k$ = CHR$(27) THEN END
GOTO lex1:

END SUB

SUB bignum (number$, spot, clr)

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
    SELECT CASE number$
        CASE IS = "-1": : COLOR 0, 0: FOR I = 0 TO 6: LOCATE SR + I, sc: PRINT "     ": NEXT I: EXIT SUB
        CASE IS = "0"
            LOCATE SR, sc: PRINT "€€€€€"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "€": NEXT I
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "€": NEXT I
            LOCATE SR + 6, sc: PRINT "€€€€€"
            EXIT SUB

        CASE IS = "1": FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "€": NEXT I: EXIT SUB

        CASE IS = "2"
            LOCATE SR, sc: PRINT "€€€€€": LOCATE SR + 3, sc: PRINT "€€€€€": LOCATE SR + 6, sc: PRINT "€€€€€"
            FOR I = 1 TO 2: LOCATE SR + I, sc + 4: PRINT "€": NEXT I: FOR I = 4 TO 5: LOCATE SR + I, sc: PRINT "€": NEXT I: EXIT SUB

        CASE IS = "3":
            LOCATE SR, sc: PRINT "€€€€€": LOCATE SR + 3, sc: PRINT "€€€€€": LOCATE SR + 6, sc: PRINT "€€€€€"
            FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "€": NEXT I: EXIT SUB

        CASE IS = "4":
            FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "€": NEXT I: LOCATE SR + 3, sc: PRINT "€€€€€"
            FOR I = 0 TO 2: LOCATE SR + I, sc: PRINT "€": NEXT I: EXIT SUB

        CASE IS = "5":
            LOCATE SR, sc: PRINT "€€€€€": LOCATE SR + 3, sc: PRINT "€€€€€": LOCATE SR + 6, sc: PRINT "€€€€€"
            FOR I = 1 TO 2: LOCATE SR + I, sc: PRINT "€": NEXT I: FOR I = 4 TO 5: LOCATE SR + I, sc + 4: PRINT "€": NEXT I: EXIT SUB

        CASE IS = "6":
            LOCATE SR, sc: PRINT "€€€€€"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "€": NEXT I
            LOCATE SR + 3, sc: PRINT "€€€€€"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "€": NEXT I
            LOCATE SR + 6, sc: PRINT "€€€€€"
            COLOR 0, 0: LOCATE SR + 1, sc + 4: PRINT " "
            LOCATE SR + 2, sc + 4: PRINT " "
            EXIT SUB

        CASE IS = "7": LOCATE SR, sc: PRINT "€€€€€": FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "€": NEXT I: EXIT SUB

        CASE IS = "8":
            LOCATE SR, sc: PRINT "€€€€€"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "€": NEXT I
            LOCATE SR + 3, sc: PRINT "€€€€€"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "€": NEXT I
            LOCATE SR + 6, sc: PRINT "€€€€€"
            EXIT SUB

        CASE IS = "9":
            LOCATE SR, sc: PRINT "€€€€€"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "€": NEXT I
            LOCATE SR + 3, sc: PRINT "€€€€€"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "€": NEXT I
            LOCATE SR + 6, sc: PRINT "€€€€€"
            COLOR 8, 8: LOCATE SR + 4, sc: PRINT " "
            LOCATE SR + 5, sc: PRINT " "
            EXIT SUB
      
        CASE ELSE: PRINT : PRINT "Number out of range of 0-9": SYSTEM
    END SELECT


END SUB

FUNCTION CurrentDate$ (Style)

m$ = LEFT$(DATE$, 2): mm = VAL(m$)   'month
d$ = MID$(DATE$, 4, 2): dd = VAL(d$) 'day
y$ = RIGHT$(DATE$, 4): YY = VAL(y$)  'year
IF Style = 1 THEN dy$ = DAYOFWEEK(mm, dd, YY)

SELECT CASE mm
    CASE IS = 1: month$ = "January"
    CASE IS = 2: month$ = "Feburary"
    CASE IS = 3: month$ = "March"
    CASE IS = 4: month$ = "April"
    CASE IS = 5: month$ = "May"
    CASE IS = 6: month$ = "June"
    CASE IS = 7: month$ = "July"
    CASE IS = 8: month$ = "August"
    CASE IS = 9: month$ = "September"
    CASE IS = 10: month$ = "October"
    CASE IS = 11: month$ = "November"
    CASE IS = 12: month$ = "December"
END SELECT

IF dd < 10 THEN ds$ = RIGHT$(d$, 1) ELSE ds$ = d$
IF mm < 10 THEN Ms$ = RIGHT$(m$, 1) ELSE Ms$ = m$

SELECT CASE Style
CASE IS = 1: CurrentDate$ = dy$ + ", " + month$ + " " + ds$ + ", " + y$
CASE IS = 2: CurrentDate$ = month$ + " " + ds$ + ", " + y$
CASE IS = 3: CurrentDate$ = Ms$ + "/" + ds$ + "/" + RIGHT$(y$, 2)
CASE IS = 4: CurrentDate$ = Ms$ + "/" + ds$ + "/" + y$
CASE IS = 5: CurrentDate$ = month$ + " " + ds$
END SELECT


END FUNCTION

FUNCTION CurrentTime$
h = VAL(LEFT$(TIME$, 2))
m = VAL(MID$(TIME$, 4, 2)): m$ = I2a$(m)
S = VAL(RIGHT$(TIME$, 2)): S$ = I2a$(S)

SELECT CASE h
    CASE IS = 0: AP$ = "A": SH = 12
    CASE IS < 12: AP$ = "A": SH = h
    CASE IS = 12: AP$ = "P": SH = h
    CASE IS > 12: AP$ = "P": SH = h - 12
END SELECT

SH$ = I2a$(SH)
'             hour : minute <2 spaces> <AM or PM>
IF LEN(m$) = 1 THEN m$ = "0" + m$
CurrentTime$ = SH$ + ":" + m$ + " " + AP$ + "M"




END FUNCTION

FUNCTION DAYOFWEEK$ (m, d, y)
DIM J$(7): J$(1) = "Sunday": J$(2) = "Monday": J$(3) = "Tuesday"
J$(4) = "Wednesday": J$(5) = "Thursday": J$(6) = "Friday": J$(7) = "Saturday"

IF m < 1 OR m > 12 THEN PRINT : PRINT "Month must be between 1 and 12.": SYSTEM
IF d < 1 OR d > 31 THEN PRINT : PRINT "Day must be between 1 and 31.": SYSTEM
IF y < 1753 THEN PRINT : PRINT "Year must not be prior to 1753.":  SYSTEM
k = INT(.6 + (1 / m)): L = y - k: O = m + 12 * k: P = L / 100: z1 = INT(P / 4)
z2 = INT(P): z3 = INT((5 * L) / 4): z4 = INT(13 * (O + 1) / 5):
z = z4 + z3 - z2 + z1 + d - 1: z = z - (7 * INT(z / 7))
z = z + 1: DAYOFWEEK$ = J$(z): ERASE J$

END FUNCTION

FUNCTION I2a$ (h)
I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB MENU

WIDTH 40, 25: COLOR 12: CLS : LOCATE 2, 17: PRINT "Math Helper"
COLOR 9: LOCATE 4, 12: PRINT "By Charles Martin"
COLOR 14: LOCATE 8, 1: PRINT "What kind of math?"
COLOR 11: LOCATE 10, 1:
PRINT "     A  Adding          (+)"
PRINT
PRINT "     M  Multiplying     (˘  x)"
PRINT
PRINT "     S  Subtracting     (-)"
PRINT
PRINT "     X  Exit this program"

PRINT : PRINT :  COLOR 13: PRINT "  Press the letter next to the"
                           PRINT "  kind of math you want to do:"

TOM:
k$ = LCASE$(INKEY$)
IF k$ = "a" THEN ADD:
IF k$ = "m" THEN MULTIPLY:
IF k$ = "s" THEN SUBTRACT:
IF k$ = "x" THEN GOTO SPF:
IF k$ = CHR$(27) THEN GOTO SPF:
GOTO TOM:

SPF:
CLOSE #1
CLS : LOCATE 5, 1: COLOR 9: PRINT "Would you like to see the math progress file?  (Press Y or N):"
PRINT :
PRINT "This file shows how each person has doneduring each set of problems.  It shows  name, # of problems, incorrect answers  and more."
spfget:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO showprogress:
IF k$ = "n" THEN PRINT : PRINT "The statistics are stored in the file   MATH.LOG": PRINT : COLOR 13, 8: PRINT "Press a key to quit.": SLEEP: SYSTEM
IF k$ = CHR$(27) THEN PRINT : PRINT "The statistics are stored in the file   MATH.LOG": PRINT : COLOR 13, 8: PRINT "Press a key to quit.": SLEEP: SYSTEM
GOTO spfget:

showprogress:
COLOR 2: PRINT
         PRINT "The statistics are stored in the file"
         PRINT "MATH.LOG.  The oldest results are at"
         PRINT "the top.  Press ESCape while viewing"
         PRINT "the file to leave."
PRINT : COLOR 14: PRINT "Press a key to view the file.": SLEEP: SHELL "list MATH.LOG": SYSTEM

END SUB

SUB MULTIPLY
mu:
COLOR 15, 8: CLS : RANDOMIZE TIMER
begin:
WRONG = 0: right = 0

COLOR 11: LOCATE 3, 13: PRINT "Multiplication Tutor": LOCATE 5, 13: PRINT "By Charles Martin"

COLOR 15: LOCATE 8, 1: INPUT "How many problems?  (1-99):  ", probs
IF probs < 1 OR probs > 99 THEN PRINT : PRINT "Between 1 and 99 probs, please.": SLEEP 2: GOTO mu

GEN2:
PRINT : PRINT : LINE INPUT "What is your name?  ", name$
IF LEN(name$) < 2 OR LEN(name$) > 10 THEN CLS : GOTO GEN2:

500
PRINT : PRINT "What is the highest number that can be  in a problem?  (2-31):  "; : INPUT "", h
IF h <= 1 THEN h = 13
IF h > 31 THEN PRINT : PRINT "Between 2 and 31, please.": SLEEP 3: CLS : GOTO 500

st = TIMER
lloop3:
FOR P = 1 TO probs
CLS : a = 0: B = 0: rightanswer = 0: ua = 0

a = INT(RND * h) + 1: B = INT(RND * h) + 1
COLOR 13: LOCATE 3, 25: PRINT a; "˘"; B; "= ??": LOCATE 2, 26: PRINT "#"; P; "OF"; probs:   rightanswer = a * B

na$ = LTRIM$(STR$(a)): NB$ = LTRIM$(STR$(B)): NC$ = LTRIM$(STR$(a * B))
COLOR 15, 8: LOCATE 16, 6: PRINT "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
COLOR NC, NC: LOCATE 11, 8: PRINT "€": LOCATE 11, 10: PRINT "€"
LOCATE 12, 9: PRINT "€": LOCATE 13, 8: PRINT "€": LOCATE 13, 10: PRINT "€"

SELECT CASE a
CASE IS < 10: R$ = RIGHT$(na$, 1): GOTO 12
CASE IS > 9: R$ = RIGHT$(na$, 1): L$ = LEFT$(na$, 1): GOTO 12
END SELECT

12
bignum R$, 4, NC
IF a < 10 THEN GOTO 14
bignum L$, 3, NC

14
m$ = "": L$ = ""
SELECT CASE B
CASE IS < 10: R$ = RIGHT$(NB$, 1): GOTO 16
CASE IS > 9: R$ = RIGHT$(NB$, 1): L$ = LEFT$(NB$, 1): GOTO 16
END SELECT

16
bignum R$, 10, NC
IF B < 10 THEN GOTO 18
bignum L$, 9, NC

18
LOCATE 20, 1: COLOR 11, 8: PRINT "What is the answer?  "; : INPUT "", ua
IF ua = 0 THEN GOTO 18
LOCATE 20, 1: PRINT SPACE$(40)

m$ = "": R$ = ""
SELECT CASE rightanswer
CASE IS < 10: R$ = RIGHT$(NC$, 1): GOTO 20
CASE 10 TO 99: R$ = RIGHT$(NC$, 1): L$ = LEFT$(NC$, 1): GOTO 20
CASE IS > 99: R$ = RIGHT$(NC$, 1): L$ = LEFT$(NC$, 1): zz$ = LEFT$(NC$, 2): m$ = RIGHT$(zz$, 1): GOTO 20
END SELECT

20
bignum R$, 16, NC
IF rightanswer < 10 THEN GOTO ch3:
SELECT CASE rightanswer
CASE 10 TO 99: bignum L$, 15, NC: GOTO ch3:
CASE IS > 99: bignum L$, 14, NC: bignum m$, 15, NC: GOTO ch3:
END SELECT

ch3:
m$ = "": R$ = ""
IF ua <> rightanswer THEN GOTO WRONG:
IF ua = rightanswer THEN GOTO right:

WRONG:
COLOR 10, 8: LOCATE 8, 26: PRINT a; "˘"; B: LOCATE 9, 26: PRINT " is not"; ua
LOCATE 12, 26: PRINT "The correct": LOCATE 13, 26: PRINT "answer is"; rightanswer
WRONG = WRONG + 1: GOTO ep:

right:
COLOR 12, 8: LOCATE 8, 25: PRINT "THAT'S RIGHT!!": LOCATE 9, 24: PRINT a; "˘"; B; "="; rightanswer
right = right + 1

ep:
COLOR 14: LOCATE 16, 29: PRINT "Press ENTER": LOCATE 17, 29: PRINT "to continue."
DO UNTIL INKEY$ = CHR$(13): LOOP
NEXT P

morea:
et = TIMER - st: CLS : LOCATE 2, 1: PRINT name$; " is multiplying."
COLOR 15
PRINT : PRINT : PRINT "You answered"; right; "out of"; probs; "correctly."

pc = INT(100 * (right / probs))
PRINT : PRINT "That means you got "; I2a$(pc); "% correct."

COLOR 9
LOCATE 11, 1: PRINT "Elapsed time:"
CALL RealTime(et): printrealtime 11, 15

PRINT : PRINT : PRINT

PRINT #1, "             MATH TYPE:  ADDITION"
PRINT #1, "                  NAME:  "; UCASE$(name$)
PRINT #1, "         # OF PROBLEMS:  "; USING "###"; probs
PRINT #1, "     HIGHEST # ALLOWED:  "; USING "###"; h
PRINT #1, "# OF INCORRECT ANSWERS:  "; USING "###"; WRONG
PRINT #1, "       PERCENT CORRECT:  "; USING "###.##"; pc
PRINT #1, "                  DATE:  "; CurrentDate$(1)
PRINT #1, "                  TIME:  "; CurrentTime$
PRINT #1, STRING$(40, 205)
PRINT #1, ""
PRINT #1, ""

COLOR 10: LOCATE 21, 1: PRINT "More problems?  (Press Y or N)"
lex3:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN CLS :  GOTO begin:
IF k$ = "n" THEN MENU
IF k$ = CHR$(27) THEN END
GOTO lex3:

END SUB

SUB printrealtime (rx, cx)
LOCATE rx
IF hrs <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "#,###,### Hour"; hrs;
    IF hrs > 1 THEN PRINT "s": PRINT
IF min <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "       ## Minut"; min;
    IF min > 1 THEN PRINT "s": PRINT
IF sec <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "       ## Second"; sec;
    IF sec > 1 THEN PRINT "s": PRINT
END SUB

SUB RealTime (nos)
IF nos < 60 THEN
    hrs = 0: min = 0: sec = nos: GOTO 550    'if < 1 min, all seconds, done
ELSEIF nos >= 60 AND nos < 3600 THEN
    hrs = 0: min = INT(nos / 60): sec = nos MOD 60: GOTO 550
ELSEIF nos >= 3600 THEN
    min = INT(nos / 60): hrs = INT(min / 60): min = min - (hrs * 60)
    sec = nos MOD 60: GOTO 550
END IF
IF nos < 60 THEN
    hrs = 0: min = 0: sec = nos: GOTO 550    'if < 1 min, all seconds, done
ELSEIF nos >= 60 AND nos < 3600 THEN
    hrs = 0: min = INT(nos / 60): sec = nos MOD 60: GOTO 550
ELSEIF nos >= 3600 THEN
    min = INT(nos / 60): hrs = INT(min / 60): min = min - (hrs * 60)
    sec = nos MOD 60: GOTO 550
END IF
550
END SUB

SUB SUBTRACT
su:
COLOR 15, 8: CLS : RANDOMIZE TIMER
begin2:
WRONG = 0: right = 0

COLOR 11:
LOCATE 3, 13: PRINT "Subtraction Tutor"
LOCATE 5, 13: PRINT "By Charles Martin"

COLOR 15
LOCATE 8, 1: INPUT "How many problems?  (1-99):  ", probs
IF n > 1 THEN GOTO lloop2:
IF probs < 1 OR probs > 99 THEN PRINT : PRINT "Between 1 and 99 probs, please.": SLEEP 2: GOTO su:

gen3:
PRINT : PRINT : LINE INPUT "What is your name?  ", name$
IF LEN(name$) < 2 OR LEN(name$) > 10 THEN CLS : GOTO gen3:

5000
PRINT : PRINT "What is the highest number that can be  in a problem?  (Default is 25)?  "; : INPUT "", h
IF h <= 1 THEN h = 25
IF h > 999 THEN PRINT : PRINT "Between 2 and 999, please.": SLEEP 3: CLS : GOTO 5000
st = TIMER
lloop2:
FOR P = 1 TO probs
CLS : a = 0: B = 0: rightanswer = 0: ua = 0
COLOR NC, NC: LOCATE 12, 2: PRINT "€€€"
COLOR 15, 8: LOCATE 16, 6: PRINT "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
prn:
a = INT(RND * h) + 1: B = INT(RND * h) + 1
IF a = B THEN GOTO prn:
IF B > a THEN SWAP a, B
COLOR 13: LOCATE 3, 25: PRINT a; "-"; B; "= ??": LOCATE 2, 26: PRINT "#"; P; "OF"; probs:   rightanswer = a * B
na$ = LTRIM$(STR$(a)): NB$ = LTRIM$(STR$(B)): NC$ = LTRIM$(STR$(a - B))

L$ = LEFT$(na$, 1): R$ = RIGHT$(na$, 1)
IF a > 99 THEN zz$ = LEFT$(na$, 2): m$ = RIGHT$(zz$, 1)

bignum R$, 4, NC
IF a < 10 THEN GOTO 150
IF m$ = "" THEN bignum L$, 3, NC
IF m$ <> "" THEN bignum m$, 3, NC: bignum L$, 2, NC

150
m$ = "": L$ = LEFT$(NB$, 1): R$ = RIGHT$(NB$, 1)
IF B > 99 THEN zz$ = LEFT$(NB$, 2): m$ = RIGHT$(zz$, 1)

bignum R$, 10, NC
IF B < 10 THEN GOTO 300
IF m$ = "" THEN bignum L$, 9, NC
IF m$ <> "" THEN bignum m$, 9, NC: bignum L$, 8, NC

300
m$ = "": R$ = ""
rightanswer = a - B:

ch2:
LOCATE 20, 1: COLOR 11, 8: PRINT "What is the answer?  "; : INPUT "", ua
IF ua < 1 THEN GOTO ch2:
LOCATE 20, 1: PRINT SPACE$(40)

m$ = "": R$ = ""
L$ = LEFT$(NC$, 1): R$ = RIGHT$(NC$, 1)
IF rightanswer > 99 THEN zz$ = LEFT$(NC$, 2): m$ = RIGHT$(zz$, 1)

bignum R$, 16, NC
IF rightanswer < 10 THEN GOTO 450
IF m$ = "" THEN bignum L$, 15, NC
IF m$ <> "" THEN bignum m$, 15, NC: bignum L$, 14, NC

450
COLOR , 8
IF ua <> rightanswer THEN GOTO wrong2:  ELSE GOTO right2:

wrong2:
COLOR 10: LOCATE 8, 26: PRINT a; "-"; B: LOCATE 9, 26: PRINT " is not"; ua
LOCATE 12, 26: PRINT "The correct": LOCATE 13, 26: PRINT "answer is"; rightanswer
WRONG = WRONG + 1: GOTO ep2:

right2:
COLOR 12: LOCATE 8, 25: PRINT "THAT'S RIGHT!!": LOCATE 9, 24: PRINT a; "-"; B; "="; rightanswer
right = right + 1

ep2:
COLOR 14: LOCATE 16, 29: PRINT "Press ENTER": LOCATE 17, 29: PRINT "to continue."
DO UNTIL INKEY$ = CHR$(13): LOOP
NEXT P

morea2:
et = TIMER - st
CLS : LOCATE 2, 1: PRINT name$; " is doing subtraction problems"
COLOR 15
PRINT : PRINT : PRINT "You answered"; right; "out of"; probs; "correctly."

pc = INT(100 * (right / probs))
PRINT : PRINT "That means you got "; I2a$(pc); "% correct."

COLOR 9
LOCATE 11, 1: PRINT "Elapsed time:"
CALL RealTime(et): printrealtime 11, 15

PRINT : PRINT : PRINT :

PRINT #1, "MATH TYPE:  SUBTRACTION"
PRINT #1, "NAME:  "; UCASE$(na$)
PRINT #1, "# OF PROBLEMS:  "; probs
PRINT #1, "HIGHEST # ALLOWED IN PROBLEMS:  "; h
PRINT #1, "# OF INCORRECT ANSWERS:  "; WRONG
PRINT #1, "PERCENT CORRECT:  "; pc
PRINT #1, "DATE:  "; CurrentDate$(1)
PRINT #1, "TIME:  "; CurrentTime$
PRINT #1, STRING$(40, 205)
PRINT #1, ""
PRINT #1, ""

COLOR 10: LOCATE 21, 1: PRINT "More problems?  (Press Y or N)"
lex2:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN CLS :  GOTO begin2:
IF k$ = "n" THEN MENU
IF k$ = CHR$(27) THEN END
GOTO lex2:

END SUB

