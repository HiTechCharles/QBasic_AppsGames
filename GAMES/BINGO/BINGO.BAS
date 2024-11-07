DECLARE SUB center (row, text$)  'centers text on a given line
DECLARE FUNCTION i2a$ (h)        'converts numeric variables to strings
DECLARE SUB INTRO ()             'shows scrolling marquee, instructions,and copyright
DECLARE SUB newgame ()           'starts a new game and resets variables
DECLARE SUB paintscreen ()       'main game.
DECLARE SUB PlaySounds (ps)      '00plays sounds according to the value of PS

SHELL "cd sounds"
DIM SHARED CN(75)
DIM SHARED n, letter$, nc, playit

RANDOMIZE TIMER
playit = 1
INTRO

SUB center (row, text$)
'the sub centers text while in 40x25 screen mode
  Col = 21
  LOCATE row, Col - (LEN(text$) / 2)
  PRINT text$;
END SUB

FUNCTION i2a$ (h)
i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB INTRO

WIDTH 80, 25: SCREEN 0:  COLOR 10, 8: CLS
LOCATE 2, 30: PRINT "All-star Bingo"                      'starts title screen
LOCATE 4, 31: COLOR 12, 8: PRINT "By "; : COLOR 15, 8: PRINT "Charles"; : COLOR 9, 8: PRINT " Martin"
COLOR 15, 8:
LOCATE 23, 1: PRINT "(c) 2000-2004 Charles Martin"
COLOR 14: LOCATE 6, 1:
PRINT "This program allows you to play bingo without having another person call"
PRINT "the numbers out.  everyone can play.  When a number is called, it will show"
PRINT "up on the left of the screen, and said aloud.  The program also keeps track"
PRINT "of the numbers that have been called out."
PRINT : COLOR 11
PRINT "OPERATION:  During the game, you can use the following keys:"
PRINT "    #0   '0' will show you a detailed explanation of all availible commands"
PRINT "    #1   press 1 when someone gets a bingo"
PRINT "    #2   Hit 2 to show you different ways to get bingo.  (patterns)"
PRINT "    #3   Quits the game"

COLOR 14: center 19, "Press any key to continue. . .": SLEEP

CALL newgame            'starts the game

END SUB

SUB newgame

WIDTH 40, 25: CLS : ERASE CN
n = 0        'current number gets reset
letter$ = "" 'Letter for current number also needs clearing

'status line variables need to be set to 0 for a new game.
bcalled = 0: icalled = 0: ncalled = 0: gcalled = 0: ocalled = 0: nc = 0

COLOR 15, 9: CLS :             'prints message saying clear cards, etc.
center 7, "ATTENTION ALL PLAYERS:"
center 9, "Prepare for a brand new game."

center 12, "Remember to clear all"
center 14, "cards that you are using."

'pauses flow to allow players to read the above message
COLOR 14: center 21, "Press any key to start the new game.": SLEEP

paintscreen     'main game sub starts the new game.

END SUB

SUB paintscreen

PlaySounds 78        'plays beginning sound (three red dings

pickagain:            'picks the next number
n = 0: playit = 1: RANDOMIZE TIMER

LET n = INT(RND * 75) + 1
IF CN(n) = 1 THEN GOTO pickagain:
IF CN(n) = 0 THEN LET CN(n) = 1: LET nc = nc + 1

SELECT CASE n                   'assigns the current number with the right
CASE 1 TO 15: letter$ = "B": bcalled = bcalled + 1      '
CASE 16 TO 30: letter$ = "I": icalled = icalled + 1
CASE 31 TO 45: letter$ = "N": ncalled = ncalled + 1
CASE 46 TO 60: letter$ = "G": gcalled = gcalled + 1
CASE 61 TO 75: letter$ = "O": ocalled = ocalled + 1
END SELECT

'toplevel: allows the screen to refresh without picking another number.
toplevel:

CLS
COLOR 15, 8       'prints the called numbers pannel
 LOCATE 3, 23: PRINT "ÚÄÄÂÄÄÂÄÄÂÄÄÂÄÄ¿"
 LOCATE 4, 23: PRINT "³  ³  ³  ³  ³  ³"
 LOCATE 5, 23: PRINT "ÃÄÄÅÄÄÅÄÄÅÄÄÅÄÄ´"
 LOCATE 6, 23: PRINT "³  ³  ³  ³  ³  ³"
 LOCATE 7, 23: PRINT "³  ³  ³  ³  ³  ³"
 LOCATE 8, 23: PRINT "³  ³  ³  ³  ³  ³"
 LOCATE 9, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 10, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 11, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 12, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 13, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 14, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 15, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 16, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 17, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 18, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 19, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 20, 23: PRINT "³  ³  ³  ³  ³  ³"
LOCATE 21, 23: PRINT "ÀÄÄÁÄÄÁÄÄÁÄÄÁÄÄÙ"

COLOR 15, 8: LOCATE 6, 1:       'ptints the current number in a little screen
PRINT "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
PRINT "º             º"
PRINT "º             º"
PRINT "º             º"
PRINT "º             º"
PRINT "º             º"
PRINT "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"

COLOR 15, 9:          'some parts turn the wrong color when you print to them
FOR I = 1 TO 5        'the next series of loops correct this.
LOCATE I, 1: PRINT SPACE$(22)
NEXT I

FOR I = 13 TO 23: LOCATE I, 1: PRINT SPACE$(22): NEXT I
FOR I = 6 TO 12: LOCATE I, 16: PRINT SPACE$(7): NEXT I
FOR h = 1 TO 20: LOCATE h, 39: PRINT "  ": NEXT h

LOCATE 1, 23: PRINT SPACE$(18): LOCATE 2, 23: PRINT SPACE$(18)
LOCATE 22, 23: PRINT SPACE$(18): LOCATE 23, 23: PRINT SPACE$(18)
LOCATE 21, 39: PRINT "  "

'starts printing out the called numbers pannel.
'the immediate line print 'b i n g o' at the top of the pannel.
COLOR 14, 8: LOCATE 4, 25: PRINT "B"; TAB(28); "I"; TAB(31); "N"; TAB(34); "G"; TAB(37); "O"

'this part prints the numbers that have been called.  if they've been called,
'they show up here.  when a number is called, it gets stored so the computer
'can't pick that number again.  (with the right code)  this 'storage place'
'has 75 boxes to store data.  if 1 is called, the first box stores '1' to
'signify that 1 has been called.  so if the 5th box has a 0, it doesen't
'show up because it hasen't been picked.  if the 5th box has a 1, it shows.

COLOR 14         'b
IF CN(1) = 1 THEN LOCATE 6, 24: PRINT " 1"
IF CN(2) = 1 THEN LOCATE 7, 24: PRINT " 2"
IF CN(3) = 1 THEN LOCATE 8, 24: PRINT " 3"
IF CN(4) = 1 THEN LOCATE 9, 24: PRINT " 4"
IF CN(5) = 1 THEN LOCATE 10, 24: PRINT " 5"
IF CN(6) = 1 THEN LOCATE 11, 24: PRINT " 6"
IF CN(7) = 1 THEN LOCATE 12, 24: PRINT " 7"
IF CN(8) = 1 THEN LOCATE 13, 24: PRINT " 8"
IF CN(9) = 1 THEN LOCATE 14, 24: PRINT " 9"
IF CN(10) = 1 THEN LOCATE 15, 24: PRINT "10"
IF CN(11) = 1 THEN LOCATE 16, 24: PRINT "11"
IF CN(12) = 1 THEN LOCATE 17, 24: PRINT "12"
IF CN(13) = 1 THEN LOCATE 18, 24: PRINT "13"
IF CN(14) = 1 THEN LOCATE 19, 24: PRINT "14"
IF CN(15) = 1 THEN LOCATE 20, 24: PRINT "15"

