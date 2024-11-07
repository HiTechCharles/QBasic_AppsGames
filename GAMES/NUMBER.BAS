DECLARE SUB COMPNAMES ()
DECLARE SUB center (Row, text$)
DECLARE FUNCTION limitinput$ (allowedchars)
DECLARE SUB PLAY1 ()                      'Declare subs and functions
DECLARE SUB PLAY2 ()

DIM SHARED cnames$(100)     'Defines an array to store names of computer pl
COMMON SHARED player1$, player2$, contents$, n, firstgame, ta, tb, ga, gb, shortest, longest 'Allows these variables to be used
                                                           'in all SUBs and FUNCTIONs

BEGIN:       'starts the input phase
CLEAR
firstgame = 1

SCREEN 0: COLOR 11, 8: CLS : LOCATE 24, 1
PRINT "(c)  Copyright 1997-2004 Charles Martin"         'Prints top portion
COLOR 14, 8: center 2, "G u e s s  - A -  N u m b e r"  'and bottom line
COLOR 9, 8: LOCATE 4, 31: PRINT "By ";
COLOR 12, 8: PRINT "Charles ";
COLOR 15, 8: PRINT "Martin"


LOCATE 7, 1: PRINT "How many players?  (1 or 2)"    'asks how many players
getkey:               'looks for either a 1 or a 2 to be pressed, then
board$ = INKEY$       'calls the necessary subroutine
IF board$ = "1" THEN GOTO START:
IF board$ = "2" THEN GOTO START:
GOTO getkey:

START:
IF board$ = "1" THEN LOCATE 7, 30: PRINT "1 Player game": CALL PLAY1:
IF board$ = "2" THEN LOCATE 7, 30: PRINT "2 Player game": CALL PLAY2:

SUB center (Row, text$)

'This sub centers a given string of text on a given line

  COL = 40     'center of screen
  LOCATE Row, COL - (LEN(text$) / 2 + .5)  'finds the new starting point then
  PRINT text$;                             'prints the text

END SUB

SUB COMPNAMES

'a list of 100 names for the computer player.
'This is why the COMPNAMES array is used.  It stores these names.

LET cnames$(1) = "Charles"  'Wouldn't you expect my name to be first?
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
LET cnames$(81) = "Krista "
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

END SUB

FUNCTION limitinput$ (allowedchars)
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
         CASE IS = 13: limitinput$ = contents$: EXIT FUNCTION
         CASE ELSE:
         SELECT CASE tc
              CASE IS < allowedchars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l9B": GOTO TOS:
         END SELECT
     END SELECT
LOOP

END FUNCTION

SUB PLAY1
CALL COMPNAMES       'loads the computer names into the COMPNAMES array

SOPR:       'Ask if the player wants PC speaker sound
PRINT : PRINT : PRINT "Would you like to hear sounds during the game?  (Press Y or N)"
getchoice:       'looks for one of the following keys:  "y" "Y" "n" "N"
board$ = LCASE$(INKEY$)
IF board$ = "y" THEN snd = 1: GOTO po1:
IF board$ = "n" THEN snd = 0: GOTO po1:
GOTO getchoice:

po1:   'prints the choice that the player made about sound since the letters
       'typed are not shown like an INPUT statement.
IF board$ = "y" THEN LOCATE 10, 65: PRINT "Yes" ELSE LOCATE 10, 65: PRINT "No"

p1:
PRINT : PRINT "Name of player 1:  ";
player1$ = limitinput$(14)
IF LEN(player1$) < 2 THEN CLS : GOTO p1:  'must be >= 3 characters and <= 14

RANDOMIZE TIMER    'picks the computer name to use.  COMPNAMES loads them
GCM:               'into the COMPNAMES array that's in the code
LET X = INT(RND * 100) + 1
LET player2$ = cnames$(X) 'puts computer name into a regular variable
PRINT : PRINT : PRINT cnames$(X); " will be picking the numbers that you will guess."

IF firstgame = 1 THEN GOTO gethigh:  'If it is the player's first game, stats
IF firstgame = 0 THEN GOTO stats:    'will not be shown.
                                     'since everything would be a 0!
stats:   'if at least one game is played, the stats are shown
CLS : LOCATE 2, 25: PRINT player1$; "'s Statistics"
COLOR 12: LOCATE 5, 1: PRINT "Games played:  "; ga; ""
COLOR 9: LOCATE 7, 1: PRINT "Total turns used:  "; ta
COLOR 10: LOCATE 9, 1: PRINT "Shortest game:  "; shortest; "turns"
COLOR 13: LOCATE 11, 1: PRINT "Longest game:  "; longest; "turns"
COLOR 11: LOCATE 13, 1: PRINT "Average turns used per game: "; INT(ta / ga)
LOCATE 16, 25: SHELL "pause": GOTO gethigh: 'pauses  easier than using INKEY$

