DECLARE SUB calculateRange ()
DECLARE SUB center (Row, Text$)
DECLARE SUB clearlines (t, b, c)
DECLARE FUNCTION CurrentTime$ (ti$)
DECLARE FUNCTION DateFix$ (doe$)
DECLARE FUNCTION DAYOFWEEK$ (m%, d%, y%)
DECLARE SUB DisplayResults ()
DECLARE SUB GetDates ()
DECLARE FUNCTION I2a$ (h%)
DECLARE FUNCTION InputString$ (Row%, Column%, InputField$, Foreground%, Background%, ValidCharacters$, ReturnMode%, EntryMode%, CaseMode%)
DECLARE SUB InitArrays ()
DECLARE SUB Instructions ()
DECLARE FUNCTION NumberOfDays (mtt, ytt)
DECLARE FUNCTION plural$ (ntt, si$, pl$)
DECLARE FUNCTION Replace$ (Text$, LookFor$, ReplaceWith$)
DECLARE FUNCTION ReRun ()
DECLARE SUB Screen2File (Fi$, top%, bottom%, left%, right%)
DECLARE FUNCTION TimeFix$ (ti$)
COMMON SHARED months, Weeks, days, Years, TotalDays, hrs%, min%, Hours, minutes, cm

TYPE DateClass
    month AS INTEGER
      day AS INTEGER
     year AS INTEGER
     time AS STRING * 5
END TYPE '12
DIM SHARED start AS DateClass, endd AS DateClass, day$(7), month$(12)

    InitArrays
    Instructions
ReStart:
    GetDates
    calculateRange
    DisplayResults
    IF ReRun = 1 THEN GOTO ReStart ELSE SYSTEM

SUB calculateRange
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

SUB center (Row, Text$)
    Col = 21 - LEN(Text$) / 2: LOCATE Row, Col: PRINT Text$
END SUB

SUB clearlines (t, b, c)
    FOR R = t TO b
        LOCATE R, c, 0: PRINT SPACE$(40 - c)
    NEXT R
END SUB

FUNCTION CurrentTime$ (ti$)
    c = INSTR(ti$, ":")
    IF c > 0 THEN
        h% = VAL(LEFT$(ti$, c - 1))
        m% = VAL(MID$(ti$, c + 1))
    ELSE
        h% = VAL(ti$): min% = 0
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
    DIM pt$(3)
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

FUNCTION DAYOFWEEK$ (m%, d%, y%)
    k = INT(.6 + (1 / m%)): L = y% - k: O = m% + 12 * k: p = L / 100: z1 = INT(p / 4)
    z2 = INT(p): z3 = INT((5 * L) / 4): z4 = INT(13 * (O + 1) / 5)
    z = z4 + z3 - z2 + z1 + d% - 1: z = z - (7 * INT(z / 7))
    z = z + 1: DAYOFWEEK$ = day$(z)
END FUNCTION

SUB DisplayResults
    COLOR 13: CLS : fmt$ = "          ###,### "
              LOCATE 2, 1: PRINT "Start:": LOCATE 5, 1: PRINT "  End:"
    COLOR 10: LOCATE 2, 10: PRINT DAYOFWEEK$(start.month, start.day, start.year); ", "; month$(start.month); " "; I2a$(start.day); ", "; I2a$(start.year)
              LOCATE 3, 10: PRINT CurrentTime$(start.time);
              IF start.time <> "0:00 " THEN PRINT "  ("; start.time; ")"
              LOCATE 5, 10: PRINT DAYOFWEEK$(endd.month, endd.day, endd.year); ", "; month$(endd.month); " "; I2a$(endd.day); ", "; I2a$(endd.year)
              LOCATE 6, 10: PRINT CurrentTime$(endd.time);
              IF endd.time <> "0:00 " THEN PRINT "  ("; endd.time; ")"

              LOCATE 7, 1: COLOR 15: PRINT STRING$(40, "Í")
              LOCATE 10, 1
              
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
    Screen2File "Daycount.txt", 2, 15, 1, 40

    COLOR 9: center 19, "Press ENTER to rerun the program,"
    center 20, "or ESCape to quit:"
