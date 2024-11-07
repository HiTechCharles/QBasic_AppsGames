DECLARE FUNCTION DAYOFWEEK$ (m, d, y)
m$ = LEFT$(DATE$, 2): d$ = MID$(DATE$, 4, 2): y$ = RIGHT$(DATE$, 4)
cm = VAL(m$): cd = VAL(d$): cy = VAL(y$)

IF LEN(m$) = 1 THEN m$ = RIGHT$(m$, 1)
IF LEN(d$) = 1 THEN d$ = RIGHT$(d$, 1)

SHELL "md " + CHR$(34) + COMMAND$ + DAYOFWEEK$(cm, cd, cy) + " " + m$ + "-" + d$ + CHR$(34)

FUNCTION DAYOFWEEK$ (m, d, y)

DIM J$(7): J$(1) = "Sun": J$(2) = "Mon": J$(3) = "Tue"
J$(4) = "Wed": J$(5) = "Thu": J$(6) = "Fri": J$(7) = "Sat"

IF m < 1 OR m > 12 THEN PRINT : PRINT "Month must be between 1 and 12.": SYSTEM
IF d < 1 OR d > 31 THEN PRINT : PRINT "Day must be between 1 and 31.": SYSTEM
IF y < 1753 THEN PRINT : PRINT "Year must not be prior to 1753.":  SYSTEM
k = INT(.6 + (1 / m)): L = y - k: O = m + 12 * k: P = L / 100: z1 = INT(P / 4)
z2 = INT(P): z3 = INT((5 * L) / 4): z4 = INT(13 * (O + 1) / 5):
z = z4 + z3 - z2 + z1 + d - 1: z = z - (7 * INT(z / 7))
z = z + 1: DAYOFWEEK$ = J$(z): ERASE J$
END FUNCTION