gethigh:  'gets the largest number that the computer can pick.  (1-??)
          'GET HIGH:  what a name for a label.  Say NO to drugs!
PRINT : PRINT player2$; " can pack a number as high as 10,000."
PRINT "Would you like to change this?  (Y or N)"
ggg:   'another Y/N prompt
board$ = INKEY$
IF board$ = "y" THEN GOTO changehigh:
IF board$ = "Y" THEN GOTO changehigh:
IF board$ = "n" THEN PRINT : PRINT player2$; " will pick a number between 1 and 10,000. ": PRINT "Press any key to start the game.": DO: LOOP WHILE INKEY$ = "": LET TOP = 10000: GOTO GAME:
IF board$ = "N" THEN PRINT : PRINT player2$; " will pick a number between 1 and 10,000. ": PRINT "Press any key to start the game.": DO: LOOP WHILE INKEY$ = "": LET TOP = 10000: GOTO GAME:
GOTO ggg:

changehigh:   'Lets the player change the top number
CLS : PRINT : PRINT "Right now, "; player2$; " can pick a number as high as 10,000"
PRINT : PRINT "What is the hishest number that "; player2$; : INPUT " Can pick:  ", TOP
IF TOP < 10 THEN GOTO changehigh:
IF TOP > 999999 THEN GOTO changehigh:
GOTO GAME

GAME: LET turns = 0: LET G = 0: LET n = 0 'clears important variables
COLOR 13: CLS : PRINT :
RANDOMIZE TIMER
LET n = INT(RND * TOP) + 1  'gets random number between 1 and ??

'this next part draws the boxes that make up the interface.  I used
'WordPerfect 5.1 to draw this graphic.  It's great for drawing GFX like this.
PRINT "ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·"
PRINT "º                                                                             º"
PRINT "ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                      ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·                                  º"
PRINT "º                      º                   º                                  º"
PRINT "º                      ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½                                  º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º0"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½"

COLOR 15: LOCATE 2, 10:  'prints top line
       IF TOP = 10000 THEN
       PRINT player1$; " must guess "; player2$; "'s number; between 1 and 10,000"
END IF
       IF TOP <> 10000 THEN
       PRINT player1$; " must guess "; player2$; "'s number; between 1 and"; : PRINT USING "###,###"; TOP
END IF

COLOR 14:
LOCATE 10, 7: PRINT player1$; ","   'prints info to the left of the guess box
LOCATE 11, 7: PRINT "Your gurss is:"

number:
COLOR 14, 8: LOCATE 11, 27: PRINT "               " 'clears last guess from box
COLOR 15: LOCATE 11, 27: INPUT "", G  'takes guess input inside the box
                                      
LOCATE 16, 3: PRINT SPACE$(76)  'clears last message (too high, low, out of
LOCATE 18, 2: PRINT SPACE$(76)  'range)

SELECT CASE G  'Finds out how sucessful th guess was
CASE IS > TOP  'if out of range, print message
COLOR 14, 9: LOCATE 16, 10: PRINT "Your guess is out or range."
LOCATE 18, 10: PRINT "The number is between 1 and"; TOP
COLOR 14, 8: GOTO number:

CASE IS < n  'too low message if lower
COLOR 14, 9: LOCATE 16, 25: PRINT G; "is too small"
IF snd = 1 THEN PLAY "O1C" 'plays a low tone for too low if sound on
COLOR 14, 8: LET turns = turns + 1: GOTO number

CASE IS > n  'too big message if higher
COLOR 14, 9: LOCATE 16, 25: PRINT G; "is too big!"
IF snd = 1 THEN PLAY "O4c" 'plays high tone for too big
COLOR 14, 8: LET turns = turns + 1: GOTO number:

CASE n = G: GOTO win:  'if correct number is guessed, goto win announcement
END SELECT

win:
LET turns = turns + 1  'adds a turn for the winning guess
LET ga = ga + 1: LET ta = ta + turns: LET firstgame = 0  'keeps running turn total
SELECT CASE shortest
CASE IS = 0: LET shortest = turns: GOTO LONGRECORD:
CASE IS < turns:  GOTO LONGRECORD:
CASE IS > turns:  LET shortest = turns: GOTO LONGRECORD:
END SELECT