END SUB

SUB GetDates
    COLOR 10: CLS
    center 1, "Enter the STARTING & ENDING dates"
    center 3, "Dates:  1/30/06     6-15-2000    "
    center 4, "        2/13/1980   9/11/01      "
    center 6, "Times:  11:05a      15:36        "
    center 7, "        02:00       3:57p        "

    VIEW PRINT 9 TO 23

First:
    CLS : COLOR 13: LOCATE 9, 1: PRINT "STARTING:"
    DO UNTIL INKEY$ = "": LOOP
    
    st$ = InputString$(9, 12, DATE$, 14, 9, "0123456789-/", 5, 1, 1)
    st$ = DateFix$(st$)
    IF LEN(st$) < 10 THEN
        COLOR 13, 8: CLS : GOTO First:
    ELSEIF LEN(st$) > 10 THEN
        COLOR 12, 8: center 16, st$: LOCATE , , 0: SLEEP 3: CLS : st$ = "": GOTO First:
    ELSE
        COLOR 15, 8: LOCATE 9, 12: PRINT st$
        start.month = VAL(LEFT$(st$, 2))
        start.day = VAL(MID$(st$, 4, 2))
        start.year = VAL(RIGHT$(st$, 4))
    END IF
    
time1:
    COLOR 13, 8: LOCATE 10, 1: PRINT "    TIME:"
    bt$ = InputString$(10, 12, CurrentTime$(TIME$) + SPACE$(6 - LEN(CurrentTime$(TIME$))), 14, 9, "0123456789:apAP", 5, 1, 1)
    bt$ = TimeFix$(bt$)
    IF LEN(bt$) > 10 THEN
        COLOR 12, 8: center 16, bt$: SLEEP 3: bt$ = "": clearlines 16, 23, 1: GOTO time1:
    ELSE
        COLOR 15, 8: LOCATE 10, 12: PRINT bt$ + SPACE$(6 - LEN(bt$))
        Hours = 24 - hrs%: minutes = 60 - min%
        IF minutes = 60 THEN
            minutes = 0
        ELSE
            Hours = Hours - 1
        END IF

        start.time = bt$
    END IF
    
    VIEW PRINT 12 TO 23

second:
    LOCATE 12, 1: COLOR 13, 8: PRINT "  ENDING:"
    IF st$ = DATE$ THEN DS$ = SPACE$(10) ELSE DS$ = DATE$
    end$ = InputString$(12, 12, DS$, 14, 9, "0123456789-/", 5, 1, 1)
    end$ = DateFix$(end$)
    IF LEN(end$) < 10 THEN
        COLOR 13, 8: CLS : GOTO second:
    ELSEIF LEN(end$) > 10 THEN
        COLOR 12, 8: center 16, end$: LOCATE , , 0: SLEEP 3: CLS : end$ = "": GOTO second:
    ELSE
        COLOR 15, 8: LOCATE 12, 12: PRINT end$
        endd.month = VAL(LEFT$(end$, 2))
        endd.day = VAL(MID$(end$, 4, 2))
        endd.year = VAL(RIGHT$(end$, 4))
    END IF

time2:
    COLOR 13, 8: LOCATE 13, 1: PRINT "    TIME:"
    IF st$ = DATE$ THEN DS$ = SPACE$(6) ELSE DS$ = CurrentTime$(TIME$)
    et$ = InputString$(13, 12, DS$ + SPACE$(6 - LEN(CurrentTime$(TIME$))), 14, 9, "0123456789:apAP", 5, 1, 1)
    et$ = TimeFix$(et$)
    IF LEN(et$) > 10 THEN
        COLOR 12, 8: center 16, et$: SLEEP 3: et$ = "": clearlines 16, 23, 1: GOTO time2:
    ELSE
        COLOR 15, 8: LOCATE 13, 12: PRINT et$ + SPACE$(5)
        Hours = Hours + hrs%: minutes = minutes + min%
        endd.time = et$

