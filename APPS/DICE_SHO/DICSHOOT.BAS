DECLARE SUB center (row, text$)
DECLARE FUNCTION Limitinput$ (allowedchars)
DECLARE SUB pd (dn, DP)
DECLARE SUB playsounds (PSD!)
DECLARE SUB ReadAll ()
DIM SHARED ones, twos, threes, fours, fives, sixes, nod, c, dicetotal
DIM SHARED DIE(28)

abeg:
WIDTH 80, 25: COLOR 12, 8: CLS

beg:
center 2, "Dice Shooter"
COLOR 15: center 4, "By Charles Martin"

COLOR 13: LOCATE 9, 1: PRINT "How many dice do you want"
                       PRINT "to use?  (from 1 to 28):  ";
                       nod = VAL(Limitinput$(2))
IF nod < 1 OR nod > 28 THEN PRINT : PRINT "Between 1 and 28, please.": SLEEP 3: CLS : GOTO beg:

COLOR 10: LOCATE 17, 20: PRINT "OK, you're using"; nod; "dice."
LOCATE 19, 20: PRINT "Press any key to get rollin'": SLEEP

Aroll:
ones = 0: twos = 0: threes = 0: fours = 0: fives = 0
sixes = 0: dicetotal = 0: c = 0: COLOR 15, 8: CLS

FOR I = 1 TO nod
    RANDOMIZE TIMER
    c = INT(RND * 6) + 1
    DIE(I) = c
    SELECT CASE c
        CASE IS = 1: ones = ones + 1: dicetotal = dicetotal + 1:  GOTO pod:
        CASE IS = 2: twos = twos + 1: dicetotal = dicetotal + 2: GOTO pod:
        CASE IS = 3: threes = threes + 1: dicetotal = dicetotal + 3: GOTO pod:
        CASE IS = 4: fours = fours + 1: dicetotal = dicetotal + 4: GOTO pod:
        CASE IS = 5: fives = fives + 1: dicetotal = dicetotal + 5: GOTO pod:
        CASE IS = 6: sixes = sixes + 1: dicetotal = dicetotal + 6: GOTO pod:
    END SELECT

pod:
    pd c, I
NEXT I:

COLOR 15, 9: IF nod < 9 THEN LOCATE 2, 72: PRINT "Throwing ": LOCATE 3, 72: PRINT nod; "dice  "
             IF nod > 9 THEN LOCATE 2, 72: PRINT "Throwing ": LOCATE 3, 72: PRINT nod; "dice "
IF dicetotal <= 12 THEN playsounds dicetotal

COLOR 14, 8
  IF ones > 0 THEN LOCATE 7, 72: PRINT "1's: "; ones
  IF twos > 0 THEN LOCATE 9, 72: PRINT "2's: "; twos
IF threes > 0 THEN LOCATE 11, 72: PRINT "3's: "; threes
 IF fours > 0 THEN LOCATE 13, 72: PRINT "4's: "; fours
 IF fives > 0 THEN LOCATE 15, 72: PRINT "5's: "; fives
 IF sixes > 0 THEN LOCATE 17, 72: PRINT "6's: "; sixes

LOCATE 20, 72: PRINT "TOTAL:"
LOCATE 21, 74: PRINT USING "###"; dicetotal

tsl:
COLOR 10: LOCATE 23, 1: PRINT "ENTER to roll, C to change # of dice, R to Read, ESC to quit:"
gc:
k$ = LCASE$(INKEY$)
 IF k$ = CHR$(13) THEN GOTO Aroll:
IF k$ = CHR$(27) THEN playsounds 13:  SYSTEM
IF k$ = "c" THEN GOTO CCD:
IF k$ = "r" THEN ReadAll: GOTO tsl:
GOTO gc:


CCD:
COLOR 15, 9:
LOCATE 23, 1: PRINT SPACE$(80)
LOCATE 23, 1: PRINT "How many dice do you want to roll?  (from 1 to 28):  ";
nod = VAL(Limitinput$(2))
IF nod < 1 OR nod > 28 THEN LOCATE 23, 1: PRINT SPACE$(80): LOCATE 23, 1: PRINT "Between 1 and 28, please.": SLEEP 3: GOTO CCD:

COLOR 15, 9: IF nod < 9 THEN LOCATE 2, 72: PRINT "Throwing ": LOCATE 3, 72: PRINT nod; "dice  ": LOCATE 4, 72: PRINT "next roll"
             IF nod > 9 THEN LOCATE 2, 72: PRINT "Throwing ": LOCATE 3, 72: PRINT nod; "dice ": LOCATE 4, 72: PRINT "next roll"
             GOTO tsl:
             

SUB center (row, text$)

col = 41 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

FUNCTION Limitinput$ (allowedchars)
tc = 0: CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
TOS:
     DO
     LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
     LOOP WHILE CHAR$ = ""
     SELECT CASE ASC(CHAR$)
         CASE IS = 8
            IF contents$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
            IF contents$ <> "" THEN contents$ = LEFT$(contents$, LEN(contents$) - 1): tc = tc - 1
         CASE IS = 13: Limitinput$ = contents$: EXIT FUNCTION
         CASE ELSE:
         SELECT CASE tc
              CASE IS < allowedchars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l9B": GOTO TOS:
         END SELECT
     END SELECT
LOOP

END FUNCTION

SUB pd (dn, DP)

