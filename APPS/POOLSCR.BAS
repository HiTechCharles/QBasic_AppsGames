DECLARE SUB bignum (number!, spot!)
DECLARE SUB bignum (number, spot)
DECLARE FUNCTION bms (fa, sa)
DECLARE SUB center (row, text$)
DECLARE SUB cleararea (XX, YY)
DECLARE SUB ClearBoard ()
DECLARE SUB Cmdline ()
DECLARE FUNCTION currenttime$ ()
DECLARE SUB getinfo ()
DECLARE FUNCTION getkey$ (allowed$)
DECLARE SUB help ()
DECLARE FUNCTION i2a$ (h)
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
DECLARE SUB main ()
DECLARE SUB menu ()
DECLARE SUB settable ()
DECLARE FUNCTION trim$ (t$)
DECLARE SUB updategames ()
DECLARE SUB UpdatePoints ()
COMMON SHARED nog, pointsused, cashprize, bet, winner, loser, unlimited, en
DIM SHARED name$(2), points(2), games(2)

BEGIN:
winner = 0: loser = 0: nog = 0: bet = 0: cashprize = 0
WIDTH 40, 25: COLOR 9: CLS
Cmdline
getinfo
settable
main


COLOR 15, 8: CLS : COLOR 15, 9
LOCATE 4, 1:
PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄ¿"
PRINT "³                  ³    ³"
PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄ´"
PRINT "³                  ³    ³"
PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÙ"
COLOR 14
LOCATE 5, 2: PRINT name$(1); : LOCATE 5, 22: PRINT USING "###"; games(1)
LOCATE 7, 2: PRINT name$(2); : LOCATE 7, 22: PRINT USING "###"; games(2)
COLOR 14, 8:
IF winner = 0 THEN LOCATE 9, 12: PRINT "SUSPENDED GAME" ELSE LOCATE 9, 15: PRINT "FINAL SCORE"

IF cashprize = 0 AND bet = 0 THEN GOTO smenu:
IF games(1) = games(2) THEN GOTO smenu:


IF bet <> 0 THEN
    COLOR 12: wonamt = bms(games(1), games(2)) * bet
   
    FMT$ = "": FM$ = ""
    SELECT CASE wonamt
        CASE 0 TO .99: ww$ = i2a$(wonamt)
            ww$ = RIGHT$(ww$, LEN(ww$) - 1)
            IF LEN(ww$) = 1 THEN ww$ = ww$ + "0"
            FM$ = ww$ + "›"
        CASE 1 TO 9.99: FMT$ = "#.##"
        CASE 10 TO 99.99: FMT$ = "##.##"
        CASE 100 TO 999.99: FMT$ = "###.##"
        CASE 1000 TO 9999.99: FMT$ = "#,###.##"
        CASE 10000 TO 99999.99: FMT$ = "##,###.##"
        CASE 100000 TO 999999.99#: FMT$ = "###,###.##"
        CASE 1000000 TO 9999999.99#: FMT$ = "#.###.###.##"
    END SELECT
      
    IF loser = 0 AND winner = 0 THEN
        IF games(1) > games(2) THEN winner = 1: loser = 2:  ELSE loser = 1: winner = 2
     END IF

    LOCATE 12, 5: PRINT name$(loser); " owes ";
   
    IF FM$ <> "" THEN
        PRINT FM$
    ELSE
        PRINT USING "$$" + FMT$; wonamt
    END IF
END IF


