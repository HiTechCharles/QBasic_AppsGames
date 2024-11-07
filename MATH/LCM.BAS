DIM SHARED denom(4)
DIM SHARED F

begin:  COLOR 14, 8: WIDTH 40, 25: CLS
: PRINT : PRINT "LCM (Least common multiple) finder"

PRINT : PRINT : INPUT "How many fractions?  (2 to 4):  ", F
IF F < 2 OR F > 4 THEN GOTO begin:

frinputa: PRINT : PRINT : PRINT :
INPUT "Denominator of first fraction:  ", denom(1)
IF denom(1) < 2 THEN GOTO frinputa:

frinputb: PRINT : INPUT "Denominator of second fraction:  ", denom(2)
IF denom(2) < 2 THEN GOTO frinputb:

frinputc:
SELECT CASE F
CASE IS >= 3
PRINT : INPUT "Denominator of third fraction:  ", denom(3)
IF denom(3) < 2 THEN GOTO frinputc:

CASE IS < 3
GOTO PRINTLCM:
END SELECT

frinputd:
SELECT CASE F
CASE 4
PRINT : INPUT "Denominator of forth fraction:  ", denom(4)
IF denom(4) < 2 THEN GOTO frinputd:

CASE IS < 4
GOTO PRINTLCM:
END SELECT


PRINTLCM: : WIDTH 80, 25: COLOR 9, 8, 14
CLS : PRINT : PRINT "LCM Finder Results"
PRINT : PRINT : PRINT
PRINT "ÖÄÄÄÄÄÒÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄ·"
PRINT "º     º     ³     ³     ³     ³     ³     ³     ³     ³     ³     ³     ³     º"
PRINT "ÇÄÄÄÄÄ×ÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄ¶"
PRINT "º     º     ³     ³     ³     ³     ³     ³     ³     ³     ³     ³     ³     º"
PRINT "ÇÄÄÄÄÄ×ÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄ¶"
PRINT "º     º     ³     ³     ³     ³     ³     ³     ³     ³     ³     ³     ³     º"
PRINT "ÇÄÄÄÄÄ×ÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄ¶"
PRINT "º     º     ³     ³     ³     ³     ³     ³     ³     ³     ³     ³     ³     º"
PRINT "ÓÄÄÄÄÄÐÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄ½"

COLOR 15: LOCATE 7, 3: PRINT denom(1)
LOCATE 7, 8: PRINT denom(1) + denom(1): LET facta = denom(1) + denom(1)
LOCATE 7, 14: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 20: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 26: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 32: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 38: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 44: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 50: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 56: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 62: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 68: LET facta = facta + denom(1): PRINT facta
LOCATE 7, 74: LET facta = facta + denom(1): PRINT facta

COLOR 14: LOCATE 9, 3: PRINT denom(2)
LOCATE 9, 8: PRINT denom(2) + denom(2): LET factb = denom(2) + denom(2)
LOCATE 9, 14: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 20: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 26: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 32: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 38: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 44: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 50: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 56: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 62: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 68: LET factb = factb + denom(2): PRINT factb
LOCATE 9, 74: LET factb = factb + denom(2): PRINT factb

IF denom(3) = 0 THEN GOTO ending: :
IF denom(3) > 0 THEN GOTO pri3

pri3:
COLOR 13: LOCATE 11, 3: PRINT denom(3)
LOCATE 11, 8: PRINT denom(3) + denom(3): LET factc = denom(3) + denom(3)
LOCATE 11, 14: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 20: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 26: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 32: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 38: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 44: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 50: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 56: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 62: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 68: LET factc = factc + denom(3): PRINT factc
LOCATE 11, 74: LET factc = factc + denom(3): PRINT factc

IF F < 4 THEN GOTO ending:
IF F = 4 THEN GOTO pri4

pri4:
COLOR 12: LOCATE 13, 3: PRINT denom(4)
LOCATE 13, 8: PRINT denom(4) + denom(4): LET factd = denom(4) + denom(4)
LOCATE 13, 14: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 20: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 26: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 32: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 38: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 44: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 50: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 56: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 62: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 68: LET factd = factd + denom(4): PRINT factd
LOCATE 13, 74: LET factd = factd + denom(4): PRINT factd

ending:
VIEW PRINT 15 TO 23: COLOR 15: : LOCATE 16, 1:
PRINT "Would you like to run LCM finder again?  (Press Y or N)"

lax:
LET k$ = LCASE$(INKEY$)
IF k$ = "y" THEN CLEAR : GOTO begin:
IF k$ = "n" THEN PRINT : PRINT "Goodbye, and thank you for using LCM finder": PRINT : PRINT : COLOR 11: SHELL "pause":   SYSTEM
IF k$ = "q" THEN PRINT : PRINT "Goodbye, and thank you for using LCM finder": PRINT : PRINT : COLOR 11: SHELL "pause": SYSTEM
IF k$ = CHR$(27) THEN PRINT : PRINT "Goodbye, and thank you for using LCM finder": PRINT : PRINT : COLOR 11: SHELL "pause":   SYSTEM
GOTO lax:

