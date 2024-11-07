DECLARE SUB AnyMinuteNow ()
DECLARE SUB CalculateRange ()
DECLARE SUB center (row, Text$)
DECLARE SUB clearlines (top, btm, col)
DECLARE FUNCTION CurrentTime$ (TI$)
DECLARE FUNCTION DateFix$ (doe$)
DECLARE FUNCTION DayOfWeek$ (m%, d%, y%)
DECLARE SUB DisplayResults ()
DECLARE FUNCTION Fieldbkg$ (nos)
DECLARE SUB GetDates ()
DECLARE FUNCTION I2a$ (h%)
DECLARE SUB InitArrays ()
DECLARE SUB Load ()
DECLARE FUNCTION limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, TI$)
DECLARE FUNCTION NumberOfDays (mtt, ytt)
DECLARE FUNCTION plural$ (ntt, si$, pl$)
DECLARE FUNCTION Replace$ (Text$, LookFor$, ReplaceWith$)
DECLARE FUNCTION ReRun ()
DECLARE FUNCTION TimeFix$ (TI$)
DECLARE FUNCTION trim$ (ttt$)
COMMON SHARED months, Weeks, days, Years, TotalDays, hrs%, min%, Hours
COMMON SHARED minutes, cm, cy, edit


TYPE dateclass
    month AS INTEGER
      day AS INTEGER
     year AS INTEGER
     time AS STRING * 5
END TYPE '11

TYPE EventClass
    month AS INTEGER
      day AS INTEGER
     year AS INTEGER
     time AS STRING * 5
        desc AS STRING * 40
   format AS INTEGER
     runs AS INTEGER
END TYPE '55
DIM SHARED start AS dateclass, endd AS dateclass, evin AS EventClass, day$(7), month$(12)

    InitArrays
    Load
ReStart:
    GetDates
    CalculateRange
    DisplayResults
    IF ReRun = 1 THEN GOTO ReStart ELSE SYSTEM

SUB AnyMinuteNow
END SUB

SUB CalculateRange
    cm = start.month
    cd = start.day
    cy = start.year

    em = endd.month
    ed = endd.day
    ey = endd.year

    days = 0: Weeks = 0: months = 0: Years = 0

    DO UNTIL cm = em AND cd = ed AND cy = ey
        cd = cd + 1
        IF cm = em AND cd = ed AND cy = ey THEN GOTO DoneCounting:
        IF cd > NumberOfDays(cm, cy) THEN cd = 1: cm = cm + 1
        IF cm > 12 THEN cm = 1: cd = 1: cy = cy + 1
        IF cm = em AND cd = ed AND cy = ey THEN EXIT DO ELSE days = days + 1
    LOOP

DoneCounting:
    TotalDays = days

yr:
    IF days - 365 < 0 THEN GOTO mon:  ELSE Years = Years + 1: days = days - 365: GOTO yr:
mon:
    IF days - 30 < 0 THEN GOTO wk:  ELSE months = months + 1: days = days - 30: GOTO mon:
wk:
    IF days - 7 < 0 THEN GOTO dy:  ELSE Weeks = Weeks + 1: days = days - 7: GOTO wk:
dy:
    IF ((Years * 365) + (months * 30) + (Weeks * 7) + days) = TotalDays + 1 THEN PRINT "Calculation error - determined numbers of weeks/months/years does not equal total # of days": SYSTEM

END SUB

SUB center (row, Text$)
    col = 21 - LEN(Text$) / 2: LOCATE row, col: PRINT Text$
END SUB

SUB clearlines (top, btm, col)
    COLOR , 0
    FOR I = top TO btm
        LOCATE I, col: PRINT SPACE$((40 - col) + 1)
    NEXT I
END SUB

FUNCTION CurrentTime$ (TI$)
    c = INSTR(TI$, ":")
    IF c > 0 THEN
        h% = VAL(LEFT$(TI$, c - 1))
        m% = VAL(MID$(TI$, c + 1))
    ELSE
        h% = VAL(TI$): min% = 0
    END IF
    
    SELECT CASE h%
        CASE IS = 0: ap$ = "a": sh% = 12
        CASE IS < 12: ap$ = "a": sh% = h%
        CASE IS = 12: ap$ = "p": sh% = h%
        CASE IS > 12: ap$ = "p": sh% = h% - 12
    END SELECT

    IF m% < 10 THEN m$ = "0" + I2a$(m%) ELSE m$ = I2a$(m%)
    CurrentTime$ = I2a$(sh%) + ":" + m$ + ap$
