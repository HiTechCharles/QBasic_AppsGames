DECLARE SUB bankrupt ()
DECLARE SUB center (Row, Text$)
DECLARE SUB chance ()
DECLARE SUB comm ()
DECLARE SUB crj (l, t$)
DECLARE SUB deeds ()
DECLARE SUB gifload (A$)
DECLARE SUB playsounds (wtp)
DECLARE SUB ROLL ()
DECLARE SUB SAC ()
DIM SHARED chd(16): DIM SHARED cmd(16): DIM SHARED names$(4): DIM SHARED players, turn, D1, d2, nt, RP

gifload "graphics\monohelp.gif"
LOCATE 17, 10: PRINT SPACE$(30)
LOCATE 18, 10: COLOR 15: PRINT "    Version 5.0"
LOCATE 21, 10: COLOR 9: PRINT "    Press any key to start!"
LOCATE 21, 1: PRINT SPACE$(12)
LOCATE 22, 10: PRINT SPACE$(30)
LOCATE 22, 1: COLOR 12: PRINT "Charles": PRINT "Martin": SLEEP:

RANDOMIZE TIMER
BEGIN:
SCREEN 0: WIDTH 80, 25: COLOR 15, 8: CLS : center 2, "Monopoly Helper 5.0"
center 4, "By Charles Martin"

COLOR 14, 8: LOCATE 9, 1:
PRINT "How many players:  (2 to 4)"

bored:
bored$ = INKEY$
IF bored$ = "2" THEN GOTO bp1:
IF bored$ = "3" THEN GOTO bp1:
IF bored$ = "4" THEN GOTO bp1:
GOTO bored:

bp1:
SELECT CASE bored$
CASE IS = "2"
LET players = 2
CASE IS = "3"
LET players = 3
CASE IS = "4"
players = 4
END SELECT

getit:
LOCATE 9, 30: PRINT players; "player game"
PRINT : PRINT : LINE INPUT "Name of player 1:  ", names$(1)
IF names$(1) = "" THEN GOTO getit:
IF LEN(names$(1)) < 3 OR LEN(names$(1)) > 12 THEN CLS : GOTO getit:

gn2:
PRINT : LINE INPUT "Name of player 2:  ", names$(2)
IF names$(2) = "" THEN CLS : GOTO gn2:
IF LEN(names$(2)) < 3 OR LEN(names$(2)) > 12 THEN CLS : GOTO gn2:

SELECT CASE players
CASE IS < 3: GOTO sgp:
CASE IS = 3:
GN32:
PRINT : LINE INPUT "Name of player 3:  ", names$(3)
IF names$(3) = "" THEN CLS : GOTO GN32:
IF LEN(names$(3)) < 3 OR LEN(names$(3)) > 12 THEN CLS : GOTO GN32:
GOTO sgp:
CASE IS = 4:
GN3:
PRINT : LINE INPUT "Name of player 3:  ", names$(3)
IF names$(3) = "" THEN CLS : GOTO GN3:
IF LEN(names$(3)) < 3 OR LEN(names$(3)) > 12 THEN CLS : GOTO GN3
gn4:
PRINT : LINE INPUT "Name of player 4:  ", names$(4)
IF names$(4) = "" THEN CLS : GOTO gn4:
IF LEN(names$(4)) < 3 OR LEN(names$(4)) > 12 THEN CLS : GOTO gn4
GOTO sgp:
END SELECT

sgp:
COLOR 15: CLS : LOCATE 9, 1: PRINT "Are you playing a short game?"
LOCATE 11, 1: PRINT "In a 'short game,' all players get two random properties, and immediately"
PRINT "pay the bank for the properties they receive.  All prices and rules stay"
PRINT "the same."
sgon:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN shg = 1: GOTO ShortGame:
IF k$ = "n" THEN shg = 0: GOTO staging:
GOTO sgon:

ShortGame:
DIM OWN(28):  CLS : COLOR 15, 8:  RANDOMIZE TIMER

Pl1:
CLS : COLOR 15, 12: PRINT : PRINT names$(1); "'s properties"

p1:
LET N = INT(RND * 27) + 1
IF OWN(N) = 0 THEN GOTO print1:
IF OWN(N) > 0 THEN GOTO p1:

print1:
SELECT CASE N
CASE 1: COLOR 5, 8: PRINT "Mediterranean Avenue": LET OWN(2) = 1: LET Pay = Pay + 60:  LET Props = Props + 1
CASE 2: COLOR 5, 8: PRINT "Baltic Avenue": LET OWN(2) = 1: LET Pay = Pay + 60:    LET Props = Props + 1
CASE 3: COLOR 15, 8: PRINT "Reading Railroad": LET OWN(3) = 1: LET Pay = Pay + 200:   LET Props = Props + 1
CASE 4: COLOR 3, 8: PRINT "Oriental Avenue": LET OWN(4) = 1: LET Pay = Pay + 100:   LET Props = Props + 1
CASE 5: COLOR 3, 8: PRINT "Vermont Avenue": LET OWN(5) = 1: LET Pay = Pay + 100:    LET Props = Props + 1
CASE 6: COLOR 3, 8: PRINT "Connecticut Avenue": LET OWN(6) = 1: LET Pay = Pay + 120:   LET Props = Props + 1
CASE 7: COLOR 5, 8: PRINT "St. Charles Place": LET OWN(7) = 1: LET Pay = Pay + 140:   LET Props = Props + 1
CASE 8: COLOR 7, 8: PRINT "Electric Company": LET OWN(8) = 1: LET Pay = Pay + 150:    LET Props = Props + 1
CASE 9: COLOR 5, 8: PRINT "States Avenue": LET OWN(9) = 1: LET Pay = Pay + 140:       LET Props = Props + 1
CASE 10: COLOR 5, 8: PRINT "Virginia Avenue": LET OWN(10) = 1: LET Pay = Pay + 160:   LET Props = Props + 1
CASE 11: COLOR 15, 8: PRINT "Pensylvania Railroad": LET OWN(11) = 1: LET Pay = Pay + 200: : LET Props = Props + 1
CASE 12: COLOR 12, 8: PRINT "St. James Place": LET OWN(12) = 1: LET Pay = Pay + 180:        LET Props = Props + 1
CASE 13: COLOR 12, 8: PRINT "Tenessee Avenue": LET OWN(13) = 1: LET Pay = Pay + 180:        LET Props = Props + 1
CASE 14: COLOR 12, 8: PRINT "New York Avenue": LET OWN(14) = 1: LET Pay = Pay + 200:        LET Props = Props + 1
CASE 15: COLOR 4, 8: PRINT "Kentucky Avenue": LET OWN(15) = 1: LET Pay = Pay + 220:         LET Props = Props + 1
CASE 16: COLOR 4, 8: PRINT "Indiana Avenue": LET OWN(16) = 1: LET Pay = Pay + 220:          LET Props = Props + 1
CASE 17: COLOR 4, 8: PRINT "Illinois Avenue": LET OWN(17) = 1: LET Pay = Pay + 240: LET Props = Props + 1
CASE 18: COLOR 15, 8: PRINT "B & O Railroad": LET OWN(18) = 1: LET Pay = Pay + 20: LET Props = Props + 1
CASE 19: COLOR 14, 8: PRINT "Atlantic Avenue": LET OWN(19) = 1: LET Pay = Pay + 260:          LET Props = Props + 1
CASE 20: COLOR 14, 8: PRINT "Ventnor Avenue": LET OWN(20) = 1: LET Pay = Pay + 260:           LET Props = Props + 1
CASE 21: COLOR 7, 8: PRINT "Water Works": LET OWN(21) = 1: LET Pay = Pay + 150:               LET Props = Props + 1
CASE 22: COLOR 14, 8: PRINT "Marvin Gardens": LET OWN(22) = 1: LET Pay = Pay + 280:           LET Props = Props + 1
CASE 23: COLOR 2, 8: PRINT "Pacific Avenue": LET OWN(23) = 1: LET Pay = Pay + 300:            LET Props = Props + 1
CASE 24: COLOR 2, 8: PRINT "North Carolina Avenue": LET OWN(24) = 1: LET Pay = Pay + 300:     LET Props = Props + 1
CASE 25: COLOR 2, 8: PRINT "Pensylvania Avenue": LET OWN(25) = 1: LET Pay = Pay + 300:        LET Props = Props + 1
CASE 26: COLOR 15, 8: PRINT "Short Line Railroad": LET OWN(26) = 1: LET Pay = Pay + 200:      LET Props = Props + 1
CASE 27: COLOR 9, 8: PRINT "Park Place": LET OWN(27) = 1: LET Pay = Pay + 350:                LET Props = Props + 1
CASE 28: COLOR 9, 8: PRINT "Boardwalk": LET OWN(28) = 1: LET Pay = Pay + 400:                 LET Props = Props + 1
END SELECT

