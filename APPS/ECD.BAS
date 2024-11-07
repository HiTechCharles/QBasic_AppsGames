DECLARE SUB center (row!, Text$)
DECLARE SUB center (row, Text$)
DECLARE FUNCTION CurrentDate$ (style!)
DECLARE SUB GetInfo ()
DECLARE FUNCTION dayofweek$ (m, d, y)
DECLARE FUNCTION i2a$ (h)
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
DECLARE SUB parse (stp$)
DECLARE FUNCTION replace$ (Text$, LookFor$, ReplaceWith$)
DECLARE FUNCTION trim$ (ttt$)
DIM SHARED remain, CD1$, CD2$, Event$, DOE$, fec, fileerror, wd$(3), FI$
ON ERROR GOTO errorhandler:

BEG:
WIDTH 40, 25: COLOR 15: CLS
FI$ = "ECD.DAT": fec = 1: OPEN "ECD.DAT" FOR INPUT AS 6: PT = 1
INPUT #6, Event$: INPUT #6, DOE$: INPUT #6, CD1$: INPUT #6, CD2$: CLOSE 6

ADL:
COLOR 12, 8: CLS
'open the file and get the days remaining and the last date the program was run
OPEN "DALR.DAT" FOR INPUT AS 1:  INPUT #1, remain: INPUT #1, ld$: CLOSE 1
center 4, Event$: COLOR 10: center 8, "Today is"
center 9, CurrentDate$(1)

COLOR 9: center 12, CD1$: center 13, CD2$: COLOR 15 'display event desc.

SELECT CASE ld$
    CASE IS = DATE$: ran = 1  'if computer is started more than once a day,
    CASE IS <> DATE$: ran = 0 'don't change anything
END SELECT

IF ran = 0 THEN remain = remain - 1 ELSE GOTO FIN:
center 16, "Thre are " + i2a$(remain) + " days to go!"

'Write days remaining and last start date into file
OPEN "DALR.dat" FOR OUTPUT AS 1: WRITE #1, remain, DATE$
CLOSE 1: : COLOR 15

SELECT CASE remain   'displays messages based on days remaining
    CASE IS = 90: center 19, "After 90 days, it all begins"
    CASE IS = 60: center 19, "Two months remaining!"
    CASE IS = 29: center 19, "Less than a month now!"
    CASE IS = 14: center 19, "TWO WEEKS will go by fast!"
    CASE IS = 7: center 19, "ONE WEEK!  ONE WEEK!! Groovy!"
    CASE IS = 6: center 19, "It won't be long now!"
    CASE IS = 5: center 19, "Start to pack, never look back!"
    CASE IS = 4: center 19, "I propose a toast to a great trip."
    CASE IS = 3: center 19, "Rockin' and rollin'"
    CASE IS = 2: center 19, "Are you ready for what's to come?"
    CASE IS = 1: center 19, "YAHOO!  Tomorrow is the day!"
    CASE IS = 0: GOTO bigday:
    CASE ELSE: GOTO hh:
END SELECT

hh:
COLOR 10, 8: center 22, "Press any key to continue...": SLEEP 10: SYSTEM

bigday:
'the day of the event!  put anything you want here

GOTO FIN:

FIN:
IF ran = 1 THEN center 16, "Thre are " + i2a$(remain) + " days to go!"
GOTO hh:

errorhandler:
IF fec <> 1 THEN SOUND 1600, 4
SELECT CASE ERR
    CASE IS = 53:
    IF fec <> 1 THEN PRINT "FILE NOT FOUND OR NOT ACCESSABLE - "; FI$
    fileerror = 1
    IF FI$ = "ECD.DAT" THEN GetInfo: GOTO ADL:
    IF fec = 1 THEN RESUME NEXT ELSE SYSTEM
    CASE IS = 61: PRINT "Disk Is full.  Delete unneeded files from the disk.": SYSTEM: RESUME NEXT
    CASE ELSE: PRINT : PRINT "ERROR"; ERR
END SELECT

SUB center (row, Text$)

col = 21 - LEN(Text$) / 2
LOCATE row, col: PRINT Text$

END SUB

FUNCTION CurrentDate$ (style)

m$ = LEFT$(DATE$, 2): mm = VAL(m$)   'month
d$ = MID$(DATE$, 4, 2): dd = VAL(d$) 'day
y$ = RIGHT$(DATE$, 4): YY = VAL(y$)  'year
IF style = 1 THEN dy$ = dayofweek(mm, dd, YY)

