DECLARE SUB compnames ()
DECLARE SUB waitforkey (row, col, tc)
DECLARE SUB center (row, text$)

DIM SHARED player1$, player2$, y$, z$

compnames


SCREEN 0:
getplayer1:

CLS : RANDOMIZE TIMER:
LOCATE 2, 30: COLOR 6, 8: PRINT "Rock,"; : COLOR 15, 8: PRINT " Paper, "; : COLOR 12, 8: PRINT " Scisors"
COLOR 12
center 3, "By Charles Martin"
COLOR 15, 8:

LOCATE 6, 1: PRINT "Is player 1 a human or computer player?  H for human"
             PRINT "                                         C for computer"
gettype1:
playertype1$ = LCASE$(INKEY$)
IF playertype1$ = "h" THEN GOTO getplayer2:
IF playertype1$ = "c" THEN GOTO getplayer2:
GOTO gettype1:

getplayer2:
LOCATE 10, 1: PRINT "Is player 2 a human or computer player?  H for human"
             PRINT "                                         C for computer"
gettype2:
playertype2$ = LCASE$(INKEY$)
IF playertype2$ = "h" THEN GOTO getnames:
IF playertype2$ = "c" THEN GOTO getnames:
GOTO gettype2:

getnames:
LOCATE 13, 1:

SELECT CASE playertype1$
CASE IS = "h"
LINE INPUT "Name of player 1:  ", player1$
IF player1$ = "" THEN CLS : GOTO getnames:
IF LEN(player1$) < 2 THEN CLS : GOTO getnames:
IF LEN(player1$) > 9 THEN CLS : GOTO getnames:
GOTO name2:
CASE IS = "c"
player1$ = y$
PRINT "Player 1 will be "; player1$
GOTO name2:
END SELECT

name2:
LOCATE 15, 1:
SELECT CASE playertype2$
CASE IS = "h"
PRINT : LINE INPUT "Name of player 2:  ", player2$
IF player2$ = "" THEN CLS : GOTO name2:
IF LEN(player2$) < 2 THEN CLS : GOTO name2:
IF LEN(player2$) > 9 THEN CLS : GOTO name2:
GOTO decide:
CASE IS = "c"
player2$ = z$
PRINT : PRINT "Player 2 will be "; player2$
waitforkey 22, 28, 14
GOTO decide:
END SELECT

decide:
getcolor:
LET fg = INT(RND * 15) + 1
IF fg = 8 THEN GOTO getcolor:

COLOR fg, 8: : CLS :

 center 3, "ษอออออออออออป               ษอออออออออออป"
 center 4, "บ           บ               บ           บ"
 center 5, "วฤฤฤchoseฤฤฤถ               วฤฤฤchoseฤฤฤถ"
 center 6, "บ           บ               บ           บ"
 center 7, "ศอออออัอออออผ               ศอออออัอออออผ"
 center 8, "      ณ                           ณ      "
 center 9, "      ณ                           ณ      "
center 10, "      ณ                           ณ      "
center 11, "      ณ                           ณ      "
center 12, "ษอออออฯอออออออออออออออออออออออออออฯอออออป"
center 13, "บ                                       บ"
center 14, "ศอออออออออออออออออออออออออออออออออออออออผ"

COLOR 15, 8:

SELECT CASE playertype1$
CASE IS = "h"
col = 25 - (LEN(player1$) / 2)
LOCATE 4, col: PRINT player1$

LOCATE 17, 1: PRINT "Press R for Rock"
              PRINT "      P for Paper"
              PRINT "      S for Scisors"
getplay:
kbd$ = INKEY$
kbd$ = LCASE$(kbd$)
IF kbd$ = "r" THEN p1$ = kbd$: GOTO p2:
IF kbd$ = "p" THEN p1$ = kbd$: GOTO p2:
IF kbd$ = "s" THEN p1$ = kbd$: GOTO p2:
GOTO getplay
GOTO p2:

CASE IS = "c"
LOCATE 4, 22: PRINT player1$
LET p = INT(RND * 3) + 1
IF p = 1 THEN p1$ = "r": GOTO p2:
IF p = 2 THEN p1$ = "p": GOTO p2:
IF p = 3 THEN p1$ = "s": GOTO p2:
CASE ELSE: PRINT : PRINT "ERROR:  playertype1$ not being set correctly.  Creed rules!"
END SELECT

p2:
SELECT CASE playertype2$
CASE IS = "h"

col = 53 - (LEN(player2$) / 2)
LOCATE 4, col: PRINT player2$

