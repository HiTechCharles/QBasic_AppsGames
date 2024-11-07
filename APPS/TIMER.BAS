DECLARE SUB CMT ()
DECLARE SUB cta ()
DECLARE SUB center (row!, text$)

DIM SHARED charset(128, 8, 6)   'array for storing font information
DIM SHARED H, M, S, oH, oM, OS, et, starttime, ts, lt$, olt$, z, ap$, logtime

IF INSTR(COMMAND$, "-L") > 0 OR INSTR(COMMAND$, "/L") > 0 THEN logtime = 1

IF logtime <> 1 THEN GOTO Begin:
WIDTH 40, 25:  COLOR 15: CLS
OPEN "Mtime.log" FOR APPEND AS #6
              '----0----0----0----0----0----0----0----|
PRINT : PRINT "You can now add a comment that wil go"
        PRINT "into the Time log file.  Press ENTER"
        PRINT "when done typing, or leave it blank."
PRINT : INPUT ">", CC$

PRINT #6, " "
PRINT #6, " "
PRINT #6, "/-------NEW TIMER SESSION-------\"
IF CC$ <> "" THEN PRINT #6, "COMMENT:  "; CC$
PRINT #6, " "
PRINT #6, "---START DATE:  "; DATE$; "  "; TIME$

Begin:
WIDTH 40, 25: COLOR 10: CLS : LOCATE 3, 1: PRINT "Press ENTER / SPACE to start the timer.":

DO UNTIL INKEY$ = " " OR INKEY$ = CHR$(13) OR INKEY$ = CHR$(27): k$ = INKEY$: LOOP
IF k$ = CHR$(27) THEN SYSTEM

starttime = TIMER: : ts = 1: LOCATE 3, 1: PRINT SPACE$(39)

timeloop:
LOCATE 1, 1: COLOR 14, 1: PRINT "   DATE   ": PRINT DATE$
LOCATE 1, 31: PRINT "  TIME   ": LOCATE 2, 31: PRINT TIME$; " "
COLOR , 8:
CMT

DO UNTIL INKEY$ = "": LOOP
DO WHILE INKEY$ = ""
COLOR 14, 1: LOCATE 2, 31: PRINT TIME$; " "
              LOCATE 2, 1: PRINT DATE$: COLOR , 8

et = TIMER - starttime
olt$ = LEFT$(TIME$, 2)
IF lt$ <> olt$ THEN CMT

COLOR 14, 1: rt$ = RIGHT$(TIME$, 6): LOCATE 3, 33: PRINT rt$
M = M + oM: M = INT((et + OS) / 60): : z = M * 60   '----GOOD
IF M + oM = 60 THEN H = H + 1: oM = 0: M = 0: OS = 0: S = 0: et = 0: starttime = TIMER: GOTO timeloop:
IF H > 9999 THEN GOTO MaxedOUt:
et = et - z: S = S + OS: S = et '                   -----GOOD

COLOR 15, 8: LOCATE 9, 15: PRINT USING "####:##:##.###"; H; M + oM; S + OS
COLOR 14: LOCATE 10, 18: PRINT "H  M  S MS"
COLOR 13: : center 15, "Press any key to stop the timer..."
LOOP
oH = H: oM = M + oM: OS = S + OS

IF logtime <> 1 THEN GOTO stc:
PRINT #6, "[STOP]  ";
IF oH > 0 THEN PRINT #6, oH; "HOURS  ";
IF oM > 0 THEN PRINT #6, oM; "MINUTES  ";
IF OS > 0 THEN PRINT #6, USING "##.##"; OS; : PRINT #6, " SECONDS"
PRINT " "

stc:
SOUND 2500, 5
ts = ts + 1: COLOR 14, 12: center 1, "TIMER'S LAST STOPS"
timslot:
IF ts < 7 THEN COLOR 15, 12: LOCATE ts, 12: PRINT USING "   ####:##:##.##"; oH; oM; OS; : PRINT "  ": GOTO STPtime:
IF ts >= 7 THEN GOTO resetstack:

resetstack:
ts = 2: CALL cta
COLOR 15, 12:
LOCATE ts, 12: PRINT USING "   ####:##:##.##"; oH; oM; OS; : PRINT "  ": GOTO STPtime:

STPtime:
COLOR 9, 8: LOCATE 15, 1: PRINT SPACE$(40): center 15, "TIMER IS STOPPED"
COLOR 11: : LOCATE 16, 7: PRINT "PRESS ENTER to CONTINUE"
LOCATE 17, 7: PRINT "        C   to CLEAR timer"
LOCATE 18, 7: PRINT "        S   to SET"
LOCATE 19, 7: PRINT "     ESCAPE to quit"
tio:
k$ = LCASE$(INKEY$)
IF k$ = CHR$(13) THEN GOTO keepgoing:
IF k$ = CHR$(27) THEN GOTO EndThis:
IF k$ = "c" THEN CLEAR : GOTO Begin:
IF k$ = "s" THEN GOTO settime:
 IF k$ = " " THEN GOTO keepgoing:
IF k$ = "q" THEN GOTO EndThis:
GOTO tio:

keepgoing:
S = 0: M = 0: :
starttime = TIMER
VIEW PRINT 15 TO 23: CLS : VIEW PRINT: GOTO timeloop:


settime:
CLS
LOCATE 5, 1: COLOR 15
INPUT "  HOURS:  (0-999): ", H
IF H > 9999 OR H < 0 THEN FOR Amanda = 1 TO 4: SOUND 235, 5: SOUND 0, 3: NEXT: GOTO settime:

gmt:
INPUT "MINUTES:   (0-59): ", oM
IF oM < 0 OR oM > 59 THEN FOR Amanda = 1 TO 4: SOUND 235, 5: SOUND 0, 3: NEXT: PRINT : PRINT "Between 0 and 59 mins, please.": SLEEP 2: CLS : LOCATE 5, 1: GOTO gmt:

gst:
INPUT "SECONDS:   (0-59): ", OS
IF OS < 0 OR OS > 59 THEN FOR Amanda = 1 TO 4: SOUND 235, 5: SOUND 0, 3: NEXT:    PRINT : PRINT "Between 0 and 59.99 seconds, please.": SLEEP 2: CLS : LOCATE 5, 1: : GOTO gst:
PRINT : PRINT : PRINT "You got it!  Time being set to"
PRINT H; "Hours,"; oM; "Minutes,"; OS; "Seconds"
SOUND 2500, 5
CLS : ts = 1: starttime = TIMER: GOTO timeloop

MaxedOUt:
COLOR 10: center 20, "The clock has reached its"
          center 21, " maximum of 10,000 hours."
COLOR 13, 8: center 23, "Press any key."

IF logtime <> 1 THEN SYSTEM    'just end the program if no log requested
IF logtime = 1 THEN GOTO EndThis:

EndThis:
IF logtime <> 1 THEN SYSTEM    'just end the program if no log requested
PRINT #6, "[EXIT]  ";
IF oH > 0 THEN PRINT #6, oH; "HOURS  ";
IF oM > 0 THEN PRINT #6, oM; "MINUTES  ";
IF OS > 0 THEN PRINT #6, USING "##.##"; OS; : PRINT #6, " SECONDS"
PRINT " "
PRINT #6, "---END DATE:  "; DATE$; "   "; TIME$
CLOSE #6

SUB center (row, text$)

col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

SUB CMT

rt$ = RIGHT$(TIME$, 6): lt$ = LEFT$(TIME$, 2)
SELECT CASE lt$
CASE IS = "00": ap$ = "A": z = 12: GOTO prt:
CASE IS = "12": ap$ = "P": z = 12: GOTO prt:
CASE IS = "13": ap$ = "P": z = 1: GOTO prt:
CASE IS = "14": ap$ = "P": z = 2: GOTO prt:
CASE IS = "15": ap$ = "P": z = 3: GOTO prt:
CASE IS = "16": ap$ = "P": z = 4: GOTO prt:
CASE IS = "17": ap$ = "P": z = 5: GOTO prt:
CASE IS = "18": ap$ = "P": z = 6: GOTO prt:
CASE IS = "19": ap$ = "P": z = 7: GOTO prt:
CASE IS = "20": ap$ = "P": z = 8: GOTO prt:
CASE IS = "21": ap$ = "P": z = 9: GOTO prt:
CASE IS = "22": ap$ = "P": z = 10: GOTO prt:
CASE IS = "23": ap$ = "P": z = 11: GOTO prt:
CASE ELSE: ap$ = "A": GOTO prt:
END SELECT

prt:
LOCATE 3, 31: COLOR 14, 1

IF lt$ = "00" THEN PRINT USING "##"; z; : PRINT rt$; ap$: EXIT SUB
IF ap$ = "A" THEN PRINT TIME$; ap$
IF ap$ = "P" THEN PRINT USING "##"; z; : PRINT rt$; ap$

END SUB

SUB cta

COLOR , 8
FOR I = 2 TO 6
LOCATE I, 12: PRINT SPACE$(19)
NEXT I

END SUB

