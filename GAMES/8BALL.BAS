DECLARE SUB cfn ()
DECLARE SUB center (row, text$)
DECLARE SUB DISPLAYanswer ()
DECLARE SUB INITANSWERS ()
DECLARE SUB KRACKER ()
DECLARE SUB mp (k$)
DECLARE SUB pause (n!)

DIM SHARED answers$(52)
DIM SHARED question$, answer$, name$, ASE

CLEAR : RANDOMIZE TIMER: SCREEN 0:   COLOR 15, 9: WIDTH 80, 25: CLS
IF INSTR(COMMAND$, "-SE") > 0 THEN ASE = 1
OPEN "c:\8ball.log" FOR APPEND AS #1

startinput: COLOR 15, 8: PRINT : COLOR 15, 12
center 2, "Magic 8-ball "
center 4, "Get all of your questions answered!"

Begin:
VIEW PRINT 6 TO 24: COLOR 14, 8: CLS :  COLOR 15, 8
LOCATE 7, 1: LINE INPUT "Please give your name:  ", name$
name$ = LTRIM$(RTRIM$(name$))
IF name$ = "" THEN COLOR 14, 8: PRINT : PRINT "You must give the 8-ball your name.": GOTO Begin:

getquestion:
IF ASE = 1 THEN cfn


COLOR 15: PRINT : PRINT : PRINT "Please type in your question.  You may leave this blank if you want."
LINE INPUT ">", question$
IF question$ = "" THEN GOTO anaprompt:
IF LEN(question$) < 5 THEN PRINT : PRINT "You must type a question at least 5 letters long or leave it blank.": PRINT : SHELL "pause": COLOR 15, 8: CLS : PRINT : PRINT : GOTO getquestion:
IF LEN(question$) > 75 THEN PRINT : PRINT "You must type a question less than 75 letters long or leave it blank.": PRINT : SHELL "pause": COLOR 15, 8: CLS : PRINT : PRINT : GOTO getquestion:
IF question$ <> "" THEN GOTO getanswer:

anaprompt:
IF question$ = "" THEN PRINT : PRINT "Leave the question blank?  (Press Y/N):"
gac:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN PRINT : COLOR 13, 8: PRINT : PRINT "your question has been left blank.": PRINT : SHELL "pause": GOTO getanswer:
IF k$ = "n" THEN COLOR 15, 8: CLS : PRINT : PRINT : GOTO getquestion:
IF k$ = CHR$(27) THEN COLOR 15, 8: CLS : PRINT : PRINT : GOTO getquestion:
GOTO gac:
                                       
getanswer:
RANDOMIZE TIMER
INITANSWERS

DISPLAYanswer