LOCATE 17, 1: PRINT "Press R for Rock"
              PRINT "      P for Paper"
              PRINT "      S for Scisors"
getplay2:
kbd$ = INKEY$
kbd$ = LCASE$(kbd$)
IF kbd$ = "r" THEN p2$ = kbd$: GOTO Seewhowins:
IF kbd$ = "p" THEN p2$ = kbd$: GOTO Seewhowins:
IF kbd$ = "s" THEN p2$ = kbd$: GOTO Seewhowins:
GOTO getplay2
GOTO Seewhowins:

CASE IS = "c"
LOCATE 4, 50: PRINT player2$
LET p = INT(RND * 3) + 1
IF p = 1 THEN p2$ = "r": GOTO Seewhowins:
IF p = 2 THEN p2$ = "p": GOTO Seewhowins:
IF p = 3 THEN p2$ = "s": GOTO Seewhowins:
CASE ELSE: PRINT : PRINT "ERROR:  playertype1$ not being set correctly.  Creed rules!"
END SELECT

Seewhowins:
LET c$ = p1$ + p2$

   rockwins$ = "Rock smashes Scisors"
  paperwins$ = "Paper covers Rock"
scisorswins$ = "Scisors cut Paper"

SELECT CASE c$
CASE IS = "rr"
message$ = "Both players chose Rock"
winner = 0
GOTO Endgame
CASE IS = "pp"
message$ = "Both players chose Paper"
winner = 0
GOTO Endgame:
CASE IS = "ss"
message$ = "Both players chose Scisors"
winner = 0
GOTO Endgame:
CASE IS = "rs"
LET message$ = rockwins$
winner = 1
GOTO Endgame:
CASE IS = "rp"
LET message$ = paperwins$
winner = 2
GOTO Endgame:
CASE IS = "sr"
LET message$ = rockwins$
winner = 2
GOTO Endgame:
CASE IS = "sp"
LET message$ = scisorswins$
winner = 1
GOTO Endgame:
CASE IS = "pr"
LET message$ = paperwins$
winner = 1
GOTO Endgame:
CASE IS = "ps"
LET message$ = scisorswins$
winner = 2
GOTO Endgame:
CASE IS = "sr"
LET message$ = rockwins$
winner = 2
GOTO Endgame:
CASE IS = "pr"
LET message$ = paperwins$
winner = 1
GOTO Endgame:
CASE IS = "rs"
0 LET message$ = rockwins$
winner = 1
GOTO Endgame:
CASE IS = "ps"
LET message$ = scisorswins$
winner = 2
GOTO Endgame:
CASE IS = "rp"
LET message$ = paperwins$
winner = 2
GOTO Endgame:
CASE IS = "sp"
LET message$ = scisorswins$
winner = 1
GOTO Endgame:
CASE ELSE:  PRINT : PRINT "ERROR in module funpack at address 041c-041e  Hit any key to return to system"
END SELECT

Endgame:

COLOR 10, 8:
SELECT CASE p1$
CASE IS = "r": LOCATE 6, 24: PRINT "Rock"
CASE IS = "p": LOCATE 6, 24: PRINT "Paper"
CASE IS = "s": LOCATE 6, 23: PRINT "Scisors"
END SELECT

SELECT CASE p2$
CASE IS = "r": LOCATE 6, 52: PRINT "Rock" '48 to 59
CASE IS = "p": LOCATE 6, 52: PRINT "Paper"
CASE IS = "s": LOCATE 6, 51: PRINT "Scisors"
END SELECT


COLOR 12, 8:
center 13, message$
VIEW PRINT 17 TO 20: CLS : VIEW PRINT

COLOR 9, 8:

SELECT CASE winner
CASE IS = 0: center 16, "Neither player wins."
tf1 = tf1 + 1: tf2 = tf2 + 1
CASE IS = 1: col = 40 - LEN(player1$) - 5 / 2: wf1 = wf1 + 1
LOCATE 16, col: PRINT player1$; " WINS!": lf2 = lf2 + 1
CASE IS = 2: col = 40 - LEN(player2) - 5 / 2: wf2 = wf2 + 1
LOCATE 16, col: PRINT player2$; " WINS!": lf1 = lf1 + 1
END SELECT

SELECT CASE p1$
CASE IS = "r": ru1 = ru1 + 1
CASE IS = "p": pu1 = pu1 + 1
CASE IS = "s": su1 = su1 + 1
END SELECT

