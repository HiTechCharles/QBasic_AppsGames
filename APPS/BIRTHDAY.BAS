DECLARE SUB center (row, text$)
DECLARE FUNCTION CurrentDate$ (Style!)
DECLARE SUB dayofweek (M, d, Y)
DECLARE SUB GetName ()
DECLARE SUB mp (k$)
DECLARE SUB pause (PN)
DECLARE SUB PlaySong ()
DECLARE SUB ProcessName ()
COMMON SHARED day$, nam$, nc$

GetName   'gets the person's name
ProcessName

COLOR 9: CLS : LOCATE 2, 1: PRINT "IT'S "; nam$; " BIRTHDAY TODAY,"
COLOR 9: LOCATE 3, 1: PRINT "on "; CurrentDate$(1)
PlaySong  'plays the birthday song

COLOR 15: LOCATE 16, 1: PRINT "Enjoy your birthday, "; nc$; "!!"
SLEEP: SYSTEM

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

FUNCTION CurrentDate$ (Style)

M$ = LEFT$(DATE$, 2): mm = VAL(M$)   'month
d$ = MID$(DATE$, 4, 2): dd = VAL(d$) 'day
Y$ = RIGHT$(DATE$, 4): YY = VAL(Y$)  'year
IF Style = 1 THEN dayofweek mm, dd, YY

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
IF mm < 10 THEN Ms$ = RIGHT$(M$, 1) ELSE Ms$ = M$

SELECT CASE Style
CASE IS = 1: CurrentDate$ = day$ + ", " + month$ + " " + ds$ + ", " + Y$
CASE IS = 2: CurrentDate$ = month$ + " " + ds$ + ", " + Y$
CASE IS = 3: CurrentDate$ = Ms$ + "/" + ds$ + "/" + RIGHT$(Y$, 2)
CASE IS = 4: CurrentDate$ = Ms$ + "/" + ds$ + "/" + Y$
CASE IS = 5: CurrentDate$ = month$ + " " + ds$
END SELECT


END FUNCTION

SUB dayofweek (M, d, Y)
DIM J$(7): J$(1) = "Sunday": J$(2) = "Monday": J$(3) = "Tuesday"
J$(4) = "Wednesday": J$(5) = "Thursday": J$(6) = "Friday": J$(7) = "Saturday"

IF M < 1 OR M > 12 THEN PRINT : PRINT "Month must be between 1 and 12.": SYSTEM
IF d < 1 OR d > 31 THEN PRINT : PRINT "Day must be between 1 and 31.": SYSTEM
IF Y < 1753 THEN PRINT : PRINT "Year must not be prior to 1753.":  SYSTEM
k = INT(.6 + (1 / M)): L = Y - k: O = M + 12 * k: P = L / 100: z1 = INT(P / 4)
z2 = INT(P): z3 = INT((5 * L) / 4): z4 = INT(13 * (O + 1) / 5):
z = z4 + z3 - z2 + z1 + d - 1: z = z - (7 * INT(z / 7))
z = z + 1: day$ = J$(z)
END SUB

SUB GetName
WIDTH 40, 25: COLOR 10: CLS
LOCATE 3, 1: PRINT "Who's birthday is it today?"
COLOR 15: INPUT ">", nam$
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
CASE IS = "c": PLAY "o3l9c":
CASE ELSE: GOTO eos:
END SELECT
eos:
END SUB

SUB pause (PN)
PLAY "P" + LTRIM$(STR$(PN))
END SUB

SUB PlaySong
COLOR 13: : B$ = "HAPPY BIRTHDAY TO YOU":  LOCATE 10, 1
PRINT B$; ","
PLAY "t130": mp "d": pause 24: mp "d": PLAY "t100"
mp "f": pause 16: mp "d"
pause 16: mp "h": pause 16: mp "g"

PRINT B$; "."
pause 4: PLAY "t130": mp "d": pause 24: mp "d": PLAY "t100"
mp "f": pause 16: mp "d"
pause 16: mp "j": pause 16: mp "h"

PRINT "HAPPY BIRTHDAY DEAR "; nc$
pause 4: PLAY "t130": mp "d": pause 24: mp "d": PLAY "t100"
mp "c": pause 16: mp "a": pause 16: mp "h": pause 16:
PLAY "t140": mp "g": mp "h": mp "g": mp "f"

PRINT B$; "!"
pause 5: PLAY "t130": mp "c": pause 24: mp "c": PLAY "t100"
mp "s": pause 16: mp "j": pause 16: mp "a": pause 16: mp "j"
END SUB

SUB ProcessName
nam$ = LTRIM$(RTRIM$(UCASE$(nam$))): lon = LEN(nam$)
SELECT CASE RIGHT$(nam$, 2)
    CASE "'S": nc$ = LEFT$(nam$, lon - 2)
    CASE "S'": nc$ = LEFT$(nam$, lon - 2)
    CASE ELSE
        C$ = RIGHT$(nam$, 1): nc$ = nam$
        IF C$ = "S" THEN nam$ = nam$ + "'" ELSE nam$ = nam$ + "'S"
END SELECT
END SUB