SELECT CASE mm
    CASE IS = 1: month$ = "January"
    CASE IS = 2: month$ = "Feburary"
    CASE IS = 3: month$ = "March"
    CASE IS = 4: month$ = "April"
    CASE IS = 5: month$ = "May"
    CASE IS = 6: month$ = "June"
    CASE IS = 7: month$ = "July"
    CASE IS = 8: month$ = "August"
    CASE IS = 9: month$ = "September"
    CASE IS = 10: month$ = "October"
    CASE IS = 11: month$ = "November"
    CASE IS = 12: month$ = "December"
END SELECT

IF dd < 10 THEN ds$ = RIGHT$(d$, 1) ELSE ds$ = d$
IF mm < 10 THEN Ms$ = RIGHT$(m$, 1) ELSE Ms$ = m$

SELECT CASE style
CASE IS = 1: CurrentDate$ = dy$ + ", " + month$ + " " + ds$ + ", " + y$
CASE IS = 2: CurrentDate$ = month$ + " " + ds$ + ", " + y$
CASE IS = 3: CurrentDate$ = Ms$ + "/" + ds$ + "/" + RIGHT$(y$, 2)
CASE IS = 4: CurrentDate$ = Ms$ + "/" + ds$ + "/" + y$
CASE IS = 5: CurrentDate$ = month$ + " " + ds$
END SELECT


END FUNCTION

FUNCTION dayofweek$ (m, d, y)

DIM J$(7): J$(1) = "Sunday": J$(2) = "Monday": J$(3) = "Tuesday"
J$(4) = "Wednesday": J$(5) = "Thursday": J$(6) = "Friday": J$(7) = "Saturday"

IF m < 1 OR m > 12 THEN PRINT : PRINT "Month must be between 1 and 12.": SYSTEM
IF d < 1 OR d > 31 THEN PRINT : PRINT "Day must be between 1 and 31.": SYSTEM
IF y < 1753 THEN PRINT : PRINT "Year must not be prior to 1753.":  SYSTEM
k = INT(.6 + (1 / m)): l = y - k: O = m + 12 * k: P = l / 100: z1 = INT(P / 4)
z2 = INT(P): z3 = INT((5 * l) / 4): z4 = INT(13 * (O + 1) / 5):
z = z4 + z3 - z2 + z1 + d - 1: z = z - (7 * INT(z / 7))
z = z + 1: dayofweek$ = J$(z): ERASE J$

END FUNCTION

SUB GetInfo

EVE:
COLOR 9, 8: CLS : center 2, "Provide the event details"
               center 3, "to the computer:"

COLOR 15: LOCATE 6, 1: PRINT "Event title  (up to 38)"
PRINT ">"; : COLOR 14, 9: PRINT SPACE$(38)
Event$ = Limitinput$(38, "", 7, 2, "")
Event$ = trim$(Event$)
IF Event$ = "" THEN GOTO EVE:

DOE:
COLOR 15, 8: LOCATE 10, 1: PRINT "Date of the Event:  (up to 10)"
PRINT ">"; : COLOR 14, 9: PRINT SPACE$(10)
DOE$ = Limitinput$(10, "0123456789-/", 11, 2, "")
DOE$ = trim$(DOE$)
IF LEN(DOE$) < 6 THEN COLOR 15, 8: CLS : GOTO DOE:
DOE$ = replace$(DOE$, "/", "-")
parse DOE$

IF LEN(wd$(1)) = 1 THEN wd$(1) = "0" + wd$(1)
IF LEN(wd$(2)) = 1 THEN wd$(2) = "0" + wd$(2)
CY$ = MID$(DATE$, 7, 2)
IF LEN(wd$(3)) = 1 THEN PRINT : PRINT "INVALID YEAR - MUST BE 2 OR 4 DIGITS!": SLEEP 3: COLOR , 8: CLS : GOTO DOE:
IF LEN(wd$(3)) = 2 THEN wd$(3) = CY$ + wd$(3)
DOE$ = wd$(1) + "-" + wd$(2) + "-" + wd$(3)

edesc:
COLOR 15, 8: LOCATE 14, 1: PRINT "Event Description (2 lines of up to 38)"
PRINT ">"; : COLOR 14, 9: PRINT SPACE$(38)
CD1$ = Limitinput$(38, "", 15, 2, "")
CD1$ = trim$(CD1$)
IF LEN(CD1$) < 6 THEN COLOR 15, 8: CLS : GOTO edesc:

COLOR 15, 8: PRINT : PRINT ">"; : COLOR 14, 9: PRINT SPACE$(38)
CD2$ = Limitinput$(38, "", 16, 2, "")
CD2$ = trim$(CD2$)
IF LEN(CD2$) < 6 THEN COLOR 15, 8: CLS : GOTO edesc:

DaysToGo:
LOCATE 19, 1: COLOR 15, 8: PRINT "Determine now many days until the event"
                           PRINT "happens.  When calculating this, DO NOT"
                           PRINT "COUNT today, or the day of the event."
                           PRINT "(1 to 999)   >"; : COLOR 14, 9: PRINT SPACE$(3)
