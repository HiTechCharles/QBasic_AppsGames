DECLARE SUB rjust (R!, t$)
DECLARE SUB center (row, text$)

bbegin:
COLOR 14: WIDTH 40, 25: CLS : center 2, "Bowling Average Tracker"
COLOR 13: center 4, "By Charles Martin"

COLOR 15: LOCATE 7, 1:

ON ERROR GOTO nofile:
OPEN "C:\bowlavg.dat" FOR INPUT AS #1

nofile:
number = ERR
IF number = 53 THEN nsf = -1: GOTO newstats:   'if no file go to somewhere else

PN:
SELECT CASE nsf
    CASE IS = -1: GOTO newstats:
    CASE ELSE: GOTO havestats:
END SELECT

newstats:
LOCATE 7, 1: LINE INPUT "Please enter your name:  ", name$
name$ = UCASE$(name$): name$ = LTRIM$(RTRIM$(name$))
IF LEN(name$) < 2 OR LEN(name$) > 12 THEN VIEW PRINT 5 TO 23: CLS : VIEW PRINT: GOTO newstats:

VIEW PRINT: CLS
COLOR 10: PRINT : PRINT "You can now enter scores, as many as you"
                  PRINT "want.  To quit adding scores, just press"
                  PRINT "ENTER on an empty line.": PRINT : PRINT : COLOR 12: NS = 0
         
DO UNTIL quit = 1
nes = nes + 1
MMSN:
COLOR 12: PRINT "Score #"; nes; "- "; : INPUT "", S
SELECT CASE S
CASE IS < 1: quit = 1: GOTO setnew:
CASE IS > 300: COLOR 15: PRINT : PRINT "The highest possible score is 300.": PRINT : SLEEP 2: GOTO MMSN:
CASE IS > 1: NS = NS + S: GOTO EO2:
END SELECT

EO2:
LOOP
GOTO setnew2:

setnew2:
CLS
avg = INT(NS / nes)

center 2, "Statistics for": PRINT " "; name$
COLOR 14: center 6, "Your average is": LOCATE 7, 14: PRINT "based on"; nes; "scores."
          
COLOR 15: center 9, "Your average is": PRINT INT(avg)

OPEN "C:\bowlavg.dat" FOR APPEND AS #1
PRINT #1, name$: PRINT #1, nes: PRINT #1, avg: SYSTEM

havestats:
IF nes > 0 THEN GOTO setnew:
INPUT #1, name$
INPUT #1, FS    '# of scores in FILE
INPUT #1, avg   'average in FILE
CLOSE #1

PRINT : PRINT "Welcome back, "; name$; "!"
PRINT
PRINT "Your current average is"; avg
PRINT : PRINT "Your average is based on": PRINT "scores from"; FS; "games."
CLOSE #1

COLOR 13: PRINT : PRINT : PRINT "Want to add new scores?  (Y/N):"
wsn:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO GNS:
IF k$ = "n" THEN SYSTEM
GOTO wsn:

GNS:
VIEW PRINT: CLS
COLOR 10: PRINT : PRINT "You can now enter new scores, as many"
          PRINT "as you need to.  To quit adding scores, just"
          PRINT "press ENTER on an empty line.": PRINT : PRINT : COLOR 12: NS = 0

DO UNTIL quit = 1
nes = nes + 1
MMS:
PRINT "Score #"; nes; "- "; : INPUT "", S
SELECT CASE S
CASE IS > 300: PRINT : PRINT "The highest possible score is 300.  Go lower.": SLEEP 2: GOTO MMS:
CASE IS > 1: NS = NS + S: GOTO EO:
CASE IS < 1: quit = 1: GOTO setnew:
END SELECT

EO:
LOOP
GOTO setnew

setnew:
IF nsf = -1 THEN GOTO setnew2:
nes = nes - 1
COLOR 11: CLS : center 2, "You have finished entering new scores."
                center 4, "Below is information about the": center 5, "scores JUST ENTERED."
                COLOR 9:


rjust 9, "# of scores entered:": PRINT " "; nes
rjust 11, "Total of scores entered:":  PRINT " "; NS
eavg = INT(NS / nes)
rjust 13, "Average of ENTERED scores:": PRINT " "; eavg
COLOR 13: center 19, "Press a key to see updated statistics": SLEEP:

CLS
allscores = nes + FS
newavg = INT((eavg + avg) / 2)

center 2, "UPDATED statistics"
COLOR 11: center 3, "For ": PRINT name$
COLOR 14: center 6, "Your total average is now"
          center 7, "based on": PRINT allscores; "scores."
COLOR 15: center 10, "Average BEFORE new scores": PRINT INT(avg)
          center 12, "Your updated average is": PRINT INT(newavg)


KILL "C:\bowlavg.dat"
OPEN "C:\bowlavg.dat" FOR APPEND AS #1
PRINT #1, name$
PRINT #1, allscores
PRINT #1, newavg


SUB center (row, text$)

VIEW PRINT
col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$; :

END SUB

SUB rjust (R, t$)

RJ = 27 - LEN(t$)
LOCATE R, RJ: PRINT t$; :




END SUB

