DECLARE SUB center (row, text$)    'Centers text on a given line
DECLARE SUB CompNames ()           'Gets a name for a computer player
DECLARE SUB OnePlayer ()           'One player game
DECLARE SUB StickSound (T)         'plays a sound for picking up sticks
DECLARE SUB TwoPlayers ()          'Two player game

DIM SHARED player1$, player2$, wfa, wfb, lfa, lfb, NT, L, StixLeft, x$, CS

begin:
WIDTH 40, 25: COLOR 9, 8:  CLS     'Sets up the screen with wider letters
center 2, "23 Pickup Xtra"         'Centers the words in "" on line 2
center 3, "By Charles Martin"
COLOR 11: center 4, "Home.earthlink.net/~drwfan54"

COLOR 14: LOCATE 7, 1: PRINT "How many human players?  (1 or 2):  "
NP:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN OnePlayer
IF k$ = "2" THEN TwoPlayers
IF k$ = CHR$(27) THEN SYSTEM
GOTO NP:

'A guide so I don't use more  |---0----0----0----0----0----0----0----X
'than 40 letters in a line.
                            

SUB center (row, text$)

col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

3 SUB CompNames

'a list of 100 names for the computer player.
'This is why the COMPNAMES array is used.  It stores these names.

DIM cnames$(100)  'stores the computer names

LET cnames$(1) = "Charles"  'Wouldn't you expect my name to be first?
LET cnames$(2) = "Amanda"
LET cnames$(3) = "Victor"
LET cnames$(4) = "Julie"
LET cnames$(5) = "James"
LET cnames$(6) = "Donna"
LET cnames$(7) = "Jason"
LET cnames$(8) = "Squall"
LET cnames$(9) = "Irvine"
LET cnames$(10) = "Cid"
LET cnames$(11) = "Angela"
LET cnames$(12) = "Paul"
LET cnames$(13) = "Fred"
LET cnames$(14) = "Annie"
LET cnames$(15) = "Neil"
LET cnames$(16) = "Kim"
LET cnames$(17) = "Don"
LET cnames$(18) = "Jannifer"
LET cnames$(19) = "Max"
LET cnames$(20) = "David"
LET cnames$(21) = "Roy"
LET cnames$(22) = "Bill"
LET cnames$(23) = "Leo"
LET cnames$(24) = "Patrica"
LET cnames$(25) = "shawna"

LET cnames$(26) = "Steve"
LET cnames$(27) = "Anikan"
LET cnames$(28) = "Lou"
LET cnames$(29) = "Troy"
LET cnames$(30) = "Adam"
LET cnames$(31) = "Ken"
LET cnames$(32) = "Jack"
LET cnames$(33) = "Dena"
LET cnames$(34) = "Dana"
LET cnames$(35) = "Scott"
LET cnames$(36) = "janelle"
LET cnames$(37) = "Janette"
LET cnames$(38) = "Marvin"
LET cnames$(39) = "Martha"
LET cnames$(40) = "Pamela"
LET cnames$(41) = "Thomas"
LET cnames$(42) = "Sue"
LET cnames$(43) = "Brian"
LET cnames$(44) = "Kathy"
LET cnames$(45) = "Heather"
LET cnames$(46) = "Shiela"
LET cnames$(47) = "Kevin"
LET cnames$(48) = "Amy"
LET cnames$(49) = "Alicia"
LET cnames$(50) = "Nichole"

LET cnames$(51) = "James"
LET cnames$(52) = "Doug"
LET cnames$(53) = "Aeris"
LET cnames$(54) = "Gary"
LET cnames$(55) = "Tara"
LET cnames$(56) = "Vincent"
LET cnames$(57) = "Emily"
LET cnames$(58) = "Nikki"
LET cnames$(59) = "Joe"
LET cnames$(60) = "Mike"
LET cnames$(61) = "Crystal"
LET cnames$(62) = "Christian"
LET cnames$(63) = "Shane"
LET cnames$(64) = "Angel"
LET cnames$(65) = "Isiah"
LET cnames$(66) = "Luke"
LET cnames$(67) = "John"
LET cnames$(68) = "Mark"
LET cnames$(69) = "Tom "
LET cnames$(70) = "Trever"
LET cnames$(71) = "Sonya"
LET cnames$(72) = "Samson"
LET cnames$(73) = "Dean"
LET cnames$(74) = "Dan"
LET cnames$(75) = "Tonya"

