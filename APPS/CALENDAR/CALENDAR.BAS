DECLARE SUB Arrow ()
DECLARE SUB center (row, text$)
DECLARE SUB ClearBoard ()
DECLARE FUNCTION CurrentTime$ ()
DECLARE SUB DayCount ()
DECLARE FUNCTION DayOfWeek$ (m, d, y)
DECLARE SUB DrawGrid ()
DECLARE FUNCTION FindDate (Month, year, place$)
DECLARE SUB GetInput ()
DECLARE SUB GLocate (xxp, yyp)
DECLARE SUB HelpScreen ()
DECLARE FUNCTION I2A$ (h)
DECLARE SUB InitArrays ()
DECLARE SUB jfont (a$, c, XCoordinate, YCoordinate, Size)
DECLARE SUB LoadColors ()
DECLARE SUB LoadFont ()
DECLARE SUB LoadHolidays ()
DECLARE FUNCTION NumberOfDays (mon, yr)
DECLARE SUB NumberSquare (sn)
DECLARE SUB plotmonth ()
DECLARE SUB RangeCheck ()
DECLARE FUNCTION RowsNeeded ()
DECLARE SUB SaveColors ()
DECLARE SUB SetColors ()
DECLARE SUB ShowHolidays ()
DECLARE SUB TADdisplay ()
DECLARE SUB Today ()

COMMON SHARED Month, year, gridlines, bkg, numbers, onday, opt, fileerror, day$
COMMON SHARED startcol, FI$, FEC, currentmonth, currentday, currentyear, dd$, td$, NOH
ON ERROR GOTO ErrorHandler:

TYPE HolidayClass
         name AS STRING * 30
        Month AS INTEGER
          day AS INTEGER
    placeinst AS STRING * 5
END TYPE '39

DIM SHARED charset(128, 8, 6), Month$(12), day$(7), Holiday AS HolidayClass
    LoadColors
    LoadFont
    LoadHolidays
    InitArrays
    Today
    plotmonth
    GetInput

ErrorHandler:
    SELECT CASE ERR
        CASE IS = 53:
            IF FEC <> 1 THEN
                SOUND 1600, 4
                PRINT "FILE NOT FOUND - "; FI$
            END IF
            fileerror = 1
            IF FEC = 1 THEN RESUME NEXT ELSE SYSTEM
        CASE IS = 61: PRINT "Disk Is full.  Delete unneeded files from the disk.": SYSTEM
        CASE ELSE: PRINT : PRINT "ERROR"; ERR: SYSTEM
    END SELECT

SUB Arrow
    LOCATE 12, 6: PRINT "    ": LOCATE 14, 6: PRINT "    ": LOCATE 16, 6: PRINT "    "

    IF opt > 3 THEN opt = 1
    IF opt < 1 THEN opt = 3
    
    SELECT CASE opt
        CASE 1: R = 12
        CASE 2: R = 14
        CASE 3: R = 16
    END SELECT

    LOCATE R, 6: PRINT "ÄÄÄ"
END SUB

SUB center (row, text$)
    Col = 21 - LEN(text$) / 2: LOCATE row, Col: PRINT text$
END SUB

SUB ClearBoard
    DO UNTIL INKEY$ = "": LOOP
END SUB

FUNCTION CurrentTime$
    h = VAL(LEFT$(TIME$, 2))
    m = VAL(MID$(TIME$, 4, 2)): m$ = I2A$(m)
    S = VAL(RIGHT$(TIME$, 2)): S$ = I2A$(S)

    SELECT CASE h
        CASE IS = 0: AP$ = "A": SH = 12
        CASE IS < 12: AP$ = "A": SH = h
        CASE IS = 12: AP$ = "P": SH = h
        CASE IS > 12: AP$ = "P": SH = h - 12
    END SELECT

    SH$ = I2A$(SH)
'             hour : minute <2 spaces> <AM or PM>
    IF LEN(m$) = 1 THEN m$ = "0" + m$
    CurrentTime$ = SH$ + ":" + m$ + " " + AP$ + "M"