IF Props = 1 THEN LET N = 0: GOTO p1:
IF Props = 2 THEN LET N = 0: GOTO p1:
IF Props = 3 THEN COLOR 14: PRINT names$(1); " pays"; Pay; "to the bank."
N = 0: Props = 0: Pay = 0: GOTO PL2:

PL2:
COLOR 4, 11: PRINT : PRINT names$(2); "'s properties"

p2:
LET N = INT(RND * 27) + 1
IF OWN(N) = 0 THEN GOTO print2:
IF OWN(N) > 0 THEN GOTO p2:

print2:
SELECT CASE N
CASE 1: COLOR 5, 8: PRINT "Mediterranean Avenue": LET OWN(1) = 2: LET Pay = Pay + 60:  LET Props = Props + 1
CASE 2: COLOR 5, 8: PRINT "Baltic Avenue": LET OWN(2) = 2: LET Pay = Pay + 60:    LET Props = Props + 1
CASE 3: COLOR 15, 8: PRINT "Reading Railroad": LET OWN(3) = 2: LET Pay = Pay + 200:   LET Props = Props + 1
CASE 4: COLOR 3, 8: PRINT "Oriental Avenue": LET OWN(4) = 2: LET Pay = Pay + 100:   LET Props = Props + 1
CASE 5: COLOR 3, 8: PRINT "Vermont Avenue": LET OWN(5) = 2: LET Pay = Pay + 100:    LET Props = Props + 1
CASE 6: COLOR 3, 8: PRINT "Connecticut Avenue": LET OWN(6) = 2: LET Pay = Pay + 120:   LET Props = Props + 1
CASE 7: COLOR 5, 8: PRINT "St. Charles Place": LET OWN(7) = 2: LET Pay = Pay + 140:   LET Props = Props + 1
CASE 8: COLOR 7, 8: PRINT "Electric Company": LET OWN(8) = 2: LET Pay = Pay + 150:    LET Props = Props + 1
CASE 9: COLOR 5, 8: PRINT "States Avenue": LET OWN(9) = 2: LET Pay = Pay + 140:       LET Props = Props + 1
CASE 10: COLOR 5, 8: PRINT "Virginia Avenue": LET OWN(10) = 2: LET Pay = Pay + 160:   LET Props = Props + 1
CASE 11: COLOR 15, 8: PRINT "Pensylvania Railroad": LET OWN(11) = 2: LET Pay = Pay + 200: : LET Props = Props + 1
CASE 12: COLOR 12, 8: PRINT "St. James Place": LET OWN(12) = 2: LET Pay = Pay + 180:        LET Props = Props + 1
CASE 13: COLOR 12, 8: PRINT "Tenessee Avenue": LET OWN(13) = 2: LET Pay = Pay + 180:        LET Props = Props + 1
CASE 14: COLOR 12, 8: PRINT "New York Avenue": LET OWN(14) = 2: LET Pay = Pay + 200:        LET Props = Props + 1
CASE 15: COLOR 4, 8: PRINT "Kentucky Avenue": LET OWN(15) = 2: LET Pay = Pay + 220:         LET Props = Props + 1
CASE 16: COLOR 4, 8: PRINT "Indiana Avenue": LET OWN(16) = 2: LET Pay = Pay + 220:          LET Props = Props + 1
CASE 17: COLOR 4, 8: PRINT "Illinois Avenue": LET OWN(17) = 2: LET Pay = Pay + 240: LET Props = Props + 1
CASE 18: COLOR 15, 8: PRINT "B & O Railroad": LET OWN(18) = 2: LET Pay = Pay + 20: LET Props = Props + 1
CASE 19: COLOR 14, 8: PRINT "Atlantic Avenue": LET OWN(19) = 2: LET Pay = Pay + 260:          LET Props = Props + 1
CASE 20: COLOR 14, 8: PRINT "Ventnor Avenue": LET OWN(20) = 2: LET Pay = Pay + 260:           LET Props = Props + 1
CASE 21: COLOR 7, 8: PRINT "Water Works": LET OWN(21) = 2: LET Pay = Pay + 150:               LET Props = Props + 1
CASE 22: COLOR 14, 8: PRINT "Marvin Gardens": LET OWN(22) = 2: LET Pay = Pay + 280:           LET Props = Props + 1
CASE 23: COLOR 2, 8: PRINT "Pacific Avenue": LET OWN(23) = 2: LET Pay = Pay + 300:            LET Props = Props + 1
CASE 24: COLOR 2, 8: PRINT "North Carolina Avenue": LET OWN(24) = 2: LET Pay = Pay + 300:     LET Props = Props + 1
CASE 25: COLOR 2, 8: PRINT "Pensylvania Avenue": LET OWN(25) = 2: LET Pay = Pay + 300:        LET Props = Props + 1
CASE 26: COLOR 15, 8: PRINT "Short Line Railroad": LET OWN(26) = 2: LET Pay = Pay + 200:      LET Props = Props + 1
CASE 27: COLOR 9, 8: PRINT "Park Place": LET OWN(27) = 2: LET Pay = Pay + 350:                LET Props = Props + 1
CASE 28: COLOR 9, 8: PRINT "Boardwalk": LET OWN(28) = 2: LET Pay = Pay + 400:                 LET Props = Props + 1
END SELECT

IF Props = 1 THEN LET N = 0: GOTO p2:
IF Props = 2 THEN LET N = 0: GOTO p2:
IF Props = 3 THEN COLOR 14: PRINT names$(2); " pays"; Pay; "to the bank."

IF players < 3 THEN GOTO staging:
IF players > 2 THEN GOTO PL3:

PL3:
N = 0: Props = 0: Pay = 0:
COLOR 15, 9: PRINT : PRINT names$(3); "'s properties"

p3:
LET N = INT(RND * 27) + 1
IF OWN(N) = 0 THEN GOTO print3:
IF OWN(N) > 0 THEN GOTO p3:

print3:
SELECT CASE N
CASE 1: COLOR 5, 8: PRINT "Mediterranean Avenue": LET OWN(1) = 3: LET Pay = Pay + 60:  LET Props = Props + 1
CASE 2: COLOR 5, 8: PRINT "Baltic Avenue": LET OWN(2) = 3: LET Pay = Pay + 60:    LET Props = Props + 1
CASE 3: COLOR 15, 8: PRINT "Reading Railroad": LET OWN(3) = 3: LET Pay = Pay + 200:   LET Props = Props + 1
CASE 4: COLOR 3, 8: PRINT "Oriental Avenue": LET OWN(4) = 3: LET Pay = Pay + 100:   LET Props = Props + 1
CASE 5: COLOR 3, 8: PRINT "Vermont Avenue": LET OWN(5) = 3: LET Pay = Pay + 100:    LET Props = Props + 1
CASE 6: COLOR 3, 8: PRINT "Connecticut Avenue": LET OWN(6) = 3: LET Pay = Pay + 120:   LET Props = Props + 1
CASE 7: COLOR 5, 8: PRINT "St. Charles Place": LET OWN(7) = 3: LET Pay = Pay + 140:   LET Props = Props + 1
CASE 8: COLOR 7, 8: PRINT "Electric Company": LET OWN(8) = 3: LET Pay = Pay + 150:    LET Props = Props + 1
CASE 9: COLOR 5, 8: PRINT "States Avenue": LET OWN(9) = 3: LET Pay = Pay + 140:       LET Props = Props + 1
CASE 10: COLOR 5, 8: PRINT "Virginia Avenue": LET OWN(10) = 3: LET Pay = Pay + 160:   LET Props = Props + 1
CASE 11: COLOR 15, 8: PRINT "Pensylvania Railroad": LET OWN(11) = 3: LET Pay = Pay + 200: : LET Props = Props + 1
CASE 12: COLOR 12, 8: PRINT "St. James Place": LET OWN(12) = 3: LET Pay = Pay + 180:        LET Props = Props + 1
CASE 13: COLOR 12, 8: PRINT "Tenessee Avenue": LET OWN(13) = 3: LET Pay = Pay + 180:        LET Props = Props + 1
CASE 14: COLOR 12, 8: PRINT "New York Avenue": LET OWN(14) = 3: LET Pay = Pay + 200:        LET Props = Props + 1
CASE 15: COLOR 4, 8: PRINT "Kentucky Avenue": LET OWN(15) = 3: LET Pay = Pay + 220:         LET Props = Props + 1
CASE 16: COLOR 4, 8: PRINT "Indiana Avenue": LET OWN(16) = 3: LET Pay = Pay + 220:          LET Props = Props + 1
CASE 17: COLOR 4, 8: PRINT "Illinois Avenue": LET OWN(17) = 3: LET Pay = Pay + 240: LET Props = Props + 1
CASE 18: COLOR 15, 8: PRINT "B & O Railroad": LET OWN(18) = 3: LET Pay = Pay + 20: LET Props = Props + 1
CASE 19: COLOR 14, 8: PRINT "Atlantic Avenue": LET OWN(19) = 3: LET Pay = Pay + 260:          LET Props = Props + 1
CASE 20: COLOR 14, 8: PRINT "Ventnor Avenue": LET OWN(20) = 3: LET Pay = Pay + 260:           LET Props = Props + 1
CASE 21: COLOR 7, 8: PRINT "Water Works": LET OWN(21) = 3: LET Pay = Pay + 150:               LET Props = Props + 1
CASE 22: COLOR 14, 8: PRINT "Marvin Gardens": LET OWN(22) = 3: LET Pay = Pay + 280:           LET Props = Props + 1
CASE 23: COLOR 2, 8: PRINT "Pacific Avenue": LET OWN(23) = 3: LET Pay = Pay + 300:            LET Props = Props + 1
CASE 24: COLOR 2, 8: PRINT "North Carolina Avenue": LET OWN(24) = 3: LET Pay = Pay + 300:     LET Props = Props + 1
CASE 25: COLOR 2, 8: PRINT "Pensylvania Avenue": LET OWN(25) = 3: LET Pay = Pay + 300:        LET Props = Props + 1
CASE 26: COLOR 15, 8: PRINT "Short Line Railroad": LET OWN(26) = 3: LET Pay = Pay + 200:      LET Props = Props + 1
CASE 27: COLOR 9, 8: PRINT "Park Place": LET OWN(27) = 3: LET Pay = Pay + 350:                LET Props = Props + 1
CASE 28: COLOR 9, 8: PRINT "Boardwalk": LET OWN(28) = 3: LET Pay = Pay + 400:                 LET Props = Props + 1
END SELECT

IF Props = 1 THEN LET N = 0: GOTO p3:
IF Props = 2 THEN LET N = 0: GOTO p3:
IF Props = 3 THEN COLOR 14: PRINT names$(3); " pays"; Pay; "to the bank."

IF players = 4 THEN GOTO PL4:

PL4:
N = 0: Props = 0: Pay = 0:
COLOR 8, 15: PRINT : PRINT names$(4); "'s properties"

p4:
LET N = INT(RND * 27) + 1
IF OWN(N) = 0 THEN GOTO print4:
IF OWN(N) > 0 THEN GOTO p4:

print4:
SELECT CASE N
CASE 1: COLOR 5, 8: PRINT "Mediterranean Avenue": LET OWN(1) = 4: LET Pay = Pay + 60:  LET Props = Props + 1
CASE 2: COLOR 5, 8: PRINT "Baltic Avenue": LET OWN(2) = 4: LET Pay = Pay + 60:    LET Props = Props + 1
CASE 3: COLOR 15, 8: PRINT "Reading Railroad": LET OWN(3) = 4: LET Pay = Pay + 200:   LET Props = Props + 1
CASE 4: COLOR 3, 8: PRINT "Oriental Avenue": LET OWN(4) = 4: LET Pay = Pay + 100:   LET Props = Props + 1
CASE 5: COLOR 3, 8: PRINT "Vermont Avenue": LET OWN(5) = 4: LET Pay = Pay + 100:    LET Props = Props + 1
CASE 6: COLOR 3, 8: PRINT "Connecticut Avenue": LET OWN(6) = 4: LET Pay = Pay + 120:   LET Props = Props + 1
CASE 7: COLOR 5, 8: PRINT "St. Charles Place": LET OWN(7) = 4: LET Pay = Pay + 140:   LET Props = Props + 1
CASE 8: COLOR 7, 8: PRINT "Electric Company": LET OWN(8) = 4: LET Pay = Pay + 150:    LET Props = Props + 1
CASE 9: COLOR 5, 8: PRINT "States Avenue": LET OWN(9) = 4: LET Pay = Pay + 140:       LET Props = Props + 1
CASE 10: COLOR 5, 8: PRINT "Virginia Avenue": LET OWN(10) = 4: LET Pay = Pay + 160:   LET Props = Props + 1
CASE 11: COLOR 15, 8: PRINT "Pensylvania Railroad": LET OWN(11) = 4: LET Pay = Pay + 200: : LET Props = Props + 1
CASE 12: COLOR 12, 8: PRINT "St. James Place": LET OWN(12) = 4: LET Pay = Pay + 180:        LET Props = Props + 1
CASE 13: COLOR 12, 8: PRINT "Tenessee Avenue": LET OWN(13) = 4: LET Pay = Pay + 180:        LET Props = Props + 1
CASE 14: COLOR 12, 8: PRINT "New York Avenue": LET OWN(14) = 4: LET Pay = Pay + 200:        LET Props = Props + 1
CASE 15: COLOR 4, 8: PRINT "Kentucky Avenue": LET OWN(15) = 4: LET Pay = Pay + 220:         LET Props = Props + 1
CASE 16: COLOR 4, 8: PRINT "Indiana Avenue": LET OWN(16) = 4: LET Pay = Pay + 220:          LET Props = Props + 1
CASE 17: COLOR 4, 8: PRINT "Illinois Avenue": LET OWN(17) = 4: LET Pay = Pay + 240: LET Props = Props + 1
CASE 18: COLOR 15, 8: PRINT "B & O Railroad": LET OWN(18) = 4: LET Pay = Pay + 20: LET Props = Props + 1
CASE 19: COLOR 14, 8: PRINT "Atlantic Avenue": LET OWN(19) = 4: LET Pay = Pay + 260:          LET Props = Props + 1
CASE 20: COLOR 14, 8: PRINT "Ventnor Avenue": LET OWN(20) = 4: LET Pay = Pay + 260:           LET Props = Props + 1
CASE 21: COLOR 7, 8: PRINT "Water Works": LET OWN(21) = 4: LET Pay = Pay + 150:               LET Props = Props + 1
CASE 22: COLOR 14, 8: PRINT "Marvin Gardens": LET OWN(22) = 4: LET Pay = Pay + 280:           LET Props = Props + 1
CASE 23: COLOR 2, 8: PRINT "Pacific Avenue": LET OWN(23) = 4: LET Pay = Pay + 300:            LET Props = Props + 1
CASE 24: COLOR 2, 8: PRINT "North Carolina Avenue": LET OWN(24) = 4: LET Pay = Pay + 300:     LET Props = Props + 1
CASE 25: COLOR 2, 8: PRINT "Pensylvania Avenue": LET OWN(25) = 4: LET Pay = Pay + 300:        LET Props = Props + 1
CASE 26: COLOR 15, 8: PRINT "Short Line Railroad": LET OWN(26) = 4: LET Pay = Pay + 200:      LET Props = Props + 1
CASE 27: COLOR 9, 8: PRINT "Park Place": LET OWN(27) = 4: LET Pay = Pay + 350:                LET Props = Props + 1
CASE 28: COLOR 9, 8: PRINT "Boardwalk": LET OWN(28) = 4: LET Pay = Pay + 400:                 LET Props = Props + 1
END SELECT

IF Props = 1 THEN LET N = 0: GOTO p4:
IF Props = 2 THEN LET N = 0: GOTO p4:
IF Props = 3 THEN COLOR 14: PRINT names$(4); " pays"; Pay; "to the bank."

staging:
IF shg = 0 THEN LOCATE 17, 1: SHELL " pause"
IF shg = 1 THEN LOCATE 10, 41: SHELL "pause"

RP = players
COLOR 15, 9: CLS :
LOCATE 19, 1: PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�"
LOCATE 20, 1: PRINT "H - Help"
LOCATE 21, 1: PRINT "C - Draw a chance card"
LOCATE 22, 1: PRINT "M - Draw a Community Chest card"
LOCATE 23, 1: PRINT "D - Show title deeds"
LOCATE 20, 41: PRINT "R - Show Monopoly rules"
LOCATE 21, 41: PRINT "B - Eliminate bankrupt players"
LOCATE 22, 41: PRINT "X - Exit"

turn = 1
VIEW PRINT 1 TO 18
playsounds 1
RANDOMIZE TIMER
ROLL

SUB bankrupt

WIDTH 40, 25: COLOR 2, 8: VIEW PRINT: CLS : LOCATE 2, 4: PRINT "Emiminate players from the game"

COLOR 13: LOCATE 6, 1:
FOR P = 1 TO 4
IF names$(P) <> "" THEN PRINT : PRINT "     "; P; "- "; names$(P)
NEXT P
PRINT : PRINT "      5 - Return to game"
COLOR 15:
PRINT : PRINT : PRINT "Press the number next to the"
		PRINT "player who is to be eliminated:"

gbd:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN pe = 1: GOTO bproc:
IF k$ = "2" THEN pe = 2: GOTO bproc:
IF k$ = "3" THEN pe = 3: GOTO bproc:
IF k$ = "4" THEN pe = 4: GOTO bproc:
IF k$ = "5" THEN WIDTH 80, 25: COLOR 14, 9: SAC
IF k$ = CHR$(27) THEN WIDTH 80, 25: COLOR 14, 9: SAC
GOTO gbd:

bproc:
IF names$(pe) = "" THEN GOTO gbd:
IF names$(pe) <> "" THEN GOTO son:

son:
CLS : COLOR 15: LOCATE 7, 1: PRINT "Are you SURE you want to remove"
			 PRINT : PRINT names$(pe); " from the game?": PRINT : PRINT "(Press Y or N)"
snp:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN LOCATE 14, 1: PRINT names$(pe); " is BANKRUPT!": playsounds 28: RP = RP - 1: names$(pe) = "": GOTO btg:
IF k$ = "n" THEN SAC
IF k$ = CHR$(27) THEN SAC
GOTO snp:

btg:
IF RP = 1 THEN GOTO ewin:
IF pe = turn THEN GOTO fot:
IF pe <> turn THEN WIDTH 80, 25: SAC

fot:
IF RP = 1 THEN GOTO ewin:
nt = turn + 1
cm3:
IF nt > players THEN nt = 1: GOTO cm3:
IF names$(nt) = "" THEN nt = nt + 1: GOTO cm3:
IF names$(nt) <> "" THEN GOTO cm4:

cm4:
IF RP = 1 THEN GOTO ewin:
turn = nt
LOCATE 17, 1: PRINT "The game will resume"
PRINT "with "; names$(turn); "'s turn."
SLEEP 5: WIDTH 80, 25: COLOR 15, 9: CLS

LOCATE 19, 1: PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�"
LOCATE 20, 1: PRINT "H - Help"
LOCATE 21, 1: PRINT "C - Draw a chance card"
LOCATE 22, 1: PRINT "M - Draw a Community Chest card"
LOCATE 23, 1: PRINT "D - Show title deeds"
LOCATE 20, 41: PRINT "R - Show Monopoly rules"
LOCATE 21, 41: PRINT "B - Eliminate bankrupt players"
LOCATE 22, 41: PRINT "X - Exit"
VIEW PRINT 1 TO 18: ROLL

ewin:
WIDTH 40, 25: COLOR 9, 8: CLS

DO WHILE W$ = ""
W = W + 1
IF names$(W) = "" THEN GOTO el:
IF names$(W) <> "" THEN W$ = names$(W): GOTO pw:

el:
LOOP

pw:
LOCATE 7, 10: PRINT W$; " has"
LOCATE 9, 10: PRINT "WON THE GAME!!"
playsounds 24
COLOR 14: LOCATE 13, 10: PRINT "Press any key to quit...": SLEEP:
playsounds 25: SYSTEM


END SUB

SUB center (Row, Text$)
  Col = 40
  LOCATE Row, Col - (LEN(Text$) / 2 + .5)
  PRINT Text$;
END SUB

SUB chance

COLOR 8, 8: WIDTH 40, 25: VIEW PRINT: CLS