END FUNCTION

FUNCTION DateFix$ (doe$)
    IF LEN(doe$) < 6 THEN DateFix$ = "ERROR - valid date not passed to function"
    IF doe$ = CHR$(27) THEN SYSTEM
    DIM pt$(11)
    doe$ = Replace$(doe$, "/", "-")

    WordSep$ = "-"   'this is what separates each word/part
    LOS = LEN(doe$): wd = 1

    FOR LTR = 1 TO LOS
        CH$ = MID$(doe$, LTR, 1)
        SELECT CASE CH$
            CASE IS = WordSep$: pt$(wd) = WSF$: wd = wd + 1: WSF$ = ""
            CASE ELSE:  WSF$ = WSF$ + CH$
        END SELECT
    NEXT LTR

    pt$(wd) = WSF$

    m = VAL(pt$(1)): d = VAL(pt$(2)): y = VAL(pt$(3))
    IF y > 99 AND y < 1753 THEN DateFix$ = "Invalid Year - must be 2 OR 4 digits": EXIT FUNCTION
    IF m > 12 THEN DateFix$ = "Invalid month - Range is 1 to 12": EXIT FUNCTION
    IF d > 31 THEN DateFix$ = "Invalid day - Range is 1 to 31": EXIT FUNCTION
    nd% = NumberOfDays(m, y)
    IF d > nd% THEN DateFix$ = month$(m) + " has " + I2a$(nd%) + " days, not" + RTRIM$(STR$(d)) + ".": EXIT FUNCTION

    IF LEN(pt$(1)) = 1 THEN pt$(1) = "0" + pt$(1)
    IF LEN(pt$(2)) = 1 THEN pt$(2) = "0" + pt$(2)
    cy$ = MID$(DATE$, 7, 2)
    IF LEN(pt$(3)) = 2 THEN pt$(3) = cy$ + pt$(3)
    DateFix$ = pt$(1) + "-" + pt$(2) + "-" + pt$(3)

END FUNCTION

FUNCTION DayOfWeek$ (m%, d%, y%)
    k = INT(.6 + (1 / m%)): L = y% - k: O = m% + 12 * k: P = L / 100: z1 = INT(P / 4)
    z2 = INT(P): z3 = INT((5 * L) / 4): z4 = INT(13 * (O + 1) / 5)
    z = z4 + z3 - z2 + z1 + d% - 1: z = z - (7 * INT(z / 7))
    z = z + 1: DayOfWeek$ = day$(z)
END FUNCTION

SUB DisplayResults
    WIDTH 40, 25: COLOR 13: CLS : fmt$ = "          ###,### "
              LOCATE 2, 1: PRINT "Today:": LOCATE 5, 1: PRINT "Event:"
    COLOR 10: LOCATE 2, 10: PRINT DayOfWeek$(start.month, start.day, start.year); ", "; month$(start.month); " "; I2a$(start.day); ", "; I2a$(start.year)
              LOCATE 3, 10
              IF evin.format = 1 THEN PRINT CurrentTime$(start.time) ELSE PRINT start.time
              
              LOCATE 5, 10: PRINT DayOfWeek$(endd.month, endd.day, endd.year); ", "; month$(endd.month); " "; I2a$(endd.day); ", "; I2a$(endd.year)
              LOCATE 6, 10:
              IF evin.format = 1 THEN PRINT CurrentTime$(endd.time) ELSE PRINT endd.time
              
              LOCATE 7, 1: COLOR 15: PRINT STRING$(40, "Í")
              COLOR 12: center 10, trim$(evin.desc)
              COLOR 15: LOCATE 12, 1

    IF TotalDays = 0 THEN
        IF Hours <> 0 THEN PRINT USING fmt$; Hours; : PRINT plural$(Hours, "Hour", "Hours")
        IF minutes <> 0 THEN PRINT USING fmt$; minutes; : PRINT plural$(minutes, "Minute", "Minutes")
        GOTO DD:
    END IF

    IF Years <> 0 THEN PRINT USING fmt$; Years; : PRINT plural$(Years, "Year", "Years")
    IF months <> 0 THEN PRINT USING fmt$; months; : PRINT plural$(months, "Month", "Months")
    IF Weeks <> 0 THEN PRINT USING fmt$; Weeks; : PRINT plural$(Weeks, "Week", "Weeks")
    IF days <> 0 THEN PRINT USING fmt$; days; : PRINT plural$(days, "Day", "Days")
    IF Hours <> 0 THEN PRINT USING fmt$; Hours; : PRINT plural$(Hours, "Hour", "Hours")
    IF minutes <> 0 THEN PRINT USING fmt$; minutes; : PRINT plural$(minutes, "Minute", "Minutes")