END FUNCTION

SUB DayCount
    SCREEN 0: WIDTH 40, 25
    SHELL "Daycount.exe"
    SCREEN 13
END SUB

FUNCTION DayOfWeek$ (m, d, y)
    K = INT(.6 + (1 / m)): L = y - K: O = m + 12 * K: P = L / 100: z1 = INT(P / 4)
    z2 = INT(P): z3 = INT((5 * L) / 4): z4 = INT(13 * (O + 1) / 5):
    z = z4 + z3 - z2 + z1 + d - 1: z = z - (7 * INT(z / 7))
    z = z + 1: startcol = z: DayOfWeek$ = day$(z)
END FUNCTION

SUB DrawGrid
    StartX = 36: StartY = 30
    rows = RowsNeeded: Col = 7
    SizeX = 35: SizeY = 25

     LINE (StartX, StartY)-(Col * SizeX + StartX, rows * SizeY + StartY), bkg, BF
     LINE (StartX, StartY)-(Col * SizeX + StartX, rows * SizeY + StartY), gridlines, B
     GLocate StartX, StartY

    SizeX$ = I2A$(SizeX): SizeY$ = I2A$(SizeY): sn = 0
    FOR rw = 1 TO rows
        FOR cl = 1 TO Col
            DRAW "c" + I2A$(gridlines) + " r" + SizeX$ + "d" + SizeY$ + "l" + SizeX$ + "u" + SizeY$ + "r" + SizeX$
        NEXT cl
        GLocate StartX, (rw * SizeY) + StartY
    NEXT rw
END SUB

FUNCTION FindDate (Month, year, place$)
    count = VAL(LEFT$(place$, 1))  'number of times to find the day
    NOD = NumberOfDays(Month, year) 'number of days in the month
    fd$ = RIGHT$(place$, 3)  'day of week to find  (first 3 letters)

    IF count = 0 THEN  'if looking for the last day of a month, count = 0
        'current day = last day of month, direction is backward, find day once
        fd = NOD: dir = -1: count = 1
    ELSE
        'start at beginning of month, go forward through month
        fd = 1: dir = 1
    END IF
    
    DO
        'if current day matches specified day, set day found counter +1
        IF LEFT$(DayOfWeek(Month, fd, year), 3) = fd$ THEN CurCount = CurCount + 1

        IF count = CurCount THEN FindDate = fd: EXIT FUNCTION
        fd = fd + dir  'advance ore retreat one day
        'if beginning or end of month reached, exit function
        IF fd < 1 OR fd > NOD THEN EXIT FUNCTION
    LOOP
END FUNCTION

SUB GetInput
top:
    Up$ = CHR$(0) + CHR$(72): Dn$ = CHR$(0) + CHR$(80): Lt$ = CHR$(0) + CHR$(75)
    Rt$ = CHR$(0) + CHR$(77): Escape$ = CHR$(27): F1$ = CHR$(0) + CHR$(59)

BOI:
    TADdisplay
    K$ = UCASE$(INKEY$)
    SELECT CASE K$
        CASE "": GOTO BOI:
        CASE Up$: year = year + 1
        CASE Dn$: year = year - 1
        CASE Lt$: Month = Month - 1
        CASE Rt$:  Month = Month + 1
        CASE F1$, "?": HelpScreen
        CASE "C": SetColors
        CASE "D": DayCount
        CASE "H": ShowHolidays
        CASE "T": IF currentmonth = Month AND currentyear = year THEN GOTO top ELSE Today
        CASE Escape$: SaveColors
        CASE ELSE: GOTO BOI:
    END SELECT

Change:
    RangeCheck
    plotmonth
    GOTO top:
END SUB

SUB GLocate (xxp, yyp)
    DRAW "bm" + I2A$(xxp) + "," + I2A$(yyp)
END SUB