playsounds 19: COLOR 14, 12: FOR I = 6 TO 17: LOCATE I, 5: PRINT SPACE$(30): NEXT I
LOCATE 7, 6: PRINT "CHANCE"

ccmb:
c = INT(RND * 16) + 1
IF chd(c) > 0 THEN GOTO ccmb:

SELECT CASE c
CASE IS = 1
line1$ = "Advance token to the nearest"
line2$ = "railroad and pay owner twice"
line3$ = "the rent to which he/she is"
line4$ = "otherwised entitled."
line6$ = "If railroad is UNOWNED,"
line7$ = "you may buy it from the bank."
STP = 26: GOTO PCC:

CASE IS = 2
	 '----0----0----0----0----0----|
line1$ = "Take a ride on the reading"
line3$ = "If you pass go, collect $200"
STP = 26: GOTO PCC:

CASE IS = 3
line1$ = "Advance to Illinois Avenue"
STP = 27: GOTO PCC:

CASE IS = 4
line1$ = "Advance token to the nearest"
line2$ = "railroad and pay owner twice"
line3$ = "the rent to which he/she is"
line4$ = "otherwised entitled."
line6$ = "If railroad is UNOWNED,"
line7$ = "you may buy it from the bank."
STP = 26: GOTO PCC:

CASE IS = 5
line1$ = "You have been ELECTED"
line2$ = "CHAIRMAN of the board."
line4$ = "Pay each player $50"
STP = 23: GOTO PCC:

CASE IS = 6
line1$ = "Take a walk on the Boardwalk"
line3$ = "Advance token to Boaardwalk"
STP = 27: GOTO PCC:

CASE IS = 7
line1$ = "GO TO JAIL"
line2$ = "Go directly to jail"
line4$ = "DO NOT PASS GO,"
line5$ = "DO NOT COLLECT $200"
STP = 22: GOTO PCC:

CASE IS = 8
line1$ = "Advance to St. Charles Place"
line3$ = "If you pass GO, collect $200"
STP = 27: GOTO PCC:

CASE IS = 9
line1$ = "Bank pays you"
line2$ = "dividend of $50"
STP = 23: GOTO PCC:

CASE IS = 10
line1$ = "Advance token to nearest"
line2$ = "utility.  If UNOWNED, you"
line3$ = "may buy it from the bank."
line5$ = "If owned, throw dice and pay"
line6$ = "owner a total ten times"
line7$ = "the amount thrown."
STP = 23: GOTO PCC:

CASE IS = 11
line1$ = "This card may be kept until"
line2$ = "needed or sold."
line4$ = "GET OUT OF JAIL FREE"
STP = 21: GOTO PCC:

CASE IS = 12
line1$ = "Go back 3 spaces"
STP = 17: GOTO PCC:

CASE IS = 13
line1$ = "Make general repairs on all"
line2$ = "your property"
line4$ = "For each house, pay $25"
line5$ = "For each hotel, pay $100"
STP = 25: GOTO PCC:

CASE IS = 14
line1$ = "Your building and loan"
line2$ = "matures.  Collect $150"
STP = 20: GOTO PCC:

CASE IS = 15
line1$ = "Pay poor tax of $15"
STP = 23: GOTO PCC:

CASE IS = 16
line1$ = "Advance to GO"
line3$ = "Collect $200"
STP = 18: GOTO PCC:
END SELECT

PCC:
chd(c) = 1:
crj 9, line1$
crj 10, line2$
crj 11, line3$
crj 12, line4$
crj 13, line5$
crj 14, line6$
crj 15, line7$
playsounds STP
IF STP = 25 THEN GOTO GHH2:
COLOR 15, 8:  LOCATE 20, 5: PRINT "Press any key to continue...": SLEEP: WIDTH 80, 25: SAC

GHH2:
COLOR 9, 8: LOCATE 20, 1: PRINT "Does "; names$(turn); " own any houses"
			   PRINT "or hotels?  (Y or N):"
chh2:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO calchh2:
IF k$ = "n" THEN GOTO NP2:
GOTO chh2:

NP2:
LOCATE 20, 1: PRINT SPACE$(40): LOCATE 21, 1: PRINT SPACE$(40)
COLOR 15, 8: LOCATE 23, 5: PRINT "Press any key to continue...": SLEEP:
DO UNTIL INKEY$ = "": LOOP: WIDTH 80, 25: SAC

calchh2:
COLOR 10, 8: CLS : LOCATE 17, 1: INPUT "How many houses?  ", houses
IF houses < 0 OR houses > 32 THEN CLS : GOTO calchh2:

ch22:
LOCATE 19, 1: INPUT "How many hotels?  ", hotels
IF hotels < 0 OR hotels > 12 THEN CLS : GOTO ch22:

th1 = 40 * houses: th2 = 115 * hotels: topay = th1 + th2
COLOR 12: LOCATE 21, 1: PRINT names$(turn); " owes "; : PRINT USING "$#,###"; topay; : PRINT " for general repairs."
LOCATE 23, 1: PRINT "Press any key to continue...": SLEEP: WIDTH 80, 25: SAC

END SUB

SUB comm

COLOR 8, 8: WIDTH 40, 25: VIEW PRINT: CLS


IF RCC = 0 THEN FOR I = 1 TO 16: cmd(I) = 0: NEXT I

playsounds 19: COLOR 11, 14: FOR I = 6 TO 14: LOCATE I, 5: PRINT SPACE$(30): NEXT I
LOCATE 7, 6: PRINT "COMMUNITY CHEST"

ccmb2:
c = INT(RND * 16) + 1
IF cmd(c) > 0 THEN GOTO ccmb2:

SELECT CASE c
CASE IS = 1
	 '----0----0----0----0----0----|
line1$ = "You've won second prize in"  'amanda wins first prize!!!
line3$ = "a beauty contest. "
line4$ = "Collect $10"
STP = 30: GOTO PCC2:

CASE IS = 2
line1$ = "Grand opera opening"
line3$ = "Collect $50 from every player"
line4$ = "for opening night seats"
STP = 29: GOTO PCC2:

CASE IS = 3
line1$ = "You are assessed for"
line2$ = "street repairs"
line4$ = "$40 per house, $115 per hotel"
STP = 25: GOTO PCC2:

CASE IS = 4
line1$ = "Doctor's fee"
line3$ = "Pay $50"
STP = 23: GOTO PCC2:

CASE IS = 5
line1$ = "Receive for servives, $25"
STP = 20: GOTO PCC2:

CASE IS = 6
line1$ = "Bank error in your favor"
line3$ = "Collect $200"
STP = 20: GOTO PCC2:

CASE IS = 7
line1$ = "Xmas fund matures"
line3$ = "Collect $100"
STP = 20: GOTO PCC2:

CASE IS = 8
line1$ = "Income tax refund"
line3$ = "Collect $20"
STP = 20: GOTO PCC2:

CASE IS = 9:
line1$ = "GET OUT OF JAIL FREE"
line3$ = "This card may be kept until"
line4$ = "needed or sold."
STP = 21: GOTO PCC2:

CASE IS = 10
line1$ = "Life insurance matures"
line3$ = "Collect $100"
STP = 20: GOTO PCC2:

CASE IS = 11
line1$ = "Pay school tax"
line3$ = "of $150"
STP = 23: GOTO PCC2:

CASE IS = 12
line1$ = "From sale of stock"
line3$ = "you get $45"
STP = 20: GOTO PCC2:

CASE IS = 13:
line1$ = "GO TO JAIL"
line2$ = "Go directly to jail"
line3$ = "DO NOT PASS GO,"
line4$ = "DO NOT COLLECT $200"
STP = 22: GOTO PCC2:

CASE IS = 14
line1$ = "Pay hospital $100"
STP = 23: GOTO PCC2:

CASE IS = 15
line1$ = "You inherit $100"
STP = 20: GOTO PCC2:

CASE IS = 16
line1$ = "Advance to GO"
line3$ = "Collect $200"
STP = 18: GOTO PCC2:
END SELECT

PCC2:
cmd(c) = 1:
crj 9, line1$
crj 10, line2$
crj 11, line3$
crj 12, line4$
playsounds STP: RCC = RCC - 1
IF STP = 25 THEN GOTO GHH:

COLOR 15, 8:  LOCATE 17, 5: PRINT "Press any key to continue...": SLEEP: WIDTH 80, 25: SAC

GHH:
COLOR 9, 8: LOCATE 17, 1: PRINT "Does "; names$(turn); " own any houses"
			   PRINT "or hotels?  (Y or N):"
chh:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO calchh:
IF k$ = "n" THEN GOTO NP:
GOTO chh:

NP:
LOCATE 17, 1: PRINT SPACE$(40): LOCATE 18, 1: PRINT SPACE$(40)
COLOR 15, 8: LOCATE 17, 5: PRINT "Press any key to continue...": SLEEP:
DO UNTIL INKEY$ = "": LOOP: WIDTH 80, 25: SAC

calchh:
LOCATE 17, 1: PRINT SPACE$(40): LOCATE 18, 1: PRINT SPACE$(40)
COLOR 10, 8: LOCATE 17, 1: INPUT "How many houses?  ", houses
IF houses < 0 OR houses > 32 THEN CLS : GOTO calchh:

ch2:
LOCATE 19, 1: INPUT "How many hotels?  ", hotels
IF hotels < 0 OR hotels > 12 THEN CLS : GOTO ch2:

th1 = 40 * houses: th2 = 115 * hotels: topay = th1 + th2
COLOR 12: LOCATE 21, 1: PRINT names$(turn); " owes "; : PRINT USING "$#,###"; topay; : PRINT " for street repair."
LOCATE 23, 1: PRINT "Press any key to continue...": SLEEP: WIDTH 80, 25: SAC

END SUB

SUB crj (l, t$)

IF LEN(t$) > 30 THEN PRINT : PRINT "The message intended for line"; l: PRINT "is too long.": PRINT t$: END

rj = 34 - LEN(t$)
LOCATE l, rj: PRINT t$

END SUB

SUB deeds

SHELL "cd deeds"

bod: VIEW PRINT: COLOR 8, 8: CLS

LOCATE 4, 1: COLOR 5, 8
PRINT "1. Mediterranean Avenue"
PRINT "   Baltic Avenue"

COLOR 11: LOCATE 7, 1
PRINT "2. Oriental Avenue"
PRINT "   Vermont Avenue"
PRINT "   Connecticut Avenue"

COLOR 13: LOCATE 11, 1:
PRINT "3. St. Charles Place"
PRINT "   States Avenue"
PRINT "   Virginia Avenue"

COLOR 12: LOCATE 15, 1:
PRINT "4. St. James Place"
PRINT "   Tenessee Avenue"
PRINT "   New York Avenue"

COLOR 4: LOCATE 19, 1
PRINT "5. Kentucky Avenue"
PRINT "   Indiana Avenue"
PRINT "   Illinois Avenue"

COLOR 15: LOCATE 23, 1:
PRINT "6. Electric Company"
PRINT "   Water works"

COLOR 14:
LOCATE 4, 35: PRINT " 7. Atlantic Avenue"
LOCATE 5, 35: PRINT "    Ventnor Avenue"
LOCATE 6, 35: PRINT "    Marvin Gardens"

COLOR 2:
LOCATE 8, 35: PRINT " 8. Pacific Avenue"
LOCATE 9, 35: PRINT "    No. Carolina Avenue"
LOCATE 10, 35: PRINT "    Pensylvania Avenue"

COLOR 9:
LOCATE 12, 35: PRINT " 9. Park Place"
LOCATE 13, 35: PRINT "    Boardwalk"

COLOR 7:
LOCATE 15, 35: PRINT "10. Reading Railroad"
LOCATE 16, 35: PRINT "    Pensylvania Railroad"
LOCATE 17, 35: PRINT "    B & O Railroad"
LOCATE 18, 35: PRINT "    Short Line"

COLOR 14
LOCATE 20, 35: PRINT "11. Return to game"

COLOR 7
LOCATE 23, 35: PRINT "Press the number next to the group"
LOCATE 24, 35: INPUT "you want, then press ENTER. ", A

COLOR 15, 8:
SELECT CASE A
CASE IS = 1
CLS : PRINT : SHELL "type dpurple.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 2
CLS : PRINT : SHELL "type lblue.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 3
CLS : PRINT : SHELL "type lpurple.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 4
CLS : PRINT : SHELL "type orange.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 5
CLS : PRINT : SHELL "type red.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 6
CLS : PRINT : SHELL "type utility.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 7
CLS : PRINT : SHELL "type yellow.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 8
CLS : PRINT : SHELL "type green.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 9
CLS : PRINT : SHELL "type blue.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 10
CLS : PRINT : SHELL "type railroad.ded"
PRINT : PRINT : SHELL "pause"
GOTO bod:
CASE IS = 11
SHELL "cd .."
SAC
END SELECT

END SUB

SUB gifload (A$)
DEFINT A-Z
DIM Prefix(4095), Suffix(4095), OutStack(4095), shiftout%(8)
DIM Ybase AS LONG, powersof2(11) AS LONG, WorkCode AS LONG

FOR A% = 0 TO 7: shiftout%(8 - A%) = 2 ^ A%: NEXT A%
FOR A% = 0 TO 11: powersof2(A%) = 2 ^ A%: NEXT A%
IF A$ = "" THEN INPUT "GIF file"; A$: IF A$ = "" THEN END
IF INSTR(A$, ".") = 0 THEN A$ = A$ + ".gif"
OPEN A$ FOR BINARY AS #1
A$ = "      ": GET #1, , A$
IF A$ <> "GIF87a" THEN PRINT "Not a GIF87a file.": END
GET #1, , TotalX: GET #1, , TotalY: GOSUB GetByte
NumColors = 2 ^ ((A% AND 7) + 1): NoPalette = (A% AND 128) = 0
GOSUB GetByte: Background = A%
GOSUB GetByte: IF A% <> 0 THEN PRINT "Bad screen descriptor.": END
IF NoPalette = 0 THEN P$ = SPACE$(NumColors * 3): GET #1, , P$
DO
	GOSUB GetByte
	IF A% = 44 THEN
	EXIT DO
	ELSEIF A% <> 33 THEN
	PRINT "Unknown extension type.": END
	END IF
	GOSUB GetByte
	DO: GOSUB GetByte: A$ = SPACE$(A%): GET #1, , A$: LOOP UNTIL A% = 0
LOOP
GET #1, , XStart: GET #1, , YStart: GET #1, , XLength: GET #1, , YLength
XEnd = XStart + XLength: YEnd = YStart + YLength: GOSUB GetByte
IF A% AND 128 THEN PRINT "Can't handle local colormaps.": END
Interlaced = A% AND 64: PassNumber = 0: PassStep = 8
GOSUB GetByte
ClearCode = 2 ^ A%
EOSCode = ClearCode + 1
FirstCode = ClearCode + 2: NextCode = FirstCode
StartCodeSize = A% + 1: CodeSize = StartCodeSize
StartMaxCode = 2 ^ (A% + 1) - 1: MaxCode = StartMaxCode