LONGRECORD:
SELECT CASE longest
CASE IS = 0: LET longest = turns: GOTO MESSAGE:
CASE IS > turns:  GOTO MESSAGE:
CASE IS < turns:  LET longest = turns: GOTO MESSAGE:
END SELECT

MESSAGE:
COLOR 14, 9: LOCATE 16, 32: PRINT "You got it!!"
IF snd = 1 THEN PLAY "o4L11CEFGP16L8EL3G"
COLOR 15, 8: LOCATE 19, 3: PRINT "You WIN!   The number was"; : PRINT USING "###,###"; n
LOCATE 20, 3: PRINT "You guessed "; player2$; "'s number in"; turns; "turns."
center 22, "Press Any Key to continue"
DO:  LOOP WHILE INKEY$ = ""

ENDGAME:
CLS : PRINT : PRINT "Would you like to play again?  (Press Y or N)"
gac:
board$ = INKEY$  'y/n prompt
IF board$ = "y" THEN LOCATE 2, 48: PRINT "Yes":  GOTO NG:
IF board$ = "Y" THEN LOCATE 2, 48: PRINT "Yes":  GOTO NG:
IF board$ = "n" THEN CLS : center 10, "Thank you for playing ": center 12, "G u e s s - A - N u m b e r !": center 14, "By Charles Martin": PRINT : center 17, "Press any key to quit..": SLEEP: SYSTEM
IF board$ = "N" THEN CLS : center 10, "Thank you for playing ": center 12, "G u e s s - A - N u m b e r !": center 14, "By Charles Martin": PRINT : center 17, "Press any key to quit..": SLEEP: SYSTEM
GOTO gac:

NG:
PRINT : PRINT "Do you want to use the same player names as the last game did?  (Y, N, or Q)"
ghij:
board$ = INKEY$
IF board$ = "y" THEN CLS : GOTO stats:
IF board$ = "Y" THEN CLS : GOTO stats:
IF board$ = "n" THEN GOTO newgame:
IF board$ = "N" THEN GOTO newgame:
IF board$ = "q" THEN SYSTEM
IF board$ = "Q" THEN SYSTEM
GOTO ghij:

newgame: 'starts the input phase
firstgame = 1

SCREEN 0: COLOR 11, 8: CLS : LOCATE 24, 1:
PRINT "(c)  Copyright 1997-2001 Charles Martin"       'Prints top portion
COLOR 14, 8: center 2, "G u e s s  - A -  N u m b e r"  'and bottom line
COLOR 9, 8: LOCATE 4, 31: PRINT "By ";
COLOR 12, 8: PRINT "Charles ";
COLOR 15, 8: PRINT "Martin"


LOCATE 7, 1: PRINT "How many players?  (1 or 2)"    'asks how many players
getkeyx:               'looks for either a 1 or a 2 to be pressed, then
board$ = INKEY$        'calls the necessary subroutine
IF board$ = "1" THEN GOTO START2:
IF board$ = "2" THEN GOTO START2:
GOTO getkeyx:

START2:
IF board$ = "1" THEN LOCATE 7, 30: PRINT "1 Player game": CALL PLAY1:
IF board$ = "2" THEN LOCATE 7, 30: PRINT "2 Player game": CALL PLAY2:

END SUB

SUB PLAY2

IF firstgame = 1 THEN GOTO SOPR2:
IF firstgame = 0 THEN GOTO flip:

SOPR2:
ta = 0: tb = 0: ga = 0: gb = 0: shortest = 0: longest = 0: n = 0
PRINT : PRINT : PRINT "Would you like to hear sounds during the game?  (Press Y or N)"
getchoice2:
board$ = INKEY$
IF board$ = "y" THEN snd = 1: GOTO po2:
IF board$ = "Y" THEN snd = 1: GOTO po2:
IF board$ = "n" THEN snd = 0: GOTO po2:
IF board$ = "N" THEN snd = 0: GOTO po2:
GOTO getchoice2:

po2:
IF board$ = "y" THEN LOCATE 10, 65: PRINT "Yes"
IF board$ = "Y" THEN LOCATE 10, 65: PRINT "Yes"
IF board$ = "n" THEN LOCATE 10, 65: PRINT "No"
IF board$ = "N" THEN LOCATE 10, 65: PRINT "NO"
GOTO p2:


p2:
guesser = 1: PRINT : PRINT : LINE INPUT "Who is guessing the first numbers?  ", player1$
LET playera$ = player1$
SELECT CASE LEN(player1$)
CASE IS < 3: CLS : GOTO p2
CASE IS > 14:
PRINT : PRINT "Name must be less then 14 letters.": CLS : GOTO p2
CASE IS = 0
PRINT : PRINT "You must enter a name.": CLS : GOTO p2
CASE ELSE:  LET playera$ = player1$: GOTO P3:
END SELECT