LET cnames$(76) = "Al"
LET cnames$(77) = "Ted"
LET cnames$(78) = "Kelly"
LET cnames$(79) = "Ryan"
LET cnames$(80) = "Matt"
LET cnames$(81) = "Krista"
LET cnames$(82) = "Robert"
LET cnames$(83) = "Jeff"
LET cnames$(84) = "Chris"
LET cnames$(85) = "Larry"
LET cnames$(86) = "Bob"
LET cnames$(87) = "Randy"
LET cnames$(88) = "Chad"
LET cnames$(89) = "Tim"
LET cnames$(90) = "Bert"
LET cnames$(91) = "Gordon"
LET cnames$(92) = "Kenan"
LET cnames$(93) = "Kevin"
LET cnames$(94) = "Shaun"
LET cnames$(95) = "Tony"
LET cnames$(96) = "Terry"
LET cnames$(97) = "Andrew"
LET cnames$(98) = "George"
LET cnames$(99) = "William"
LET cnames$(100) = "Mary"

RANDOMIZE TIMER
C = INT(RND * 100) + 1
player2$ = cnames$(C)

END SUB


SUB OnePlayer

wfa = 0: lfa = 0: wfb = 0: lfb = 0: StixLeft = 23

OP:
CompNames

COLOR 14: LOCATE 9, 1: LINE INPUT "Name of human Player:  ", player1$  'gets name
SELECT CASE LEN(player1$)   'Makes sure name is not too big or small. 2-12 accepted.
CASE IS < 2: PRINT : PRINT "Name must be at least 2 letters long.": SLEEP 2: CLS : GOTO OP:
CASE IS > 11: PRINT : PRINT "Name must be 12 letters or less.": SLEEP 2: CLS : GOTO OP:
CASE ELSE:  GOTO GetCPname:
END SELECT

GetCPname:
COLOR 10: LOCATE 11: PRINT "You will be playing against "; player2$

SndState:
COLOR 12: LOCATE 13, 1: PRINT "Would you like to hear sounds during"
                        PRINT "the game?  (Press Y or N):"
gss:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN snd = 1: GOTO Cskill:  'If Y, allow sound
IF k$ = "n" THEN snd = 0: GOTO Cskill:  'If N, have no sound
GOTO gss:

Cskill:
COLOR 9: LOCATE 16, 1: PRINT "What should "; player2$; "'s skil level be?"
                       PRINT "1-Easy, 2-averate, or 3-smart:"
CS:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN CS = 1: GOTO inst:
IF k$ = "2" THEN CS = 2: GOTO inst:
IF k$ = "3" THEN CS = 3: GOTO inst:
GOTO CS:

inst:
COLOR 10: SLEEP 1: CLS 'pauses for 1 second allowing screen to be seen B4 it clears
center 2, "23 Pickup instructions": COLOR 15: LOCATE 5, 1:
PRINT "23 pickup is a 2-player game in which"
PRINT
PRINT "players take turns taking sticks from"
PRINT
PRINT "a pile that starts with 23.  On a"
PRINT
PRINT "player's turn, the player takes"
PRINT
PRINT "either 1, 2, or 3 sticks.  The"
PRINT
PRINT "player that takes the LAST stick"
PRINT
PRINT "LOSES the game."
COLOR 17: center 20, "Press any key to start!": SLEEP

realgame2:
CLS : StixLeft = 23: NT = 0: L = 5'Sets # of sticks for a new game

FirstTurn2:     'Decides who goes first randomly
RANDOMIZE TIMER
P = INT(RND * 2) + 1
IF P = 1 THEN GOTO op1:
IF P = 2 THEN GOTO op2:


op1:
IF snd = 1 THEN StickSound NT
COLOR 14: LOCATE 1, 1:
PRINT "³                                      ³"
PRINT "³                                      ³"
PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
COLOR 11: LOCATE 2, 3: PRINT player1$; "'s turn  - "; StixLeft; "sticks left"
IF L > 23 THEN L = 5: VIEW PRINT 5 TO 23: CLS : VIEW PRINT:   'clear results panel when it gets full
COLOR 9: LOCATE L, 1: PRINT player1$; ", HOW MANY?  (1,2,3):"
getstix3:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN NT = 1: GOTO WR3:
IF k$ = "2" THEN NT = 2: GOTO WR3:
IF k$ = "3" THEN NT = 3: GOTO WR3:
GOTO getstix3:

WR3:
'Cant press 3 with only 2 sticks left
IF NT = 1 THEN LOCATE L, 1: PRINT SPACE$(39): LOCATE L, 1: PRINT player1$; " took"; NT; "stick."
IF NT <> 1 THEN LOCATE L, 1: PRINT SPACE$(39): LOCATE L, 1: PRINT player1$; " took"; NT; "sticks."
StixLeft = StixLeft - NT
L = L + 1

SELECT CASE StixLeft
CASE IS > 1: GOTO op2:
CASE IS = 0: LOCATE L, 1: PRINT "---"; player1$; " has taken the last stick!"
LOCATE L + 1, 1: COLOR 15: PRINT UCASE$(player2$); " HAS WON!"
lfa = lfa + 1: wfb = wfb + 1  'give win and loss to appropriate players
GOTO EndGame2:

CASE IS = 1: COLOR 15: LOCATE L, 1: PRINT "---"; player2$; " must take the last stick!"
LOCATE L + 1, 1: COLOR 9: PRINT UCASE$(player1$); " HAS WON!"
lfb = lfb + 1: wfa = wfa + 1  'give win and loss to appropriate players
GOTO EndGame2:
END SELECT

op2:
IF snd = 1 THEN StickSound NT
COLOR 14: LOCATE 1, 1:
PRINT "³                                      ³"
PRINT "³                                      ³"
PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
COLOR 11: LOCATE 2, 3: PRINT player2$; "'s turn  - "; StixLeft; "sticks left"
IF L > 23 THEN L = 5: VIEW PRINT 5 TO 23: CLS : VIEW PRINT:   'clear results panel when it gets full

SELECT CASE CS  'do a set of code based on skill level
CASE IS = 1:
EZ:
NT = INT(RND * 3) + 1

GOTO PR:

CASE IS = 2:
avg:
IF StixLeft > 12 THEN GOTO EZ:
IF StixLeft = 12 THEN NT = 3
IF StixLeft = 11 THEN NT = 2
IF StixLeft = 10 THEN NT = 1
IF StixLeft = 9 THEN GOTO EZ:
IF StixLeft = 8 THEN NT = 3
IF StixLeft = 7 THEN NT = 2
IF StixLeft = 6 THEN NT = 1
IF StixLeft = 5 THEN GOTO EZ:
IF StixLeft = 4 THEN NT = 3
IF StixLeft = 3 THEN NT = 2
IF StixLeft = 2 THEN NT = 1
IF StixLeft = 1 THEN NT = 1

CASE IS = 3:
smart:
IF StixLeft = 23 THEN NT = 2
IF StixLeft = 22 THEN NT = 1
IF StixLeft = 21 THEN NT = 1
IF StixLeft = 20 THEN NT = 3
IF StixLeft = 19 THEN NT = 2
IF StixLeft = 18 THEN NT = 1
IF StixLeft = 17 THEN GOTO EZ:
IF StixLeft = 16 THEN NT = 3
IF StixLeft = 15 THEN NT = 2
IF StixLeft = 14 THEN NT = 1
IF StixLeft = 13 THEN GOTO EZ:
IF StixLeft = 12 THEN NT = 3
IF StixLeft = 11 THEN NT = 2
IF StixLeft = 10 THEN NT = 1
IF StixLeft = 9 THEN GOTO EZ:
IF StixLeft = 8 THEN NT = 3
IF StixLeft = 7 THEN NT = 2
IF StixLeft = 6 THEN NT = 1
IF StixLeft = 5 THEN GOTO EZ:
IF StixLeft = 4 THEN NT = 3
IF StixLeft = 3 THEN NT = 2
IF StixLeft = 2 THEN NT = 1
IF StixLeft = 1 THEN NT = 1

