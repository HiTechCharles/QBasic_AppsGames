DECLARE SUB Flipgfx ()
DECLARE SUB center (row, TEXT$)
DECLARE SUB ClearBoard ()
DECLARE SUB CoinSound (cn)
DECLARE SUB CompNames ()
DECLARE SUB delay (sec)
DECLARE SUB GetHumanInput ()
DECLARE SUB GetPCinput ()
DECLARE SUB PrintResult ()
DECLARE SUB UpdateScores ()
DECLARE SUB WaitForKey (RW)
COMMON SHARED Y$, z$, PT1$, PT2$, player1$, player2$, gr1, gr2, PL1, pl2, SND
COMMON SHARED SideCalled, SideCalled$, flipside, flipside$, GotItRight, Waitafterfirst

CFBEGIN:
IF INSTR(COMMAND$, "/W") > 0 OR INSTR(COMMAND$, "-W") > 0 THEN Waitafterfirst = 1

SCREEN 13: COLOR 12: CLS : center 2, "Coin Roll"
COLOR 14: center 3, "By Charles Martin": RANDOMIZE TIMER
CONST TRUE = 1, FALSE = NOT TRUE

CompNames
LOCATE 7, 1: COLOR 11
PRINT "In this game, players take turns"
PRINT "flipping a coin.  The other player"
PRINT "tries to predict whether the coin"
PRINT "will land HEADS or TAILS!"
PRINT
PRINT "You will be asked before each round"
PRINT "starts whether you want to continue"
PRINT "playing, or not."

COLOR 13: WaitForKey 19

GIN:
CLS : LOCATE 3, 1: COLOR 15
PRINT "Is player 1 a human or computer player?"
PRINT "Press H for human, or C for computer:"
gettype1:
PT1$ = LCASE$(INKEY$)
IF PT1$ = "h" THEN GOTO getplayer2:
IF PT1$ = "c" THEN GOTO getplayer2:
GOTO gettype1:

getplayer2:
LOCATE 7, 1: PRINT "Is player 2 a human or computer player? "
PRINT "Press H for human, or C for computer:"
gettype2:
PT2$ = LCASE$(INKEY$)
IF PT2$ = "h" THEN GOTO getnames:
IF PT2$ = "c" THEN GOTO getnames:
GOTO gettype2:

getnames:
LOCATE 11, 1: COLOR 13
IF PT1$ = "h" THEN GOTO hn1:
IF PT1$ = "c" THEN GOTO cn1:

cn1:
player1$ = Y$
PRINT "Player 1 will be "; player1$
GOTO gn2:

hn1:
INPUT "What is player 1's name:  ", player1$
IF LEN(player1$) < 2 OR LEN(player1$) > 10 THEN PRINT : PRINT "Between 2 and 10 letters, please.": SLEEP: CLS : GOTO getnames:

gn2:
COLOR 11: LOCATE 13, 1:
IF PT2$ = "h" THEN GOTO hn2:
IF PT2$ = "c" THEN GOTO cn2:

cn2:
player2$ = z$
PRINT : PRINT "Player 2 will be "; player2$
GOTO GPT:

hn2:
INPUT "What is player 2's name:  ", player2$
IF LEN(player2$) < 2 OR LEN(player2$) > 10 THEN PRINT : PRINT "Between 2 and 10 letters, please.": SLEEP: CLS : GOTO hn2:

GPT:
IF player1$ = player2$ THEN PRINT : PRINT "Names are identical -- Redo name input": SLEEP 3: CLS : GOTO getnames:
player1$ = LTRIM$(RTRIM$(player1$)): player2$ = LTRIM$(RTRIM$(player2$))
player1$ = UCASE$(player1$): player2$ = UCASE$(player2$)
COLOR 44: PRINT : PRINT : PRINT "Would you like to hear sounds during"
                          PRINT "the game?  (Press Y or N):"
SON:
K$ = LCASE$(INKEY$)
IF K$ = "y" THEN SND = 1: GOTO TOG:
IF K$ = "n" THEN SND = 0: GOTO TOG:
GOTO SON:

TOG:
CLS : UpdateScores
COLOR 78: center 6, player1$ + " will now flip the coin..."
SELECT CASE PT2$
CASE IS = "h"
     COLOR 14: LOCATE 9, 1: PRINT player2$; ", on which side will the"
     PRINT "coin land?   "; : COLOR 15: PRINT "Press H for HEADS OR"
     PRINT "                   T for TAILS"
     GetHumanInput
     IF SND = 1 THEN CoinSound SideCalled
     GOTO PCR1:
     CASE IS = "c": GetPCinput
     IF SND = 1 THEN CoinSound SideCalled: GOTO PCR1:
END SELECT

PCR1: VIEW PRINT 8 TO 23: CLS 2: VIEW PRINT
COLOR 89: center 10, player2$ + " CALLS " + SideCalled$

flipside = INT(RND * 2) + 1
IF flipside = 1 THEN flipside$ = "HEADS" ELSE flipside$ = "TAILS"
Flipgfx
IF SND = 1 THEN CoinSound flipside
pl2 = pl2 + 1: PrintResult
IF GotItRight = TRUE THEN gr2 = gr2 + 1
IF Waitafterfirst = 0 THEN delay 3 ELSE COLOR 95: WaitForKey 20

CLS : UpdateScores
COLOR 78: center 6, player2$ + " will now flip the coin..."
SELECT CASE PT1$
CASE IS = "h"
     COLOR 14: LOCATE 9, 1: PRINT player1$; ", on which side will the"
     PRINT "coin land?   "; : COLOR 15: PRINT "Press H for HEADS OR"
     PRINT "                   T for TAILS"
     GetHumanInput
     IF SND = 1 THEN CoinSound SideCalled
     GOTO PCR2:
     CASE IS = "c": GetPCinput
     IF SND = 1 THEN CoinSound SideCalled
     GOTO PCR2:
END SELECT

PCR2:  VIEW PRINT 8 TO 23: CLS 2: VIEW PRINT
COLOR 89: center 10, player1$ + " CALLS " + SideCalled$

flipside = INT(RND * 2) + 1
IF flipside = 1 THEN flipside$ = "HEADS" ELSE flipside$ = "TAILS"
Flipgfx
IF SND = 1 THEN CoinSound flipside
PL1 = PL1 + 1: PrintResult
IF GotItRight = TRUE THEN gr1 = gr1 + 1
GOTO AskToQuit:

AskToQuit:
ClearBoard
COLOR 95: center 21, "Press ENTER to continue"
          center 22, "playing, or ESCape to"
          center 23, "quit the current game:"
PAON:
K$ = LCASE$(INKEY$)
IF K$ = CHR$(13) THEN GOTO TOG:
IF K$ = " " THEN GOTO TOG:
IF K$ = CHR$(27) THEN GOTO NEWGAME:
GOTO PAON:


NEWGAME:
CLS
COLOR 15: center 2, "Would you like to start a brand new"
          center 3, "game with different players?"
COLOR 78: center 5, "(Press Y or N)"

NGON:
K$ = LCASE$(INKEY$)
IF K$ = "y" THEN CLEAR : GOTO CFBEGIN:
IF K$ = "n" THEN SYSTEM
IF K$ = CHR$(27) THEN SYSTEM
GOTO NGON:


SUB center (row, TEXT$)
col = 21 - LEN(TEXT$) / 2: LOCATE row, col: PRINT TEXT$
END SUB

SUB ClearBoard
DO UNTIL INKEY$ = "": LOOP
END SUB

SUB CoinSound (cn)
IF cn = 1 THEN
    PLAY "o4l11c"
ELSEIF cn = 2 THEN
    PLAY "o4l11cc"
END IF
END SUB

SUB CompNames

DIM cnames$(100)            'Stores computer names

LET cnames$(1) = "Charles" 'duh
LET cnames$(2) = "Shane"
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
LET cnames$(18) = "Jennifer"
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

