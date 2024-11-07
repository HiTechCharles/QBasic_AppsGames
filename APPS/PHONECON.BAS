DECLARE SUB center (row!, text$)
DECLARE SUB FindKey (KK$)
DECLARE SUB IsAlpha (dd$)
DECLARE SUB isdigit (dd$)
DIM SHARED IsDig, IsAlp, ptc$, pn$, lp, nuptc$, npn$, KEY$, cmd, cl

'$DYNAMIC

IF INSTR(COMMAND$, "/?") > 0 OR INSTR(COMMAND$, "-?") > 0 THEN GOTO USAGE:
IF COMMAND$ <> "" THEN cmd = 1: pn$ = COMMAND$: GOTO CLI:

Pbegin:
WIDTH 40, 25: COLOR 9: CLS : center 2, "PhoneCon"
center 3, "Phone Number Converter": center 5, "By Charles Martin"
LOCATE 9, 1: COLOR 15
PRINT "This program takes a confusing phone"
PRINT "number such as 1-888-2TRAVEL, and turns"
PRINT "it into a number that's easier to dial."
PRINT : PRINT : CLEAR

DO UNTIL INKEY$ = "": LOOP
COLOR 14: PRINT : PRINT "OK, now put in the phone number:"
PRINT "(Leave this blank to quit.)"
COLOR 15: INPUT ">", pn$
pn$ = LTRIM$(RTRIM$(pn$)): pn$ = UCASE$(pn$): lp = LEN(pn$)
IF lp = 0 THEN SYSTEM
IF lp < 6 OR lp > 22 THEN PRINT :  PRINT "Between 6 and 22 characters, please.": SLEEP 3: CLS : GOTO Pbegin:

IPT:
REDIM SHARED NB$(lp):  ptc$ = pn$

FOR AM = 1 TO lp
    NB$(AM) = LEFT$(ptc$, 1): nuptc$ = RIGHT$(ptc$, lp - AM): : ptc$ = nuptc$
    IsAlpha NB$(AM)
     SELECT CASE IsAlp
         CASE IS = 1: FindKey NB$(AM): npn$ = npn$ + KEY$: GOTO 100
         CASE ELSE: npn$ = npn$ + NB$(AM): GOTO 100
     END SELECT

100
NEXT AM'anda

IF cmd = 1 THEN GOTO print4cmd:
CLS
COLOR 13: LOCATE 5, 1, 0: PRINT "   Your input:  "; : COLOR 15: PRINT pn$
COLOR 13: LOCATE 7, 1, 0: PRINT "Simple number:  "; : COLOR 15: PRINT npn$
IF cl = 0 THEN LOCATE 8, 17: PRINT "(NO CHANGE)"
COLOR 14: center 11, "Press any key...": SLEEP: GOTO Pbegin:

CLI:
lp = LEN(pn$)
IF lp < 6 OR lp > 22 THEN PRINT :  PRINT "Between 6 and 22 characters, please.": SYSTEM
GOTO IPT:

USAGE:
COLOR 15: PRINT : PRINT :
PRINT "Letters-2-Numbers   2003 Charles Martin": PRINT
PRINT "This program takes a confusing phone"
PRINT "number such as 1-888-2TRAVEL, and turns"
PRINT "it into a number that's easier to dial."

PRINT : PRINT "Command-line arguments are not"
        PRINT "needed.  You CAN put a phone"
        PRINT "number on the command line, and"
        PRINT "the program will give you the"
        PRINT "simplified form of the number."
        PRINT : PRINT : SYSTEM

print4cmd:
COLOR 15: PRINT : PRINT
PRINT "   Your input:  "; : COLOR 15: PRINT pn$
PRINT "Simple number:  "; : COLOR 15: PRINT npn$
IF cl = 0 THEN LOCATE CSRLIN, 17: PRINT "(NO CHANGE)"
PRINT : PRINT : SYSTEM

REM $STATIC
SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB FindKey (KK$)
SELECT CASE KK$
    CASE IS = "A", "B", "C": KEY$ = "2": GOTO eok:
    CASE IS = "D", "E", "F": KEY$ = "3": GOTO eok:
    CASE IS = "G", "H", "I": KEY$ = "4": GOTO eok:
    CASE IS = "J", "K", "L": KEY$ = "5": GOTO eok:
    CASE IS = "M", "N", "O": KEY$ = "6": GOTO eok:
    CASE IS = "P", "Q", "R", "S": KEY$ = "7": GOTO eok:
    CASE IS = "T", "U", "V": KEY$ = "8": GOTO eok:
    CASE IS = "W", "X", "Y", "Z": KEY$ = "9": GOTO eok:
    CASE ELSE: PRINT : PRINT "Non-alpha character tested with FindKey.  Check input loop": SYSTEM
END SELECT
eok:
END SUB

SUB IsAlpha (dd$)
IsAlp = 0: ST$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    IF INSTR(ST$, dd$) > 0 THEN
        IsAlp = 1: GOTO eva:
    ELSE
        IsAlp = -1: GOTO eva:
END IF

eva:
IF IsAlp = 1 THEN cl = cl + 1
END SUB

SUB isdigit (dd$)
IsDig = 0: Dig = 0: ST$ = "0123456789"
    IF INSTR(ST$, dd$) > 0 THEN
        Dig = VAL(dd$): GOTO eod:
    ELSE
        Dig = 0: IsDig = -1: GOTO eod:
END IF

eod:
IF Dig <> 0 THEN IsDig = 1
END SUB