min:    IF minutes >= 60 THEN Hours = Hours + 1: minutes = minutes - 60: GOTO min:
hou:    IF Hours >= 24 THEN TotalDays = Totalday + 1: Hours = Hours - 24: GOTO hou
    END IF
    
    VIEW PRINT
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

FUNCTION InputString$ (Row%, Column%, InputField$, Foreground%, Background%, ValidCharacters$, ReturnMode%, EntryMode%, CaseMode%)

'*******************************************************************************
'*   this function inputs a string of the desired length and desired characters*
'*   at the selected row, column and color                                     *
'*******************************************************************************

'   parameter list:
'   Row% - line# on screen to input string
'   Column% - column on screen to input string
'   InputField$ - the original string to edit
'   Foreground% - character color of input field
'   Background% - background color of input field
'   ValidCharacters$ - list of allowable input characters: "" = all allowed
'   ReturnMode% - way to return string:
'      1: return entire field as-is
'      2: return field less any trailing blanks
'      3: return field less any leading blanks
'      4: return field less both leading and trailing blanks
'      5: return field with all blanks removed
'      6: left justify and kill blanks between 1st and last char
'      7: right justify and kill inner blanks
'   EntryMode% - way to termin%ate input:
'      1: termin%ates only when enter is pressed
'      2: termin%ates after cursor goes past last character in field
'   CaseMode% - forces uppercase, lowercase or no preference
'      1: accept as entered
'      2: forces upper case
'      3: forces lower case

    True% = 1                             ' logical true
    False% = 0                            ' logical false

    EnterKey$ = CHR$(13)                  ' signifies end of entry
    ESCape$ = CHR$(27)                    ' emergency exit from function
    EraseToEOF$ = CHR$(20)                ' ^T erase from cursor to EOF
    RestoreField$ = CHR$(18)              ' ^R restore original field
    EraseField$ = CHR$(25)                ' ^Y erase entire field
    BackSpace$ = CHR$(8)                  ' dragging, destructive backspace
    RightArrow$ = "M"                     ' input cursor right
    LeftArrow$ = "K"                      ' input cursor left
    InsertKey$ = "R"                      ' insert mode toggle
    DeleteKey$ = "S"                      ' character delete
    HomeKey$ = "G"                        ' input cursor start of field
    EndKey$ = "O"                         ' input cursor after last char

    InputFinished% = False%               ' set to true on enter or escape
    InsertMode% = False%                  ' start off in insert off mode

    OriginalField$ = InputField$          ' for ^R restore original field
    Length% = LEN(InputField$)            ' total input field length
    CurrentColumn% = Column%              ' cursor at first entry column
    CursorPosition% = 1                   ' 1st position in entry string
    EndColumn% = Column% + Length% - 1    ' last column in entry string

    COLOR Foreground%, Background%        ' set specified colors
    LOCATE Row%, Column%, 0               ' locate cursor
    PRINT InputField$;                    ' display original field
    LOCATE Row%, Column%, 1, 6, 7         ' locate at first character

    WHILE InputFinished% = False%         ' main loop

       InputKey$ = INKEY$                 ' get a keystroke if present
       EditKey$ = MID$(InputKey$, 2, 1)   ' editing key pressed?

       IF EditKey$ <> "" THEN

          SELECT CASE EditKey$

             CASE RightArrow$
                IF CurrentColumn% <= EndColumn% THEN
                   CurrentColumn% = CurrentColumn% + 1
                   CursorPosition% = CursorPosition% + 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE LeftArrow$
                IF CurrentColumn% > Column% THEN
                   CurrentColumn% = CurrentColumn% - 1
                   CursorPosition% = CursorPosition% - 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE InsertKey$
                IF InsertMode% = True% THEN
                   LOCATE Row%, CurrentColumn%, 1, 6, 7
                   InsertMode% = False%
                ELSE
                   LOCATE Row%, CurrentColumn%, 1, 3, 7
                   InsertMode% = True%
                END IF

             CASE DeleteKey$
                IF CurrentColumn% <= EndColumn% THEN
                   FOR Index% = CursorPosition% TO Length% - 1
                       MID$(InputField$, Index%, 1) = MID$(InputField$, Index% + 1, 1)
                   NEXT Index%
                   MID$(InputField$, Length%, 1) = " "
                   LOCATE Row%, Column%, 0
                   PRINT InputField$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE HomeKey$
                IF CursorPosition% > 1 THEN
                   CurrentColumn% = Column%
                   CursorPosition% = 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE EndKey$
                IF CursorPosition% < Length% THEN
                   FOR Index% = Length% TO 1 STEP (-1)
                       IF MID$(InputField$, Index%, 1) <> " " THEN
                          EXIT FOR
                       END IF
                   NEXT Index%
                   CursorPosition% = Index% + 1
                   CurrentColumn% = Column% + Index%
                   LOCATE Row%, CurrentColumn%, 1
                END IF

          END SELECT

       ELSE

          SELECT CASE InputKey$

             CASE ESCape$
                InputString$ = InputKey$
                EXIT FUNCTION

             CASE BackSpace$
                IF CurrentColumn% > Column% THEN
                   N$ = ""
                   FOR Index% = 1 TO CursorPosition% - 2
                       N$ = N$ + MID$(InputField$, Index%, 1)
                   NEXT Index%
                   FOR Index% = CursorPosition% TO Length%
                       N$ = N$ + MID$(InputField$, Index%, 1)
                   NEXT Index%
                   InputField$ = LEFT$(N$ + SPACE$(Length%), Length%)
                   CurrentColumn% = CurrentColumn% - 1
                   CursorPosition% = CursorPosition% - 1
                   LOCATE Row%, Column%, 0
                   PRINT InputField$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE EraseField$
                InputField$ = SPACE$(Length%)
                LOCATE Row%, Column%, 0
                PRINT InputField$;
                CursorPosition% = 1
                CurrentColumn% = Column%
                LOCATE Row%, Column%, 1

             CASE EraseToEOF$
                IF CurrentColumn% <= EndColumn% THEN
                   MID$(InputField$, CursorPosition%, Length% - CursorPosition% + 1) = SPACE$(Length% - CursorPosition% + 1)
                   LOCATE Row%, Column%
                   PRINT InputField$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE RestoreField$
                InputField$ = OriginalField$
                LOCATE Row%, Column%, 0
                PRINT InputField$;
                CursorPosition% = 1
                CurrentColumn% = Column%
                LOCATE Row%, Column%, 1

             CASE EnterKey$
                InputFinished% = True%

             CASE ELSE

                ValidKey% = False%
