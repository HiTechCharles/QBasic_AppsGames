DECLARE SUB CARDMODE ()                'Card mode for 1 or 2 players
DECLARE SUB center (Row, text$)        'centers text on the given line
DECLARE SUB center40 (Row, text$)      'centers text while in 40 x 25
DECLARE SUB Clear.square (S)           'gets rid of a square for card mode
DECLARE SUB CompNames ()               'Initializes computer names
DECLARE SUB gifload (a$)               'loads title board and title screen
DECLARE FUNCTION I2a$ (H)              'converts a numeric-type to string
DECLARE SUB INTRO ()                   'shows logo and tic tac toe screen
DECLARE SUB makex (S)                  'makes an x in the square specified by S
DECLARE SUB makeo (S)                  'makes an O in the square
DECLARE SUB NORMALMODE ()              'Classic t3 tor 1 or 2 players
DECLARE SUB playsounds (S)             'plays aounds
DECLARE SUB waitforkey (Row, col, tc)  'waits for a key to be pressed

DIM SHARED cards(11)               'Stores cards used in 1/2p card mode
DIM SHARED squares(9)              'keeps track of who has each square

DIM SHARED player1$, player2$, p, wfx, wfo, lfx, lfo, cat, y$, ls
DIM SHARED z$, PlayerType1$, PlayerType2$, sndstate, skill1, skill2

RANDOMIZE TIMER: INTRO

begin:
CALL CompNames
SCREEN 0: WIDTH 80, 25: COLOR 12, 8: CLS
LOCATE 2, 32: PRINT "T i c  "; : COLOR 15: PRINT "T a c  "; : COLOR 9: PRINT "T o e"
COLOR 14: center 3, "By Charles Martin"

getplayer1:
COLOR 15: LOCATE 7, 1: PRINT "Player X:  Human or computer player?    H for human"
			   PRINT "                                        C for computer"
getplay1:
PlayerType1$ = LCASE$(INKEY$)
IF PlayerType1$ = "h" THEN GOTO getplayer2:
IF PlayerType1$ = "c" THEN GOTO getplayer2:
GOTO getplayer1:

getplayer2:
COLOR 15: LOCATE 10, 1: PRINT "Player O:  Human or computer player?    H for human"
			   PRINT "                                        C for computer"
getplay2:
PlayerType2$ = LCASE$(INKEY$)
IF PlayerType2$ = "h" THEN GOTO getnames:
IF PlayerType2$ = "c" THEN GOTO getnames:
GOTO getplayer2:

getnames:
LOCATE 13, 1: COLOR 12

SELECT CASE PlayerType1$
CASE IS = "h"
  LINE INPUT "Name of player 1 (X):  ", player1$
	IF player1$ = "" THEN CLS : GOTO getnames:
	IF LEN(player1$) < 2 THEN CLS : GOTO getnames:
	IF LEN(player1$) > 11 THEN CLS : GOTO getnames:
  GOTO name2:
CASE IS = "c"
  player1$ = y$
  PRINT "Player X is a computer opponent by the name of "; player1$: GOTO name2:
END SELECT

name2:
COLOR 9
LOCATE 15, 1:
SELECT CASE PlayerType2$
CASE IS = "h"
   PRINT : PRINT : LINE INPUT "Name of player 2 (O):  ", player2$
	IF player2$ = "" THEN CLS : GOTO name2:
	IF LEN(player2$) < 2 THEN CLS : GOTO name2:
	IF LEN(player2$) > 11 THEN CLS : GOTO name2:
  GOTO wsound:
CASE IS = "c"
  player2$ = z$
  COLOR 9: PRINT : PRINT "Player O is a computer opponent by the name of "; player2$
 GOTO wsound:
END SELECT

wsound:
y$ = "": z$ = "": COLOR 14
PRINT : PRINT : PRINT "Would you like to hear sound during the game?  (Press Y or N)"
gs:
 k$ = LCASE$(INKEY$)
IF k$ = "y" THEN sndstate = 1: GOTO instruct:
IF k$ = "n" THEN sndstate = 0: GOTO instruct:
GOTO gs:

instruct:
player1$ = LTRIM$(RTRIM$(player1$))
player2$ = LTRIM$(RTRIM$(player2$))

COLOR 11
PRINT : PRINT : PRINT "Would you like to read the instructions?  (Press Y or N)"
gi:
 k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO showinst:
IF k$ = "n" THEN GOTO mode:
GOTO gi:

showinst:
SHELL "..\read ..\inst.txt"
GOTO mode:

mode:
CLS : COLOR 15, 0: center 2, "Choose a game mode to play:"

COLOR 14:
LOCATE 5, 1: PRINT "R"; : COLOR 15: PRINT "  Classic mode:  Regular tic tac toe for two players.  Players "
		 PRINT "                  choose where they want their pieces to go."
		 
COLOR 14: LOCATE 8, 1: PRINT "C"; : COLOR 15: PRINT "     Card mode:  A variation of tic tac toe where cards are drawn to"
						  PRINT "                  determine where pieces go.  There are also special cards"
						  PRINT "                  such as 'lose a turn', which makes you lose a turn!  See the"
						  PRINT "                  instructions for more details."

LOCATE 14, 1: PRINT "Choose a mode:  Press R for regular, C for card or I to see instructions:"
gm:
 k$ = LCASE$(INKEY$)
IF k$ = "c" THEN mode = 2: GOTO CPUskill:
IF k$ = "i" THEN SHELL "..\read ..\inst.txt": GOTO mode:
IF k$ = "r" THEN mode = 1: GOTO CPUskill:
GOTO gm:

CPUskill:
IF PlayerType1$ = "h" AND PlayerType2$ = "h" THEN GOTO check:

SELECT CASE PlayerType1$
  CASE IS = "h":  GOTO C2:
  CASE IS = "c": COLOR 10: PRINT : PRINT : PRINT "Which skill level should the computer ("; player1$; ") use?  (1 or 2)"
gsl:
k$ = INKEY$
IF k$ = "1" THEN GOTO asl1:
IF k$ = "2" THEN GOTO asl1:
GOTO gsl:
asl1: IF k$ = "1" THEN skill1 = 1
	  IF k$ = "2" THEN skill1 = 2
	  GOTO C2
END SELECT

C2:
IF PlayerType2$ = "h" THEN GOTO check:

COLOR 10: PRINT : PRINT : PRINT "Which skill level should the computer ("; player2$; ") use?  (1 or 2)"
gs3:
 k$ = INKEY$
IF k$ = "1" THEN GOTO asl2:
IF k$ = "2" THEN GOTO asl2:
GOTO gs3:
asl2: IF k$ = "1" THEN skill2 = 1
	  IF k$ = "2" THEN skill2 = 2
	  GOTO check:

check:
CLS : center 2, "Selected game settings"

COLOR 12:
LOCATE 5, 1: PRINT "Player 1 (X):  "; :
IF PlayerType1$ = "h" THEN PRINT "Humen      NAME:  "; player1$
IF PlayerType1$ = "c" THEN PRINT "Computer   NAME:  "; player1$, : PRINT "SKILL LEVEL: "; skill1

COLOR 9:
LOCATE 7, 1: PRINT "Player 2 (O):  "; :
IF PlayerType2$ = "h" THEN PRINT "Humen      NAME:  "; player2$
IF PlayerType2$ = "c" THEN PRINT "Computer   NAME:  "; player2$, : PRINT "SKILL LEVEL: "; skill2

COLOR 14:
LOCATE 10:
SELECT CASE sndstate
CASE IS = 0: PRINT "Sound is off": GOTO MD:
CASE ELSE: PRINT "Sound is On": GOTO MD:
END SELECT

MD: LOCATE 12: PRINT "Mode:  "; :
IF mode = 1 THEN PRINT "Regular"
IF mode = 2 THEN PRINT "Card"


start:
COLOR 15: LOCATE 14, 1: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
IF mode = 2 THEN GOTO GetReady:

LOCATE 16, 1: PRINT "To place a piece, push the number that is inside the square you want.  The"
LOCATE 17, 1: PRINT "player whose turn it is will be on the bottom of the screen."

GetReady:
waitforkey 20, 28, 11

IF mode = 1 THEN NORMALMODE
IF mode = 2 THEN CARDMODE
CLEAR : GOTO begin:

SUB CARDMODE

TOC:
WIDTH 40, 25: COLOR 15: CLS

IF wfx > 0 OR lfx > 0 THEN LOCATE 1, 1: PRINT player1$: PRINT I2a$(wfx); "W  "; I2a$(lfx); "L"
GG = wfx + wfo + cat + 1: LOCATE 1, 13: : COLOR 13: PRINT USING "GAME:  ###"; GG
IF cat > 0 THEN LOCATE 2, 13: PRINT USING "TIES:  ###"; cat
IF wfo > 0 OR lfo > 0 THEN COLOR 14: LOCATE 1, 27: PRINT player2$: LOCATE 2, 27: PRINT I2a$(wfo); "W  "; I2a$(lfo); "L"

 COLOR 15
 center40 7, "ÉÍÍÍÍÍÑÍÍÍÍÍÑÍÍÍÍÍ»"
 center40 8, "º     ³     ³     º"
 center40 9, "º     ³     ³     º"
center40 10, "º     ³     ³     º"
center40 11, "ÇÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄ¶"
center40 12, "º     ³     ³     º"
center40 13, "º     ³     ³     º"
center40 14, "º     ³     ³     º"
center40 15, "ÇÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄ¶"
center40 16, "º     ³     ³     º"
center40 17, "º     ³     ³     º"
center40 18, "º     ³     ³     º"
center40 19, "ÈÍÍÍÍÍÏÍÍÍÍÍÏÍÍÍÍÍ¼"