SUB HelpScreen
    COLOR 13: CLS : center 1, "Calendar HELP"
    LOCATE 3, 1: COLOR 30

    PRINT "This calendar will allow you to flip"
    PRINT "through months and years using high-"
    PRINT "contrast colors with a large font."
    PRINT "Use the following keys while"
    PRINT "looking at the calendar:"
    PRINT     'Line 8
    PRINT
    PRINT "   UP & DOWN   Forward and back 1 year"
    PRINT "LEFT & RIGHT   Next and previous month"
    PRINT "      ESCAPE   Quit the program"
    PRINT     'L13
    PRINT "           C   Change the color scheme"
    PRINT
    PRINT "           D   Use the Day counter"
    PRINT
    PRINT "           H   Display upcoming holidays"
    PRINT
    PRINT "           T   Show calendar for Today"
    
    COLOR 14: LOCATE 23, 1: PRINT "Read CALENDAR.TXT       Press any key...": SLEEP
END SUB

FUNCTION I2A$ (h)
    I2A$ = LTRIM$(RTRIM$(STR$(h)))
 END FUNCTION

SUB InitArrays
     Month$(1) = "January":  Month$(2) = "February":  Month$(3) = "March"
     Month$(4) = "April":    Month$(5) = "May":       Month$(6) = "June"
     Month$(7) = "July":     Month$(8) = "August":    Month$(9) = "September"
    Month$(10) = "October": Month$(11) = "November": Month$(12) = "December"

    day$(1) = "Sunday":    day$(2) = "Monday":   day$(3) = "Tuesday"
    day$(4) = "Wednesday": day$(5) = "Thursday": day$(6) = "Friday"
    day$(7) = "Saturday"
END SUB

SUB jfont (a$, c, XCoordinate, YCoordinate, Size)
    Size = INT(Size)             'No decimals allowed!
    IF Size > 10 THEN Size = 10  'Check and fix invalid size calls
    IF Size < 1 THEN Size = 1    'likewise for <.

    YCoordinate = INT(YCoordinate / Size)     'Prevent ballooning of YCoordinates
                                              'that is a result of using
                                              'size values larger than 1 for size

    'Enter 999 as XCoordinate for Centered text...
    IF XCoordinate = 999 THEN XCoordinate = 160 - (LEN(a$) * 3 * Size)

    StartX = XCoordinate               'set Starting X-Val for character drawing

    FOR E = 1 TO LEN(a$)
        B$ = MID$(a$, E, 1)     ' read each character of the string
        a = ASC(B$)             ' get ASCII values of each character
        FOR X = 1 TO 8
            FOR y = 1 TO 6
                SELECT CASE charset(a, X, y)      'use ASCII value (a) to point
                                                  ' to the correct element in
                                                  ' the array
                    CASE 0: Col = 0               'Don't draw pixel
                    CASE 1: Col = c               'Draw pixel
                    CASE ELSE                     'Error!
                        CLS
                        SCREEN 9
                        BEEP
                        COLOR 4
                        PRINT "Error in FONTDATA.DAT"
                        PRINT "This could be the result of unauthorized tampering with the file."
                        PRINT "To fix: edit FONTDATA.DAT; make sure only 1's, 0's, and commas are there."
                        PRINT
                        PRINT "If you are still having trouble..."
                        PRINT "Send email to: davison_soft@geocities.com"
                        PRINT "to obtain a fresh copy of the file"
                        PRINT
                        PRINT "Program will now continue, but may exhibit erratic behavior..."
                        SLEEP
                        SCREEN 13
                END SELECT
                IF Col <> 0 THEN          'Draw a pixel!
                    LINE (StartX + pixelsright, (X + YCoordinate) * Size)-(StartX + pixelsright + (Size - 1), ((X + YCoordinate) * Size) + (Size - 1)), Col, BF
                END IF
                StartX = StartX + Size    'Set starting X-value for next pixel
            NEXT y
            StartX = XCoordinate          'reset StartX for next line of pixels
        NEXT X
        pixelsright = pixelsright + (6 * Size)   'add pixels for next character
    NEXT E
END SUB