LET cnames$(51) = "Arron"
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
LET cnames$(63) = "Amanda"
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
LET cnames$(94) = "Ashley"
LET cnames$(95) = "Tony"
LET cnames$(96) = "Terry"
LET cnames$(97) = "Andrew"
LET cnames$(98) = "George"
LET cnames$(99) = "William"
LET cnames$(100) = "Mary"

pickagain:
RANDOMIZE TIMER

LET z = INT(RND * 100) + 1
LET Y = INT(RND * 100) + 1

IF Y = z THEN GOTO pickagain:  'doesen't allow identical computer names
Y$ = cnames$(Y)
z$ = cnames$(z)

END SUB

SUB delay (sec)

start = TIMER
IF start + sec < 86400 THEN
   DO WHILE TIMER < start + sec: LOOP
ELSE
   DO UNTIL TIMER = 0: LOOP
   DO WHILE TIMER < start + sec - 86400: LOOP
END IF

END SUB

SUB Flipgfx
A = 210: B = -20: s = -20
FOR I = 1 TO 2
    FOR CircPos = A TO B STEP s
        c = INT(RND * 2) + 1
        IF c = 1 THEN c = 42 ELSE c = 44
        CIRCLE (290, CircPos), 25, c
        PAINT (290, CircPos), c, c
        SOUND 0, 1.5
        CIRCLE (290, CircPos), 25, 0
        PAINT (290, CircPos), 0, 0
    NEXT CircPos
    A = -20: B = 170: s = 20
NEXT I

c = flipside
IF c = 1 THEN c = 44 ELSE c = 42
CIRCLE (290, 170), 25, c
PAINT (290, 170), c, c
DRAW "bm268, 173"

SELECT CASE flipside
    CASE IS = 1
        DRAW "c6 u5 nu5 r5 nu5 d5"
        DRAW "bm+2,0 u10 nr5 d5 nr3 d5 r5"
        DRAW "bm+2,0 u10 f5 nl5 f5"
        DRAW "bm+2,0 nr3 u10 r3 f3 d4 g3"
        DRAW "bm+2,0 r10 e4 l10 e4 r6"
    CASE IS = 2
        DRAW "c6 br3 u10 nl3 nr3 d10 br3"
        DRAW "bm+2,0 u10 f5 nl5 f5"
        DRAW "bm+2,0 r3 u10 nl3 nr3 d10 r3"
        DRAW "bm+2,0 nu10 r5"
        DRAW "bm+2,0 r8 e4 l9 e4 r3"
END SELECT

END SUB

SUB GetHumanInput
GHI:
K$ = LCASE$(INKEY$)
   IF K$ = "h" THEN SideCalled = 1: SideCalled$ = "HEADS": EXIT SUB
   IF K$ = "t" THEN SideCalled = 2: SideCalled$ = "TAILS": EXIT SUB
   IF K$ = "r" THEN GetPCinput: EXIT SUB
GOTO GHI:
END SUB

SUB GetPCinput
SideCalled = INT(RND * 2) + 1
IF SideCalled = 1 THEN SideCalled$ = "HEADS" ELSE SideCalled$ = "TAILS"
END SUB

SUB PrintResult
SELECT CASE SideCalled - flipside
       CASE IS = 0: COLOR 15: center 14, SideCalled$ + " IT IS!!":   GotItRight = TRUE: EXIT SUB
         CASE ELSE: COLOR 13: center 14, "SORRY, THE COIN WAS " + flipside$: GotItRight = FALSE: EXIT SUB
END SELECT
END SUB

SUB UpdateScores
IF PL1 <> 0 THEN COLOR 9: LOCATE 2, 2: PRINT player1$: LOCATE 3, 1: PRINT gr1; "FOR"; PL1
IF pl2 <> 0 THEN COLOR 14: LOCATE 2, 22: PRINT player2$: LOCATE 3, 21: PRINT gr2; "FOR"; pl2
END SUB

SUB WaitForKey (RW)
center RW, "Press a key to continue...": SLEEP
END SUB

