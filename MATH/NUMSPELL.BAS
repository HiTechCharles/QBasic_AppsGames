DECLARE SUB center (row, text$)
DECLARE SUB Hun (h$)
DECLARE SUB one (h$)
DECLARE SUB quote (word$)
DECLARE SUB ten (h$)
DECLARE SUB thou (h$)
COMMON SHARED num, num$, o$, t$, hu$, th$, digits, rc, ln

WIDTH 40, 25
begin:
COLOR 11: CLS : center 2, "NumSpell"
COLOR 7: center 3, "By Charles Martin": rc = 0

COLOR 14: LOCATE 7, 1: PRINT "This program will take a number, and"
PRINT "then spell it out in words."
PRINT
PRINT "For example, if you typed in "; : quote "214": PRINT " the"
PRINT "program says "; : quote "TWO HUNDRED FOURTEEN"
PRINT
PRINT : COLOR 13
PRINT "OK, type in a whole number between 2"
PRINT "and 10,000.  Use 0 to quit, or 1 to"
PRINT "pick a random number to spell.   "; : COLOR 15: INPUT ">", num
num = INT(num)
IF num = 0 THEN center 20, "ZERO": SLEEP 2: SYSTEM
IF num = 1 THEN GOTO rn:
IF num < 0 OR num > 10000 THEN PRINT : PRINT "Between 1 and 10,000, please!": SLEEP 3: GOTO begin:

dig:
num = INT(num)
IF num < 10 THEN digits = 1
IF num >= 10 AND num < 100 THEN digits = 2
IF num >= 100 AND num < 1000 THEN digits = 3
IF num >= 1000 AND num < 10000 THEN digits = 4
IF num = 10000 THEN digits = 5


CLS
num$ = LTRIM$(RTRIM$(STR$(num)))
SELECT CASE digits
CASE IS = 1: o$ = num$: one r$: GOTO EOW:
CASE IS = 2: o$ = RIGHT$(num$, 1): t$ = LEFT$(num$, 1)
CASE IS = 3: o$ = RIGHT$(num$, 1): z$ = LEFT$(num$, 2): t$ = RIGHT$(z$, 1): hu$ = LEFT$(num$, 1)
CASE IS = 4: th$ = LEFT$(num$, 1): o$ = RIGHT$(num$, 1): zz$ = LEFT$(num$, 3): t$ = RIGHT$(zz$, 1): YY$ = LEFT$(zz$, 2): hu$ = RIGHT$(YY$, 1)
END SELECT

EOW:
CLS : COLOR 14: LOCATE 2, 10
IF rc <> 1 THEN PRINT "You have chosen" ELSE PRINT "This computer has chosen"
LOCATE 3, 10: PRINT "the number "; USING "##,###"; num

ln = 8: COLOR 15:
IF num = 10000 THEN center ln, "TEN THOUSAND": GOTO dun:
thou th$: LOCATE 8, 1: Hun hu$

IF t$ <> "1" THEN GOTO TOP:
SELECT CASE t$ + o$
CASE IS = "10": center ln, "TEN": GOTO dun:
CASE IS = "11": center ln, "ELEVEN": GOTO dun:
CASE IS = "12": center ln, "TWELVE": GOTO dun:
CASE IS = "13": center ln, "THIRTEEN": GOTO dun:
CASE IS = "14": center ln, "FOURTEEN": GOTO dun
CASE IS = "15": center ln, "FIFTEEN": GOTO dun
CASE IS = "16": center ln, "SIXTEEN": GOTO dun
CASE IS = "17": center ln, "SEVENTEEN": GOTO dun
CASE IS = "18": center ln, "EIGHTEEN": GOTO dun
CASE IS = "19": center ln, "NINETEEN": GOTO dun
END SELECT

dun:
COLOR 10: center 20, "Press any key...": SLEEP: GOTO begin:


TOP:
ten t$
one o$
GOTO dun:

rn:
RANDOMIZE TIMER: rc = 1
num = INT(RND * 10000) + 2
IF num < 2 OR num > 10000 THEN GOTO rn:
GOTO dig

SUB center (row, text$)

col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$;

END SUB

SUB Hun (h$)

SELECT CASE h$
CASE IS = "0": EXIT SUB
CASE IS = "1": center ln, "ONE HUNDRED": GOTO eh:
CASE IS = "2": center ln, "TWO HUNDRED": GOTO eh:
CASE IS = "3": center ln, "THREE HUNDRED": GOTO eh:
CASE IS = "4": center ln, "FOUR HUNDRED": GOTO eh:
CASE IS = "5": center ln, "FIVE HUNDRED": GOTO eh:
CASE IS = "6": center ln, "SIX HUNDRED": GOTO eh:
CASE IS = "7": center ln, "SEVEN HUNDRED": GOTO eh:
CASE IS = "8": center ln, "EIGHT HUNDRED": GOTO eh:
CASE IS = "9": center ln, "NINE HUNDRED": GOTO eh:
END SELECT

eh:
ln = ln + 2
END SUB



SUB one (h$)

SELECT CASE h$
CASE IS = "0": EXIT SUB
CASE IS = "1": center ln, "ONE": EXIT SUB
CASE IS = "2": center ln, "TWO": EXIT SUB
CASE IS = "3": center ln, "THREE": EXIT SUB
CASE IS = "4": center ln, "FOUR": EXIT SUB
CASE IS = "5": center ln, "FIVE": EXIT SUB
CASE IS = "6": center ln, "SIX": EXIT SUB
CASE IS = "7": center ln, "SEVEN": EXIT SUB
CASE IS = "8": center ln, "EIGHT": EXIT SUB
CASE IS = "9": center ln, "NINE": EXIT SUB
END SELECT

END SUB

SUB quote (word$)
PRINT CHR$(34); word$; CHR$(34);
END SUB

SUB ten (h$)

SELECT CASE h$
CASE IS = "0": EXIT SUB
CASE IS = "2": center ln, "TWENTY": GOTO ET:
CASE IS = "3": center ln, "THIRTY": GOTO ET:
CASE IS = "4": center ln, "FORTY": GOTO ET:
CASE IS = "5": center ln, "FIFTY": GOTO ET:
CASE IS = "6": center ln, "SIXTY": GOTO ET:
CASE IS = "7": center ln, "SEVENTY": GOTO ET:
CASE IS = "8": center ln, "EIGHTY": GOTO ET:
CASE IS = "9": center ln, "NINETY": GOTO ET:
END SELECT

ET:
ln = ln + 2
END SUB

SUB thou (h$)

SELECT CASE h$
CASE IS = "0": EXIT SUB
CASE IS = "1": center ln, "ONE THOUSAND": GOTO eth:
CASE IS = "2": center ln, "TWO THOUSAND": GOTO eth:
CASE IS = "3": center ln, "THREE THOUSAND": GOTO eth:
CASE IS = "4": center ln, "FOUR THOUSAND": GOTO eth:
CASE IS = "5": center ln, "FIVE THOUSAND": GOTO eth:
CASE IS = "6": center ln, "SIX THOUSAND": GOTO eth:
CASE IS = "7": center ln, "SEVEN THOUSAND": GOTO eth:
CASE IS = "8": center ln, "EIGHT THOUSAND": GOTO eth:
CASE IS = "9": center ln, "NINE THOUSAND": GOTO eth:
END SELECT

eth:
ln = ln + 2
END SUB