remain = VAL(Limitinput$(3, "0123456789", 22, 15, ""))
IF remain <= 1 THEN COLOR , 8: CLS : GOTO DaysToGo:

'OPEN "ECD.DAT" FOR APPEND AS 8: CLOSE 8
OPEN "ECD.DAT" FOR OUTPUT AS 8
WRITE #8, Event$, DOE$, CD1$, CD2$: CLOSE 8
OPEN "DALR.dat" FOR OUTPUT AS 1
WRITE #1, remain, DATE$: CLOSE 1
END SUB

FUNCTION i2a$ (h)
    i2a$ = trim$(STR$(h))
END FUNCTION

FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
'
'LimitInput$ -- Allows the user to type only a certain number of characters
'all common editing functions can be used to delete/edit characters.

'   USAGE:  StringVariable$ = LimitInput$ (<# characters allowed>, <characters allowed in string>, <Row>, <Collumn>, <Existing tecxt>)
'EXAMPLES:  NUM = val(LimitInput$ (12, "0123456789.", 5, 5, ""))
            'up to 12 digits, only numbers and decimal allowed, start typing at 5,5      

allowesc = 1   'allow escape to be pushed during input

'---------
IF UCASE$(ALLOWEDCHARS$) = "ALL" OR ALLOWEDCHARS$ = "" THEN ALLOWEDCHARS$ = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+`~[]{};:'" + CHR$(34) + ",<.>/?\| "

LOCATE row, col: PRINT et$; : CONTENTS$ = et$
LT$ = CHR$(0) + CHR$(75): RT$ = CHR$(0) + CHR$(77)
ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8)
IF allowesc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27) + LT$ + RT$
TC = LEN(et$): CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
tos:
     DO
     LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
      EndCol = LEN(CONTENTS$): CurCol = POS(0)
    LOOP WHILE CHAR$ = ""
     IF INSTR(ALLOWEDCHARS$, CHAR$) = 0 THEN GOTO tos:
     SELECT CASE CHAR$
         CASE IS = CHR$(8)
            IF CONTENTS$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
            IF CONTENTS$ <> "" THEN CONTENTS$ = LEFT$(CONTENTS$, LEN(CONTENTS$) - 1): TC = TC - 1
         CASE IS = CHR$(13): Limitinput$ = CONTENTS$: EXIT FUNCTION
         CASE IS = CHR$(27)
            IF allowesc = 1 THEN Limitinput$ = CHR$(27): EXIT FUNCTION
         CASE IS = LT$: IF TC > 0 THEN PRINT CHR$(29); : TC = TC - 1
         CASE IS = RT$: IF TC <= ALLOWEDCHARS THEN PRINT CHR$(28); : TC = TC + 1
         CASE ELSE:
         SELECT CASE TC
              CASE IS < ALLOWEDCHARS: PRINT CHAR$; : TC = TC + 1: CONTENTS$ = CONTENTS$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l29B": GOTO tos:
         END SELECT
     END SELECT
LOOP
END FUNCTION

SUB parse (stp$)
WordSep$ = "-"   'this is what separates each word/part
stp$ = trim$(stp$): LOS = LEN(stp$): wd = 1
IF stp$ = "" THEN EXIT SUB

FOR LTR = 1 TO LOS
    CH$ = MID$(stp$, LTR, 1)
    SELECT CASE CH$
        CASE IS = WordSep$: wd$(wd) = WSF$: wd = wd + 1: WSF$ = ""
        CASE ELSE:  WSF$ = WSF$ + CH$
    END SELECT
NEXT LTR

wd$(wd) = WSF$
parts = wd

END SUB

FUNCTION replace$ (Text$, LookFor$, ReplaceWith$)

'   check for null original string, not in at all, or equal
    IF (Text$ = "") OR (INSTR(Text$, LookFor$) < 1) OR (Text$ = ReplaceWith$) OR LEN(Text$) < LEN(LookFor$) THEN
       replace$ = Text$
       EXIT FUNCTION
    END IF

    New$ = ""

    LengthOfReplacement% = LEN(ReplaceWith$)
    LengthOfText% = LEN(Text$)
    LengthOfStringToLookFor% = LEN(LookFor$)

    i% = 1
    WHILE i% <= LengthOfText% - LengthOfStringToLookFor% + 1
        IF MID$(Text$, i%, LengthOfStringToLookFor%) = LookFor$ THEN
           New$ = New$ + ReplaceWith$
           i% = i% + LengthOfStringToLookFor%
        ELSE
           New$ = New$ + MID$(Text$, i%, 1)
           i% = i% + 1
        END IF
    WEND

    replace$ = New$
   

END FUNCTION

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

