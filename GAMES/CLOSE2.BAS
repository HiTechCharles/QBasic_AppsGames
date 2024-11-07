DECLARE FUNCTION LimitInput$ (AllowedChars!)
DECLARE SUB CompNames ()
DECLARE SUB center (row!, text$)
COMMON SHARED y$, z$, pt1$, pt2$, Player1$, Player2$, pf1, pf2, ties, MaxNum
COMMON SHARED pg1, pg2, pgc, nug

tbegin:
WIDTH 40, 25: COLOR 12: CLS : center 2, "Close2"
COLOR 14: center 3, "By Charles Martin"

CompNames

LOCATE 7, 1: COLOR 14
PRINT "In this game, the computer picks a"
PRINT "number, and two players try to guess it."
PRINT
PRINT "The closest player to the computer's"
PRINT "number gets a point.  The first player"
PRINT "to reach a set amount of points wins!"
COLOR 7: center 20, "Press any key...": SLEEP

GIN:
CLS : LOCATE 3, 1: COLOR 15
PRINT "Is player 1 a human or computer player?"
PRINT "Press H for human, or C for computer:"
gettype1:
pt1$ = LCASE$(INKEY$)
IF pt1$ = "h" THEN GOTO getplayer2:
IF pt1$ = "c" THEN GOTO getplayer2:
GOTO gettype1:

getplayer2:
LOCATE 7, 1: PRINT "Is player 2 a human or computer player? "
PRINT "Press H for human, or C for computer:"
gettype2:
pt2$ = LCASE$(INKEY$)
IF pt2$ = "h" THEN GOTO getnames:
IF pt2$ = "c" THEN GOTO getnames:
GOTO gettype2:

getnames:
LOCATE 11, 1: COLOR 13
IF pt1$ = "h" THEN GOTO hn1:
IF pt1$ = "c" THEN GOTO cn1:

cn1:
Player1$ = y$
PRINT "Player 1 will be "; Player1$
GOTO gn2:

hn1:
PRINT "What is player 1's name:  "; : Player1$ = LimitInput$(10)
IF LEN(Player1$) < 2 THEN PRINT : PRINT : PRINT "At least 2 letters, please.": SLEEP: CLS : GOTO getnames:

gn2:
COLOR 11: LOCATE 13, 1:
IF pt2$ = "h" THEN GOTO hn2:
IF pt2$ = "c" THEN GOTO cn2:

cn2:
Player2$ = z$
PRINT "Player 2 will be "; Player2$
GOTO GPT:

hn2:
PRINT "What is player 2's name:  "; : Player2$ = LimitInput$(10)
IF LEN(Player2$) < 2 THEN PRINT : PRINT : PRINT "At least 2 letters, please.": SLEEP: CLS : GOTO hn2:

GPT:
IF Player1$ = Player2$ THEN PRINT : PRINT "Names are identical -- Redo name input": SLEEP 3: CLS : GOTO getnames:
Player1$ = LTRIM$(RTRIM$(Player1$)): Player2$ = LTRIM$(RTRIM$(Player2$))
PRINT : PRINT : COLOR 10: PRINT "Play to how many points?  (Between 2"
PRINT "and 999, or 1 to randomly select):": COLOR 15: PRINT ">"; : points = VAL(LimitInput$(3))
points = INT(points)
IF points = 0 THEN points = 5
IF points = 1 THEN points = INT(RND * 25) + 2: PRINT : PRINT points; "points randomly selected!": SLEEP 3
IF points < 2 OR points > 999 THEN PRINT : PRINT : PRINT "Between 1 and 999, please.": SLEEP 3: CLS : GOTO GPT:

IF nug = 1 THEN GOTO TheGame:

CLS : COLOR 12: center 3, "THE PLAYERS..."
IF pt1$ = "h" THEN y$ = "human" ELSE y$ = "computer"
IF pt2$ = "h" THEN z$ = "human" ELSE z$ = "computer"
COLOR 13: LOCATE 6, 5: PRINT Player1$; ", a "; y$; " player"
COLOR 11: LOCATE 8, 5: PRINT Player2$; ", a "; z$; " player"
COLOR 15: LOCATE 12, 5: PRINT "Playing to"; points; "points"
COLOR 10: center 16, "Press any key to start!": SLEEP


TheGame:
DO UNTIL points = pf1 OR points = pf2
gm = gm + 1: DO UNTIL INKEY$ = "": LOOP
VIEW PRINT: CLS : COLOR 14: LOCATE 2, 1: PRINT Player1$; " has"; pf1; TAB(21); Player2$; " has"; pf2
PRINT "ROUND #"; gm; TAB(21); "PLAYING TO"; points
LOCATE 4, 1:
IF ties <> 0 THEN PRINT "TIE GAMES: "; ties

RANDOMIZE TIMER
x = INT(RND * 10)
MaxNum = 10 * x: COLOR 15: CS$ = "The number is between 1 and"
CS$ = CS$ + STR$(MaxNum): center 7, CS$

