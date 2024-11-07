DECLARE SUB InitArrays ()
DECLARE SUB Today ()
DECLARE FUNCTION datefix$ (doe$)
DECLARE FUNCTION DAYOFWEEK$ (m, d, y)
DECLARE FUNCTION I2a$ (h)
DECLARE FUNCTION NumberOfDays ()
DECLARE FUNCTION replace$ (text$, LookFor$, ReplaceWith$)
COMMON SHARED month, day, year
DIM SHARED day$(7), month$(12), wd$(3)

CLS
InitArrays
d$ = "1-1-1753"
month = 1: day = 1: year = 1753

OPEN "Friday13.txt" FOR OUTPUT AS #1
OPEN "Occur.txt" FOR OUTPUT AS #2
PRINT #1, "Friday the 13th will happen on these dates,"
PRINT #1, "starting from "; d$
PRINT #1, STRING$(75, 196)
PRINT #2, "Friday the 13th will happen..."
PRINT #2, STRING$(75, 196)

COLOR 10: CLS
DO UNTIL INKEY$ = CHR$(27)
    day = day + 1
    IF day > NumberOfDays THEN day = 1: month = month + 1
    IF month > 12 THEN
        SELECT CASE inyear
            CASE IS = 1: PRINT #2, USING " Once       in #####"; year
            CASE IS = 2: PRINT #2, USING "Twice       in #####"; year
              CASE ELSE: PRINT #2, USING "#,### times in #####"; inyear; year
        END SELECT
        month = 1: day = 1: year = year + 1:  inyear = 0: totalyears = totalyears + 1
    END IF
    day$ = DAYOFWEEK$(month, day, year)
    fu$ = day$ + ", " + month$(month) + " " + I2a$(day) + ", " + I2a$(year)
    IF day$ = "Friday" AND day = 13 THEN inyear = inyear + 1: PRINT fu$: PRINT #1, fu$
LOOP

PRINT #1, STRING$(75, 196): PRINT #2, STRING$(75, 196)
PRINT #1, ""
PRINT #1, "Now you have "; USING "###,###"; totalyears; : PRINT #1, " years of Friday the 13th statistics!"

CLOSE #1, #2


FUNCTION datefix$ (doe$)
    IF LEN(doe$) < 6 THEN datefix$ = "ERROR - valid date not passed to function"
    doe$ = replace$(doe$, "/", "-")

    WordSep$ = "-"   'this is what separates each word/part
    LOS = LEN(doe$): wd = 1

    FOR LTR = 1 TO LOS
        CH$ = MID$(doe$, LTR, 1)
        SELECT CASE CH$
            CASE IS = WordSep$: wd$(wd) = WSF$: wd = wd + 1: WSF$ = ""
            CASE ELSE:  WSF$ = WSF$ + CH$
        END SELECT
    NEXT LTR

    wd$(wd) = WSF$

    IF LEN(wd$(1)) = 1 THEN wd$(1) = "0" + wd$(1)
    IF LEN(wd$(2)) = 1 THEN wd$(2) = "0" + wd$(2)
    CY$ = MID$(DATE$, 7, 2)
    IF LEN(wd$(3)) = 1 THEN datefix$ = "INVALID YEAR - MUST BE 2 OR 4 DIGITS!"
    IF LEN(wd$(3)) = 2 THEN wd$(3) = CY$ + wd$(3)
    datefix$ = wd$(1) + "-" + wd$(2) + "-" + wd$(3)
END FUNCTION

FUNCTION DAYOFWEEK$ (m, d, y)
    k = INT(.6 + (1 / m)): L = y - k: O = m + 12 * k: P = L / 100: z1 = INT(P / 4)
    z2 = INT(P): z3 = INT((5 * L) / 4): z4 = INT(13 * (O + 1) / 5):
    z = z4 + z3 - z2 + z1 + d - 1: z = z - (7 * INT(z / 7))
    z = z + 1: startcol = z: DAYOFWEEK$ = day$(z)

END FUNCTION

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB InitArrays
    month$(1) = "January": month$(2) = "Feburary":   month$(3) = "March"
     month$(4) = "April":   month$(5) = "May":        month$(6) = "June"
     month$(7) = "July":    month$(8) = "August":     month$(9) = "September"
    month$(10) = "October": month$(11) = "November": month$(12) = "December"

    day$(1) = "Sunday": day$(2) = "Monday": day$(3) = "Tuesday"
    day$(4) = "Wednesday": day$(5) = "Thursday": day$(6) = "Friday": day$(7) = "Saturday"
END SUB

FUNCTION NumberOfDays
    SELECT CASE month
        CASE 1: NumberOfDays = 31
        CASE 2: IF year MOD 4 = 0 THEN NumberOfDays = 29 ELSE NumberOfDays = 28
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

FUNCTION replace$ (text$, LookFor$, ReplaceWith$)

'   check for null original string, not in at all, or equal
    IF (text$ = "") OR (INSTR(text$, LookFor$) < 1) OR (text$ = ReplaceWith$) OR LEN(text$) < LEN(LookFor$) THEN
       replace$ = text$
       EXIT FUNCTION
    END IF

    new$ = ""

    LengthOfReplacement% = LEN(ReplaceWith$)
    LengthOfText% = LEN(text$)
    LengthOfStringToLookFor% = LEN(LookFor$)

    i% = 1
    WHILE i% <= LengthOfText% - LengthOfStringToLookFor% + 1
        IF MID$(text$, i%, LengthOfStringToLookFor%) = LookFor$ THEN
           new$ = new$ + ReplaceWith$
           i% = i% + LengthOfStringToLookFor%
        ELSE
           new$ = new$ + MID$(text$, i%, 1)
           i% = i% + 1
        END IF
    WEND

    replace$ = new$

END FUNCTION

SUB Today
   month = VAL(LEFT$(DATE$, 2))
   day = VAL(MID$(DATE$, 4, 2))
    year = VAL(RIGHT$(DATE$, 4))
END SUB

