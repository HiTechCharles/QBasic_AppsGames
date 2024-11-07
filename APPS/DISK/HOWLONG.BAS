DECLARE SUB center (row, text$)
DECLARE FUNCTION Limitinput$ (allowedchars)
DECLARE SUB RealTime (nos)
COMMON SHARED size, size$, hrs, min, sec, origsize, k$

DEFSNG A-Z
1
WIDTH 40, 25: COLOR 13: VIEW PRINT: CLS
center 2, "DownloadTime"
center 3, "By Charles Martin"
VIEW PRINT 4 TO 23

10
COLOR 15: LOCATE 6, 1: PRINT "Download speed:  (0 to quit)  "; : s$ = Limitinput$(5)

IF s$ = CHR$(27) THEN SYSTEM
speed = VAL(s$)
IF speed = 0 THEN SYSTEM
IF speed < .1 THEN CLS : GOTO 10

20
COLOR 15: LOCATE 8, 1: PRINT "What is the size of the file?"
PRINT "(Numbers only)   >"; : COLOR 10: size$ = Limitinput$(7)
IF size$ = CHR$(27) THEN SYSTEM
size = VAL(size$):  size$ = LTRIM$(RTRIM$(UCASE$(size$))): origsize = size
IF size < .1 THEN CLS : GOTO 20

ls = LEN(size$)
IF RIGHT$(size$, 1) = "B" THEN size$ = LEFT$(size$, ls - 1)

30
    SELECT CASE RIGHT$(size$, 1)
        CASE IS = "K": GOTO Results:
        CASE IS = "M": size = size * 1024: GOTO Results:
        CASE IS = "G": size = size * 10240: GOTO Results:
        CASE ELSE: GOTO ASK:
    END SELECT

ASK:
COLOR 14: CLS : LOCATE 6, 1:
IF INSTR(origsize$, ".") THEN k$ = ".##" ELSE k$ = ""
PRINT "FILE SIZE:  "; USING "###,###" + k$; origsize

PRINT : COLOR 13:
PRINT "Choose one of the following options"
PRINT "by pressing a letter:"
PRINT : COLOR 15
PRINT "     K.  KiloBytes  (KB)"
PRINT "     M.  MegaBytes  (MB)"
PRINT "     G.  Gigobytes  (GB)"
PRINT "     S.  Specify a new file size"
PRINT "     Q.  Quit"
gum:
    k$ = LCASE$(INKEY$)
    IF k$ = "k" OR k$ = "m" OR k$ = "g" THEN size$ = size$ + UCASE$(k$): GOTO 30
    IF k$ = "s" THEN CLS : GOTO 20
    IF k$ = "q" OR k$ = "x" THEN SYSTEM
    IF k$ = CHR$(27) THEN SYSTEM
GOTO gum:

Results:
time = size / speed

COLOR 14: CLS : LOCATE 6, 1:
origsize$ = LTRIM$(RTRIM$(STR$(origsize)))
IF INSTR(origsize$, ".") THEN k$ = ".##" ELSE k$ = ""
PRINT "FILE SIZE:  "; USING "#,###,###" + k$ + " &B"; origsize; RIGHT$(size$, 1)
speed$ = LTRIM$(RTRIM$(STR$(speed)))
IF INSTR(speed$, ".") THEN k$ = ".##" ELSE k$ = ""
PRINT "    SPEED:  "; USING "    #,###" + k$ + " KB/SECOND"; speed
PRINT
PRINT "     time:  "; : cx = POS(0)
COLOR 15

RealTime time

60
IF hrs <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "#,###,### Hour"; hrs;
    IF hrs > 1 THEN PRINT "s": PRINT

IF min <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "       ## Minut"; min;
    IF min > 1 THEN PRINT "s": PRINT
IF sec <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "       ## Second"; sec;
    IF sec > 1 THEN PRINT "s": PRINT

center 23, "Press any key...": SLEEP: GOTO 1

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

FUNCTION Limitinput$ (allowedchars)
tc = 0: CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
TOS:
     DO
     LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
     LOOP WHILE CHAR$ = ""
     SELECT CASE ASC(CHAR$)
         CASE IS = 8
            IF contents$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
            IF contents$ <> "" THEN contents$ = LEFT$(contents$, LEN(contents$) - 1): tc = tc - 1
         CASE IS = 13: Limitinput$ = contents$: EXIT FUNCTION
         CASE IS = 27: Limitinput$ = CHR$(27): EXIT FUNCTION
         CASE ELSE:
         SELECT CASE tc
              CASE IS < allowedchars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l9B": GOTO TOS:
         END SELECT
     END SELECT
LOOP

END FUNCTION

SUB RealTime (nos)

IF nos < 60 THEN
    hrs = 0: min = 0: sec = nos: GOTO 50    'if < 1 min, all seconds, done
ELSEIF nos >= 60 AND nos < 3600 THEN
    hrs = 0: min = INT(nos / 60): sec = nos MOD 60: GOTO 50
ELSEIF nos >= 3600 THEN
    min = INT(nos / 60): hrs = INT(min / 60): min = min - (hrs * 60)
    sec = nos MOD 60: GOTO 50
END IF
IF nos < 60 THEN
    hrs = 0: min = 0: sec = nos: GOTO 50    'if < 1 min, all seconds, done
ELSEIF nos >= 60 AND nos < 3600 THEN
    hrs = 0: min = INT(nos / 60): sec = nos MOD 60: GOTO 50
ELSEIF nos >= 3600 THEN
    min = INT(nos / 60): hrs = INT(min / 60): min = min - (hrs * 60)
    sec = nos MOD 60: GOTO 50
END IF
50
END SUB

