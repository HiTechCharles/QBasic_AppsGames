DECLARE SUB a2i (number$)
DECLARE SUB center (row, text$)

DIM SHARED num, L$, m$, r$, L, m, r, digtotal, i, num$, chk, td, msg$

DRB:
WIDTH 40, 25: CLS : COLOR 12: center 2, "Divisability Rules"
COLOR 15: center 4, "By Charles Martin"

LOCATE 9, 1: COLOR 14: PRINT "Please type in a 2, or"
PRINT "3-digit whole number:   "; : COLOR 15: INPUT ">", num
IF num = 1 THEN GOTO rcn:
IF num < 10 OR num > 999 THEN PRINT : PRINT "A 2, or 3-digit whole number, please.": SLEEP 3: GOTO DRB:

NRN:
msg$ = "You "

STT:
CLS
COLOR 14: LOCATE 2, 1: PRINT msg$; "chose the number"; num
num = INT(num): IF num > 99 THEN td = 1:
num$ = LTRIM$(RTRIM$(STR$(num)))

L$ = LEFT$(num$, 1)
r$ = RIGHT$(num$, 1)
IF num > 99 THEN zz$ = LEFT$(num$, 2): m$ = RIGHT$(zz$, 1)

a2i L$
L = i
a2i m$
m = i
a2i r$
r = i

PRINT : PRINT : COLOR 10:        '9 15 12 14
chk = num MOD 2
SELECT CASE chk
CASE IS = 0:
PRINT num$; " is divisible by 2 because"; r
PRINT "(the ONES digit) is divisible by 2."
PRINT num$; " divided by 2 is"; (num / 2): GOTO rf3:
CASE ELSE:
PRINT num$; " is NOT divisible by 2 because"; r:
PRINT "(the ONES digit) is not divisible by 2.": GOTO rf3:
END SELECT

rf3:
PRINT : PRINT : COLOR 15
chk = num MOD 3
SELECT CASE chk
CASE IS = 0:
PRINT num$; " is divisible by 3  because"
IF td = 0 THEN PRINT L$; "+"; r$; "="; digtotal; "and";
IF td <> 0 THEN PRINT L$; "+"; m$; "+"; r$; "="; digtotal; "and";
PRINT digtotal; "is divisible by 3."
PRINT num$; " divided by 3 is"; (num / 3): GOTO rf5:

CASE ELSE:
PRINT num$; " is NOT divisible by 3 because"
IF td = 0 THEN PRINT L$; "+"; r$; "="; digtotal; "and";
IF td <> 0 THEN PRINT L$; "+"; m$; "+"; r$; "="; digtotal; "and";
PRINT digtotal; "is not divisible by 3.": GOTO rf5:
END SELECT

rf5:
PRINT : PRINT : COLOR 13
chk = num MOD 5
SELECT CASE chk
CASE IS = 0:
PRINT num$; " is divisible by 5 because"; r
PRINT "(the ONES digit) is divisible by 5."
PRINT num$; " divided by 5 is"; (num / 5): GOTO rf9:
CASE ELSE:
PRINT num$; " is NOT divisible by 5 because"; r:
PRINT "(the ONES digit) is not divisible by 5.": GOTO rf9:
END SELECT


rf9:
PRINT : PRINT : COLOR 11
chk = num MOD 9
SELECT CASE chk
CASE IS = 0:
PRINT num$; " is divisible by 9  because"
IF td = 0 THEN PRINT L$; "+"; r$; "="; digtotal; "and";
IF td <> 0 THEN PRINT L$; "+"; m$; "+"; r$; "="; digtotal; "and";
PRINT digtotal; "is divisible by 9."
PRINT num$; " divided by 9 is"; (num / 9): GOTO RPA:

CASE ELSE:
PRINT num$; " is NOT divisible by 9 because"
IF td = 0 THEN PRINT L$; "+"; r$; "="; digtotal; "and";
IF td <> 0 THEN PRINT L$; "+"; m$; "+"; r$; "="; digtotal; "and";
PRINT digtotal; "is not divisible by 9.": GOTO RPA:
END SELECT


RPA:
PRINT : PRINT : COLOR 9: PRINT "Try another number?  (Press Y or N):"
ttan:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN CLEAR : GOTO DRB:
IF k$ = "n" THEN SYSTEM
IF k$ = CHR$(27) THEN SYSTEM
GOTO ttan:

rcn:
RANDOMIZE TIMER
num = INT(RND * 999) + 10
IF num < 10 OR num > 999 THEN GOTO rcn:
msg$ = "This computer "
GOTO STT:

SUB a2i (number$)


SELECT CASE number$
CASE IS = "0": i = 0: GOTO EOS:
CASE IS = "1": i = 1: GOTO EOS:
CASE IS = "2": i = 2: GOTO EOS:
CASE IS = "3": i = 3: GOTO EOS:
CASE IS = "4": i = 4: GOTO EOS:
CASE IS = "5": i = 5: GOTO EOS:
CASE IS = "6": i = 6: GOTO EOS:
CASE IS = "7": i = 7: GOTO EOS:
CASE IS = "8": i = 8: GOTO EOS:
CASE IS = "9": i = 9: GOTO EOS:
END SELECT

EOS:
digtotal = digtotal + i

END SUB

SUB center (row, text$)

col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$

END SUB