IF cashprize <> 0 THEN

    COLOR 12: wonamt = cashprize
  
    FMT$ = "": FM$ = ""
    SELECT CASE wonamt
        CASE 0 TO .99: ww$ = i2a$(wonamt)
            ww$ = RIGHT$(ww$, LEN(ww$) - 1)
            IF LEN(ww$) = 1 THEN ww$ = ww$ + "0"
            FM$ = ww$ + "›"
        CASE 1 TO 9.99: FMT$ = "#.##"
        CASE 10 TO 99.99: FMT$ = "##.##"
        CASE 100 TO 999.99: FMT$ = "###.##"
        CASE 1000 TO 9999.99: FMT$ = "#,###.##"
        CASE 10000 TO 99999.99: FMT$ = "##,###.##"
        CASE 100000 TO 999999.99#: FMT$ = "###,###.##"
        CASE 1000000 TO 9999999.99#: FMT$ = "#.###.###.##"
    END SELECT
  
    IF loser = 0 AND winner = 0 THEN
        IF games(1) > games(2) THEN winner = 1: loser = 2:  ELSE loser = 1: winner = 2
     END IF

    LOCATE 12, 5: PRINT name$(winner); " has won the"
    LOCATE 13, 5: PRINT "cash prize of";
    IF FM$ <> "" THEN
        PRINT FM$
    ELSE
        PRINT USING "$$" + FMT$; wonamt
    END IF
END IF

smenu:
COLOR 15
LOCATE 17, 1:
PRINT "     D.  New match, different players"
PRINT "     S.  New match, same players"
PRINT "     X.  Exit"
PRINT
COLOR 14!: PRINT "Press the key next to desired option:"

A$ = getkey$("dsx")
SELECT CASE A$
    CASE IS = "D": CLEAR : GOTO BEGIN:
    CASE IS = "S": GOTO BEGIN:
    CASE "X", CHR$(27): SYSTEM
END SELECT

SUB bignum (number, spot)

clr = 15

SELECT CASE spot
    CASE IS = 0: EXIT SUB
    CASE IS = 1: SR = 1: sc = 2: GOTO SetNum:
    CASE IS = 2: SR = 1: sc = 8: GOTO SetNum:
    CASE IS = 3: SR = 1: sc = 14: GOTO SetNum:
    CASE IS = 4: SR = 1: sc = 23: GOTO SetNum:
    CASE IS = 5: SR = 1: sc = 29: GOTO SetNum:
    CASE IS = 6: SR = 1: sc = 35: GOTO SetNum:
    CASE IS = 7: SR = 9: sc = 2: GOTO SetNum:
    CASE IS = 8: SR = 9: sc = 8: GOTO SetNum:
    CASE IS = 9: SR = 9: sc = 14: GOTO SetNum:
    CASE IS = 10: SR = 9: sc = 23: GOTO SetNum:
    CASE IS = 11: SR = 9: sc = 29: GOTO SetNum:
    CASE IS = 12: SR = 9: sc = 35: GOTO SetNum:
    CASE IS = 13: SR = 17: sc = 2: GOTO SetNum:
    CASE IS = 14: SR = 17: sc = 8: GOTO SetNum:
    CASE IS = 15: SR = 17: sc = 14: GOTO SetNum:
    CASE IS = 16: SR = 17: sc = 23: GOTO SetNum:
    CASE IS = 17: SR = 17: sc = 29: GOTO SetNum:
    CASE IS = 18: SR = 17: sc = 35: GOTO SetNum:
    CASE ELSE: PRINT : PRINT "Pos # out of range of 1-18": SYSTEM
END SELECT