PLG1:
VIEW PRINT 8 TO 23:
pgc = INT(RND * MaxNum) + 1: COLOR 13: LOCATE 12, 1
SELECT CASE pt1$
CASE IS = "h"
ph1:
PRINT Player1$; ", what is your guess?  "; : pg1 = VAL(LimitInput$(3))
IF pg1 < 1 OR pg1 > MaxNum THEN PRINT : PRINT : PRINT "Between 1, and"; MaxNum; "please!": SLEEP 3: CLS : LOCATE 12, 1: GOTO ph1:
GOTO plg2:

CASE IS = "c": pg1 = INT(RND * MaxNum) + 1: GOTO plg2:
END SELECT


plg2:
CLS : LOCATE 12, 1: COLOR 11
SELECT CASE pt2$
CASE IS = "h"
ph2:
PRINT Player2$; ", what is your guess?  "; : pg2 = VAL(LimitInput$(3))
IF pg2 < 1 OR pg2 > MaxNum THEN PRINT : PRINT "Between 1, and"; MaxNum; "please!": SLEEP 3: CLS : LOCATE 12, 1: GOTO ph2:
GOTO rev:

CASE IS = "c": pg2 = INT(RND * MaxNum) + 1: GOTO rev:
END SELECT

rev:
pg1 = INT(pg1): pg2 = INT(pg2)
CLS : COLOR 13: LOCATE 11, 5: PRINT Player1$; " guessed"; pg1
      COLOR 11: LOCATE 12, 5: PRINT Player2$; " guessed"; pg2
COLOR 9: LOCATE 15, 5: PRINT "The computer's number was"; pgc

IF pgc > pg1 THEN dif1 = pgc - pg1 ELSE dif1 = pg1 - pgc
IF pgc > pg2 THEN dif2 = pgc - pg2 ELSE dif2 = pg2 - pgc
COLOR 15
IF dif1 = dif2 THEN GOTO tiegame:
IF dif1 > dif2 THEN GOTO p2w:
IF dif2 > dif1 THEN GOTO p1w:

tiegame:
ties = ties + 1: LOCATE 18, 5: COLOR 14: PRINT "IT'S A TIE!": GOTO EOL:

p1w: pf1 = pf1 + 1: LOCATE 18, 5: PRINT UCASE$(Player1$); " WINS!": GOTO EOL:
p2w: pf2 = pf2 + 1: LOCATE 18, 5: PRINT UCASE$(Player2$); " WINS!": GOTO EOL:

EOL: COLOR 10: center 22, "Press ESCape to quit or any"
               center 23, "other key to continue... "
PON:
k$ = INKEY$
    IF k$ = CHR$(27) THEN SYSTEM
    IF k$ <> "" THEN GOTO EOLP:
GOTO PON:
EOLP:
LOOP

AWinner:
VIEW PRINT: CLS
COLOR 12: center 2, "WE HAVE A WINNER!!"

COLOR 14: LOCATE 6, 5: PRINT "Rounds played: "; gm
LOCATE 8, 5: PRINT "Played to"; points; "points"
IF ties <> 0 THEN LOCATE 10, 5: PRINT "Tie fsgames: "; ties

COLOR 14: center 14, "FINAL SCORE:"
COLOR 13: LOCATE 15, 1: PRINT Player1$; " -"; pf1
COLOR 11: LOCATE 15, 21: PRINT Player2$; " -"; pf2

COLOR 15: LOCATE 19, 5: PRINT "THE WINNER IS ";
IF pf1 > pf2 THEN PRINT UCASE$(Player1$)
IF pf2 > pf1 THEN PRINT UCASE$(Player2$)

COLOR 7: center 23, "Press any key...": SLEEP

CLS
COLOR 14: center 2, "Press Y or N to answer the following..."
COLOR 15: LOCATE 6, 1: PRINT "Do you want to play again?"
pag:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO ISP:
IF k$ = "n" THEN SYSTEM
IF k$ = CHR$(27) THEN SYSTEM
GOTO pag:

ISP:
LOCATE 9, 1: PRINT "Same Players?"
tsp:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN nug = 1: gm = 0: GOTO GPT:
IF k$ = "n" THEN CLEAR : GOTO tbegin:
IF k$ = CHR$(27) THEN SYSTEM
GOTO tsp:

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
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
LET y = INT(RND * 100) + 1

IF y = z THEN GOTO pickagain:  'doesen't allow identical computer names
y$ = cnames$(y)
z$ = cnames$(z)

END SUB

FUNCTION LimitInput$ (AllowedChars)
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
         CASE IS = 13: LimitInput$ = contents$: EXIT FUNCTION
         CASE IS = 80: PRINT "ONE OF THE ARROWS": SYSTEM
         CASE ELSE:
         SELECT CASE tc
              CASE IS < AllowedChars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l9B": GOTO TOS:
         END SELECT
     END SELECT
LOOP

END FUNCTION