SUB LoadColors
    bkg = 134: numbers = 44: gridlines = 15: FEC = 1

    OPEN "calendar.dat" FOR INPUT AS #1
    IF fileerror = 1 THEN
        OPEN "calendar.dat" FOR APPEND AS #1
        PRINT #1, bkg, numbers, gridlines
        CLOSE #1
    ELSE
        INPUT #1, bkg
        INPUT #1, numbers
        INPUT #1, gridlines
        CLOSE #1
    END IF
    FEC = 0
END SUB

SUB LoadFont
    SCREEN 13: CLS : GLocate StartX, StartY
    FI$ = "Fontdata.dat": OPEN "fontdata.dat" FOR INPUT AS #9
    FI$ = "DayCount.exe": OPEN "Daycount.exe" FOR INPUT AS #4: CLOSE #4
    RANDOMIZE TIMER

    FOR a = 1 TO 126
        FOR X = 1 TO 8
            FOR y = 1 TO 6
                INPUT #9, B
                charset(a, X, y) = B        'loads font data into 3-D array.
            NEXT y
        NEXT X
    NEXT a
    CLOSE

    PALETTE 200, 0
END SUB

SUB LoadHolidays
    OPEN "Holidays.dat" FOR RANDOM AS #2 LEN = 39
    NOH = LOF(2) / 39
    IF LOF(2) = 0 THEN
        SOUND 1600, 4
        PRINT "The holiday information database, "
        PRINT "HOLIDAYS.DAT was not found."
        CLOSE #2:  KILL "holidays.dat"
        SYSTEM
    END IF
END SUB

FUNCTION NumberOfDays (mon, yr)
    SELECT CASE mon
        CASE 1: NumberOfDays = 31
        CASE 2: IF yr MOD 4 = 0 THEN NumberOfDays = 29 ELSE NumberOfDays = 28
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

SUB NumberSquare (sn)
    X = 0: y = 0

    SELECT CASE sn
        CASE 1 TO 7: y = 35
        CASE 8 TO 14: y = 60
        CASE 15 TO 21: y = 85
        CASE 22 TO 28: y = 110
        CASE 29 TO 35: y = 135
        CASE 36 TO 42: y = 160
    END SELECT

    Col = sn
    DO UNTIL (Col - 7) < 1
        Col = Col - 7
    LOOP

    SELECT CASE Col
        CASE 1: X = 50
        CASE 2: X = 85
        CASE 3: X = 120
        CASE 4: X = 155
        CASE 5: X = 190
        CASE 6: X = 225
        CASE 7: X = 260
    END SELECT

    IF onday > 9 THEN X = X - 6
    IF Month = currentmonth AND onday = currentday AND year = currentyear THEN clr = 36 ELSE clr = numbers
    jfont I2A$(onday), clr, X, y, 2
END SUB

SUB plotmonth
    currentmonth = VAL(LEFT$(DATE$, 2))
      currentday = VAL(MID$(DATE$, 4, 2))
     currentyear = VAL(RIGHT$(DATE$, 4))
    day$ = DayOfWeek$(currentmonth, currentday, currentyear)

   CLS : DrawGrid
   onday = 1: NumberSquare startcol

    FOR I = startcol + 1 TO (startcol + NumberOfDays(Month, year) - 1)
        onday = onday + 1
        NumberSquare I
    NEXT I

    jfont Month$(Month) + ", " + I2A$(year), 78, 999, 0, 1
    jfont "       Sun   Mon   Tue   Wed   Thu   Fri   Sat", 100, 0, 22, 1
    jfont "For HELP, press F1", 9, 0, 190, 1
    jfont day$ + ", " + Month$(currentmonth) + " " + I2A$(currentday) + ", " + I2A$(currentyear), 100, 145, 190, 1
    jfont CurrentTime$, 100, 270, 0, 1
END SUB

SUB RangeCheck
    IF Month = 0 THEN Month = 12: year = year - 1
    IF Month = 13 THEN Month = 1: year = year + 1

    IF year < 1753 THEN
        SOUND 500, 2: SOUND 0, 1: SOUND 250, 2
        year = 1753
    END IF
END SUB