SetNum:
    COLOR clr, clr
    SELECT CASE number
        CASE IS = -1: : COLOR 0, 0: FOR I = 0 TO 6: LOCATE SR + I, sc: PRINT "     ": NEXT I: EXIT SUB
        CASE IS = 0
            LOCATE SR, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "Û": NEXT I
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I
            LOCATE SR + 6, sc: PRINT "ÛÛÛÛÛ"
            EXIT SUB

        CASE IS = 1: FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I: EXIT SUB

        CASE IS = 2
            LOCATE SR, sc: PRINT "ÛÛÛÛÛ": LOCATE SR + 3, sc: PRINT "ÛÛÛÛÛ": LOCATE SR + 6, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 2: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I: FOR I = 4 TO 5: LOCATE SR + I, sc: PRINT "Û": NEXT I: EXIT SUB

        CASE IS = 3:
            LOCATE SR, sc: PRINT "ÛÛÛÛÛ": LOCATE SR + 3, sc: PRINT "ÛÛÛÛÛ": LOCATE SR + 6, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I: EXIT SUB

        CASE IS = 4:
            FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I: LOCATE SR + 3, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 0 TO 2: LOCATE SR + I, sc: PRINT "Û": NEXT I: EXIT SUB

        CASE IS = 5:
            LOCATE SR, sc: PRINT "ÛÛÛÛÛ": LOCATE SR + 3, sc: PRINT "ÛÛÛÛÛ": LOCATE SR + 6, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 2: LOCATE SR + I, sc: PRINT "Û": NEXT I: FOR I = 4 TO 5: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I: EXIT SUB

        CASE IS = 6:
            LOCATE SR, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "Û": NEXT I
            LOCATE SR + 3, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I
            LOCATE SR + 6, sc: PRINT "ÛÛÛÛÛ"
            COLOR 0, 0: LOCATE SR + 1, sc + 4: PRINT " "
            LOCATE SR + 2, sc + 4: PRINT " "
            EXIT SUB

        CASE IS = 7: LOCATE SR, sc: PRINT "ÛÛÛÛÛ": FOR I = 0 TO 6: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I: EXIT SUB

        CASE IS = 8:
            LOCATE SR, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "Û": NEXT I
            LOCATE SR + 3, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I
            LOCATE SR + 6, sc: PRINT "ÛÛÛÛÛ"
            EXIT SUB

        CASE IS = 9:
            LOCATE SR, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 5: LOCATE SR + I, sc: PRINT "Û": NEXT I
            LOCATE SR + 3, sc: PRINT "ÛÛÛÛÛ"
            FOR I = 1 TO 5: LOCATE SR + I, sc + 4: PRINT "Û": NEXT I
            LOCATE SR + 6, sc: PRINT "ÛÛÛÛÛ"
            COLOR 8, 0: LOCATE SR + 4, sc: PRINT " "
            LOCATE SR + 5, sc: PRINT " "
            EXIT SUB
     
        CASE ELSE: PRINT : PRINT "Number out of range of 0-9": SYSTEM
    END SELECT



END SUB

FUNCTION bms (fa!, sa!)
    IF fa! > sa! THEN
        bms = fa! - sa!
    ELSE
        bms = sa! - fa!
    END IF
END FUNCTION

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB cleararea (XX, YY)
    FOR I = XX TO YY: LOCATE I, 1: PRINT SPACE$(40): NEXT I
END SUB

SUB ClearBoard
DO UNTIL INKEY$ = "": LOOP
END SUB

SUB Cmdline
FOR NUM = 2 TO LEN(COMMAND$)

  CHAR$ = MID$(COMMAND$, NUM, 1)
 
  IF UCASE$(CHAR$) = "C" AND MID$(COMMAND$, NUM - 1, 1) = "/" THEN
    CAG = 1
  END IF

  IF UCASE$(CHAR$) = "N" AND MID$(COMMAND$, NUM - 1, 1) = "/" THEN
    CAG = 0
  END IF

  IF UCASE$(CHAR$) = "?" AND MID$(COMMAND$, NUM - 1, 1) = "/" THEN
      PRINT : PRINT
      PRINT "Pool ScoreBoard        by Charles Martin"
      PRINT "Keeps score while playing pool/billiards"
      PRINT
      PRINT "   USAGE:  POOLSCR [/C /N]"
      PRINT
      PRINT "     /C    Set players' points to 0"
      PRINT "           after a player wins"
      PRINT "     /N    DO not reset points after"
      PRINT "           a player wins"
      SYSTEM
  END IF
NEXT NUM
END SUB

FUNCTION currenttime$
h = VAL(LEFT$(TIME$, 2))
m = VAL(MID$(TIME$, 4, 2)): m$ = i2a$(m)
S = VAL(RIGHT$(TIME$, 2)): S$ = i2a$(S)