DD:
    
    COLOR 9:  center 21, "     E - Edit event details"
              center 22, "     N - Track a NEW event "
              center 23, "ESCape - Exit              "

END SUB

FUNCTION Fieldbkg$ (nos)
    COLOR 15, 4: PRINT SPACE$(nos)
END FUNCTION

SUB GetDates
    start.month = VAL(LEFT$(DATE$, 2))
    start.day = VAL(MID$(DATE$, 4, 2))
    start.year = VAL(RIGHT$(DATE$, 4))
    start.time = LEFT$(TIME$, 5)

    hrs = VAL(LEFT$(start.time, 2))
    min = VAL(RIGHT$(start.time, 2))
    Hours = 24 - hrs: minutes = 60 - min
        IF minutes = 60 THEN
            minutes = 0
        ELSE
            Hours = Hours - 1
        END IF
    
    IF evin.runs = 0 OR edit = 1 THEN
Intro:
        WIDTH 40, 25: COLOR 9: CLS
        center 2, "Until My Date -- UMD"
        COLOR 14: center 3, "By Charles Martin"

desc:   LOCATE 12, 1: COLOR 14: PRINT "Event description:"
        IF edit = 1 THEN et$ = trim$(evin.desc) ELSE et$ = ""
        PRINT Fieldbkg$(39): TI$ = limitinput$(39, "", 13, 1, et$)
            IF TI$ = CHR$(27) THEN CLOSE #1: SYSTEM
            IF LEN(TI$) < 5 THEN clearlines 12, 13, 1: GOTO desc:
        evin.desc = TI$
        
fmt:    COLOR 14, 8: LOCATE 16, 1
        PRINT "Choose a time format:": COLOR 15
        PRINT "     1.  12-hour  (9:35am, 12:30p)"
        PRINT "     2.  24-hour  (09:35, 13:30)": LOCATE , , 0

gfk:    k$ = INPUT$(1)
                IF k$ = "1" OR k$ = "2" THEN evin.format = VAL(k$): GOTO inex:
                IF k$ = CHR$(27) THEN CLOSE #1: SYSTEM
        GOTO gfk:
        
inex:   COLOR 13, 0: CLS
        center 2, "Examples of date and time entry:"
        COLOR 15: LOCATE 5, 1
            PRINT "     Dates:  1/30/06      6-15-2000"
            PRINT "             2-13-1980    09/11/01"
            PRINT
        IF evin.format = 1 THEN
            PRINT "     Times:  11:05a       2:55p"
            PRINT "             3p           8:56a"
        ELSE
            PRINT "     Times:  01:25        21:00"
            PRINT "             6:42         17"
        END IF

Date2:
        LOCATE 12, 1: COLOR 14, 8: PRINT "    DATE:  "; Fieldbkg$(10)

        IF edit = 1 THEN et$ = I2a$(evin.month) + "-" + I2a$(evin.day) + "-" + I2a$(evin.year) ELSE et$ = ""
        end$ = limitinput$(10, "0123456789-/", 12, 12, et$)
        end$ = DateFix$(end$)
        IF LEN(end$) < 10 THEN
            COLOR 13, 8: clearlines 12, 14, 1: GOTO Date2:
        ELSEIF LEN(end$) > 10 THEN
            COLOR 12, 8: center 16, end$: LOCATE , , 0: SLEEP 3: clearlines 12, 16, 1: end$ = "": GOTO Date2:
        ELSE
            COLOR 15, 8: LOCATE 12, 12: PRINT end$
            endd.month = VAL(LEFT$(end$, 2))
            endd.day = VAL(MID$(end$, 4, 2))
            endd.year = VAL(RIGHT$(end$, 4))
            evin.month = endd.month
            evin.day = endd.day
            evin.year = endd.year
        END IF