COLOR 14
LOCATE 9, 12: PRINT "-1-": LOCATE 13, 12: PRINT "-4-": LOCATE 17, 12: PRINT "-7-"
LOCATE 9, 18: PRINT "-2-": LOCATE 13, 18: PRINT "-5-": LOCATE 17, 18: PRINT "-8-"
LOCATE 9, 24: PRINT "-3-": LOCATE 13, 24: PRINT "-6-": LOCATE 17, 24: PRINT "-9-"

'9-13-17, 13,19,25
ERASE cards, squares: p = 0: px = 0

Cfirstturn:
 X = INT(RND * 2) + 1
IF X = 1 THEN GOTO cpl1:
IF X = 2 THEN GOTO cpl2:

cpl1:
px = 0: IF p = 9 THEN GOTO Ccat:
Clear.square 22: Clear.square 23
COLOR 9: LOCATE 22, 1: PRINT player1$; " (X) ";

 c = INT(RND * 11) + 1
IF cards(c) <> 0 THEN GOTO cpl1:
IF cards(c) = 0 THEN cards(c) = 1: GOTO pn:
pn:
p = p + 1
SELECT CASE c
CASE IS = 1: COLOR 15: PRINT "moves to square 1.": makex 1: cards(1) = 1: GOTO ccfw1:
CASE IS = 2: COLOR 15: PRINT "moves to square 2.": makex 2: cards(2) = 1: GOTO ccfw1:
CASE IS = 3: COLOR 15: PRINT "moves to square 3.": makex 3: cards(3) = 1: GOTO ccfw1:
CASE IS = 4: COLOR 15: PRINT "has drawn the WILD CARD!": cards(4) = 1
SELECT CASE PlayerType1$
CASE IS = "h"
COLOR 10: LOCATE 23, 1: PRINT "Choose an open square:  ";
os1:
 k$ = LCASE$(INKEY$)
IF k$ = "1" AND squares(1) = 0 THEN makex 1: cards(1) = 1: GOTO ewc1:
IF k$ = "2" AND squares(2) = 0 THEN makex 2: cards(2) = 1: GOTO ewc1:
IF k$ = "3" AND squares(3) = 0 THEN makex 3: cards(3) = 1: GOTO ewc1:
IF k$ = "4" AND squares(4) = 0 THEN makex 4: cards(5) = 1: GOTO ewc1:
IF k$ = "5" AND squares(5) = 0 THEN makex 5: cards(6) = 1: GOTO ewc1:
IF k$ = "6" AND squares(6) = 0 THEN makex 6: cards(7) = 1: GOTO ewc1:
IF k$ = "7" AND squares(7) = 0 THEN makex 7: cards(9) = 1: GOTO ewc1:
IF k$ = "8" AND squares(8) = 0 THEN makex 8: cards(10) = 1: GOTO ewc1:
IF k$ = "9" AND squares(9) = 0 THEN makex 9: cards(11) = 1: GOTO ewc1:
GOTO os1:
ewc1:
Clear.square 22: Clear.square 23: LOCATE 22, 1: PRINT player1$; " (X) chose square "; k$; "."
GOTO ccfw1:

CASE IS = "c"
IF skill1 < 2 THEN GOTO rn1:
IF p < 3 THEN GOTO rn1:

IF squares(1) = 1 AND squares(2) = 1 AND squares(3) = 0 THEN cards(3) = 1: makex 3: px = 3: GOTO dp1:
IF squares(3) = 1 AND squares(2) = 1 AND squares(1) = 0 THEN cards(1) = 1: makex 1: px = 1: GOTO dp1:
IF squares(1) = 1 AND squares(3) = 1 AND squares(2) = 0 THEN cards(2) = 1: makex 2: px = 2: GOTO dp1:
IF squares(4) = 1 AND squares(5) = 1 AND squares(6) = 0 THEN cards(6) = 1: makex 6: px = 6: GOTO dp1:
IF squares(6) = 1 AND squares(5) = 1 AND squares(4) = 0 THEN cards(4) = 1: makex 4: px = 4: GOTO dp1:
IF squares(4) = 1 AND squares(6) = 1 AND squares(5) = 0 THEN cards(5) = 1: makex 5: px = 5: GOTO dp1:
IF squares(7) = 1 AND squares(8) = 1 AND squares(9) = 0 THEN cards(9) = 1: makex 9: px = 9: GOTO dp1:
IF squares(9) = 1 AND squares(8) = 1 AND squares(7) = 0 THEN cards(7) = 1: makex 7: px = 7: GOTO dp1:
IF squares(7) = 1 AND squares(9) = 1 AND squares(8) = 0 THEN cards(8) = 1: makex 8: px = 8: GOTO dp1:
IF squares(1) = 1 AND squares(4) = 1 AND squares(7) = 0 THEN cards(7) = 1: makex 7: px = 7: GOTO dp1:
IF squares(7) = 1 AND squares(4) = 1 AND squares(1) = 0 THEN cards(1) = 1: makex 1: px = 1: GOTO dp1:
IF squares(1) = 1 AND squares(7) = 1 AND squares(4) = 0 THEN cards(4) = 1: makex 4: px = 4: GOTO dp1:
IF squares(2) = 1 AND squares(5) = 1 AND squares(8) = 0 THEN cards(8) = 1: makex 8: px = 8: GOTO dp1:
IF squares(8) = 1 AND squares(5) = 1 AND squares(2) = 0 THEN cards(2) = 1: makex 2: px = 2: GOTO dp1:
IF squares(2) = 1 AND squares(8) = 1 AND squares(5) = 0 THEN cards(5) = 1: makex 5: px = 5: GOTO dp1:
IF squares(3) = 1 AND squares(6) = 1 AND squares(9) = 0 THEN cards(9) = 1: makex 9: px = 9: GOTO dp1:
IF squares(9) = 1 AND squares(6) = 1 AND squares(3) = 0 THEN cards(3) = 1: makex 3: px = 3: GOTO dp1:
IF squares(3) = 1 AND squares(9) = 1 AND squares(6) = 0 THEN cards(6) = 1: makex 6: px = 6: GOTO dp1:
IF squares(1) = 1 AND squares(5) = 1 AND squares(9) = 0 THEN cards(9) = 1: makex 9: px = 9: GOTO dp1:
IF squares(9) = 1 AND squares(5) = 1 AND squares(1) = 0 THEN cards(1) = 1: makex 1: px = 1: GOTO dp1:
IF squares(1) = 1 AND squares(9) = 1 AND squares(5) = 0 THEN cards(5) = 1: makex 5: px = 5: GOTO dp1:
IF squares(3) = 1 AND squares(5) = 1 AND squares(7) = 0 THEN cards(7) = 1: makex 7: px = 7: GOTO dp1:
IF squares(7) = 1 AND squares(5) = 1 AND squares(3) = 0 THEN cards(3) = 1: makex 3: px = 3: GOTO dp1:
IF squares(3) = 1 AND squares(7) = 1 AND squares(5) = 0 THEN cards(5) = 1: makex 5: px = 5: GOTO dp1:
IF squares(1) = 2 AND squares(2) = 2 AND squares(3) = 0 THEN cards(3) = 1: makex 3: px = 3: GOTO dp1:
IF squares(3) = 2 AND squares(2) = 2 AND squares(1) = 0 THEN cards(1) = 1: makex 1: px = 1: GOTO dp1:
IF squares(1) = 2 AND squares(3) = 2 AND squares(2) = 0 THEN cards(2) = 1: makex 2: px = 2: GOTO dp1:
IF squares(4) = 2 AND squares(5) = 2 AND squares(6) = 0 THEN cards(6) = 1: makex 6: px = 6: GOTO dp1:
IF squares(6) = 2 AND squares(5) = 2 AND squares(4) = 0 THEN cards(4) = 1: makex 4: px = 4: GOTO dp1:
IF squares(4) = 2 AND squares(6) = 2 AND squares(5) = 0 THEN cards(5) = 1: makex 5: px = 5: GOTO dp1:
IF squares(7) = 2 AND squares(8) = 2 AND squares(9) = 0 THEN cards(9) = 1: makex 9: px = 9: GOTO dp1:
IF squares(9) = 2 AND squares(8) = 2 AND squares(7) = 0 THEN cards(7) = 1: makex 7: px = 7: GOTO dp1:
IF squares(7) = 2 AND squares(9) = 2 AND squares(8) = 0 THEN cards(8) = 1: makex 8: px = 8: GOTO dp1:
IF squares(1) = 2 AND squares(4) = 2 AND squares(7) = 0 THEN cards(7) = 1: makex 7: px = 7: GOTO dp1:
IF squares(7) = 2 AND squares(4) = 2 AND squares(1) = 0 THEN cards(1) = 1: makex 1: px = 1: GOTO dp1:
IF squares(1) = 2 AND squares(7) = 2 AND squares(4) = 0 THEN cards(4) = 1: makex 4: px = 4: GOTO dp1:
IF squares(2) = 2 AND squares(5) = 2 AND squares(8) = 0 THEN cards(8) = 1: makex 8: px = 8: GOTO dp1:
IF squares(8) = 2 AND squares(5) = 2 AND squares(2) = 0 THEN cards(2) = 1: makex 2: px = 2: GOTO dp1:
IF squares(2) = 2 AND squares(8) = 2 AND squares(5) = 0 THEN cards(5) = 1: makex 5: px = 5: GOTO dp1:
IF squares(3) = 2 AND squares(6) = 2 AND squares(9) = 0 THEN cards(9) = 1: makex 9: px = 9: GOTO dp1:
IF squares(9) = 2 AND squares(6) = 2 AND squares(3) = 0 THEN cards(3) = 1: makex 3: px = 3: GOTO dp1:
IF squares(3) = 2 AND squares(9) = 2 AND squares(6) = 0 THEN cards(6) = 1: makex 6: px = 6: GOTO dp1:
IF squares(1) = 2 AND squares(5) = 2 AND squares(9) = 0 THEN cards(9) = 1: makex 9: px = 9: GOTO dp1:
IF squares(9) = 2 AND squares(5) = 2 AND squares(1) = 0 THEN cards(1) = 1: makex 1: px = 1: GOTO dp1:
IF squares(1) = 2 AND squares(9) = 2 AND squares(5) = 0 THEN cards(5) = 1: makex 5: px = 5: GOTO dp1:
IF squares(3) = 2 AND squares(5) = 2 AND squares(7) = 0 THEN cards(7) = 1: makex 7: px = 7: GOTO dp1:
IF squares(7) = 2 AND squares(5) = 2 AND squares(3) = 0 THEN cards(3) = 1: makex 3: px = 3: GOTO dp1:
IF squares(3) = 2 AND squares(7) = 2 AND squares(5) = 0 THEN cards(5) = 1: makex 5: px = 5: GOTO dp1:
IF px = 0 THEN GOTO rn1:

rn1:
 z = INT(RND * 9) + 1
IF squares(z) <> 0 THEN GOTO rn1:
IF squares(z) = 0 THEN makex z: cards(z) = 1: px = z:  GOTO dp1:

dp1:
Clear.square 22: Clear.square 23: LOCATE 22, 1: PRINT player1$; " (X) chose square"; px
px = 0: GOTO ccfw1:
END SELECT

CASE IS = 5: COLOR 15: PRINT "moves to square 4.": makex 4: cards(5) = 1: GOTO ccfw1:
CASE IS = 6: COLOR 15: PRINT "moves to square 5.": makex 5: cards(6) = 1: GOTO ccfw1:
CASE IS = 7: COLOR 15: PRINT "moves to square 6.": makex 6: cards(7) = 1: GOTO ccfw1:
CASE IS = 8: COLOR 15: PRINT "Loses a turn.": cards(8) = 1: p = p - 1: GOTO ccfw1:
CASE IS = 9: COLOR 15: PRINT "moves to square 7.": makex 7: cards(9) = 1: GOTO ccfw1:
CASE IS = 10: COLOR 15: PRINT "moves to square 8.": makex 8: cards(10) = 1: GOTO ccfw1:
CASE IS = 11: COLOR 15: PRINT "moves to square 9.": makex 9: cards(11) = 1: GOTO ccfw1:
END SELECT

cpl2:
px = 0: IF p = 9 THEN GOTO Ccat:
Clear.square 22: Clear.square 23
COLOR 12: LOCATE 22, 1: PRINT player2$; " (O) ";

 c = INT(RND * 11) + 1
IF cards(c) <> 0 THEN GOTO cpl2
IF cards(c) = 0 THEN cards(c) = 2: GOTO pb:

pb: p = p + 1
SELECT CASE c
CASE IS = 1: COLOR 15: PRINT "moves to square 1.": makeo 1: cards(1) = 2: GOTO ccfw2:
CASE IS = 2: COLOR 15: PRINT "moves to square 2.": makeo 2: cards(2) = 2: GOTO ccfw2:
CASE IS = 3: COLOR 15: PRINT "moves to square 3.": makeo 3: cards(3) = 2: GOTO ccfw2:
CASE IS = 4: COLOR 15: PRINT "has drawn the WILD CARD!": cards(4) = 2
SELECT CASE PlayerType2$
CASE IS = "h"
COLOR 27: LOCATE 23, 1: PRINT "Choose an open square:  ";
os2:
 k$ = LCASE$(INKEY$)
IF k$ = "1" AND squares(1) = 0 THEN makeo 1: cards(1) = 2: GOTO ewc2:
IF k$ = "2" AND squares(2) = 0 THEN makeo 2: cards(2) = 2: GOTO ewc2:
IF k$ = "3" AND squares(3) = 0 THEN makeo 3: cards(3) = 2: GOTO ewc2:
IF k$ = "4" AND squares(4) = 0 THEN makeo 4: cards(5) = 2: GOTO ewc2:
IF k$ = "5" AND squares(5) = 0 THEN makeo 5: cards(6) = 2: GOTO ewc2:
IF k$ = "6" AND squares(6) = 0 THEN makeo 6: cards(7) = 2: GOTO ewc2:
IF k$ = "7" AND squares(7) = 0 THEN makeo 7: cards(9) = 2: GOTO ewc2:
IF k$ = "8" AND squares(8) = 0 THEN makeo 8: cards(10) = 2: GOTO ewc2:
IF k$ = "9" AND squares(9) = 0 THEN makeo 9: cards(11) = 2: GOTO ewc2:
GOTO os2:
ewc2:
Clear.square 22: Clear.square 23: LOCATE 22, 1: PRINT player2$; " (O) chose square "; k$; "."
GOTO ccfw2:

CASE IS = "c"
IF skill2 = 1 THEN GOTO rn2:
IF p < 3 THEN GOTO rn2:

IF squares(1) = 2 AND squares(2) = 2 AND squares(3) = 0 THEN cards(3) = 2: makeo 3:  GOTO dp2:
IF squares(3) = 2 AND squares(2) = 2 AND squares(1) = 0 THEN cards(1) = 2: makeo 1:  GOTO dp2:
IF squares(1) = 2 AND squares(3) = 2 AND squares(2) = 0 THEN cards(2) = 2: makeo 2:  GOTO dp2:
IF squares(4) = 2 AND squares(5) = 2 AND squares(6) = 0 THEN cards(6) = 2: makeo 6:  GOTO dp2:
IF squares(6) = 2 AND squares(5) = 2 AND squares(4) = 0 THEN cards(4) = 2: makeo 4:  GOTO dp2:
IF squares(4) = 2 AND squares(6) = 2 AND squares(5) = 0 THEN cards(5) = 2: makeo 5:  GOTO dp2:
IF squares(7) = 2 AND squares(8) = 2 AND squares(9) = 0 THEN cards(9) = 2: makeo 9:  GOTO dp2:
IF squares(9) = 2 AND squares(8) = 2 AND squares(7) = 0 THEN cards(7) = 2: makeo 7:  GOTO dp2:
IF squares(7) = 2 AND squares(9) = 2 AND squares(8) = 0 THEN cards(8) = 2: makeo 8:  GOTO dp2:
IF squares(1) = 2 AND squares(4) = 2 AND squares(7) = 0 THEN cards(7) = 2: makeo 7:  GOTO dp2:
IF squares(7) = 2 AND squares(4) = 2 AND squares(1) = 0 THEN cards(1) = 2: makeo 1:  GOTO dp2:
IF squares(1) = 2 AND squares(7) = 2 AND squares(4) = 0 THEN cards(4) = 2: makeo 4:  GOTO dp2:
IF squares(2) = 2 AND squares(5) = 2 AND squares(8) = 0 THEN cards(8) = 2: makeo 8:  GOTO dp2:
IF squares(8) = 2 AND squares(5) = 2 AND squares(2) = 0 THEN cards(2) = 2: makeo 2:  GOTO dp2:
IF squares(2) = 2 AND squares(8) = 2 AND squares(5) = 0 THEN cards(5) = 2: makeo 5:  GOTO dp2:
IF squares(3) = 2 AND squares(6) = 2 AND squares(9) = 0 THEN cards(9) = 2: makeo 9:  GOTO dp2:
IF squares(9) = 2 AND squares(6) = 2 AND squares(3) = 0 THEN cards(3) = 2: makeo 3:  GOTO dp2:
IF squares(3) = 2 AND squares(9) = 2 AND squares(6) = 0 THEN cards(6) = 2: makeo 6:  GOTO dp2:
IF squares(1) = 2 AND squares(5) = 2 AND squares(9) = 0 THEN cards(9) = 2: makeo 9:  GOTO dp2:
IF squares(9) = 2 AND squares(5) = 2 AND squares(1) = 0 THEN cards(1) = 2: makeo 1:  GOTO dp2:
IF squares(1) = 2 AND squares(9) = 2 AND squares(5) = 0 THEN cards(5) = 2: makeo 5:  GOTO dp2:
IF squares(3) = 2 AND squares(5) = 2 AND squares(7) = 0 THEN cards(7) = 2: makeo 7:  GOTO dp2:
IF squares(7) = 2 AND squares(5) = 2 AND squares(3) = 0 THEN cards(3) = 2: makeo 3:  GOTO dp2:
IF squares(3) = 2 AND squares(7) = 2 AND squares(5) = 0 THEN cards(5) = 2: makeo 5:  GOTO dp2:
IF squares(1) = 1 AND squares(2) = 1 AND squares(3) = 0 THEN cards(3) = 2: makeo 3:  GOTO dp2:
IF squares(3) = 1 AND squares(2) = 1 AND squares(1) = 0 THEN cards(1) = 2: makeo 1:  GOTO dp2:
IF squares(1) = 1 AND squares(3) = 1 AND squares(2) = 0 THEN cards(2) = 2: makeo 2:  GOTO dp2:
IF squares(4) = 1 AND squares(5) = 1 AND squares(6) = 0 THEN cards(6) = 2: makeo 6:  GOTO dp2:
IF squares(6) = 1 AND squares(5) = 1 AND squares(4) = 0 THEN cards(4) = 2: makeo 4:  GOTO dp2:
IF squares(4) = 1 AND squares(6) = 1 AND squares(5) = 0 THEN cards(5) = 2: makeo 5:  GOTO dp2:
IF squares(7) = 1 AND squares(8) = 1 AND squares(9) = 0 THEN cards(9) = 2: makeo 9:  GOTO dp2:
IF squares(9) = 1 AND squares(8) = 1 AND squares(7) = 0 THEN cards(7) = 2: makeo 7:  GOTO dp2:
IF squares(7) = 1 AND squares(9) = 1 AND squares(8) = 0 THEN cards(8) = 2: makeo 8:  GOTO dp2:
IF squares(1) = 1 AND squares(4) = 1 AND squares(7) = 0 THEN cards(7) = 2: makeo 7:  GOTO dp2:
IF squares(7) = 1 AND squares(4) = 1 AND squares(1) = 0 THEN cards(1) = 2: makeo 1:  GOTO dp2:
IF squares(1) = 1 AND squares(7) = 1 AND squares(4) = 0 THEN cards(4) = 2: makeo 4:  GOTO dp2:
IF squares(2) = 1 AND squares(5) = 1 AND squares(8) = 0 THEN cards(8) = 2: makeo 8:  GOTO dp2:
IF squares(8) = 1 AND squares(5) = 1 AND squares(2) = 0 THEN cards(2) = 2: makeo 2:  GOTO dp2:
IF squares(2) = 1 AND squares(8) = 1 AND squares(5) = 0 THEN cards(5) = 2: makeo 5:  GOTO dp2:
IF squares(3) = 1 AND squares(6) = 1 AND squares(9) = 0 THEN cards(9) = 2: makeo 9:  GOTO dp2:
IF squares(9) = 1 AND squares(6) = 1 AND squares(3) = 0 THEN cards(3) = 2: makeo 3:  GOTO dp2:
IF squares(3) = 1 AND squares(9) = 1 AND squares(6) = 0 THEN cards(6) = 2: makeo 6:  GOTO dp2:
IF squares(1) = 1 AND squares(5) = 1 AND squares(9) = 0 THEN cards(9) = 2: makeo 9:  GOTO dp2:
IF squares(9) = 1 AND squares(5) = 1 AND squares(1) = 0 THEN cards(1) = 2: makeo 1:  GOTO dp2:
IF squares(1) = 1 AND squares(9) = 1 AND squares(5) = 0 THEN cards(5) = 2: makeo 5:  GOTO dp2:
IF squares(3) = 1 AND squares(5) = 1 AND squares(7) = 0 THEN cards(7) = 2: makeo 7:  GOTO dp2:
IF squares(7) = 1 AND squares(5) = 1 AND squares(3) = 0 THEN cards(3) = 2: makeo 3:  GOTO dp2:
IF squares(3) = 1 AND squares(7) = 1 AND squares(5) = 0 THEN cards(5) = 2: makeo 5:  GOTO dp2:
GOTO rn2:

rn2:
 z = INT(RND * 9) + 1
IF squares(z) <> 0 THEN GOTO rn2:
IF squares(z) = 0 THEN makeo z: cards(z) = 2: px = z:  GOTO dp2:

dp2:
px = ls
Clear.square 22: Clear.square 23: LOCATE 22, 1: PRINT player2$; " (O) chose square"; px
ls = 0: px = 0: GOTO ccfw2:
END SELECT

CASE IS = 5: COLOR 15: PRINT "moves to square 4.": makeo 4: cards(5) = 2: GOTO ccfw2:
CASE IS = 6: COLOR 15: PRINT "moves to square 5.": makeo 5: cards(6) = 2: GOTO ccfw2:
CASE IS = 7: COLOR 15: PRINT "moves to square 6.": makeo 6: cards(7) = 2: GOTO ccfw2:
CASE IS = 8: COLOR 15: PRINT "Loses a turn.": cards(8) = 2: p = p - 1: GOTO cpl1:
CASE IS = 9: COLOR 15: PRINT "moves to square 7.": makeo 7: cards(9) = 2: GOTO ccfw2:
CASE IS = 10: COLOR 15: PRINT "moves to square 8.": makeo 8: cards(10) = 2: GOTO ccfw2:
CASE IS = 11: COLOR 15: PRINT "moves to square 9.": makeo 9: cards(11) = 2: GOTO ccfw2:
END SELECT

ccfw1:
'x  checks of X wins across
Clear.square 23: LOCATE 23, 1: PRINT "Press any key to continue.": SLEEP: Clear.square 23
IF squares(1) = 1 AND squares(2) = 1 AND squares(3) = 1 THEN wxx = wxx + 1
IF squares(4) = 1 AND squares(5) = 1 AND squares(6) = 1 THEN wxx = wxx + 1
IF squares(7) = 1 AND squares(8) = 1 AND squares(9) = 1 THEN wxx = wxx + 1
'Checks X wins down
IF squares(1) = 1 AND squares(4) = 1 AND squares(7) = 1 THEN wxx = wxx + 1
IF squares(2) = 1 AND squares(5) = 1 AND squares(8) = 1 THEN wxx = wxx + 1
IF squares(3) = 1 AND squares(6) = 1 AND squares(9) = 1 THEN wxx = wxx + 1
'checks X squares for diagnal wins
IF squares(1) = 1 AND squares(5) = 1 AND squares(9) = 1 THEN wxx = wxx + 1
IF squares(3) = 1 AND squares(5) = 1 AND squares(7) = 1 THEN wxx = wxx + 1
IF wxx > 0 THEN GOTO Cwin1:
GOTO cpl2:

ccfw2:
'o  checks for O wins across
Clear.square 23: LOCATE 23, 1: PRINT "Press any key to continue.": SLEEP: Clear.square 23
IF squares(1) = 2 AND squares(2) = 2 AND squares(3) = 2 THEN wxo = wxo + 1
IF squares(4) = 2 AND squares(5) = 2 AND squares(6) = 2 THEN wxo = wxo + 1
IF squares(7) = 2 AND squares(8) = 2 AND squares(9) = 2 THEN wxo = wxo + 1
'Checks O wins down
IF squares(1) = 2 AND squares(4) = 2 AND squares(7) = 2 THEN wxo = wxo + 1
IF squares(2) = 2 AND squares(5) = 2 AND squares(8) = 2 THEN wxo = wxo + 1
IF squares(3) = 2 AND squares(6) = 2 AND squares(9) = 2 THEN wxo = wxo + 1
'checks O squares for diagnal wins
IF squares(1) = 2 AND squares(5) = 2 AND squares(9) = 2 THEN wxo = wxo + 1
IF squares(3) = 2 AND squares(5) = 2 AND squares(7) = 2 THEN wxo = wxo + 1
IF wxo > 0 THEN GOTO Cwin2:
GOTO cpl1:

Cwin1:
wfx = wfx + 1: lfo = lfo + 1:
 z = INT(RND * 5) + 1: playsounds z
Clear.square 22: LOCATE 22, 1: PRINT player1$; " (X) wins!  Press any key."
SLEEP: GOTO Cstats:

Cwin2:
wfo = wfo + 1: lfx = lfx + 1:
 z = INT(RND * 5) + 1: playsounds z
Clear.square 22: LOCATE 22, 1: PRINT player2$; " (O) wins!  Press any key."
SLEEP: GOTO Cstats:

Cstats:
COLOR 15: CLS : center40 2, "Player Stats"
COLOR 15: LOCATE 5, 12: PRINT "After"; wfx + wfo + cat; "gemes..."
COLOR 12: LOCATE 6, 1: PRINT player1$; " (X) has won"; wfx; "and lost"; lfx
COLOR 9: LOCATE 8, 1: PRINT player2$; " (O) has won"; wfo; "and lost"; lfo
COLOR 11: LOCATE 10, 1: PRINT "There have been"; cat; "tie games."
GOTO Cover:

Ccat:
cat = cat + 1
playsounds 7
Clear.square 22: LOCATE 22, 1: COLOR 27: PRINT "Cat's game! Press any key."
SLEEP: GOTO Cstats:

Cover:
COLOR 15: PRINT : PRINT : PRINT "Play again?  (Y or N)"
Cwpa:
 k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO Cag:
IF k$ = "n" THEN GOTO CFINALE:
GOTO Cwpa:

Cag: COLOR 11
PRINT : PRINT "Are the same people playing"
	PRINT "the next game?  (Y or N)"
Cwpb:
 k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO TOC:
IF k$ = "n" THEN EXIT SUB
GOTO Cwpb:

CFINALE:
COLOR 10: center40 16, "You have been playing"
COLOR 15: center40 18, "T I C  T A C  T O E"
COLOR 12: center40 20, "By Charles Martin"
waitforkey 22, 5, 14
SYSTEM
END

END SUB

SUB center (Row, text$)

'Centers a lin of text
col = 40 - (LEN(text$) / 2): LOCATE Row, col: PRINT text$

END SUB

SUB center40 (Row, text$)

col = 20 - (LEN(text$) / 2): LOCATE Row, col: PRINT text$

END SUB

SUB Clear.square (S)