SELECT CASE h
    CASE IS = 0: AP$ = "A": SH = 12
    CASE IS < 12: AP$ = "A": SH = h
    CASE IS = 12: AP$ = "P": SH = h
    CASE IS > 12: AP$ = "P": SH = h - 12
END SELECT

SH$ = i2a$(SH)
'             hour : minute <2 spaces> <AM or PM>
IF LEN(m$) = 1 THEN m$ = "0" + m$
currenttime$ = SH$ + ":" + m$ + " " + AP$ + "M"




END FUNCTION

SUB getinfo
GB:
COLOR 9, 0: CLS
center 2, "PoolScore"
COLOR 14: center 3, "By Charles Martin"
ERASE games, points
IF name$(1) <> "" AND name$(2) <> "" THEN GOTO set:
COLOR 15: LOCATE 7, 1: PRINT "Name of player 1:  "
name$(1) = Limitinput$(17, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '.-+_", 7, 20, "")
IF name$(1) = CHR$(27) THEN SYSTEM
IF LEN(name$(1)) < 3 THEN name$(1) = "": GOTO GB:

gb2:
LOCATE 9, 1: PRINT "Name of player 2:  "
name$(2) = Limitinput$(17, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '.-+_", 9, 20, "")
IF name$(2) = CHR$(27) THEN SYSTEM
IF LEN(name$(2)) < 3 THEN name$(2) = "": cleararea 9, 23: GOTO gb2:

set:
COLOR 14: LOCATE 11, 1: PRINT "How many games does a player have to "
                        PRINT "win to end the match?  (1-999 or 0 "
                        PRINT "for unlimited)  >"
COLOR 15: nog = VAL(Limitinput$(3, "0123456789", 13, 18, ""))
IF nog = 0 THEN unlimited = 1

COLOR 9: LOCATE 15, 1: PRINT "Do players score points during a game,"
                       PRINT "such as in Snooker or Rotation? "
                       PRINT "Press (Y or N):  ";
A$ = getkey$("yn")
SELECT CASE A$
    CASE IS = "Y": pointsused = 1
    CASE IS = "N": pointsused = 0
    CASE IS = CHR$(27): SYSTEM
    CASE ELSE: PRINT : PRINT "Invalid key allowed by GetKey": SYSTEM
END SELECT

cleararea 4, 23
LOCATE 6, 1: COLOR 13
PRINT "Choose one of the following..."
COLOR 15
PRINT "     B.  Wager on each game"
PRINT "     C.  Winner gets a cash prize"
PRINT "     N.  NOne of the above"
A$ = getkey$("BCN")
SELECT CASE A$
    CASE IS = "N": bet = 0: cashprize = 0: EXIT SUB
    CASE IS = "B": cashprize = 0: cleararea 4, 23
        COLOR 10
         LOCATE 7, 30: PRINT " .01    1›"
         LOCATE 8, 30: PRINT " .05    5›"
         LOCATE 9, 30: PRINT " .1    10›"
        LOCATE 10, 30: PRINT " .25   25›"
        LOCATE 11, 30: PRINT " .5    50›"
        LOCATE 12, 30: PRINT "1      $1"
        LOCATE 13, 30: PRINT "5      $5"

        COLOR 13: LOCATE 9, 1: PRINT "How much do you want to"
                               PRINT "wager on each game?  $": COLOR 15
        bet = VAL(Limitinput$(4, "0123456789.", 10, 23, ""))
    CASE IS = "C"
        COLOR 10: bet = 0: cleararea 4, 23
         LOCATE 7, 30: PRINT " .01    1›"
         LOCATE 8, 30: PRINT " .05    5›"
         LOCATE 9, 30: PRINT " .1    10›"
        LOCATE 10, 30: PRINT " .25   25›"
        LOCATE 11, 30: PRINT " .5    50›"
        LOCATE 12, 30: PRINT "1      $1"
        LOCATE 13, 30: PRINT "5      $5"

        COLOR 13: LOCATE 9, 1: PRINT "What is the prize amount?"
                               PRINT "$": COLOR 15
         cashprize = VAL(Limitinput$(4, "0123456789.", 10, 2, ""))
END SELECT

END SUB

FUNCTION getkey$ (allowed$)

AllowEsc = 1: allowed$ = UCASE$(allowed$)
GTT:
    COLOR 15, 0: LOCATE 1, 31, 0: PRINT currenttime$
    KY$ = UCASE$(INKEY$)
    IF KY$ <> "" AND INSTR(allowed$, KY$) > 0 THEN getkey$ = KY$: EXIT FUNCTION
    IF AllowEsc <> 0 AND KY$ = CHR$(27) THEN getkey$ = CHR$(27): EXIT FUNCTION  'Allow ESCape
GOTO GTT:
END FUNCTION

SUB help
COLOR 13, 8: CLS

center 1, "Keyboard Help"
LOCATE 3, 1:
PRINT "Player 1            Player 2"
PRINT "(Left side)         (Right side)"
PRINT ""
COLOR 14: center 6, "Increase # of games won"
COLOR 15: PRINT "    A                UP ARROW"
PRINT ""
COLOR 14: center 9, "Decrease # of games won"
COLOR 15: PRINT "    Z                DOWN ARROW"
PRINT ""
COLOR 14: center 12, "Increase POINTS"
COLOR 15: PRINT "    S                RIGHT ARROW"
PRINT ""
COLOR 14: center 15, "Decrease POINTS"
COLOR 15: PRINT "    X                LEFT ARROW"
PRINT ""
PRINT ""
COLOR 13:
center 19, "Press ESCape to see a menu"
center 20, "F1 for this help screen"
center 21, "F10 to exit"
COLOR 9: center 23, "Press any key...": SLEEP
END SUB

FUNCTION i2a$ (h)
i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)

AllowEsc = 1   'allow escape to be pushed during input

'---------
AllLetters$ = "abcdefghijklmnopqustuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
Numbers$ = "0123456789"
symbols$ = ".-_+ "
Everything$ = AllLetters$ + Numbers$ + symbols$

LOCATE row, col: PRINT et$; : CONTENTS$ = et$
lt$ = CHR$(0) + CHR$(75): rt$ = CHR$(0) + CHR$(77)
ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8)
IF AllowEsc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27) + lt$ + rt$
TC = LEN(et$): CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
tos:
     DO
LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
      EndCol = LEN(CONTENTS$): CurCol = POS(0)
    LOOP WHILE CHAR$ = ""
     IF INSTR(ALLOWEDCHARS$, CHAR$) = 0 THEN GOTO tos:
     SELECT CASE CHAR$
         CASE IS = CHR$(8)
            IF CONTENTS$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
            IF CONTENTS$ <> "" THEN CONTENTS$ = LEFT$(CONTENTS$, LEN(CONTENTS$) - 1): TC = TC - 1
         CASE IS = CHR$(13): Limitinput$ = CONTENTS$: EXIT FUNCTION
         CASE IS = CHR$(27)
            IF AllowEsc = 1 THEN Limitinput$ = CHR$(27): EXIT FUNCTION
         CASE IS = lt$: IF TC > 0 THEN PRINT CHR$(29); : TC = TC - 1
         CASE IS = rt$: IF TC <= ALLOWEDCHARS THEN PRINT CHR$(28); : TC = TC + 1
         CASE ELSE:
         SELECT CASE TC
              CASE IS < ALLOWEDCHARS: PRINT CHAR$; : TC = TC + 1: CONTENTS$ = CONTENTS$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l29B": GOTO tos:
         END SELECT
     END SELECT
LOOP

END FUNCTION

SUB main

up$ = CHR$(0) + CHR$(72): dn$ = CHR$(0) + CHR$(80): lt$ = CHR$(0) + CHR$(75)
rt$ = CHR$(0) + CHR$(77): enter$ = CHR$(13): escape$ = CHR$(27): f1$ = CHR$(0) + CHR$(59)
f2$ = CHR$(0) + CHR$(60): f3$ = CHR$(0) + CHR$(61): f4$ = CHR$(0) + CHR$(62)
F5$ = CHR$(0) + CHR$(63): F6$ = CHR$(0) + CHR$(64): F7$ = CHR$(0) + CHR$(65)
F8$ = CHR$(0) + CHR$(66): F9$ = CHR$(0) + CHR$(67): f10$ = CHR$(0) + CHR$(68)