SELECT CASE p2$
CASE IS = "r": ru2 = ru2 + 1
CASE IS = "p": pu2 = pu2 + 1
CASE IS = "s": su2 = su2 + 1
END SELECT

waitforkey 20, 28, 31

COLOR 15, 8: CLS :
LOCATE 2, 28: PRINT player1$; "'s Statistics"
 LOCATE 5, 1: PRINT "    Games played:  "; wf1 + lf1 + tf1
 LOCATE 7, 1: PRINT "            Wins:  "; wf1
 LOCATE 9, 1: PRINT "          Losses:  "; lf1
LOCATE 11, 1: PRINT "            Ties:  "; tf1

IF ru1 > 1 THEN LOCATE 13, 1: PRINT "   Rock was used:  "; ru1; "times"
IF ru1 = 1 THEN LOCATE 13, 1: PRINT "   Rock was used:  "; ru1; "time"

IF pu1 = 1 THEN LOCATE 15, 1: PRINT "  Paper was used:  "; pu1; "time"
IF pu1 > 1 THEN LOCATE 15, 1: PRINT "  Paper was used:  "; pu1; "times"

IF su1 = 1 THEN LOCATE 17, 1: PRINT "Scisors was used:  "; su1; "time"
IF su1 > 1 THEN LOCATE 17, 1: PRINT "Scisors was used:  "; su1; "times"

LOCATE 20, 28: PRINT "Press any key to see Player 2's statistics"
SLEEP

COLOR 14, 8: CLS :
LOCATE 2, 28: PRINT player2$; "'s Statistics"
 LOCATE 5, 1: PRINT "    Games played:  "; wf2 + lf2 + tf2
 LOCATE 7, 1: PRINT "            Wins:  "; wf2
 LOCATE 9, 1: PRINT "          Losses:  "; lf2
LOCATE 11, 1: PRINT "            Ties:  "; tf2

IF ru2 > 1 THEN LOCATE 13, 1: PRINT "   Rock was used:  "; ru2; "times"
IF ru2 = 1 THEN LOCATE 13, 1: PRINT "   Rock was used:  "; ru2; "time"

IF pu2 = 1 THEN LOCATE 15, 1: PRINT "  Paper was used:  "; pu2; "time"
IF pu2 > 1 THEN LOCATE 15, 1: PRINT "  Paper was used:  "; pu2; "times"

IF su2 = 1 THEN LOCATE 17, 1: PRINT "Scisors was used:  "; su2; "time"
IF su2 > 1 THEN LOCATE 17, 1: PRINT "Scisors was used:  "; su2; "times"




GOTO Prompts

Prompts:
waitforkey 20, 28, 19
COLOR 15, 8: CLS :
LOCATE 5, 1: PRINT "Would you like to play Rock, Paper, Scisors (RPS) again?  (Press Y or N)"

DO: LOOP UNTIL INKEY$ = ""   ' clears keyboard buffer
                              'because sometimes the next question don't show
getkey:                       'up when 2 cpu opponents play.
kbd$ = INKEY$
kbd$ = LCASE$(kbd$)
IF kbd$ = "y" THEN GOTO playagain:
IF kbd$ = "n" THEN GOTO quitgame
GOTO getkey:

playagain:
LOCATE 5, 75: COLOR 15, 8: PRINT "Yes"

COLOR 12, 8: LOCATE 8, 1: PRINT "Are the same players playing in the next game?  (Press Y or N)"
gitplace:
kbd$ = INKEY$
kbd$ = LCASE$(kbd$)
IF kbd$ = "y" THEN GOTO decide:
IF kbd$ = "n" THEN CLEAR : GOTO getplayer1:
GOTO gitplace:

quitgame:

center 15, "Thank you for playing"
LOCATE 17, 31: COLOR 6, 8: PRINT "Rock,"; : COLOR 15, 8: PRINT " Paper, "; : COLOR 12, 8: PRINT " Scisors"
COLOR 10, 8: center 19, "By Charles Martin"
COLOR 14: LOCATE 22, 1: PRINT "Press a key to quit.": SLEEP: SYSTEM

SUB center (row, text$)

  LOCATE row, 40 - (LEN(text$) / 2)
  PRINT text$;


END SUB

SUB compnames

'A list of 100 names for the computer.  The CNAMES$ array stores these
'names.

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
y$ = cnames$(y)        'stores a name for player 1 (if needed)
z$ = cnames$(z)





END SUB

SUB waitforkey (row, col, tc)

COLOR tc, 8: LOCATE row, col: PRINT "Press a key to continue. . .": SLEEP

END SUB