'               null string for valid characters means all input accepted
                IF ValidCharacters$ = "" OR INSTR(ValidCharacters$, UCASE$(InputKey$)) > 0 THEN
                   ValidKey% = True%
                END IF

                IF ValidKey% = True% AND InputKey$ <> "" AND CurrentColumn% <= EndColumn% THEN

                   SELECT CASE CaseMode%
                      CASE 1
                         ' do nothing, accept as entered
                      CASE 2
                         InputKey$ = UCASE$(InputKey$)
                      CASE 3
                         InputKey$ = LCASE$(InputKey$)
                   END SELECT

                   SELECT CASE InsertMode%
                      CASE True%
                         InputField$ = LEFT$(InputField$, CursorPosition% - 1) + InputKey$ + RIGHT$(InputField$, Length% - CursorPosition% + 1)
                         InputField$ = LEFT$(InputField$, Length%)
                         LOCATE Row%, Column%
                         PRINT InputField$;
                      CASE False%
                         PRINT InputKey$;
                         MID$(InputField$, CursorPosition%, 1) = InputKey$
                   END SELECT

                   CursorPosition% = CursorPosition% + 1
                   CurrentColumn% = CurrentColumn% + 1
                   LOCATE Row%, CurrentColumn%, 1

'                  check entry mode to see if end of field entry termin%ates entry
                   IF CurrentColumn% > EndColumn% AND EntryMode% = 2 THEN
                      InputFinished% = True%
                   END IF

                END IF

          END SELECT

       END IF

    WEND