BitsIn = 0: BlockSize = 0: BlockPointer = 1
x% = XStart: y% = YStart: Ybase = y% * 320&

SCREEN 13: DEF SEG = &HA000
IF NoPalette = 0 THEN
	OUT &H3C7, 0: OUT &H3C8, 0
	FOR A% = 1 TO NumColors * 3: OUT &H3C9, ASC(MID$(P$, A%, 1)) \ 4: NEXT A%
END IF
LINE (0, 0)-(319, 199), Background, BF
DO
	GOSUB GetCode
	IF Code <> EOSCode THEN
	IF Code = ClearCode THEN
		NextCode = FirstCode
		CodeSize = StartCodeSize
		MaxCode = StartMaxCode
		GOSUB GetCode
		CurCode = Code: LastCode = Code: LastPixel = Code
		IF x% < 320 THEN POKE x% + Ybase, LastPixel
		x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine
	ELSE
		CurCode = Code: StackPointer = 0
		IF Code > NextCode THEN EXIT DO
		IF Code = NextCode THEN
		CurCode = LastCode
		OutStack(StackPointer) = LastPixel
		StackPointer = StackPointer + 1
		END IF

		DO WHILE CurCode >= FirstCode
		OutStack(StackPointer) = Suffix(CurCode)
		StackPointer = StackPointer + 1
		CurCode = Prefix(CurCode)
		LOOP

		LastPixel = CurCode
		IF x% < 320 THEN POKE x% + Ybase, LastPixel
		x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine

		FOR A% = StackPointer - 1 TO 0 STEP -1
		IF x% < 320 THEN POKE x% + Ybase, OutStack(A%)
		x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine
		NEXT A%

		IF NextCode < 4096 THEN
		Prefix(NextCode) = LastCode
		Suffix(NextCode) = LastPixel
		NextCode = NextCode + 1
		IF NextCode > MaxCode AND CodeSize < 12 THEN
			CodeSize = CodeSize + 1
			MaxCode = MaxCode * 2 + 1
		END IF
		END IF
		LastCode = Code
	END IF
	END IF
LOOP UNTIL DoneFlag OR Code = EOSCode
'BEEP
'A$ = INPUT$(1)
CLOSE #1
EXIT SUB

GetByte: A$ = " ": GET #1, , A$: A% = ASC(A$): RETURN

NextScanLine:
	IF Interlaced THEN
	y% = y% + PassStep
	IF y% >= YEnd THEN
		PassNumber = PassNumber + 1
		SELECT CASE PassNumber
		CASE 1: y% = 4: PassStep = 8
		CASE 2: y% = 2: PassStep = 4
		CASE 3: y% = 1: PassStep = 2
		END SELECT
	END IF
	ELSE
	y% = y% + 1
	END IF
	x% = XStart: Ybase = y% * 320&: DoneFlag = y% > 199
RETURN
GetCode:
	IF BitsIn = 0 THEN GOSUB ReadBufferedByte: LastChar = A%: BitsIn = 8
	WorkCode = LastChar \ shiftout%(BitsIn)
	DO WHILE CodeSize > BitsIn
	GOSUB ReadBufferedByte: LastChar = A%
	WorkCode = WorkCode OR LastChar * powersof2(BitsIn)
	BitsIn = BitsIn + 8
	LOOP
	BitsIn = BitsIn - CodeSize
	Code = WorkCode AND MaxCode
RETURN
ReadBufferedByte:
	IF BlockPointer > BlockSize THEN
	GOSUB GetByte: BlockSize = A%
	A$ = SPACE$(BlockSize): GET #1, , A$
	BlockPointer = 1
	END IF
	A% = ASC(MID$(A$, BlockPointer, 1)): BlockPointer = BlockPointer + 1
RETURN

END SUB

DEFSNG A-Z
SUB playsounds (wtp)

RANDOMIZE TIMER: SHELL "cd waves"

SELECT CASE wtp
CASE IS = 0: GOTO ggo:
CASE IS = 1: SHELL "play begin.mp3 /q": GOTO ggo:
CASE IS = 2: SHELL "play 2.wav /q": GOTO ggo:
CASE IS = 3: SHELL "play 3.Wav /q": GOTO ggo:
CASE IS = 4: SHELL "play 4.Wav /q": GOTO ggo:
CASE IS = 5: SHELL "play 5.Wav /q": GOTO ggo:

CASE IS = 6: SHELL "play 6.Wav /q": GOTO ggo:
CASE IS = 7: SHELL "play 7.Wav /q": GOTO ggo:
CASE IS = 8: SHELL "play 8.Wav /q": GOTO ggo:
CASE IS = 9: SHELL "play 9.Wav /q": GOTO ggo:
CASE IS = 10: SHELL "play 10.Wav /q": GOTO ggo:

CASE IS = 11: SHELL "play 11.Wav /q": GOTO ggo:
CASE IS = 12: SHELL "play 12.Wav /q": GOTO ggo:
CASE IS = 13: SHELL "play goodbye.wav /q": GOTO ggo:
CASE IS = 14: SHELL "play Dice1.mp3 /q": GOTO ggo:
CASE IS = 15: SHELL "play dice2.mp3 /q": GOTO ggo:
	   
CASE IS = 16: SHELL "play doubles1.mp3 /q": GOTO ggo:
CASE IS = 17: SHELL "play doubles2.wav /q": GOTO ggo:
CASE IS = 18: SHELL "play doubles3.wav /q": GOTO ggo:
CASE IS = 19: SHELL "play cflip.wav /q": GOTO ggo:
CASE IS = 20: SHELL "play collect.mp3 /q": GOTO ggo:

CASE IS = 21: SHELL "play getout.mp3 /q": GOTO ggo:
CASE IS = 22: SHELL "play jail.mp3 /q": GOTO ggo:
CASE IS = 23: SHELL "play pay.mp3 /q": GOTO ggo:
CASE IS = 24: SHELL "play endgame.wav /q": GOTO ggo:
CASE IS = 25: SHELL "play adios.wav /q": GOTO ggo:

CASE IS = 26: SHELL "play rr.mp3 /q": GOTO ggo:
CASE IS = 27: SHELL "play advance2.mp3 /q": GOTO ggo:
CASE IS = 29: FOR I = 1 TO (RP - 1): SHELL "play collect.mp3 /q": NEXT I
CASE IS = 30: SHELL "play whistle.wav /q": GOTO ggo:
END SELECT

ggo:
SHELL "cd .."

END SUB

SUB ROLL

dp1:
IF names$(turn) = "" THEN GOTO endturn:
RANDOMIZE TIMER: D1 = 0: d2 = 0: total = 0: nt = 0
LET D1 = INT(RND * 6) + 1
LET d2 = INT(RND * 6) + 1

LET ds = INT(RND * 2) + 1
IF ds = 1 THEN playsounds 14
IF ds = 2 THEN playsounds 15

COLOR 14, 9: CLS :
LOCATE 4, 41: PRINT "You rolled a"; D1; "and a"; d2; "."
LOCATE 6, 41: PRINT names$(turn); " moves"; D1 + d2; "spaces."