time2:
        COLOR 14, 8: LOCATE 13, 1: PRINT "    TIME:  "; Fieldbkg$(6)
        IF edit = 1 THEN
            IF evin.format = 1 THEN et$ = CurrentTime$(evin.time) ELSE et$ = trim$(evin.time)
        END IF
        TI$ = limitinput$(6, "0123456789:AaPp", 13, 12, et$)
        TI$ = TimeFix$(TI$)
        IF LEN(TI$) > 10 THEN
            COLOR 12, 8: center 16, TI$: SLEEP 3: TI$ = "": clearlines 13, 16, 1: GOTO time2:
        ELSE
            COLOR 15, 8: LOCATE 13, 12: PRINT TI$ + SPACE$(5)
            endd.time = TI$
            evin.time = endd.time
        END IF
        IF edit = 1 THEN edit = 0 ELSE evin.runs = 1
        PUT #1, 1, evin
    END IF
    
     Hours = Hours + hrs%: minutes = minutes + min%
min:    IF minutes > 59 THEN Hours = Hours + 1: minutes = minutes - 60: GOTO min:
hou:    IF Hours > 23 THEN TotalDays = TotalDays + 1: Hours = Hours - 24: GOTO hou
END SUB

FUNCTION I2a$ (h%)
    I2a$ = LTRIM$(RTRIM$(STR$(h%)))
END FUNCTION

SUB InitArrays
    month$(1) = "January": month$(2) = "Feburary":   month$(3) = "March"
     month$(4) = "April":   month$(5) = "May":        month$(6) = "June"
     month$(7) = "July":    month$(8) = "August":     month$(9) = "September"
    month$(10) = "October": month$(11) = "November": month$(12) = "December"

    day$(1) = "Sunday": day$(2) = "Monday": day$(3) = "Tuesday"
    day$(4) = "Wednesday": day$(5) = "Thursday": day$(6) = "Friday": day$(7) = "Saturday"
END SUB

FUNCTION limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, TI$)

allowesc = 1   'allow escape to be pushed during input

