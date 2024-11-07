DECLARE SUB center (row!, text$)

sbegin:
WIDTH 40, 25: COLOR 15: CLS : COLOR 9: center 2, "EasySort"
COLOR 14: center 3, "Interface by Charles Martin"

DO UNTIL INKEY$ = "": LOOP
COLOR 15: LOCATE 9, 1: PRINT "FILE TO SORT:  (Leave blank to quit)"
PRINT ">"; : COLOR 13: INPUT "", ToSort$
ToSort$ = LTRIM$(RTRIM$(ToSort$)): ToSort$ = UCASE$(ToSort$): LTS = LEN(ToSort$)
IF LTS = 0 THEN SYSTEM

COLOR 15: LOCATE 13, 1: PRINT "FILE TO STORE SORTED LIST:  (Leave blank"
PRINT "to use "; ToSort$; ")  >"; : COLOR 13: INPUT "", ToStore$
ToStore$ = LTRIM$(RTRIM$(ToStore$)): ToStore$ = UCASE$(ToStore$): LTS = LEN(ToStore$)
IF LTS = 0 THEN ToStore$ = ToSort$

LOCATE 18, 1: COLOR 14
PRINT "PRESS A to sort from A to Z, 0 to 9"
PRINT "      Z to sort From Z to A, 9 to 0"
gst:
K$ = LCASE$(INKEY$)
IF K$ = "a" THEN st$ = "": GOTO DoSort:
IF K$ = "z" THEN st$ = "/R": GOTO DoSort:
IF K$ = CHR$(27) THEN GOTO sbegin:
GOTO gst:

DoSort:
CLS
    IF LTS = 0 THEN
        st = TIMER: SHELL "SORT " + st$ + " <" + ToSort$ + " > ZZ"
        KILL ToSort$
        SHELL "ren zz " + ToStore$
        et = TIMER - st
    ELSE
        st = TIMER: SHELL "SORT " + st$ + " < " + ToSort$ + " > " + ToStore$
        et = TIMER - st
    END IF
   
    COLOR 15: center 13, STR$(et) + " SECONDS"
    COLOR 9: center 15, "Press any key to continue...": SLEEP: CLEAR : GOTO sbegin:

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