CASE ELSE:  PRINT : PRINT "Skill number out of range of 1-3.": SYSTEM
END SELECT

PR:
IF StixLeft - NT < 0 THEN GOTO EZ:  'makes sure random choice is acceptable.
IF NT = 1 THEN LOCATE L, 1: PRINT SPACE$(39): LOCATE L, 1: PRINT player2$; " took"; NT; "stick."
IF NT <> 1 THEN LOCATE L, 1: PRINT SPACE$(39): LOCATE L, 1: PRINT player2$; " took"; NT; "sticks."
StixLeft = StixLeft - NT
L = L + 1

SELECT CASE StixLeft
CASE IS > 1: GOTO op1:
CASE IS = 0: LOCATE L, 1: PRINT "---"; player2$; " has taken the last stick!"
LOCATE L + 1, 1: COLOR 9: PRINT UCASE$(player1$); " HAS WON!"
lfb = lfb + 1: wfa = wfa + 1  'give win and loss to appropriate players
GOTO EndGame2:
CASE ELSE: LOCATE L, 1: PRINT "---"; player1$; " must take the last stick!"
LOCATE L + 1, 1: COLOR 15: PRINT UCASE$(player2$); " HAS WON!"
lfa = lfa + 1: wfb = wfb + 1  'give win and loss to appropriate players
GOTO EndGame2:
END SELECT

EndGame2:
IF snd = 1 THEN PLAY "T160O1>L20CDEDCDL10ECCDEDCp8l2c"
COLOR 11: center 23, "Press any key to continue...": SLEEP: CLS
center 2, "Statistics"
COLOR 9: LOCATE 5, 1: PRINT player1$; " has won"; wfa; "and lost"; lfa
COLOR 15: LOCATE 7, 1: PRINT player2$; " has won"; wfb; "and lost"; lfb
COLOR 14: LOCATE 12, 1: PRINT "Would you like to play again?  (Y/N):"
gyna3:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO SamePlayers3:
IF k$ = "n" THEN GOTO ByeMessage3:
IF k$ = CHR$(27) THEN GOTO ByeMessage3:
GOTO gyna3:

SamePlayers3:
COLOR 7: LOCATE 14, 1: PRINT "Same players "; player1$; " & "; player2$; "?"
PRINT "     Press Y or N:"
gyna4:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO realgame2:
IF k$ = "n" THEN GOTO NG2:
IF k$ = CHR$(27) THEN GOTO ByeMessage3:
GOTO gyna4:

ByeMessage3:
COLOR 15: center 17, "You've been playing"
COLOR 14: center 19, "23 Pickup Xtra"
COLOR 12: center 21, "By Charles Martin"
COLOR 9: center 23, "Press any key to quit.": SLEEP:
IF snd = 1 THEN PLAY "o4L11CEFGP16L8EL3G"
SYSTEM

NG2:
WIDTH 40, 25: COLOR 9, 8:  CLS     'Sets up the screen with wider letters
center 2, "23 Pickup Xtra"         'Centers the words in "" on line 2
center 3, "By Charles Martin"
COLOR 11: center 4, "Home.earthlink.net/~drwfan54"

COLOR 14: LOCATE 7, 1: PRINT "How many human players?  (1 or 2):  "
NP3:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN OnePlayer
IF k$ = "2" THEN TwoPlayers
IF k$ = CHR$(27) THEN SYSTEM
GOTO NP3:

END SUB

SUB StickSound (T)

FOR SS = 1 TO T
SOUND 501, 1
SOUND 0, 2
NEXT SS

END SUB

SUB TwoPlayers

wfa = 0: lfa = 0: wfb = 0: lfb = 0: StixLeft = 23

TP:

COLOR 14: LOCATE 9, 1: LINE INPUT "Name of Player 1:  ", player1$  'gets name
SELECT CASE LEN(player1$)   'Makes sure name is not too big or small. 2-12 accepted.
CASE IS < 2: PRINT : PRINT "Name must be at least 2 letters long.": SLEEP 2: CLS : GOTO TP:
CASE IS > 11: PRINT : PRINT "Name must be 12 letters or less.": SLEEP 2: CLS : GOTO TP:
CASE ELSE:  GOTO GetPlayer2:
END SELECT

GetPlayer2:
COLOR 2: LOCATE 10, 1: LINE INPUT "Name of Player 2:  ", player2$  'gets name
SELECT CASE LEN(player2$)   'Makes sure name is not too big or small. 2-12 accepted.
CASE IS < 2: PRINT : PRINT "Name must be at least 2 letters long.": SLEEP 2: CLS : GOTO GetPlayer2:
CASE IS > 11: PRINT : PRINT "Name must be 12 letters or less.": SLEEP 2: CLS : GOTO GetPlayer2:
CASE ELSE:  GOTO SndState2:
END SELECT

SndState2:
COLOR 12: LOCATE 13, 1: PRINT "Would you like to hear sounds during"
                        PRINT "the game?  (Press Y or N):"
gss2:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN snd = 1: GOTO Inst2:  'If Y, allow sound
IF k$ = "n" THEN snd = 0: GOTO Inst2:  'If N, have no sound
GOTO gss2:

Inst2:
COLOR 10: SLEEP 1: CLS 'pauses for 1 second allowing screen to be seen B4 it clears
center 2, "23 Pickup instructions": COLOR 15: LOCATE 5, 1:
PRINT "23 pickup is a 2-player game in which"
PRINT
PRINT "players take turns taking sticks from"
PRINT
PRINT "a pile that starts with 23.  On a"
PRINT
PRINT "player's turn, the player takes"
PRINT
PRINT "either 1, 2, or 3 sticks.  The"
PRINT
PRINT "player to take the LAST stick"
PRINT
PRINT "LOSES the game."
COLOR 17: center 20, "Press any key to start!": SLEEP

realgame:
CLS : StixLeft = 23: NT = 0: L = 5'Sets # of sticks for a new game

FirstTurn:     'Decides who goes first randomly
RANDOMIZE TIMER
P = INT(RND * 2) + 1
IF P = 1 THEN GOTO p1:
IF P = 2 THEN GOTO p2:


p1:
IF snd = 1 THEN StickSound NT
COLOR 14: LOCATE 1, 1:
PRINT "³                                      ³"
PRINT "³                                      ³"
PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
COLOR 11: LOCATE 2, 3: PRINT player1$; "'s turn  - "; StixLeft; "sticks left"
IF L > 23 THEN L = 5: VIEW PRINT 5 TO 23: CLS : VIEW PRINT:   'clear results panel when it gets full
COLOR 9: LOCATE L, 1: PRINT player1$; ", HOW MANY?  (1,2,3):"
getstix1:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN NT = 1: GOTO WR1:
IF k$ = "2" THEN NT = 2: GOTO WR1:
IF k$ = "3" THEN NT = 3: GOTO WR1:
GOTO getstix1:

WR1:
IF StixLeft - NT < 0 THEN GOTO p1:  'makes sure key pressed is scceptable.
                                    'Cant press 3 with only 2 sticks left
LOCATE L, 1: PRINT SPACE$(39): LOCATE L, 1: PRINT player1$; " took"; NT; "sticks."
StixLeft = StixLeft - NT
L = L + 1

SELECT CASE StixLeft
CASE IS > 1: GOTO p2:
CASE IS = 0: LOCATE L, 1: PRINT "---"; player1$; " has taken the last stick!"
LOCATE L + 1, 1: COLOR 15: PRINT UCASE$(player2$); " HAS WON!"
lfa = lfa + 1: wfb = wfb + 1  'give win and loss to appropriate players
GOTO EndGame:

CASE IS = 1: COLOR 15: LOCATE L, 1: PRINT "---"; player2$; " must take the last stick!"
LOCATE L + 1, 1: COLOR 9: PRINT UCASE$(player1$); " HAS WON!"
lfb = lfb + 1: wfa = wfa + 1  'give win and loss to appropriate players
GOTO EndGame:
END SELECT

p2:
IF snd = 1 THEN StickSound NT
COLOR 14: LOCATE 1, 1:
PRINT "³                                      ³"
PRINT "³                                      ³"
PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
COLOR 11: LOCATE 2, 3: PRINT player2$; "'s turn  - "; StixLeft; "sticks left"
IF L > 23 THEN L = 5: VIEW PRINT 5 TO 23: CLS : VIEW PRINT:   'clear results panel when it gets full
COLOR 15: LOCATE L, 1: PRINT player2$; ", HOW MANY?  (1,2,3):"
getstix2:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN NT = 1: GOTO WR2:
IF k$ = "2" THEN NT = 2: GOTO WR2:
IF k$ = "3" THEN NT = 3: GOTO WR2:
GOTO getstix2:

WR2:
IF StixLeft - NT < 0 THEN GOTO p2:
LOCATE L, 1: PRINT SPACE$(39): LOCATE L, 1: PRINT player2$; " took"; NT; "sticks."
StixLeft = StixLeft - NT
L = L + 1

SELECT CASE StixLeft
CASE IS > 1: GOTO p1:
CASE IS = 0: LOCATE L, 1: PRINT "---"; player2$; " has taken the last stick!"
LOCATE L + 1, 1: COLOR 9: PRINT UCASE$(player1$); " HAS WON!"
lfb = lfb + 1: wfa = wfa + 1  'give win and loss to appropriate players
GOTO EndGame:
CASE ELSE: LOCATE L, 1: PRINT "---"; player1$; " must take the last stick!"
LOCATE L + 1, 1: COLOR 15: PRINT UCASE$(player2$); " HAS WON!"
lfa = lfa + 1: wfb = wfb + 1  'give win and loss to appropriate players
GOTO EndGame:
END SELECT

EndGame:
IF snd = 1 THEN PLAY "T160O1>L20CDEDCDL10ECCDEDCp8l2c"
COLOR 11: center 23, "Press any key to continue...": SLEEP: CLS
center 2, "Statistics"
COLOR 9: LOCATE 5, 1: PRINT player1$; " has won"; wfa; "and lost"; lfa
COLOR 15: LOCATE 7, 1: PRINT player2$; " has won"; wfb; "and lost"; lfb
COLOR 14: LOCATE 12, 1: PRINT "Would you like to play again?  (Y/N):"
gyna:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO SamePlayers:
IF k$ = "n" THEN GOTO ByeMessage:
IF k$ = CHR$(27) THEN GOTO ByeMessage:
GOTO gyna:

SamePlayers:
COLOR 7: LOCATE 14, 1: PRINT "Same players "; player1$; " & "; player2$; "?"
PRINT "     Press Y or N:"
gyna2:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO realgame:
IF k$ = "n" THEN GOTO NG:
IF k$ = CHR$(27) THEN GOTO ByeMessage:
GOTO gyna2:

ByeMessage:
COLOR 15: center 17, "You've been playing"
COLOR 14: center 19, "23 Pickup Xtra"
COLOR 12: center 21, "By Charles Martin"
COLOR 9: center 23, "Press any key to quit.": SLEEP:
IF snd = 1 THEN PLAY "o4L11CEFGP16L8EL3G"
SYSTEM

NG:
WIDTH 40, 25: COLOR 9, 8:  CLS     'Sets up the screen with wider letters
center 2, "23 Pickup Xtra"         'Centers the words in "" on line 2
center 3, "By Charles Martin"
COLOR 11: center 4, "Home.earthlink.net/~drwfan54"

COLOR 14: LOCATE 7, 1: PRINT "How many human players?  (1 or 2):  "
NP2:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN OnePlayer
IF k$ = "2" THEN TwoPlayers
IF k$ = CHR$(27) THEN SYSTEM
GOTO NP2:











END SUB