SUB center (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;
END SUB

SUB cfn

PRINT : PRINT : COLOR 13:  ID$ = UCASE$(name$)
SELECT CASE ID$
CASE IS = "AMANDA": KRACKER
CASE IS = "BOB": PRINT "Hey, it's Uncle Bob at the computer, COOL!": EXIT SUB
CASE IS = "CHARLIE": PRINT "Charlie, the maker of this program wants to ask a question...": EXIT SUB
CASE IS = "CHARLES": PRINT "This program's creator has a question...": EXIT SUB
CASE IS = "DEBBIE": PRINT "Hi Aunt Debbie!  Heard from Amanda lately?": EXIT SUB
CASE IS = "DEB": PRINT "Good morning, how are ya!": EXIT SUB
CASE IS = "DEL": PRINT "What's up, big giang!": EXIT SUB
CASE IS = "MANDA": KRACKER
CASE IS = "AMANA": PRINT : PRINT "You forgot the 'D' in that pretty name of yours.": EXIT SUB
CASE IS = "UNCLE BOB": PRINT "Hey, hope you pick some good numbers tonight!": EXIT SUB
CASE ELSE: EXIT SUB: PRINT " ": EXIT SUB
END SELECT

END SUB

SUB DISPLAYanswer

PRINT #1, "Name:  "; name$
IF question$ <> "" THEN PRINT #1, "Question: "; question$
PRINT #1, "Answer:  "; answer$
PRINT #1, "Date:  "; DATE$
PRINT #1, "Time:  "; TIME$
PRINT #1, " "

COLOR 14, 8: CLS : COLOR 12, 8: LOCATE 8, 1:
PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ"
PRINT "ณ                                                                             ณ"
PRINT "ณ                                                                             ณ"
PRINT "ณ                                                                             ณ"
PRINT "ิอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ"
COLOR 9, 8
PRINT "ีอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ"
PRINT "ณ                                                                             ณ"
PRINT "ณ                                                                             ณ"
PRINT "ณ                                                                             ณ"
PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู"

IF question$ <> "" THEN COLOR 15, 8: center 10, question$
IF question$ = "" THEN COLOR 15, 8: center 10, "BLANK question"

center 15, answer$

COLOR 14
center 21, "Press any key to quit.": SLEEP: SYSTEM


END SUB

SUB INITANSWERS
RANDOMIZE TIMER

LET answers$(1) = "Definitely"
LET answers$(2) = "What Did You Say?"
LET answers$(3) = "Don't Hold Your Breath"
LET answers$(4) = "No Way!"
LET answers$(5) = "Probably Not"
LET answers$(6) = "Can't Tell You Now"
LET answers$(7) = "It Is Decidedly So"
LET answers$(8) = "The Force Seems Strong With No"
LET answers$(9) = "Don't Bet On It"
LET answers$(10) = "The Force Seems Strong With Yes"
LET answers$(11) = "Yes, Yes, Yes!"
LET answers$(12) = "Why Do You Ask?"
LET answers$(13) = "Maybe?"
LET answers$(14) = "My Reply Is No"
LET answers$(15) = "Chances Are Good"
LET answers$(16) = "My Reply Is Yes"
LET answers$(17) = "Try Again"
LET answers$(18) = "You May Rely On It"
LET answers$(19) = "Ask Again Later"
LET answers$(20) = "Yes, Definitely"
LET answers$(21) = "Definitely Not"
LET answers$(22) = "My Sources Say No"
LET answers$(23) = "Very Doubtful"
LET answers$(24) = "My Sources Say Yes"
LET answers$(25) = "As I See It Yes"

LET answers$(26) = "Better Not Tell You Now"
LET answers$(27) = "Signs Point To Yes"
LET answers$(28) = "Reply Hazy, Try Again"
LET answers$(29) = "Without A Doubt"
LET answers$(30) = "As I See It No"
LET answers$(31) = "It Is Certain"
LET answers$(32) = "Outlook Not So Good"
LET answers$(33) = "Concentrate And Ask Again"
LET answers$(34) = "Outlook Good"
LET answers$(35) = "There's A Slight Chance"
LET answers$(36) = "Don't Count On It"
LET answers$(37) = "Most Likely"
LET answers$(38) = "Don't Bet On It"
LET answers$(39) = "Yes"
LET answers$(40) = "No, No, No!"
LET answers$(41) = "No"
LET answers$(42) = "Proceed With Caution"
LET answers$(43) = "It's Not Possible"
LET answers$(44) = "Not In This Lifetime"
LET answers$(45) = "Certainly"
LET answers$(46) = "It's Not Clear"
LET answers$(47) = "Couldn't Tell You"
LET answers$(48) = "Sure"
LET answers$(49) = "I Have No Idea"
LET answers$(50) = "Don't Get Your Hopes Up!"

LET answers$(51) = "I Have Good News!!"
LET answers$(52) = "I Have Bad News"


RANDOMIZE TIMER

LET n = INT(RND * 52) + 1

LET answer$ = answers$(n)

END SUB

SUB KRACKER
COLOR 13: PLAY "t105"
PRINT "Follow me (charlie) and everything is all right"
mp "j": mp "a": mp "j": pause 10: mp "h": mp "h": mp "f": mp "h": mp "h":  mp "h": mp "j": mp "j"
PRINT "I'll be the one to tuck you in at night"
pause 3: mp "j": mp "j": mp "a": mp "j": mp "h": mp "h": mp "f": mp "h": mp "h": mp "j": mp "j"
PRINT "and if you ";
pause 8: mp "d": mp "f": mp "h"
PRINT "want to leave, I can gaurentee"
pause 8: mp "j": mp "a": mp "j": pause 8: mp "h": mp "h": mp "f": mp "h": mp "h": mp "j": mp "j"
PRINT "you won't find nobody else like me!"
pause 8: mp "h": mp "j": pause 8: mp "a": pause 8: mp "a": pause 8: mp "j": mp "h": pause 8: mp "j": mp "h": mp "h": pause 8: mp "h"
pause 8: mp "d": mp "f": mp "h"
END SUB

SUB mp (k$)
SELECT CASE LCASE$(k$)
CASE IS = "a": PLAY "o2l9a": GOTO eos:
CASE IS = "s": PLAY "o2l9b": GOTO eos:
CASE IS = "d": PLAY "o2l9c": GOTO eos
CASE IS = "f": PLAY "o2l9d": GOTO eos
CASE IS = "g": PLAY "o2l9e": GOTO eos
CASE IS = "h": PLAY "o2l9f": GOTO eos
CASE IS = "j": PLAY "o2l9g": GOTO eos
CASE IS = "k": PLAY "o5l9f": GOTO eos:
CASE IS = "l": PLAY "o5l9g": GOTO eos:
CASE ELSE: GOTO eos:
END SELECT
eos:
END SUB

SUB pause (n)
PLAY "P" + LTRIM$(STR$(n))
END SUB