FUNCTION RowsNeeded
    d$ = DayOfWeek$(Month, 1, year)
    NOD = NumberOfDays(Month, year)

    IF d$ = "Sunday" AND NOD = 28 THEN
        RowsNeeded = 4
    ELSEIF d$ = "Friday" AND NOD = 31 THEN
        RowsNeeded = 6
   ELSEIF d$ = "Saturday" THEN
        IF Month = 2 THEN
            RowsNeeded = 5
        ELSE
            RowsNeeded = 6
        END IF
    ELSE
        RowsNeeded = 5
    END IF
END FUNCTION

SUB SaveColors
    OPEN "calendar.dat" FOR OUTPUT AS #1
    PRINT #1, bkg; numbers; gridlines
    CLOSE #1
    SYSTEM
END SUB

SUB SetColors

    Up$ = CHR$(0) + CHR$(72): Dn$ = CHR$(0) + CHR$(80): Lt$ = CHR$(0) + CHR$(75)
    Rt$ = CHR$(0) + CHR$(77): Escape$ = CHR$(27): fmt$ = "###"

    COLOR 14: CLS : center 2, "Change Calendar Colors"
    LOCATE 5, 1: COLOR 15
    PRINT "Left & Right   Change colors"
    PRINT "  Up & Down    Switch between elements"
    PRINT "     R         Reset to default colors"
    PRINT "  ESCape       Return to calendar"
    
     COLOR 78: opt = 1
     LOCATE 12, 12: PRINT "Background"
     LOCATE 14, 12: PRINT "Date numbers"
     LOCATE 16, 12: PRINT "Grid lines"
     Arrow
     GOTO ColorChange:

CCI:
    DO
        K$ = UCASE$(INKEY$)
        SELECT CASE K$
            CASE IS = Up$: opt = opt - 1: Arrow: GOTO CCI:
            CASE IS = Dn$: opt = opt + 1: Arrow: GOTO CCI:
            CASE IS = Lt$:
                IF opt = 1 THEN bkg = bkg - 1
                IF opt = 1 AND bkg = numbers THEN bkg = bkg - 1
                IF opt = 2 THEN numbers = numbers - 1
                IF opt = 2 AND bkg = numbers THEN numbers = numbers - 1
                IF opt = 3 THEN gridlines = gridlines - 1

                IF bkg > 15 AND bkg < 21 THEN bkg = 15
                IF numbers > 15 AND numbers < 21 THEN numbers = 15
                IF gridlines > 15 AND gridlines < 21 THEN gridlines = 15
                GOTO ColorChange:
            CASE IS = Rt$
                IF opt = 1 THEN bkg = bkg + 1
                IF opt = 1 AND bkg = numbers THEN bkg = bkg + 1
                IF opt = 2 THEN numbers = numbers + 1
                IF opt = 2 AND bkg = numbers THEN numbers = numbers + 1
                IF opt = 3 THEN gridlines = gridlines + 1

                IF bkg > 15 AND bkg < 21 THEN bkg = 21
                IF numbers > 15 AND numbers < 21 THEN numbers = 21
                IF gridlines > 15 AND gridlines < 21 THEN gridlines = 21

                GOTO ColorChange:
            CASE IS = CHR$(27): EXIT SUB
            CASE IS = "R": bkg = 134: numbers = 44: gridlines = 15: GOTO ColorChange:
            END SELECT
        LOOP

ColorChange:
    IF gridlines > 175 THEN gridlines = 0
    IF gridlines < 0 THEN gridlines = 175
    IF bkg > 175 THEN bkg = 0
    IF bkg < 0 THEN bkg = 175
    IF numbers > 175 THEN numbers = 0
    IF numbers < 0 THEN numbers = 175
    IF bkg + 1 = gridlines OR bkg - 1 = gridlines THEN LINE (150, 140)-(200, 190), 0, BF

    LOCATE 12, 28: PRINT USING fmt$; bkg
    LOCATE 14, 28: PRINT USING fmt$; numbers
    LOCATE 16, 28: PRINT USING fmt$; gridlines
    
    GLocate 135, 145: DRAW "C" + I2A$(gridlines) + " R50 d40 l50 u40"
    PAINT STEP(5, 5), bkg, gridlines
    IF currentday < 10 THEN z = 126 ELSE z = 143
    jfont I2A$(currentday), numbers, z, 153, 3
    
    GOTO CCI:
END SUB

SUB ShowHolidays
    Up$ = CHR$(0) + CHR$(72): Dn$ = CHR$(0) + CHR$(80): Lt$ = CHR$(0) + CHR$(75)
    Rt$ = CHR$(0) + CHR$(77): Escape$ = CHR$(27): enter$ = CHR$(13): spc$ = " "
    
HolBegin:
    COLOR 78: CLS : center 2, "Holidays for " + Month$(Month) + ", " + I2A$(year)

    LOCATE 5, 1:
        PRINT "   Date      Holiday": COLOR 14
        PRINT "   ÄÄÄÄ      ÄÄÄÄÄÄÄ "
    Holfmt$ = "\ \ \ \ ##   \                         \"

    COLOR 15
    IF Month = 8 THEN COLOR 15: center 9, "There are no holidays in August.": GOTO KeyInstructions:

PlotHolidays:
    FOR chn = 1 TO NOH
        GET #2, chn, Holiday
        SELECT CASE Holiday.Month
            CASE IS < Month
                GOTO Eohl:
            CASE IS > Month
                EXIT FOR
            CASE ELSE
                IF Holiday.day <> 0 THEN
                    d = Holiday.day
                ELSE
                    d = FindDate(Month, year, Holiday.placeinst)
                END IF
                PRINT USING Holfmt$; LEFT$(DayOfWeek(Month, d, year), 3); LEFT$(Month$(Month), 3); d; Holiday.name
            END SELECT
Eohl:
        NEXT chn

KeyInstructions:
    COLOR 10:  center 22, "Use ARROW KEYS to adjust month and year"
    center 23, "Press Escape to return to the calendar"

HolAdjust:
    K$ = UCASE$(INKEY$)
    SELECT CASE K$
        CASE "": GOTO HolAdjust
        CASE Up$: year = year + 1
        CASE Dn$: year = year - 1
        CASE Lt$: Month = Month - 1
        CASE Rt$:  Month = Month + 1
        CASE "T": IF currentmonth = Month AND currentyear = year THEN GOTO HolAdjust ELSE Today
        CASE Escape$, enter$, spc$: EXIT SUB
        CASE ELSE: GOTO HolAdjust
    END SELECT

HolChange:
    RangeCheck
    GOTO HolBegin:
END SUB

SUB TADdisplay
    IF td$ = "" THEN
        td$ = CurrentTime$
        jfont CurrentTime$, 100, 270, 0, 1
    ELSEIF td$ <> "" AND td$ <> CurrentTime$ THEN
        td$ = CurrentTime$
        LOCATE 1, 35: PRINT "      "
        jfont CurrentTime$, 100, 270, 0, 1
    END IF
    
    day$ = DayOfWeek$(currentmonth, currentday, currentyear)
    IF dd$ = "" THEN
        dd$ = DATE$
        jfont day$ + ", " + Month$(currentmonth) + " " + I2A$(currentday) + ", " + I2A$(currentyear), 100, 145, 190, 1
    ELSEIF dd$ <> "" AND dd$ <> DATE$ THEN
        dd$ = DATE$
        plotmonth
        jfont day$ + ", " + Month$(currentmonth) + " " + I2A$(currentday) + ", " + I2A$(currentyear), 100, 145, 190, 1
    END IF

    IF td$ = "" THEN
        td$ = CurrentTime$
        jfont CurrentTime$, 100, 270, 0, 1
    ELSEIF td$ <> "" AND td$ <> CurrentTime$ THEN
        td$ = CurrentTime$
        LOCATE 1, 35: PRINT "      "
        jfont CurrentTime$, 100, 270, 0, 1
    END IF
END SUB

SUB Today
   Month = VAL(LEFT$(DATE$, 2))
   year = VAL(RIGHT$(DATE$, 4))
END SUB