'---------
IF UCASE$(ALLOWEDCHARS$) = "ALL" OR ALLOWEDCHARS$ = "" THEN ALLOWEDCHARS$ = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+`~[]{};:'" + CHR$(34) + ",<.>/?\| "

LOCATE row, col: PRINT TI$; : CONTENTS$ = TI$
LT$ = CHR$(0) + CHR$(75): RT$ = CHR$(0) + CHR$(77)
ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8)
IF allowesc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27) + LT$ + RT$
TC = LEN(TI$): CHAR$ = ""
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
         CASE IS = CHR$(13): limitinput$ = CONTENTS$: EXIT FUNCTION
         CASE IS = CHR$(27)
            IF allowesc = 1 THEN limitinput$ = CHR$(27): EXIT FUNCTION
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

SUB Load
    IF INSTR(COMMAND$, "/N") > 0 THEN SHELL "del umd.dat"
    OPEN "UMD.dat" FOR RANDOM AS #1 LEN = 55
    IF LOF(1) > 5 THEN
        GET #1, 1, evin
        endd.month = evin.month
        endd.day = evin.day
        endd.year = evin.year
        endd.time = evin.time
        hrs% = VAL(LEFT$(evin.time, 2))
        min% = VAL(RIGHT$(RTRIM$(evin.time), 2))

        
        evin.runs = evin.runs + 1: PUT #1, 1, evin
    END IF
END SUB

FUNCTION NumberOfDays (mtt, ytt)
    SELECT CASE mtt
        CASE 1: NumberOfDays = 31
        CASE 2: IF ytt MOD 4 = 0 THEN NumberOfDays = 29 ELSE NumberOfDays = 28
        CASE 3: NumberOfDays = 31
        CASE 4: NumberOfDays = 30
        CASE 5: NumberOfDays = 31
        CASE 6: NumberOfDays = 30
        CASE 7: NumberOfDays = 31
        CASE 8: NumberOfDays = 31
        CASE 9: NumberOfDays = 30
        CASE 10: NumberOfDays = 31
        CASE 11: NumberOfDays = 30
        CASE 12: NumberOfDays = 31
    END SELECT
END FUNCTION

FUNCTION plural$ (ntt, si$, pl$)
    IF ntt = 1 THEN plural$ = si$ ELSE plural$ = pl$
END FUNCTION

FUNCTION Replace$ (Text$, LookFor$, ReplaceWith$)

'*******************************************************************************
'*  replaces specified char/text in string with chosen replacement char/text   *
'*  Using "" as ReplaceWith$ effectively eliMIN%ates (squeezes out) LookFor$    *
'*******************************************************************************

'   check for null original string, not in at all, or equal
    IF (Text$ = "") OR (INSTR(Text$, LookFor$) < 1) OR (Text$ = ReplaceWith$) OR LEN(Text$) < LEN(LookFor$) THEN
       Replace$ = Text$
       EXIT FUNCTION
    END IF

    New$ = ""

    LengthOfReplacement% = LEN(ReplaceWith$)
    LengthOfText% = LEN(Text$)
    LengthOfStringToLookFor% = LEN(LookFor$)

    I% = 1
    WHILE I% <= LengthOfText% - LengthOfStringToLookFor% + 1
        IF MID$(Text$, I%, LengthOfStringToLookFor%) = LookFor$ THEN
           New$ = New$ + ReplaceWith$
           I% = I% + LengthOfStringToLookFor%
        ELSE
           New$ = New$ + MID$(Text$, I%, 1)
           I% = I% + 1
        END IF
    WEND

    Replace$ = New$

END FUNCTION

FUNCTION ReRun

ron:  LOCATE , , 0
      ct$ = LEFT$(TIME$, 5)
      DO UNTIL ct$ <> LEFT$(TIME$, 5) OR k$ <> "": k$ = UCASE$(INKEY$): LOOP
      IF Years < 1 AND months < 1 AND Weeks < 1 AND days < 1 AND Hours < 1 AND minutes < 2 THEN AnyMinuteNow: SYSTEM

    SELECT CASE k$
        CASE IS = "": ReRun = 1: EXIT FUNCTION
        CASE IS = "E": edit = 1: ReRun = 1: EXIT FUNCTION
        CASE IS = "N": edit = 0: evin.runs = 0: : ReRun = 1: EXIT FUNCTION
        CASE ELSE: ReRun = 0: EXIT FUNCTION
    END SELECT
END FUNCTION

FUNCTION TimeFix$ (TI$)
    TI$ = trim$(UCASE$(TI$)): hrs% = 0: min% = 0: ap$ = ""
    
    IF INSTR(TI$, "A") > 0 THEN
        ap$ = "A"
        TI$ = Replace$(TI$, "A", "")
    ELSEIF INSTR(TI$, "P") > 0 THEN
        ap$ = "P"
        TI$ = Replace$(TI$, "P", "")
    END IF

    c = INSTR(TI$, ":")
    IF c > 0 THEN
        hrs% = VAL(LEFT$(TI$, c - 1))
        min% = VAL(MID$(TI$, c + 1))
    ELSE
        hrs% = VAL(TI$): min% = 0
    END IF

    IF hrs% < 0 OR hrs% > 23 THEN TimeFix$ = "Invalid HOUR:  Range 1 to 12 or 0 to 23": EXIT FUNCTION
    IF min% < 0 OR min% > 59 THEN TimeFix$ = "Invalid MINUTE:  Range is 0 to 59": EXIT FUNCTION

    IF hrs% = 0 THEN format = 24: GOTO alldone:
    IF ap$ = "" THEN format = 24: GOTO alldone:
    IF hrs% <= 12 AND ap$ <> "" THEN format = 12
    IF hrs% > 12 AND ap$ <> "" THEN format = 24
    
    IF format = 12 AND hrs% <> 12 AND ap$ = "P" THEN hrs% = hrs% + 12: ap$ = "P"
    IF ap$ = "A" AND hrs% = 12 THEN hrs% = 0

alldone:
    tif$ = I2a$(hrs%) + ":"
    IF min% < 10 THEN tif$ = tif$ + "0" + I2a$(min%) ELSE tif$ = tif$ + I2a$(min%)
    TimeFix$ = tif$
END FUNCTION

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