LOCATE 4, 1
SELECT CASE D1
CASE 1: SHELL "type graphics\md1.mdf"
CASE 2: SHELL "type graphics\md2.mdf"
CASE 3: SHELL "type graphics\md3.mdf"
CASE 4: SHELL "type graphics\md4.mdf"
CASE 5: SHELL "type graphics\md5.mdf"
CASE 6: SHELL "type graphics\md6.mdf"
END SELECT

LOCATE 10, 1
SELECT CASE d2
CASE 1: SHELL "type graphics\md1.mdf"
CASE 2: SHELL "type graphics\md2.mdf"
CASE 3: SHELL "type graphics\md3.mdf"
CASE 4: SHELL "type graphics\md4.mdf"
CASE 5: SHELL "type graphics\md5.mdf"
CASE 6: SHELL "type graphics\md6.mdf"
END SELECT

total = D1 + d2
playsounds total

IF NOT D1 = d2 THEN GOTO command:
IF D1 = d2 THEN GOTO Doubles:

Doubles:
dr = dr + 1:
LET dn = INT(RND * 3) + 1
playsounds (15 + dn)

SAY1:  dn = 0
LOCATE 9, 41: PRINT "You rolled doubles!  roll again!"
LOCATE 10, 41: PRINT "Give a command or hit ENTER to"
LOCATE 11, 41: PRINT "roll again!"

SELECT CASE dr
CASE IS < 2: GOTO command:
CASE IS = 2: LOCATE 13, 41: PRINT "You've rolled 2 doubles in a row."
		 LOCATE 14, 41: PRINT "One more time, and you go to jail!": GOTO command:
CASE IS = 3: LOCATE 13, 41: PRINT "You've rolled 3 doubles in a row."
		 LOCATE 14, 41: PRINT "You now belong in JAIL!": playsounds 22: D1 = 0: GOTO endturn:
CASE ELSE: PRINT : PRINT "# of doubles rolled out of range of 1-3."
END SELECT

command:
nt = turn + 1

gm:
IF nt > players THEN nt = 1: GOTO gm:
IF names$(nt) = "" THEN nt = nt + 1: GOTO gm:
IF names$(nt) <> "" THEN GOTO cmm:

cmm:
SELECT CASE D1
CASE IS <> d2
LOCATE 10, 41: PRINT "Give a command or press ENTER"
LOCATE 11, 41: PRINT "for "; names$(nt); "'s roll.": GOTO gc:
CASE IS = d2
GOTO gc:
END SELECT

COLOR 14, 9:
gc:
k$ = LCASE$(INKEY$)
IF k$ = CHR$(13) THEN GOTO endturn:
IF k$ = "h" THEN SHELL "read help.txt": SAC
IF k$ = "c" THEN chance
IF k$ = "m" THEN comm
IF k$ = "d" THEN deeds
IF k$ = "r" THEN SHELL "read rules.txt": SAC
IF k$ = "x" THEN GOTO goodbye:
IF k$ = "b" THEN bankrupt
IF k$ = CHR$(27) THEN GOTO goodbye:
GOTO gc:

goodbye:
CLS : center 9, "Leaving already!"
center 11, "THank you for using Monopoly Helper 5.0"
playsounds 25
SYSTEM

endturn:
IF D1 = d2 THEN GOTO dp1:

IF players = turn THEN turn = 1: dr = 0: GOTO dp1:
IF players > turn THEN turn = turn + 1: dr = 0: GOTO dp1:

END SUB

SUB SAC

VIEW PRINT:  COLOR 14, 9: CLS :
LOCATE 4, 41: PRINT "You rolled a"; D1; "and a"; d2; "."
LOCATE 6, 41: PRINT names$(turn); " already moved"; D1 + d2; "spaces."

LOCATE 4, 1
SELECT CASE D1
CASE 1: SHELL "type graphics\md1.mdf"
CASE 2: SHELL "type graphics\md2.mdf"
CASE 3: SHELL "type graphics\md3.mdf"
CASE 4: SHELL "type graphics\md4.mdf"
CASE 5: SHELL "type graphics\md5.mdf"
CASE 6: SHELL "type graphics\md6.mdf"
END SELECT

LOCATE 10, 1
SELECT CASE d2
CASE 1: SHELL "type graphics\md1.mdf"
CASE 2: SHELL "type graphics\md2.mdf"
CASE 3: SHELL "type graphics\md3.mdf"
CASE 4: SHELL "type graphics\md4.mdf"
CASE 5: SHELL "type graphics\md5.mdf"
CASE 6: SHELL "type graphics\md6.mdf"
END SELECT

COLOR 15, 9
 LOCATE 19, 1: PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�"
 LOCATE 20, 1: PRINT "H - Help"
 LOCATE 21, 1: PRINT "C - Draw a chance card"
 LOCATE 22, 1: PRINT "M - Draw a Community Chest card"
LOCATE 23, 1: PRINT "D - Show title deeds"
LOCATE 20, 41: PRINT "R - Show Monopoly rules"
LOCATE 21, 41: PRINT "B - Eliminate bankrupt players"
LOCATE 22, 41: PRINT "X - Exit"
VIEW PRINT 1 TO 18: GOTO gec:

gec:
nt = turn + 1

gm2:
IF nt > players THEN nt = 1: GOTO gm2:
IF names$(nt) = "" THEN nt = nt + 1: GOTO gm2:
IF names$(nt) <> "" THEN GOTO cm:

cm:
SELECT CASE D1
CASE IS <> d2
LOCATE 10, 41: PRINT "Give a command or press ENTER"
LOCATE 11, 41: PRINT "for "; names$(nt); "'s roll.": GOTO ggc:
CASE IS = d2
LOCATE 9, 41: PRINT "You rolled doubles!  roll again!"
LOCATE 10, 41: PRINT "Give a command or hit ENTER to"
LOCATE 11, 41: PRINT "roll again!"

SELECT CASE dr
CASE IS < 2: GOTO ggc:
CASE IS = 2: LOCATE 13, 41: PRINT "You've rolled 2 doubles in a row."
		 LOCATE 14, 41: PRINT "One more time, and you go to jail!": GOTO ggc:
CASE IS = 3: LOCATE 13, 41: PRINT "You've rolled 3 doubles in a row."
		 LOCATE 14, 41: PRINT "You now belong in JAIL!": playsounds 22: D1 = 0: GOTO et:
CASE ELSE: PRINT : PRINT "# of doubles rolled out of range of 1-3."
END SELECT
GOTO ggc:
END SELECT

COLOR 14, 9:
ggc:
k$ = LCASE$(INKEY$)
IF k$ = CHR$(13) THEN GOTO et:
IF k$ = "h" THEN SHELL "read help.txt": SAC
IF k$ = "c" THEN chance
IF k$ = "m" THEN comm
IF k$ = "d" THEN deeds
IF k$ = "r" THEN SHELL "read rules.txt": SAC
IF k$ = "x" THEN GOTO bye:
IF k$ = "b" THEN bankrupt
IF k$ = CHR$(27) THEN GOTO bye:
GOTO ggc:

bye:
CLS : center 9, "Leaving already!"
center 11, "THank you for using Monopoly Helper 5.0"
playsounds 25
SYSTEM

et:
IF D1 = d2 THEN ROLL

IF players = turn THEN turn = 1: ROLL
IF players > turn THEN turn = turn + 1: ROLL


END SUB