SELECT CASE DP
CASE IS = 1: sr = 1: sc = 1: GOTO gp:
CASE IS = 2: sr = 1: sc = 11: GOTO gp:
CASE IS = 3: sr = 1: sc = 21: GOTO gp:
CASE IS = 4: sr = 1: sc = 31: GOTO gp:
CASE IS = 5: sr = 1: sc = 41: GOTO gp:
CASE IS = 6: sr = 1: sc = 51: GOTO gp:
CASE IS = 7: sr = 1: sc = 61: GOTO gp:
CASE IS = 8: sr = 6: sc = 1: GOTO gp:
CASE IS = 9: sr = 6: sc = 11: GOTO gp:
CASE IS = 10: sr = 6: sc = 21: GOTO gp:
CASE IS = 11: sr = 6: sc = 31: GOTO gp:
CASE IS = 12: sr = 6: sc = 41: GOTO gp:
CASE IS = 13: sr = 6: sc = 51: GOTO gp:
CASE IS = 14: sr = 6: sc = 61: GOTO gp:
CASE IS = 15: sr = 12: sc = 1: GOTO gp:
CASE IS = 16: sr = 12: sc = 11: GOTO gp:
CASE IS = 17: sr = 12: sc = 21: GOTO gp:
CASE IS = 18: sr = 12: sc = 31: GOTO gp:
CASE IS = 19: sr = 12: sc = 41: GOTO gp:
CASE IS = 20: sr = 12: sc = 51: GOTO gp:
CASE IS = 21: sr = 12: sc = 61: GOTO gp:
CASE IS = 22: sr = 18: sc = 1: GOTO gp:
CASE IS = 23: sr = 18: sc = 11: GOTO gp:
CASE IS = 24: sr = 18: sc = 21: GOTO gp:
CASE IS = 25: sr = 18: sc = 31: GOTO gp:
CASE IS = 26: sr = 18: sc = 41: GOTO gp:
CASE IS = 27: sr = 18: sc = 51: GOTO gp:
CASE IS = 28: sr = 18: sc = 61: GOTO gp:
END SELECT

gp:
COLOR 15, 12:
SELECT CASE dn

CASE IS = 1:
LOCATE sr, sc: PRINT "ÚÄÄÄÄÄÄÄ¿"
LOCATE sr + 1, sc: PRINT "³       ³"
LOCATE sr + 2, sc: PRINT "³   Ü   ³"
LOCATE sr + 3, sc: PRINT "³       ³"
LOCATE sr + 4, sc: PRINT "ÀÄÄÄÄÄÄÄÙ"
GOTO ses:

CASE IS = 2:
LOCATE sr, sc: PRINT "ÚÄÄÄÄÄÄÄ¿"
LOCATE sr + 1, sc: PRINT "³Ü      ³"
LOCATE sr + 2, sc: PRINT "³       ³"
LOCATE sr + 3, sc: PRINT "³     Ü ³"
LOCATE sr + 4, sc: PRINT "ÀÄÄÄÄÄÄÄÙ"
GOTO ses:

CASE IS = 3:
LOCATE sr, sc: PRINT "ÚÄÄÄÄÄÄÄ¿"
LOCATE sr + 1, sc: PRINT "³Ü      ³"
LOCATE sr + 2, sc: PRINT "³   Ü   ³"
LOCATE sr + 3, sc: PRINT "³     Ü ³"
LOCATE sr + 4, sc: PRINT "ÀÄÄÄÄÄÄÄÙ"
GOTO ses:

CASE IS = 4:
LOCATE sr, sc: PRINT "ÚÄÄÄÄÄÄÄ¿"
LOCATE sr + 1, sc: PRINT "³Ü     Ü³"
LOCATE sr + 2, sc: PRINT "³       ³"
LOCATE sr + 3, sc: PRINT "³Ü     Ü³"
LOCATE sr + 4, sc: PRINT "ÀÄÄÄÄÄÄÄÙ"
GOTO ses:

CASE IS = 5:
LOCATE sr, sc: PRINT "ÚÄÄÄÄÄÄÄ¿"
LOCATE sr + 1, sc: PRINT "³Ü     Ü³"
LOCATE sr + 2, sc: PRINT "³   Ü   ³"
LOCATE sr + 3, sc: PRINT "³Ü     Ü³"
LOCATE sr + 4, sc: PRINT "ÀÄÄÄÄÄÄÄÙ"
GOTO ses:

CASE IS = 6:
LOCATE sr, sc: PRINT "ÚÄÄÄÄÄÄÄ¿"
LOCATE sr + 1, sc: PRINT "³Ü     Ü³"
LOCATE sr + 2, sc: PRINT "³Ü     Ü³"
LOCATE sr + 3, sc: PRINT "³Ü     Ü³"
LOCATE sr + 4, sc: PRINT "ÀÄÄÄÄÄÄÄÙ"
GOTO ses:
END SELECT

ses:


END SUB

SUB playsounds (PSD)

SELECT CASE PSD
CASE IS = 1: SHELL "play 1.wav /q": GOTO ogg:
CASE IS = 2: SHELL "play 2.wav /q": GOTO ogg:
CASE IS = 3: SHELL "play 3.wav /q": GOTO ogg:
CASE IS = 4: SHELL "play 4.wav /q": GOTO ogg:
CASE IS = 5: SHELL "play 5.wav /q": GOTO ogg:
CASE IS = 6: SHELL "play 6.wav /q": GOTO ogg:

CASE IS = 7: SHELL "play 7.wav /q": GOTO ogg:
CASE IS = 8: SHELL "play 8.wav /q": GOTO ogg:
CASE IS = 9: SHELL "play 9.wav /q": GOTO ogg:
CASE IS = 10: SHELL "play 10.wav /q": GOTO ogg:
CASE IS = 11: SHELL "play 11.wav /q": GOTO ogg:
CASE IS = 12: SHELL "play 12.wav /q": GOTO ogg:
CASE IS = 13: SHELL "play adios.wav /q": GOTO ogg:
END SELECT
ogg:
END SUB

SUB ReadAll
FOR I = 1 TO nod
    playsounds DIE(I)
NEXT I
END SUB