ald$ = up$ + dn$ + "a" + "z" + f1$ + f10$
IF pointsused THEN ald$ = ald$ + "s" + "x" + lt$ + rt$

gtk:
IF games(1) >= nog AND unlimited <> 1 THEN winner = 1: loser = 2: EXIT SUB
IF games(2) >= nog AND unlimited <> 1 THEN winner = 2: loser = 1: EXIT SUB

ClearBoard
k$ = getkey(ald$)

SELECT CASE k$
    CASE IS = "A": games(1) = games(1) + 1: updategames
    CASE IS = "Z": games(1) = games(1) - 1: updategames
    CASE IS = up$: games(2) = games(2) + 1: updategames
    CASE IS = dn$: games(2) = games(2) - 1: updategames

    CASE IS = "S": points(1) = points(1) + 1: UpdatePoints:
    CASE IS = "X": points(1) = points(1) - 1: UpdatePoints:
    CASE IS = lt$: points(2) = points(2) - 1: UpdatePoints:
    CASE IS = rt$: points(2) = points(2) + 1: UpdatePoints:
    CASE IS = f1$: help: settable
    CASE IS = f10$: SYSTEM
    CASE IS = escape$: menu: settable
    IF en = 1 THEN EXIT SUB
END SELECT
GOTO gtk:
END SUB

SUB menu


COLOR 15, 9: LOCATE 5, 1:
IF pointsused <> 0 THEN PRINT "  C.  Reset POINTS to 0                 "
PRINT "  G.  Reset GAMES WON to 0              "
PRINT "  H.  Help                              "
PRINT "  M.  Start new match with same players "
PRINT "  N.  New players                       "
PRINT "  R.  Return to match                   "
PRINT "  X.  End match                         "

A$ = getkey$("cghmnrx"): en = 0

SELECT CASE A$
    CASE IS = "C": points(1) = 0: points(2) = 0
    CASE IS = "G": games(1) = 0: games(2) = 0
    CASE IS = "H": help: EXIT SUB
    CASE IS = "M": points(1) = 0: points(2) = 0: games(1) = 0: games(2) = 0: EXIT SUB
    CASE IS = "N": ERASE name$: getinfo: EXIT SUB
    CASE IS = "R": EXIT SUB
    CASE IS = "X": en = 1: EXIT SUB
    CASE IS = CHR$(27): EXIT SUB
END SELECT

END SUB

SUB settable
CLS
LOCATE 4, 1: COLOR 9, 8
PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
PRINT "³                                      ³"
PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
PRINT "³                  ³³                  ³"
PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ³³                   "
PRINT "                   ÀÙ                   "
COLOR 14, 0
LOCATE 7, 2: PRINT name$(1)
LOCATE 7, 23: PRINT name$(2)

IF pointsused THEN UpdatePoints
IF nog <> 0 THEN COLOR 14, 0: center 5, "A race to " + i2a$(nog) + " games"

IF bet <> 0 THEN
    IF bet = .01 THEN FM$ = "A penny"
    IF bet = .05 THEN FM$ = "A nickel"
    IF bet = .1 THEN FM$ = "A dime"
    IF bet = .25 THEN FM$ = "A quarter"
    IF bet = .5 THEN FM$ = "50›"
    IF bet < 10 THEN FMT$ = "#.##"
    IF bet < 100 THEN FMT$ = "##.##"
    IF bet < 1000 THEN FMT$ = "###.##"
    IF bet >= 1000 THEN FMT$ = "#,###.##"

    LOCATE 1, 1: COLOR 15

    IF FM$ <> "" THEN
        PRINT FM$; " a game"
    ELSE
        PRINT USING "$$" + FMT$; bet; : PRINT " a game"
    END IF
