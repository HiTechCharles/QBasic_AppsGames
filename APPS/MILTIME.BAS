DECLARE SUB Center (row!, text$)

DIM SHARED MH, mm, ms, SH, sm, ss, AP$, k$

BEGIN:
WIDTH 40, 25: COLOR 13: CLS
Center 2, "Time converter"

COLOR 10: LOCATE 5, 1: PRINT "CONVERT"
COLOR 14: LOCATE 7, 1:
PRINT "     M  Military to standard time"
PRINT
PRINT "     S  Standard to military time"
PRINT
PRINT "     X  Exit the program"
PRINT : PRINT :
COLOR 12: PRINT "Press letter of desired choice:"

getkind:
k$ = LCASE$(INKEY$)
IF k$ = "m" THEN GOTO MTS:
IF k$ = "s" THEN GOTO STM:
IF k$ = "x" THEN SYSTEM
IF k$ = CHR$(27) THEN SYSTEM
GOTO getkind:

MTS:
MH = 0: mm = 0: ms = 0: SH = 0: sm = 0: ss = 0: AP$ = "": k$ = ""
CLS : COLOR 11: LOCATE 3, 1: : PRINT "Put in the military time to convert:"
PRINT "Leaving a value blank will default to 0."
PRINT
INPUT "  HOURS:  ", MH
IF MH < 0 OR MH > 23 THEN GOTO MTS:
IF MH >= 12 THEN AP$ = "PM": GOTO mm:
IF MH < 12 THEN AP$ = "AM": GOTO mm:

mm:
PRINT
INPUT "MINUTES:  ", mm
IF mm < 0 OR mm > 59 THEN GOTO mm:

ms:
PRINT
INPUT "SECONDS:  ", ms
IF ms < 0 OR ms > 59 THEN GOTO ms:

COLOR 9: PRINT : PRINT "컴컴컴컴컴컴컴컴컴컴컴�"
PRINT : PRINT : COLOR 15

PRINT "Military - "; : PRINT USING "##:##:##"; MH; mm; ms
IF MH > 12 THEN SH = MH - 12
IF MH < 12 THEN SH = MH

PR:
PRINT : PRINT "Standard - "; : PRINT USING "##:##:##"; SH; mm; ms; : PRINT " "; AP$
PRINT : PRINT :
COLOR 7: PRINT "Convert another?  (Y/N): "
gyna:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN CLEAR : GOTO MTS:
IF k$ = "n" THEN CLEAR : GOTO BEGIN:
IF k$ = CHR$(27) THEN CLEAR : GOTO BEGIN:
GOTO gyna:

STM:
MH = 0: mm = 0: ms = 0: SH = 0: sm = 0: ss = 0: AP$ = "": k$ = ""
CLS : COLOR 11: LOCATE 3, 1: : PRINT "Put in the standard time to convert:"
PRINT "Leaving a value blank will default to 0."
PRINT
INPUT "  HOURS:  ", SH
IF SH < 0 OR SH > 12 THEN GOTO STM:

sm:
PRINT
INPUT "MINUTES:  ", sm
IF sm < 0 OR mm > 59 THEN GOTO sm:

ss:
PRINT
INPUT "SECONDS:  ", ss
IF ss < 0 OR ms > 59 THEN GOTO ss:

AP:
PRINT
PRINT "AM or PM?  (A or P):"
aop:
k$ = LCASE$(INKEY$)
IF k$ = "a" THEN AP$ = "AM": GOTO pr2:
IF k$ = "p" THEN AP$ = "PM": GOTO pr2:
GOTO aop:

pr2:
COLOR 9: PRINT : PRINT "컴컴컴컴컴컴컴컴컴컴컴�"
PRINT : PRINT : COLOR 15

PRINT "Standard - "; : PRINT USING "##:##:##"; SH; sm; ss; : PRINT " "; AP$


IF k$ = "p" THEN MH = SH + 12
IF k$ = "a" THEN MH = SH
IF MH = 24 THEN MH = 0

PR3:
PRINT : PRINT "Military - "; : PRINT USING "##:##:##"; MH; sm; ss
PRINT : PRINT :
COLOR 7: PRINT "Convert another?  (Y/N): "
gyna2:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN CLEAR : GOTO STM:
IF k$ = "n" THEN CLEAR : GOTO BEGIN:
IF k$ = CHR$(27) THEN CLEAR : GOTO BEGIN:
GOTO gyna2:

SUB Center (row, text$)

col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