SELECT CASE S
   CASE IS = 1: LOCATE 9, 12: PRINT "   ": EXIT SUB
   CASE IS = 2: LOCATE 9, 18: PRINT "   ": EXIT SUB
   CASE IS = 3: LOCATE 9, 24: PRINT "   ": EXIT SUB
   CASE IS = 4: LOCATE 13, 12: PRINT "   ": EXIT SUB
   CASE IS = 5: LOCATE 13, 18: PRINT "   ": EXIT SUB
   CASE IS = 6: LOCATE 13, 24: PRINT "   ": EXIT SUB
   CASE IS = 7: LOCATE 17, 12: PRINT "   ": EXIT SUB
   CASE IS = 8: LOCATE 17, 18: PRINT "   ": EXIT SUB
   CASE IS = 9: LOCATE 17, 24: PRINT "   ": EXIT SUB
   CASE 22 TO 23: LOCATE S, 1: PRINT SPACE$(40)
END SELECT

END SUB

SUB CompNames

'A list of 100 names for the computer.  The CNAMES$ array stores these
'names.

DIM cnames$(100)            'Stores computer names

 cnames$(1) = "Charles"
 cnames$(2) = "Amanda"
 cnames$(3) = "Shane"
 cnames$(4) = "Victor"
 cnames$(5) = "Julie"
 cnames$(6) = "James"
 cnames$(7) = "Donna"
 cnames$(8) = "Jason"
 cnames$(9) = "Squall"
cnames$(10) = "Irvine"
cnames$(11) = "Cid"
cnames$(12) = "Angela"
cnames$(13) = "Paul"
cnames$(14) = "Fred"
cnames$(15) = "Annie"
cnames$(16) = "Neil"
cnames$(17) = "Kim"
cnames$(18) = "Don"
cnames$(19) = "Max"
cnames$(20) = "David"
cnames$(21) = "Roy"
cnames$(22) = "Bill"
cnames$(23) = "Leo"
cnames$(24) = "Patrica"
cnames$(25) = "shawna"

cnames$(26) = "Steve"
cnames$(27) = "Anikan"
cnames$(28) = "Lou"
cnames$(29) = "Troy"
cnames$(30) = "Adam"
cnames$(31) = "Ken"
cnames$(32) = "Jack"
cnames$(33) = "Dena"
cnames$(34) = "Dana"
cnames$(35) = "Scott"
cnames$(36) = "Janelle"
cnames$(37) = "Janette"
cnames$(38) = "Marvin"
cnames$(39) = "Martha"
cnames$(40) = "Pamela"
cnames$(41) = "Thomas"
cnames$(42) = "Sue"
cnames$(43) = "Brian"
cnames$(44) = "Kathy"
cnames$(45) = "Heather"
cnames$(46) = "Shiela"
cnames$(47) = "Kevin"
cnames$(48) = "Amy"
cnames$(49) = "Alicia"
cnames$(50) = "Nichole"

cnames$(51) = "Arron"
cnames$(52) = "Doug"
cnames$(53) = "Aeris"
cnames$(54) = "Gary"
cnames$(55) = "Tara"
cnames$(56) = "Vincent"
cnames$(57) = "Emily"
cnames$(58) = "Nikki"
cnames$(59) = "Joe"
cnames$(60) = "Mike"
cnames$(61) = "Crystal"
cnames$(62) = "Christian"
cnames$(63) = "Jennifer"
cnames$(64) = "Angel"
cnames$(65) = "Isiah"
cnames$(66) = "Luke"
cnames$(67) = "John"
cnames$(68) = "Mark"
cnames$(69) = "Tom "
cnames$(70) = "Trever"
cnames$(71) = "Sonya"
cnames$(72) = "Samson"
cnames$(73) = "Dean"
cnames$(74) = "Dan"
cnames$(75) = "Tonya"

cnames$(76) = "Al"
cnames$(77) = "Ted"
cnames$(78) = "Kelly"
cnames$(79) = "Ryan"
cnames$(80) = "Matt"
cnames$(81) = "Krista"
cnames$(82) = "Robert"
cnames$(83) = "Jeff"
cnames$(84) = "Chris"
cnames$(85) = "Larry"
cnames$(86) = "Bob"
cnames$(87) = "Randy"
cnames$(88) = "Chad"
cnames$(89) = "Tim"
cnames$(90) = "Bert"
cnames$(91) = "Gordon"
cnames$(92) = "Kenan"
cnames$(93) = "Kevin"
cnames$(94) = "Ashley"
cnames$(95) = "Tony"
cnames$(96) = "Terry"
cnames$(97) = "Andrew"
cnames$(98) = "George"
cnames$(99) = "William"
cnames$(100) = "Mary"

pickagain:
z = INT(RND * 100) + 1: y = INT(RND * 100) + 1

IF y = z THEN GOTO pickagain:  'doesen't allow identical computer names
y$ = cnames$(y): z$ = cnames$(z)

END SUB

SUB gifload (a$)
DEFINT A-Z
DIM Prefix(4095), Suffix(4095), OutStack(4095), shiftout%(8)
DIM Ybase AS LONG, powersof2(11) AS LONG, WorkCode AS LONG

FOR a% = 0 TO 7: shiftout%(8 - a%) = 2 ^ a%: NEXT a%
FOR a% = 0 TO 11: powersof2(a%) = 2 ^ a%: NEXT a%
IF a$ = "" THEN INPUT "GIF file"; a$: IF a$ = "" THEN END
IF INSTR(a$, ".") = 0 THEN a$ = a$ + ".gif"
OPEN a$ FOR BINARY AS #1
a$ = "      ": GET #1, , a$
IF a$ <> "GIF87a" THEN PRINT "Not a GIF87a file.": END
GET #1, , TotalX: GET #1, , TotalY: GOSUB GetByte
NumColors = 2 ^ ((a% AND 7) + 1): NoPate = (a% AND 128) = 0
GOSUB GetByte: Background = a%
GOSUB GetByte: IF a% <> 0 THEN PRINT "Bad screen descriptor.": END
IF NoPate = 0 THEN p$ = SPACE$(NumColors * 3): GET #1, , p$
DO
	GOSUB GetByte
	IF a% = 44 THEN
	EXIT DO
	ELSEIF a% <> 33 THEN
	PRINT "Unknown extension type.": END
	END IF
	GOSUB GetByte
	DO: GOSUB GetByte: a$ = SPACE$(a%): GET #1, , a$: LOOP UNTIL a% = 0
LOOP
GET #1, , XStart: GET #1, , YStart: GET #1, , XLength: GET #1, , YLength
XEnd = XStart + XLength: YEnd = YStart + YLength: GOSUB GetByte
IF a% AND 128 THEN PRINT "Can't handle local colormaps.": END
Interlaced = a% AND 64: PassNumber = 0: PassStep = 8
GOSUB GetByte
ClearCode = 2 ^ a%
EOSCode = ClearCode + 1
FirstCode = ClearCode + 2: NextCode = FirstCode
StartCodeSize = a% + 1: CodeSize = StartCodeSize
StartMaxCode = 2 ^ (a% + 1) - 1: MaxCode = StartMaxCode

BitsIn = 0: BlockSize = 0: BlockPointer = 1
X% = XStart: y% = YStart: Ybase = y% * 320&

SCREEN 13: DEF SEG = &HA000
IF NoPate = 0 THEN
	OUT &H3C7, 0: OUT &H3C8, 0
	FOR a% = 1 TO NumColors * 3: OUT &H3C9, ASC(MID$(p$, a%, 1)) \ 4: NEXT a%
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
		IF X% < 320 THEN POKE X% + Ybase, LastPixel
		X% = X% + 1: IF X% = XEnd THEN GOSUB NextScanLine
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
		IF X% < 320 THEN POKE X% + Ybase, LastPixel
		X% = X% + 1: IF X% = XEnd THEN GOSUB NextScanLine

		FOR a% = StackPointer - 1 TO 0 STEP -1
		IF X% < 320 THEN POKE X% + Ybase, OutStack(a%)
		X% = X% + 1: IF X% = XEnd THEN GOSUB NextScanLine
		NEXT a%

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

GetByte: a$ = " ": GET #1, , a$: a% = ASC(a$): RETURN

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
	X% = XStart: Ybase = y% * 320&: DoneFlag = y% > 199
RETURN
GetCode:
	IF BitsIn = 0 THEN GOSUB ReadBufferedByte: LastChar = a%: BitsIn = 8
	WorkCode = LastChar \ shiftout%(BitsIn)
	DO WHILE CodeSize > BitsIn
	GOSUB ReadBufferedByte: LastChar = a%
	WorkCode = WorkCode OR LastChar * powersof2(BitsIn)
	BitsIn = BitsIn + 8
	LOOP
	BitsIn = BitsIn - CodeSize
	Code = WorkCode AND MaxCode
RETURN
ReadBufferedByte:
	IF BlockPointer > BlockSize THEN
	GOSUB GetByte: BlockSize = a%
	a$ = SPACE$(BlockSize): GET #1, , a$
	BlockPointer = 1
	END IF
	a% = ASC(MID$(a$, BlockPointer, 1)): BlockPointer = BlockPointer + 1
RETURN






END SUB

DEFSNG A-Z
FUNCTION I2a$ (H)
I2a$ = LTRIM$(RTRIM$(STR$(H)))
END FUNCTION

SUB INTRO

SHELL "cd media"

DEFINT A-Z
gifload "ms.gif"
COLOR 27: LOCATE 11, 4: PRINT "Charles"
	  LOCATE 11, 29: PRINT "Charles"
center40 21, "P R E S E N T S"
SLEEP 3: SCREEN 0: CLS : SCREEN 13: CLS :

CLS : gifload "title.gif"
SLEEP 5

END SUB

DEFSNG A-Z
SUB makeo (S)
squares(S) = 2: ls = S: Clear.square S