P3:
PRINT : LINE INPUT "Who is making the numbers to guess?  ", player2$
LET playerb$ = player2$
SELECT CASE LEN(player2$)
CASE IS < 3: CLS : GOTO P3
CASE IS > 14:
PRINT : PRINT "Name must be less then 14 letters.": CLS : GOTO P3
CASE IS = 0
PRINT : PRINT "You must enter a name.": CLS : GOTO P3
END SELECT

IF firstgame = 1 THEN GOTO gethigh2:
IF firstgame = 0 THEN GOTO flip:

flip:  LET y$ = player1$: LET z$ = player2$    'temp storage for name
       LET player1$ = z$: LET player2$ = y$
       y$ = "": z$ = ""
SELECT CASE guesser
CASE IS = 1
LET guesser = 2
CASE IS = 2
LET guesser = 1
END SELECT

CLS : center 2, "Role Change"
LOCATE 5, 1: PRINT "For the next game:"
LOCATE 7, 5: PRINT player1$; " will be guessing the number."
LOCATE 9, 5: PRINT player2$; " will be making the number."
COLOR 9, 0: LOCATE 11, 1: PRINT "Statistics:"
LOCATE 13, 5: PRINT playera$; " has played"; ga; "games, using a total of"; ta; "turns."

SELECT CASE gb
CASE IS = 0
LOCATE 15, 5: PRINT playerb$; " has not played yet."
CASE IS > 0
LOCATE 15, 5: PRINT playerb$; " has played"; gb; "games, using a total of"; tb; "turns."
END SELECT

LOCATE 18, 26: SHELL "pause": COLOR 15, 8: GOTO gethigh2:

gethigh2: 'gets the largest number that the computer can pick.  (1-??)
          'GET HIGH:  what a name for a label.  Say NO to drugs!
PRINT : PRINT player2$; " can pack a number as high as 10,000."
PRINT "Would you like to change this?  (Y or N)"
gggg:   'another Y/N prompt
board$ = INKEY$
IF board$ = "y" THEN GOTO changehigh2:
IF board$ = "Y" THEN GOTO changehigh2:
IF board$ = "n" THEN PRINT : PRINT player2$; " will pick a number between 1 and 10,000. ": PRINT "Press any key to start the game.": DO: LOOP WHILE INKEY$ = "": LET TOP = 10000: GOTO GAME2:
IF board$ = "N" THEN PRINT : PRINT player2$; " will pick a number between 1 and 10,000. ": PRINT "Press any key to start the game.": DO: LOOP WHILE INKEY$ = "": LET TOP = 10000: GOTO GAME2:
GOTO gggg:

changehigh2:   'Lets the player change the top number
CLS : PRINT : PRINT "Right now, "; player2$; " can pick a number as high as 10,000"
PRINT : PRINT "What is the hishest number that "; player2$; : INPUT " Can pick:  ", TOP
IF TOP < 10 THEN GOTO changehigh2:
IF TOP > 50000 THEN GOTO changehigh2:
GOTO GAME2


GAME2: LET turns = 0: LET G = 0: LET n = 0

COLOR 13: CLS : LOCATE 9, 1: PRINT
PRINT player2$; ", you can give "; player1$; " a number between 1 and"; TOP
LOCATE 11, 1: INPUT "What is the number?  ", n
SELECT CASE n
CASE IS < 1
PRINT : PRINT "you must pick a number between 1 and"; TOP: PRINT : PRINT : SHELL "pause"
CLS : GOTO GAME2
CASE IS > TOP
PRINT : PRINT "Your number cannot be higher than"; TOP: PRINT : PRINT : SHELL "pause"
CLS : GOTO GAME2:
CASE IS > 1 AND n <= TOP
GOTO MAINGAME:
CASE ELSE: CLS : GOTO GAME2:
END SELECT

MAINGAME:
PRINT "ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·"
PRINT "º                                                                             º"
PRINT "ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                      ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·                                  º"
PRINT "º                      º                   º                                  º"
PRINT "º                      ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½                                  º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "º                                                                             º"
PRINT "ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½"


form$ = "###,###"       ' sets up print using statement that i finally
COLOR 15: LOCATE 2, 10: ' learned how to use.
     IF TOP = 10000 THEN
     PRINT player1$; " must guess "; player2$; "'s number; between 1 and 10,000"
END IF
     IF TOP <> 10000 THEN
     PRINT player1$; " must guess "; player2$; "'s number; between 1 and"; : PRINT USING "###,###"; TOP
END IF

COLOR 14:
LOCATE 10, 7: PRINT player1$; ","
LOCATE 11, 7: PRINT "Your gurss is:"

NUMBER2:
COLOR 14, 8: LOCATE 11, 27: PRINT "               "
COLOR 15: LOCATE 11, 27: INPUT "", G

LOCATE 16, 2: PRINT SPACE$(76)
LOCATE 18, 2: PRINT SPACE$(76)

SELECT CASE G
CASE IS > TOP
COLOR 14, 9: LOCATE 16, 10: PRINT "Your guess is out or range."
LOCATE 18, 10: PRINT "The number is between 1 and"; TOP
COLOR 14, 8: GOTO NUMBER2:

CASE IS < n
COLOR 14, 9: LOCATE 16, 25: PRINT G; "is too small."
IF snd = 1 THEN PLAY "O1C"
COLOR 14, 8: LET turns = turns + 1: GOTO NUMBER2

CASE IS > n
COLOR 14, 9: LOCATE 16, 25: PRINT G; "is too big!"
IF snd = 1 THEN PLAY "O4c"
COLOR 14, 8: LET turns = turns + 1: GOTO NUMBER2:

CASE n = G:  GOTO win2:
END SELECT

win2:
SELECT CASE guesser
CASE IS = 1
LET ta = ta + turns + 1
LET ga = ga + 1
CASE IS = 2
LET tb = tb + turns + 1
LET gb = gb + 1
END SELECT

LET turns = turns + 1: LET firstgame = 0
COLOR 14, 9: LOCATE 16, 32: PRINT "You got it!!"
IF snd = 1 THEN PLAY "L11CEFGP16L8EL3G"
COLOR 15, 8: LOCATE 19, 3: PRINT "You WIN!   The number was"; : PRINT USING "###,###"; n
LOCATE 20, 3: PRINT "You guessed "; player2$; "'s number in"; turns; "turns."
center 22, "Press Any Key to continue"
DO:  LOOP WHILE INKEY$ = ""

ENDGAME2:
CLS : PRINT : PRINT "Would you like to play again?  (Press Y or N)"
gac2:
board$ = INKEY$  'y/n prompt
IF board$ = "y" THEN LOCATE 2, 48: PRINT "Yes":  GOTO NG2:
IF board$ = "Y" THEN LOCATE 2, 48: PRINT "Yes":  GOTO NG2:
IF board$ = "n" THEN CLS : center 10, "Thank you for playing ": center 12, "G u e s s - A - N u m b e r !": center 14, "By Charles Martin": PRINT : center 17, "Press any key to quit..": SLEEP: SYSTEM
IF board$ = "N" THEN CLS : center 10, "Thank you for playing ": center 12, "G u e s s - A - N u m b e r !": center 14, "By Charles Martin": PRINT : center 17, "Press any key to quit..": SLEEP: SYSTEM
GOTO gac2:

NG2:
PRINT : PRINT "Do you want to use the same player names as the last game did?  (Y, N, or Q)"
ghijk:
board$ = INKEY$
IF board$ = "y" THEN CLS : GOTO flip:
IF board$ = "Y" THEN CLS : GOTO flip:
IF board$ = "n" THEN GOTO newgame2:
IF board$ = "N" THEN GOTO newgame2:
IF board$ = "q" THEN SYSTEM
IF board$ = "Q" THEN SYSTEM
GOTO ghijk:

newgame2: 'starts the input phase
firstgame = 1

SCREEN 0: COLOR 11, 8: CLS : LOCATE 24, 1:
PRINT "(c)  Copyright 1997-2001 Charles Martin"       'Prints top portion
COLOR 14, 8: center 2, "G u e s s  - A -  N u m b e r"  'and bottom line
COLOR 9, 8: LOCATE 4, 31: PRINT "By ";
COLOR 12, 8: PRINT "Charles ";
COLOR 15, 8: PRINT "Martin "

LOCATE 7, 1: PRINT "How many players?  (1 or 2)"    'asks how many players
getkeyxy:               'looks for either a 1 or a 2 to be pressed, then
board$ = INKEY$        'calls the necessary subroutine
IF board$ = "1" THEN GOTO START3:
IF board$ = "2" THEN GOTO START3:
GOTO getkeyxy:

START3:
IF board$ = "1" THEN LOCATE 7, 30: PRINT "1 Player game": CALL PLAY1:
IF board$ = "2" THEN LOCATE 7, 30: PRINT "2 Player game": CALL PLAY2:



END SUB