COLOR 12       'i
IF CN(16) = 1 THEN LOCATE 6, 27:  PRINT "16"
IF CN(17) = 1 THEN LOCATE 7, 27:  PRINT "17"
IF CN(18) = 1 THEN LOCATE 8, 27:  PRINT "18"
IF CN(19) = 1 THEN LOCATE 9, 27:  PRINT "19"
IF CN(20) = 1 THEN LOCATE 10, 27:  PRINT "20"
IF CN(21) = 1 THEN LOCATE 11, 27:  PRINT "21"
IF CN(22) = 1 THEN LOCATE 12, 27:  PRINT "22"
IF CN(23) = 1 THEN LOCATE 13, 27:  PRINT "23"
IF CN(24) = 1 THEN LOCATE 14, 27:  PRINT "24"
IF CN(25) = 1 THEN LOCATE 15, 27:  PRINT "25"
IF CN(26) = 1 THEN LOCATE 16, 27:  PRINT "26"
IF CN(27) = 1 THEN LOCATE 17, 27:  PRINT "27"
IF CN(28) = 1 THEN LOCATE 18, 27:  PRINT "28"
IF CN(29) = 1 THEN LOCATE 19, 27:  PRINT "29"
IF CN(30) = 1 THEN LOCATE 20, 27:  PRINT "30"

COLOR 1    'n
IF CN(31) = 1 THEN LOCATE 6, 30:  PRINT "31"
IF CN(32) = 1 THEN LOCATE 7, 30:  PRINT "32"
IF CN(33) = 1 THEN LOCATE 8, 30:  PRINT "33"
IF CN(34) = 1 THEN LOCATE 9, 30:  PRINT "34"
IF CN(35) = 1 THEN LOCATE 10, 30:  PRINT "35"
IF CN(36) = 1 THEN LOCATE 11, 30:  PRINT "36"
IF CN(37) = 1 THEN LOCATE 12, 30:  PRINT "37"
IF CN(38) = 1 THEN LOCATE 13, 30:  PRINT "38"
IF CN(39) = 1 THEN LOCATE 14, 30:  PRINT "39"
IF CN(40) = 1 THEN LOCATE 15, 30:  PRINT "40"
IF CN(41) = 1 THEN LOCATE 16, 30:  PRINT "41"
IF CN(42) = 1 THEN LOCATE 17, 30:  PRINT "42"
IF CN(43) = 1 THEN LOCATE 18, 30:  PRINT "43"
IF CN(44) = 1 THEN LOCATE 19, 30:  PRINT "44"
IF CN(45) = 1 THEN LOCATE 20, 30:  PRINT "45"

COLOR 15      'g
IF CN(46) = 1 THEN LOCATE 6, 33:  PRINT "46"
IF CN(47) = 1 THEN LOCATE 7, 33:  PRINT "47"
IF CN(48) = 1 THEN LOCATE 8, 33:  PRINT "48"
IF CN(49) = 1 THEN LOCATE 9, 33:  PRINT "49"
IF CN(50) = 1 THEN LOCATE 10, 33:  PRINT "50"
IF CN(51) = 1 THEN LOCATE 11, 33:  PRINT "51"
IF CN(52) = 1 THEN LOCATE 12, 33:  PRINT "52"
IF CN(53) = 1 THEN LOCATE 13, 33:  PRINT "53"
IF CN(54) = 1 THEN LOCATE 14, 33:  PRINT "54"
IF CN(55) = 1 THEN LOCATE 15, 33:  PRINT "55"
IF CN(56) = 1 THEN LOCATE 16, 33:  PRINT "56"
IF CN(57) = 1 THEN LOCATE 17, 33:  PRINT "57"
IF CN(58) = 1 THEN LOCATE 18, 33:  PRINT "58"
IF CN(59) = 1 THEN LOCATE 19, 33:  PRINT "59"
IF CN(60) = 1 THEN LOCATE 20, 33:  PRINT "60"