SELECT CASE S
   CASE IS = 1: RR = 8: cc = 12: GOTO putit:
   CASE IS = 2: RR = 8: cc = 18: GOTO putit:
   CASE IS = 3: RR = 8: cc = 24: GOTO putit:
   CASE IS = 4: RR = 12: cc = 12: GOTO putit:
   CASE IS = 5: RR = 12: cc = 18: GOTO putit:
   CASE IS = 6: RR = 12: cc = 24: GOTO putit:
   CASE IS = 7: RR = 16: cc = 12: GOTO putit:
   CASE IS = 8: RR = 16: cc = 18: GOTO putit:
   CASE IS = 9: RR = 16: cc = 24: GOTO putit:
END SELECT

putit:
COLOR 12:
	LOCATE RR, cc: PRINT "ÛÛÛ"
LOCATE RR + 1, cc: PRINT "Û Û"
LOCATE RR + 2, cc: PRINT "ÛÛÛ": playsounds 6

END SUB

SUB makex (S)

squares(S) = 1: Clear.square S

SELECT CASE S
   CASE IS = 1: RR = 8: cc = 12: GOTO putit2:
   CASE IS = 2: RR = 8: cc = 18: GOTO putit2:
   CASE IS = 3: RR = 8: cc = 24: GOTO putit2:
   CASE IS = 4: RR = 12: cc = 12: GOTO putit2:
   CASE IS = 5: RR = 12: cc = 18: GOTO putit2:
   CASE IS = 6: RR = 12: cc = 24: GOTO putit2:
   CASE IS = 7: RR = 16: cc = 12: GOTO putit2:
   CASE IS = 8: RR = 16: cc = 18: GOTO putit2:
   CASE IS = 9: RR = 16: cc = 24: GOTO putit2:
END SELECT

putit2:
COLOR 9:
	LOCATE RR, cc: PRINT "Û Û"
LOCATE RR + 1, cc: PRINT " Û "
LOCATE RR + 2, cc: PRINT "Û Û": playsounds 6

END SUB

 SUB NORMALMODE

TON:
WIDTH 40, 25: COLOR 15: CLS

IF wfx > 0 OR lfx > 0 THEN LOCATE 1, 1: PRINT player1$: PRINT I2a$(wfx); "W  "; I2a$(lfx); "L"
GG = wfx + wfo + cat + 1: LOCATE 1, 13: : COLOR 13: PRINT USING "GAME:  ###"; GG
IF cat > 0 THEN LOCATE 2, 13: PRINT USING "TIES:  ###"; cat
IF wfo > 0 OR lfo > 0 THEN COLOR 14: LOCATE 1, 27: PRINT player2$: LOCATE 2, 27: PRINT I2a$(wfo); "W  "; I2a$(lfo); "L"

 COLOR 15
 center40 7, "ÉÍÍÍÍÍÑÍÍÍÍÍÑÍÍÍÍÍ»"
 center40 8, "º     ³     ³     º"
 center40 9, "º     ³     ³     º"
center40 10, "º     ³     ³     º"
center40 11, "ÇÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄ¶"
center40 12, "º     ³     ³     º"
center40 13, "º     ³     ³     º"
center40 14, "º     ³     ³     º"
center40 15, "ÇÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄ¶"
center40 16, "º     ³     ³     º"
center40 17, "º     ³     ³     º"
center40 18, "º     ³     ³     º"
center40 19, "ÈÍÍÍÍÍÏÍÍÍÍÍÏÍÍÍÍÍ¼"

COLOR 14
LOCATE 9, 12: PRINT "-1-": LOCATE 13, 12: PRINT "-4-": LOCATE 17, 12: PRINT "-7-"
LOCATE 9, 18: PRINT "-2-": LOCATE 13, 18: PRINT "-5-": LOCATE 17, 18: PRINT "-8-"
LOCATE 9, 24: PRINT "-3-": LOCATE 13, 24: PRINT "-6-": LOCATE 17, 24: PRINT "-9-"

'9-13-17, 13,19,25

ERASE squares, cards: p = 0: px = 0

firstturn:
 X = INT(RND * 2) + 1
IF X = 1 THEN GOTO pl1:
IF X = 2 THEN GOTO pl2:

pl1:
px = 0:
IF p >= 9 THEN GOTO cat:
Clear.square 22
COLOR 12: LOCATE 22, 1:
IF RIGHT$(player1$, 1) = "s" THEN PRINT player1$; "' turn  (X)"
IF RIGHT$(player1$, 1) <> "s" THEN PRINT player1$; "'s turn  (X)"
p = p + 1

SELECT CASE PlayerType1$
CASE IS = "h": GOTO hp1:
CASE IS = "c": GOTO cp1:
CASE ELSE: PRINT "ERROR": END
END SELECT

hp1:
gs1:
 k$ = LCASE$(INKEY$)
IF k$ = "1" AND squares(1) = 0 THEN makex 1: GOTO cfw1:
IF k$ = "2" AND squares(2) = 0 THEN makex 2: GOTO cfw1:
IF k$ = "3" AND squares(3) = 0 THEN makex 3: GOTO cfw1:
IF k$ = "4" AND squares(4) = 0 THEN makex 4: GOTO cfw1:
IF k$ = "5" AND squares(5) = 0 THEN makex 5: GOTO cfw1:
IF k$ = "6" AND squares(6) = 0 THEN makex 6: GOTO cfw1:
IF k$ = "7" AND squares(7) = 0 THEN makex 7: GOTO cfw1:
IF k$ = "8" AND squares(8) = 0 THEN makex 8: GOTO cfw1:
IF k$ = "9" AND squares(9) = 0 THEN makex 9: GOTO cfw1:
IF k$ = CHR$(27) THEN SYSTEM
GOTO gs1:

cp1:
SLEEP 1
SELECT CASE skill1
CASE IS = 1: GOTO p1s1:
CASE IS = 2: GOTO p1s2:
END SELECT

p1s1:
 z = INT(RND * 9) + 1
IF squares(z) <> 0 THEN GOTO p1s1:
IF squares(z) = 0 THEN makex z: GOTO cfw1:

p1s2:
IF p < 3 THEN GOTO p1s1:
IF squares(1) = 1 AND squares(2) = 1 AND squares(3) = 0 THEN squares(3) = 1: makex 3: px = 1: GOTO cfw1:
IF squares(3) = 1 AND squares(2) = 1 AND squares(1) = 0 THEN squares(1) = 1: makex 1: px = 1: GOTO cfw1:
IF squares(1) = 1 AND squares(3) = 1 AND squares(2) = 0 THEN squares(2) = 1: makex 2: px = 1: GOTO cfw1:
IF squares(4) = 1 AND squares(5) = 1 AND squares(6) = 0 THEN squares(6) = 1: makex 6: px = 1: GOTO cfw1:
IF squares(6) = 1 AND squares(5) = 1 AND squares(4) = 0 THEN squares(4) = 1: makex 4: px = 1: GOTO cfw1:
IF squares(4) = 1 AND squares(6) = 1 AND squares(5) = 0 THEN squares(5) = 1: makex 5: px = 1: GOTO cfw1:
IF squares(7) = 1 AND squares(8) = 1 AND squares(9) = 0 THEN squares(9) = 1: makex 9: px = 1: GOTO cfw1:
IF squares(9) = 1 AND squares(8) = 1 AND squares(7) = 0 THEN squares(7) = 1: makex 7: px = 1: GOTO cfw1:
IF squares(7) = 1 AND squares(9) = 1 AND squares(8) = 0 THEN squares(8) = 1: makex 8: px = 1: GOTO cfw1:
IF squares(1) = 1 AND squares(4) = 1 AND squares(7) = 0 THEN squares(7) = 1: makex 7: px = 1: GOTO cfw1:
IF squares(7) = 1 AND squares(4) = 1 AND squares(1) = 0 THEN squares(1) = 1: makex 1: px = 1: GOTO cfw1:
IF squares(1) = 1 AND squares(7) = 1 AND squares(4) = 0 THEN squares(4) = 1: makex 4: px = 1: GOTO cfw1:
IF squares(2) = 1 AND squares(5) = 1 AND squares(8) = 0 THEN squares(8) = 1: makex 8: px = 1: GOTO cfw1:
IF squares(8) = 1 AND squares(5) = 1 AND squares(2) = 0 THEN squares(2) = 1: makex 2: px = 1: GOTO cfw1:
IF squares(2) = 1 AND squares(8) = 1 AND squares(5) = 0 THEN squares(5) = 1: makex 5: px = 1: GOTO cfw1:
IF squares(3) = 1 AND squares(6) = 1 AND squares(9) = 0 THEN squares(9) = 1: makex 9: px = 1: GOTO cfw1:
IF squares(9) = 1 AND squares(6) = 1 AND squares(3) = 0 THEN squares(3) = 1: makex 3: px = 1: GOTO cfw1:
IF squares(3) = 1 AND squares(9) = 1 AND squares(6) = 0 THEN squares(6) = 1: makex 6: px = 1: GOTO cfw1:
IF squares(1) = 1 AND squares(5) = 1 AND squares(9) = 0 THEN squares(9) = 1: makex 9: px = 1: GOTO cfw1:
IF squares(9) = 1 AND squares(5) = 1 AND squares(1) = 0 THEN squares(1) = 1: makex 1: px = 1: GOTO cfw1:
IF squares(1) = 1 AND squares(9) = 1 AND squares(5) = 0 THEN squares(5) = 1: makex 5: px = 1: GOTO cfw1:
IF squares(3) = 1 AND squares(5) = 1 AND squares(7) = 0 THEN squares(7) = 1: makex 7: px = 1: GOTO cfw1:
IF squares(7) = 1 AND squares(5) = 1 AND squares(3) = 0 THEN squares(3) = 1: makex 3: px = 1: GOTO cfw1:
IF squares(3) = 1 AND squares(7) = 1 AND squares(5) = 0 THEN squares(5) = 1: makex 5: px = 1: GOTO cfw1:
IF squares(1) = 2 AND squares(2) = 2 AND squares(3) = 0 THEN squares(3) = 1: makex 3: px = 1: GOTO cfw1:
IF squares(3) = 2 AND squares(2) = 2 AND squares(1) = 0 THEN squares(1) = 1: makex 1: px = 1: GOTO cfw1:
IF squares(1) = 2 AND squares(3) = 2 AND squares(2) = 0 THEN squares(2) = 1: makex 2: px = 1: GOTO cfw1:
IF squares(4) = 2 AND squares(5) = 2 AND squares(6) = 0 THEN squares(6) = 1: makex 6: px = 1: GOTO cfw1:
IF squares(6) = 2 AND squares(5) = 2 AND squares(4) = 0 THEN squares(4) = 1: makex 4: px = 1: GOTO cfw1:
IF squares(4) = 2 AND squares(6) = 2 AND squares(5) = 0 THEN squares(5) = 1: makex 5: px = 1: GOTO cfw1:
IF squares(7) = 2 AND squares(8) = 2 AND squares(9) = 0 THEN squares(9) = 1: makex 9: px = 1: GOTO cfw1:
IF squares(9) = 2 AND squares(8) = 2 AND squares(7) = 0 THEN squares(7) = 1: makex 7: px = 1: GOTO cfw1:
IF squares(7) = 2 AND squares(9) = 2 AND squares(8) = 0 THEN squares(8) = 1: makex 8: px = 1: GOTO cfw1:
IF squares(1) = 2 AND squares(4) = 2 AND squares(7) = 0 THEN squares(7) = 1: makex 7: px = 1: GOTO cfw1:
IF squares(7) = 2 AND squares(4) = 2 AND squares(1) = 0 THEN squares(1) = 1: makex 1: px = 1: GOTO cfw1:
IF squares(1) = 2 AND squares(7) = 2 AND squares(4) = 0 THEN squares(4) = 1: makex 4: px = 1: GOTO cfw1:
IF squares(2) = 2 AND squares(5) = 2 AND squares(8) = 0 THEN squares(8) = 1: makex 8: px = 1: GOTO cfw1:
IF squares(8) = 2 AND squares(5) = 2 AND squares(2) = 0 THEN squares(2) = 1: makex 2: px = 1: GOTO cfw1:
IF squares(2) = 2 AND squares(8) = 2 AND squares(5) = 0 THEN squares(5) = 1: makex 5: px = 1: GOTO cfw1:
IF squares(3) = 2 AND squares(6) = 2 AND squares(9) = 0 THEN squares(9) = 1: makex 9: px = 1: GOTO cfw1:
IF squares(9) = 2 AND squares(6) = 2 AND squares(3) = 0 THEN squares(3) = 1: makex 3: px = 1: GOTO cfw1:
IF squares(3) = 2 AND squares(9) = 2 AND squares(6) = 0 THEN squares(6) = 1: makex 6: px = 1: GOTO cfw1:
IF squares(1) = 2 AND squares(5) = 2 AND squares(9) = 0 THEN squares(9) = 1: makex 9: px = 1: GOTO cfw1:
IF squares(9) = 2 AND squares(5) = 2 AND squares(1) = 0 THEN squares(1) = 1: makex 1: px = 1: GOTO cfw1:
IF squares(1) = 2 AND squares(9) = 2 AND squares(5) = 0 THEN squares(5) = 1: makex 5: px = 1: GOTO cfw1:
IF squares(3) = 2 AND squares(5) = 2 AND squares(7) = 0 THEN squares(7) = 1: makex 7: px = 1: GOTO cfw1:
IF squares(7) = 2 AND squares(5) = 2 AND squares(3) = 0 THEN squares(3) = 1: makex 3: px = 1: GOTO cfw1:
IF squares(3) = 2 AND squares(7) = 2 AND squares(5) = 0 THEN squares(5) = 1: makex 5: px = 1: GOTO cfw1:
IF px = 0 THEN px = 0: GOTO p1s1:

pl2:
px = 0
IF p >= 9 THEN GOTO cat:
Clear.square 22
COLOR 9
LOCATE 22, 1:
IF RIGHT$(player2$, 1) = "s" THEN PRINT player2$; "' turn  (O)"
IF RIGHT$(player2$, 1) <> "s" THEN PRINT player2$; "'s turn  (O)"

p = p + 1
SELECT CASE PlayerType2$
CASE IS = "h": GOTO hp2:
CASE IS = "c": GOTO cp2:
CASE ELSE: PRINT "ERROR": END
END SELECT

hp2:
gs2:
 k$ = LCASE$(INKEY$)
IF k$ = "1" AND squares(1) = 0 THEN makeo 1: GOTO cfw2:
IF k$ = "2" AND squares(2) = 0 THEN makeo 2: GOTO cfw2:
IF k$ = "3" AND squares(3) = 0 THEN makeo 3: GOTO cfw2:
IF k$ = "4" AND squares(4) = 0 THEN makeo 4: GOTO cfw2:
IF k$ = "5" AND squares(5) = 0 THEN makeo 5: GOTO cfw2:
IF k$ = "6" AND squares(6) = 0 THEN makeo 6: GOTO cfw2:
IF k$ = "7" AND squares(7) = 0 THEN makeo 7: GOTO cfw2:
IF k$ = "8" AND squares(8) = 0 THEN makeo 8: GOTO cfw2:
IF k$ = "9" AND squares(9) = 0 THEN makeo 9: GOTO cfw2:
IF k$ = CHR$(27) THEN SYSTEM
GOTO gs2:

cp2:
SLEEP 1
SELECT CASE skill2
CASE IS = 1: GOTO p2s1:
CASE IS = 2: GOTO p2s2:
END SELECT

p2s1:
 z = INT(RND * 9) + 1
IF squares(z) <> 0 THEN GOTO p2s1:
IF squares(z) = 0 THEN makeo z: GOTO cfw2:

p2s2:
IF p < 3 THEN GOTO p2s1:
IF squares(1) = 2 AND squares(2) = 2 AND squares(3) = 0 THEN squares(3) = 2: makeo 3: px = 1: GOTO cfw2:
IF squares(3) = 2 AND squares(2) = 2 AND squares(1) = 0 THEN squares(1) = 2: makeo 1: px = 1: GOTO cfw2:
IF squares(1) = 2 AND squares(3) = 2 AND squares(2) = 0 THEN squares(2) = 2: makeo 2: px = 1: GOTO cfw2:
IF squares(4) = 2 AND squares(5) = 2 AND squares(6) = 0 THEN squares(6) = 2: makeo 6: px = 1: GOTO cfw2:
IF squares(6) = 2 AND squares(5) = 2 AND squares(4) = 0 THEN squares(4) = 2: makeo 4: px = 1: GOTO cfw2:
IF squares(4) = 2 AND squares(6) = 2 AND squares(5) = 0 THEN squares(5) = 2: makeo 5: px = 1: GOTO cfw2:
IF squares(7) = 2 AND squares(8) = 2 AND squares(9) = 0 THEN squares(9) = 2: makeo 9: px = 1: GOTO cfw2:
IF squares(9) = 2 AND squares(8) = 2 AND squares(7) = 0 THEN squares(7) = 2: makeo 7: px = 1: GOTO cfw2:
IF squares(7) = 2 AND squares(9) = 2 AND squares(8) = 0 THEN squares(8) = 2: makeo 8: px = 1: GOTO cfw2:
IF squares(1) = 2 AND squares(4) = 2 AND squares(7) = 0 THEN squares(7) = 2: makeo 7: px = 1: GOTO cfw2:
IF squares(7) = 2 AND squares(4) = 2 AND squares(1) = 0 THEN squares(1) = 2: makeo 1: px = 1: GOTO cfw2:
IF squares(1) = 2 AND squares(7) = 2 AND squares(4) = 0 THEN squares(4) = 2: makeo 4: px = 1: GOTO cfw2:
IF squares(2) = 2 AND squares(5) = 2 AND squares(8) = 0 THEN squares(8) = 2: makeo 8: px = 1: GOTO cfw2:
IF squares(8) = 2 AND squares(5) = 2 AND squares(2) = 0 THEN squares(2) = 2: makeo 2: px = 1: GOTO cfw2:
IF squares(2) = 2 AND squares(8) = 2 AND squares(5) = 0 THEN squares(5) = 2: makeo 5: px = 1: GOTO cfw2:
IF squares(3) = 2 AND squares(6) = 2 AND squares(9) = 0 THEN squares(9) = 2: makeo 9: px = 1: GOTO cfw2:
IF squares(9) = 2 AND squares(6) = 2 AND squares(3) = 0 THEN squares(3) = 2: makeo 3: px = 1: GOTO cfw2:
IF squares(3) = 2 AND squares(9) = 2 AND squares(6) = 0 THEN squares(6) = 2: makeo 6: px = 1: GOTO cfw2:
IF squares(1) = 2 AND squares(5) = 2 AND squares(9) = 0 THEN squares(9) = 2: makeo 9: px = 1: GOTO cfw2:
IF squares(9) = 2 AND squares(5) = 2 AND squares(1) = 0 THEN squares(1) = 2: makeo 1: px = 1: GOTO cfw2:
IF squares(1) = 2 AND squares(9) = 2 AND squares(5) = 0 THEN squares(5) = 2: makeo 5: px = 1: GOTO cfw2:
IF squares(3) = 2 AND squares(5) = 2 AND squares(7) = 0 THEN squares(7) = 2: makeo 7: px = 1: GOTO cfw2:
IF squares(7) = 2 AND squares(5) = 2 AND squares(3) = 0 THEN squares(3) = 2: makeo 3: px = 1: GOTO cfw2:
IF squares(3) = 2 AND squares(7) = 2 AND squares(5) = 0 THEN squares(5) = 2: makeo 5: px = 1: GOTO cfw2:
IF squares(1) = 1 AND squares(2) = 1 AND squares(3) = 0 THEN squares(3) = 2: makeo 3: px = 1: GOTO cfw2:
IF squares(3) = 1 AND squares(2) = 1 AND squares(1) = 0 THEN squares(1) = 2: makeo 1: px = 1: GOTO cfw2:
IF squares(1) = 1 AND squares(3) = 1 AND squares(2) = 0 THEN squares(2) = 2: makeo 2: px = 1: GOTO cfw2:
IF squares(4) = 1 AND squares(5) = 1 AND squares(6) = 0 THEN squares(6) = 2: makeo 6: px = 1: GOTO cfw2:
IF squares(6) = 1 AND squares(5) = 1 AND squares(4) = 0 THEN squares(4) = 2: makeo 4: px = 1: GOTO cfw2:
IF squares(4) = 1 AND squares(6) = 1 AND squares(5) = 0 THEN squares(5) = 2: makeo 5: px = 1: GOTO cfw2:
IF squares(7) = 1 AND squares(8) = 1 AND squares(9) = 0 THEN squares(9) = 2: makeo 9: px = 1: GOTO cfw2:
IF squares(9) = 1 AND squares(8) = 1 AND squares(7) = 0 THEN squares(7) = 2: makeo 7: px = 1: GOTO cfw2:
IF squares(7) = 1 AND squares(9) = 1 AND squares(8) = 0 THEN squares(8) = 2: makeo 8: px = 1: GOTO cfw2:
IF squares(1) = 1 AND squares(4) = 1 AND squares(7) = 0 THEN squares(7) = 2: makeo 7: px = 1: GOTO cfw2:
IF squares(7) = 1 AND squares(4) = 1 AND squares(1) = 0 THEN squares(1) = 2: makeo 1: px = 1: GOTO cfw2:
IF squares(1) = 1 AND squares(7) = 1 AND squares(4) = 0 THEN squares(4) = 2: makeo 4: px = 1: GOTO cfw2:
IF squares(2) = 1 AND squares(5) = 1 AND squares(8) = 0 THEN squares(8) = 2: makeo 8: px = 1: GOTO cfw2:
IF squares(8) = 1 AND squares(5) = 1 AND squares(2) = 0 THEN squares(2) = 2: makeo 2: px = 1: GOTO cfw2:
IF squares(2) = 1 AND squares(8) = 1 AND squares(5) = 0 THEN squares(5) = 2: makeo 5: px = 1: GOTO cfw2:
IF squares(3) = 1 AND squares(6) = 1 AND squares(9) = 0 THEN squares(9) = 2: makeo 9: px = 1: GOTO cfw2:
IF squares(9) = 1 AND squares(6) = 1 AND squares(3) = 0 THEN squares(3) = 2: makeo 3: px = 1: GOTO cfw2:
IF squares(3) = 1 AND squares(9) = 1 AND squares(6) = 0 THEN squares(6) = 2: makeo 6: px = 1: GOTO cfw2:
IF squares(1) = 1 AND squares(5) = 1 AND squares(9) = 0 THEN squares(9) = 2: makeo 9: px = 1: GOTO cfw2:
IF squares(9) = 1 AND squares(5) = 1 AND squares(1) = 0 THEN squares(1) = 2: makeo 1: px = 1: GOTO cfw2:
IF squares(1) = 1 AND squares(9) = 1 AND squares(5) = 0 THEN squares(5) = 2: makeo 5: px = 1: GOTO cfw2:
IF squares(3) = 1 AND squares(5) = 1 AND squares(7) = 0 THEN squares(7) = 2: makeo 7: px = 1: GOTO cfw2:
IF squares(7) = 1 AND squares(5) = 1 AND squares(3) = 0 THEN squares(3) = 2: makeo 3: px = 1: GOTO cfw2:
IF squares(3) = 1 AND squares(7) = 1 AND squares(5) = 0 THEN squares(5) = 2: makeo 5: px = 1: GOTO cfw2:
IF px = 0 THEN GOTO p2s1:

cfw1:
'x  checks of X wins across
IF squares(1) = 1 AND squares(2) = 1 AND squares(3) = 1 THEN wxx = wxx + 1
IF squares(4) = 1 AND squares(5) = 1 AND squares(6) = 1 THEN wxx = wxx + 1
IF squares(7) = 1 AND squares(8) = 1 AND squares(9) = 1 THEN wxx = wxx + 1
'Checks X wins down
IF squares(1) = 1 AND squares(4) = 1 AND squares(7) = 1 THEN wxx = wxx + 1
IF squares(2) = 1 AND squares(5) = 1 AND squares(8) = 1 THEN wxx = wxx + 1
IF squares(3) = 1 AND squares(6) = 1 AND squares(9) = 1 THEN wxx = wxx + 1
'checks X squares for diagnal wins
IF squares(1) = 1 AND squares(5) = 1 AND squares(9) = 1 THEN wxx = wxx + 1
IF squares(3) = 1 AND squares(5) = 1 AND squares(7) = 1 THEN wxx = wxx + 1
IF wxx > 0 THEN GOTO win1:
GOTO pl2:

cfw2:
'o  checks for O wins across
IF squares(1) = 2 AND squares(2) = 2 AND squares(3) = 2 THEN wxo = wxo + 1
IF squares(4) = 2 AND squares(5) = 2 AND squares(6) = 2 THEN wxo = wxo + 1
IF squares(7) = 2 AND squares(8) = 2 AND squares(9) = 2 THEN wxo = wxo + 1
'Checks O wins down
IF squares(1) = 2 AND squares(4) = 2 AND squares(7) = 2 THEN wxo = wxo + 1
IF squares(2) = 2 AND squares(5) = 2 AND squares(8) = 2 THEN wxo = wxo + 1
IF squares(3) = 2 AND squares(6) = 2 AND squares(9) = 2 THEN wxo = wxo + 1
'checks O squares for diagnal wins
IF squares(1) = 2 AND squares(5) = 2 AND squares(9) = 2 THEN wxo = wxo + 1
IF squares(3) = 2 AND squares(5) = 2 AND squares(7) = 2 THEN wxo = wxo + 1
IF wxo > 0 THEN GOTO win2:
GOTO pl1:

win1:
wfx = wfx + 1: lfo = lfo + 1: z = INT(RND * 5) + 1: playsounds z
Clear.square 22: LOCATE 22, 1: PRINT player1$; " (X) wins!  Press any key."
SLEEP: GOTO stats:

win2:
wfo = wfo + 1: lfx = lfx + 1: z = INT(RND * 5) + 1: playsounds z
Clear.square 22: LOCATE 22, 1: PRINT player2$; " (O) wins!  Press any key."
SLEEP: GOTO stats:

stats:
CLS : COLOR 15: center40 2, "Player Stats"
COLOR 15: LOCATE 5, 12: PRINT "After"; wfx + wfo + cat; "gemes..."
COLOR 12: LOCATE 6, 1: PRINT player1$; " (X) has won"; wfx; "and lost"; lfx
COLOR 9: LOCATE 8, 1: PRINT player2$; " (O) has won"; wfo; "and lost"; lfo
COLOR 11: LOCATE 10, 1: PRINT "There have been"; cat; "tie games."
GOTO over:

cat:
cat = cat + 1: playsounds 7
Clear.square 22: LOCATE 22, 1: PRINT "Cat's game! Press any key."
SLEEP: GOTO stats:

over:
COLOR 15: PRINT : PRINT : PRINT "Play again?  (Y or N)"
wpa:
 k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO ag:
IF k$ = "n" THEN GOTO FINALE:
GOTO wpa:

ag: COLOR 11
PRINT : PRINT "Are the same people playing"
	PRINT "the next game?  (Y or N)"
wpb:
 k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO TON:
IF k$ = "n" THEN EXIT SUB
GOTO wpb:

FINALE:
COLOR 10: center40 16, "You have been playing"
COLOR 15: center40 18, "T I C  T A C  T O E"
COLOR 12: center40 20, "By Charles Martin"
COLOR 9: center40 21, "Http://home.earthlink.net/~drwfan54"
waitforkey 23, 5, 14
SYSTEM

END SUB

SUB playsounds (S)

IF sndstate = 0 THEN EXIT SUB

SELECT CASE S
   CASE IS = 1: SHELL "..\play win.wav /q"
   CASE IS = 2: SHELL "..\play win2.wav /q"
   CASE IS = 3: SHELL "..\play win3.wav /q"
   CASE IS = 4: SHELL "..\play win4.wav /q"
   CASE IS = 5: SHELL "..\play win5.wav /q"
   CASE IS = 6: SHELL "..\play place.wav /q"
   CASE IS = 7: SHELL "..\play cat.wav /q"
   CASE ELSE: PRINT : PRINT "Sound number out of range of 1-7.": END
END SELECT

EXIT SUB

END SUB

SUB waitforkey (Row, col, tc)  'waits for a key to be pressed

'Parameters:  Row, col:  row and collumn where message should appear.
'                   TC:  Text color (on black) of the message
								
COLOR tc, 8: LOCATE Row, col: PRINT "Press any key to continue. . .": SLEEP

END SUB