'   return entered string appropriately

    SELECT CASE ReturnMode%

       CASE 1     ' return entire field
          InputString$ = InputField$

       CASE 2     ' return field less any trailing blanks
          InputString$ = RTRIM$(InputField$)

       CASE 3     ' return field less any leading blanks
          InputString$ = LTRIM$(InputField$)

       CASE 4     ' return field less both leading and trailing blanks
          InputString$ = LTRIM$(RTRIM$(InputField$))

       CASE 5     ' return field with all blanks removed
          N$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(InputField$, Index%, 1) <> " " THEN
                 N$ = N$ + MID$(InputField$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = N$

       CASE 6     ' left justify and kill blanks between 1st and last char
          N$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(InputField$, Index%, 1) <> " " THEN
                 N$ = N$ + MID$(InputField$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = RIGHT$(N$ + SPACE$(Length%), Length%)

       CASE 7     ' right justify and kill inner blanks
          N$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(InputField$, Index%, 1) <> " " THEN
                 N$ = N$ + MID$(InputField$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = RIGHT$(SPACE$(Length%) + N$, Length%)

    END SELECT
END FUNCTION

SUB Instructions
    WIDTH 40, 25: COLOR 9: CLS
    center 2, "DayCount"
    COLOR 14: center 3, "By Charles Martin"
    COLOR 15: LOCATE 7, 1

    PRINT "This program will tell you the length"
    PRINT "of time between two dates, and times. "
    PRINT
    PRINT "EXAMPLE:  Your favorite TV show will"
    PRINT "start playing on January 9, and today"
    PRINT "is December 14.  How long do you have"
    PRINT "to wait?  This is the kind of calculat-"
    PRINT "ions that the software makes.  "
    COLOR 14: center 18, "Press any key...": SLEEP
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
'*  Using "" as ReplaceWith$ effectively elimin%ates (squeezes out) LookFor$    *
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

    Replace$ = New$
END FUNCTION

FUNCTION ReRun

ron:  LOCATE , , 0
    k$ = UCASE$(INKEY$)
        IF k$ = "Y" OR k$ = CHR$(13) THEN ReRun = 1: EXIT FUNCTION
        IF k$ = "N" OR k$ = CHR$(27) THEN ReRun = 0: EXIT FUNCTION
    GOTO ron:
END FUNCTION

SUB Screen2File (Fi$, top%, bottom%, left%, right%)

END SUB

FUNCTION TimeFix$ (ti$)
    ti$ = UCASE$(ti$)

    IF INSTR(ti$, "A") > 0 THEN
        ap$ = "A"
        ti$ = Replace$(ti$, "A", "")
    ELSEIF INSTR(ti$, "P") > 0 THEN
        ap$ = "P"
        ti$ = Replace$(ti$, "P", "")
    END IF

    c = INSTR(ti$, ":")
    IF c > 0 THEN
        hrs% = VAL(LEFT$(ti$, c))
        min% = VAL(MID$(ti$, c + 1))
    ELSE
        hrs% = VAL(ti$): min% = 0
    END IF

    IF hrs% < 0 OR hrs% > 23 THEN TimeFix$ = "Invalid HOUR:  Range 1 to 12 or 0 to 23": EXIT FUNCTION
    IF min% < 0 OR min% > 59 THEN TimeFix$ = "Invalid MINUTE:  Range is 0 to 59": EXIT FUNCTION
    
    IF ap$ = "" THEN format = 24: GOTO AllDone:
    IF hrs% <= 12 AND ap$ <> "" THEN format = 12
    IF hrs% > 12 AND ap$ <> "" THEN format = 24

    IF format = 12 AND hrs% <> 12 AND ap$ = "P" THEN hrs% = hrs% + 12: ap$ = "P"
    IF ap$ = "A" AND hrs% = 12 THEN hrs% = 0

AllDone:
    tif$ = I2a$(hrs%) + ":"
    IF min% < 10 THEN tif$ = tif$ + "0" + I2a$(min%) ELSE tif$ = tif$ + I2a$(min%)
    TimeFix$ = tif$
END FUNCTION