COLOR 13        'o
IF CN(61) = 1 THEN LOCATE 6, 36:  PRINT "61"
IF CN(62) = 1 THEN LOCATE 7, 36:  PRINT "62"
IF CN(63) = 1 THEN LOCATE 8, 36:  PRINT "63"
IF CN(64) = 1 THEN LOCATE 9, 36:  PRINT "64"
IF CN(65) = 1 THEN LOCATE 10, 36:  PRINT "65"
IF CN(66) = 1 THEN LOCATE 11, 36:  PRINT "66"
IF CN(67) = 1 THEN LOCATE 12, 36:  PRINT "67"
IF CN(68) = 1 THEN LOCATE 13, 36:  PRINT "68"
IF CN(69) = 1 THEN LOCATE 14, 36:  PRINT "69"
IF CN(70) = 1 THEN LOCATE 15, 36:  PRINT "70"
IF CN(71) = 1 THEN LOCATE 16, 36:  PRINT "71"
IF CN(72) = 1 THEN LOCATE 17, 36:  PRINT "72"
IF CN(73) = 1 THEN LOCATE 18, 36:  PRINT "73"
IF CN(74) = 1 THEN LOCATE 19, 36:  PRINT "74"
IF CN(75) = 1 THEN LOCATE 20, 36:  PRINT "75"

'this part prints to the little screen area on the left
COLOR 11
LOCATE 8, 8: PRINT letter$: LOCATE 10, 7: PRINT n

'These lines show numbers called.
IF nc = 1 THEN LOCATE 23, 1: COLOR 15, 9: PRINT nc; "number called"
IF nc > 1 THEN LOCATE 23, 1: COLOR 15, 9: PRINT nc; "numbers called"
IF nc = 75 THEN SLEEP 3: GOTO coverall:   'if all numbers have heen called,
                                          'everyone wins and it starts a new
PlaySounds (n):  GOTO gbx:                'game or exits

gijoe:          'this group just clears the area where the current number and
FOR I = 7 TO 11 'queastions are displayed.  if a user escapes from a question,
LOCATE I, 2: PRINT SPACE$(13)     'they're sent back here so it doesen't
NEXT I                            'refresh the screen, pick a new number, or
                                  'or re-announce the current number.

COLOR 11: LOCATE 8, 8: PRINT letter$: LOCATE 10, 7: PRINT n: GOTO gbx:

gbx:      'takes keyboard input so users can call bingo, exit, etc.
playit = 1  ' 1=bingo, 2=patterns,  3=exit, etc.
k$ = INKEY$
IF k$ = "2" THEN WIDTH 80, 25: SHELL "..\read ..\patterns.txt": playit = 0: CLS : WIDTH 40, 25: GOTO toplevel:
IF k$ = "1" THEN GOTO bingo:
IF k$ = "3" THEN GOTO bye:
IF k$ = "0" THEN WIDTH 80, 25: SHELL "..\read ..\COMMANDS.txt": playit = 0: CLS : WIDTH 40, 25: GOTO toplevel:
IF k$ = "." THEN GOTO toplevel:
IF k$ = CHR$(27) THEN GOTO bye:
IF k$ = CHR$(13) THEN GOTO pickagain:
GOTO gbx:


bingo:      'if someone pushes '1' they're sent here for the next COA.
IF nc < 5 THEN GOTO cheater:  'if less than 4 numbers are called, they
COLOR 15, 8:                  'get sent to cheaters: where they're told
FOR I = 7 TO 11               'a message because it takes at least 4 numbers
LOCATE I, 2: PRINT SPACE$(13) 'to get any kind of bingo on any card.  :)  gotcha!
NEXT I

PlaySounds 79
COLOR 14, 8: LOCATE 7, 2 'asks if there is a real bingo if so, goto clearcards
PRINT "Legal bingo?"
LOCATE 8, 4: PRINT "(Y OR N)"
lbi:                    'gets answer to 'legal bingo' question
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO clearcards:
IF k$ = "n" THEN PlaySounds 77:  GOTO gijoe:
IF k$ = CHR$(27) THEN GOTO gijoe:
GOTO lbi:

clearcards:     'asks if the game should continue or start over.
PlaySounds 76   'plays the successful bingo sound bingo
COLOR 15, 8:
FOR I = 7 TO 11
LOCATE I, 2: PRINT SPACE$(13)
NEXT I

COLOR 14, 8: LOCATE 7, 2: PRINT "Clear cards?"
LOCATE 8, 4: PRINT "(Y OR N)"
ccs:       'gets answere to 'clear cards' question.
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN newgame
IF k$ = "n" THEN SLEEP 2: GOTO pickagain
GOTO ccs:

bye:   'if you hit 3, or escape that's it  the program exits and user is
       'returned to their OS.  dos is not a dinosuur operating system.
       'without dos, how would you format a disk, copy a disk, show MBs
       'used in a folder, get a list of files in a folder (listing mp3
       'collections.)  All that stuff isn't in windows,  not even XP!!
       'most importantly, they'd be no great programs writtin in qbasic.       (like this one)
       'windows is cool, but dos has a few things over windows.
PlaySounds 80: SYSTEM

coverall:      'if all numbers are called, user can start game over or quit      (stay so you can use this great program that no one else has bothered to try to make :)
COLOR 14, 8: CLS :
center 12, "All of the numbers have been called!"
center 14, "Everyone wins!"
center 17, "Press ENTER to start a new game"
center 18, "or hit ESCape to quit."
gotojail:
LET k$ = LCASE$(INKEY$)
IF k$ = CHR$(27) THEN GOTO bye:
IF k$ = CHR$(13) THEN newgame
GOTO gotojail:

cheater:       'it's only cheating if you get caught!  but i've got ya!
COLOR 15, 8: CLS :
LOCATE 10, 1:
PRINT "At least 4 numbers need to be called in"
PRINT "order to get a bingo.  Only"; nc; "numbers"
PRINT "were called so far."
PRINT
PRINT "Cheating is not acceptable behavior"
PRINT "while playing bingo or any other game."
PRINT
center 18, "Press any key to continue"
SLEEP
playit = 0
GOTO toplevel:

'wow!!   thhhhhh hhh at's all folks.

END SUB

SUB PlaySounds (ps)


IF playit = 0 THEN EXIT SUB

SELECT CASE ps
    CASE 1 TO 15: SHELL "play B /q"
    CASE 16 TO 30: SHELL "play i /q"
    CASE 31 TO 45: SHELL "play n /q"
    CASE 46 TO 60: SHELL "play g /q"
    CASE 61 TO 75: SHELL "play o /q"
    CASE IS = 76: SHELL "play bingo /q": EXIT SUB
    CASE IS = 77: SHELL "play nobingo /q": EXIT SUB
    CASE IS = 78: SHELL "play start.mp3 /q": EXIT SUB
    CASE IS = 79: SHELL "PLAY BS /Q": EXIT SUB
    CASE IS = 80: SHELL "play adios /q": EXIT SUB
    CASE ELSE:  PRINT "SOUND # OUT OF RANGE OF 1-80": SYSTEM
END SELECT


CS$ = "PLAY "
f$ = i2a$(ps)       'all digits of the number
fd$ = LEFT$(f$, 1)  'first digit
IF ps > 9 THEN rd$ = RIGHT$(f$, 1) ELSE rd$ = ""  'second digit if total # > 9

SELECT CASE ps
    CASE 1 TO 9: CS$ = CS$ + f$: GOTO pts:
    CASE 10 TO 20: CS$ = CS$ + f$: GOTO pts:
    CASE 21 TO 75
         SHELL "play " + fd$ + "0" + "/q"
         IF rd$ <> "0" THEN SHELL "play " + rd$ + "/q"
         GOTO eos:
END SELECT

pts:
SHELL CS$ + " /q": EXIT SUB

eos:
END SUB

