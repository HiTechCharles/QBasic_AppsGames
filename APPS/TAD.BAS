DECLARE FUNCTION CurrentDate$ (Style!)
DECLARE FUNCTION CurrentDate$ (Style)
DECLARE FUNCTION CurrentTime$ ()
DECLARE SUB DayOfWeek (m, d, y)
DECLARE FUNCTION I2a$ (TN)
COMMON SHARED day$, dy$


FUNCTION CurrentDate$ (Style)
'CurrentDate$ -- Gets the day of the week, month day and/or
'year into CurrentDate$  REQUIRES DayOfWeek sub, and DAY$ to be COMMON SHARED
'
'         USAGE:  Print CurrentDate$ (<DATE STYLE #>)  'see the chart below

'DATE STYLES
'  STYLE #  ELEMENTS-----------------------------------    EXAMPLE-----
'        1  DAY OF WEEK, MONTH (WORD) DAY #, 4-DIGIT YEAR  Friday, December 14, 1979
'        2  MONTH (WORD) DAY #, 4-DIGIT YEAR               Feburary 14, 2003
'        3  MONTH #/DAY #/2-DIGIT YEAR #                   3/11/89
'        4  MONTH #/DAY #/4-DIGIT YEAR #                   12/14/1979
'        5  MONTH (WORD) DAY #                             January 4

m$ = LEFT$(DATE$, 2): mm = VAL(m$)   'month
d$ = MID$(DATE$, 4, 2): dd = VAL(d$) 'day
y$ = RIGHT$(DATE$, 4): YY = VAL(y$)  'year
IF Style = 1 THEN DayOfWeek mm, dd, YY

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

SELECT CASE Style
CASE IS = 1: CurrentDate$ = day$ + ", " + month$ + " " + ds$ + ", " + y$
CASE IS = 2: CurrentDate$ = month$ + " " + ds$ + ", " + y$
CASE IS = 3: CurrentDate$ = Ms$ + "/" + ds$ + "/" + RIGHT$(y$, 2)
CASE IS = 4: CurrentDate$ = Ms$ + "/" + ds$ + "/" + y$
CASE IS = 5: CurrentDate$ = month$ + " " + ds$
END SELECT

dy$ = month$ + " " + y$
END FUNCTION

FUNCTION CurrentTime$
h = VAL(LEFT$(TIME$, 2))
m = VAL(MID$(TIME$, 4, 2)): m$ = I2a$(m)
s = VAL(RIGHT$(TIME$, 2)): s$ = I2a$(s)

SELECT CASE h
    CASE IS = 0: AP$ = "A": SH = 12
    CASE IS < 12: AP$ = "A": SH = h
    CASE IS = 12: AP$ = "P": SH = h
    CASE IS > 12: AP$ = "P": SH = h - 12
END SELECT

SH$ = I2a$(SH)
'             hour : minute <2 spaces> <AM or PM>
IF LEN(m$) = 1 THEN m$ = "0" + m$
CurrentTime$ = SH$ + ":" + m$ + " " + AP$ + "M"



END FUNCTION

SUB DayOfWeek (m, d, y)
'DayOfWeed -- Returns the day of the week based on the month, day, and year
'Day$ is the day returned by the sub
'DO NOT USE the variables M, D, OR Y to store a date
'they are used in this sub to store calculations.

'   USAGE:  DayOfWeek   <MONTH>, <DAY>, <YEAR>
'EXAMPLES:  DayOfWeek 12, 14, 1979      DAYOFWEEK  mm, dd, yy

DIM J$(7): J$(1) = "Sunday": J$(2) = "Monday": J$(3) = "Tuesday"
J$(4) = "Wednesday": J$(5) = "Thursday": J$(6) = "Friday": J$(7) = "Saturday"

IF m < 1 OR m > 12 THEN PRINT : PRINT "Month must be between 1 and 12.": SYSTEM
IF d < 1 OR d > 31 THEN PRINT : PRINT "Day must be between 1 and 31.": SYSTEM
IF y < 1753 THEN PRINT : PRINT "Year must not be prior to 1753.":  SYSTEM
k = INT(.6 + (1 / m)): l = y - k: O = m + 12 * k: P = l / 100: z1 = INT(P / 4)
z2 = INT(P): z3 = INT((5 * l) / 4): z4 = INT(13 * (O + 1) / 5):
z = z4 + z3 - z2 + z1 + d - 1: z = z - (7 * INT(z / 7))
z = z + 1: day$ = J$(z)
END SUB

FUNCTION I2a$ (TN)
'I2a$ takes the number stored in a numeric variable and puts it into
'a string variable.
'VALUE$ is the number in string form -- must be COMMON SHARED

'   USAGE:  PRINT I2a$ <NUMBER or NUMERIC VARIABLE>
'EXAMPLES:  print I2a$ (57)         H$ = I2a$ (num)

I2a$ = LTRIM$(RTRIM$(STR$(TN)))
END FUNCTION