END IF
IF cashprize <> 0 THEN
    IF cashprize = .01 THEN FM$ = "A penny"
    IF cashprize = .05 THEN FM$ = "A nickel"
    IF cashprize = .1 THEN FM$ = "A dime"
    IF cashprize = .25 THEN FM$ = "A quarter"
    IF cashprize = .5 THEN FM$ = "50›"
    IF cashprize < 10 THEN FMT$ = "#.##"
    IF cashprize < 100 THEN FMT$ = "##.##"
    IF cashprize < 1000 THEN FMT$ = "###.##"
    IF cashprize >= 1000 THEN FMT$ = "#,###.##"

    LOCATE 1, 1: COLOR 15

    IF FM$ <> "" THEN
        PRINT FM$; " cash prize"
    ELSE
        PRINT USING "$$" + FMT$; cashprize; : PRINT " cash prize"
    END IF
END IF

updategames
END SUB

FUNCTION trim$ (t$)
trim$ = LTRIM$(RTRIM$(t$))
END FUNCTION

SUB updategames

IF games(1) < 0 THEN SOUND 2000, 1: games(1) = 0: EXIT SUB
IF games(2) < 0 THEN SOUND 2000, 1: games(2) = 0: EXIT SUB

FOR I = 7 TO 12: bignum -1, I: NEXT I

g1$ = i2a$(games(1))
g2$ = i2a$(games(2))

SELECT CASE LEN(g1$)
    CASE IS = 1: bignum VAL(RIGHT$(g1$, 1)), 9
    CASE IS = 2: bignum VAL(RIGHT$(g1$, 1)), 9
                 bignum VAL(LEFT$(g1$, 1)), 8
    CASE IS = 3: bignum VAL(RIGHT$(g1$, 1)), 9
                 bignum VAL(MID$(g1$, 2, 1)), 8
                 bignum VAL(LEFT$(g1$, 1)), 7
END SELECT

SELECT CASE LEN(g2$)
    CASE IS = 1: bignum VAL(RIGHT$(g2$, 1)), 12: EXIT SUB
    CASE IS = 2: bignum VAL(RIGHT$(g2$, 1)), 12
                 bignum VAL(LEFT$(g2$, 1)), 11: EXIT SUB
    CASE IS = 3: bignum VAL(RIGHT$(g2$, 1)), 12
                 bignum VAL(MID$(g2$, 2, 1)), 11
                 bignum VAL(LEFT$(g2$, 1)), 10
END SELECT

END SUB

SUB UpdatePoints

IF points(1) < 0 THEN SOUND 2000, 1: points(1) = 0: EXIT SUB
IF points(2) < 0 THEN SOUND 2000, 1: points(2) = 0: EXIT SUB


FOR I = 13 TO 18: bignum -1, I: NEXT I

g1$ = i2a$(points(1))
g2$ = i2a$(points(2))

SELECT CASE LEN(g1$)
    CASE IS = 1: bignum VAL(RIGHT$(g1$, 1)), 15
    CASE IS = 2: bignum VAL(RIGHT$(g1$, 1)), 15
                 bignum VAL(LEFT$(g1$, 1)), 14
    CASE IS = 3: bignum VAL(RIGHT$(g1$, 1)), 15
                 bignum VAL(MID$(g1$, 2, 1)), 14
                 bignum VAL(LEFT$(g1$, 1)), 13
END SELECT

SELECT CASE LEN(g2$)
    CASE IS = 1: bignum VAL(RIGHT$(g2$, 1)), 18: EXIT SUB
    CASE IS = 2: bignum VAL(RIGHT$(g2$, 1)), 18
                 bignum VAL(LEFT$(g2$, 1)), 17: EXIT SUB
    CASE IS = 3: bignum VAL(RIGHT$(g2$, 1)), 18
                 bignum VAL(MID$(g2$, 2, 1)), 17
                 bignum VAL(LEFT$(g2$, 1)), 16
END SELECT

END SUB

