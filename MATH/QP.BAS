DECLARE SUB center (row, text$)
DECLARE SUB DisplayResults ()
DECLARE SUB Intro ()
DECLARE FUNCTION limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
COMMON SHARED CurPerc, Result, ntd

CONST PercFormat$ = "####=#,###,###.##   "
OPEN "QP.txt" FOR APPEND AS #1: WIDTH 40, 25

begin:
    Intro
    DisplayResults
    COLOR 10: LOCATE 23, 1: PRINT "C for custom %, ENTER to continue..."
EOD:
    k$ = LCASE$(INKEY$)
    IF k$ = CHR$(13) OR k$ = " " OR k$ = CHR$(27) THEN GOTO begin:
    IF k$ = "c" THEN
        LOCATE 23, 1: PRINT SPACE$(40): LOCATE 23.1: COLOR 10
        PRINT "OTHER PERCENTAGE:  >"; : COLOR 13
        CurPerc = VAL(limitinput$(4, "0123456789.", CSRLIN, POS(0), ""))
        Result = (CurPerc / 100) * ntd
        COLOR 9: LOCATE 2, 1:
        PRINT USING "####=#,###,###.##"; CurPerc; Result; : LOCATE 23, 1: PRINT SPACE$(40):
        COLOR 10: LOCATE 23, 1: PRINT "C for custom %, ENTER to continue..."
        GOTO EOD:
    END IF
GOTO EOD:
DATA 5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,110,120
DATA 110,120,125,133,140,150,160, 166,170,175,180,200,250,300,350,400,500,600,700,800,1000,0

SUB center (row, text$)
    col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB DisplayResults
COLOR 13: CLS : PRINT "   %       RESULT      %       RESULT"
LOCATE 2, 1: COLOR 15: RESTORE: CurPerc = .01: Fpos = 0
PRINT #1, "   %       RESULT      %       RESULT"
PRINT #1, "---- ------------   ---- ------------"

DO UNTIL CurPerc = 0
    READ CurPerc: IF CurPerc = 0 THEN EXIT DO
    Result = (CurPerc / 100) * ntd
    PRINT USING PercFormat$; CurPerc; Result;
    Fpos = Fpos + 1
    PRINT #1, USING PercFormat$; CurPerc; Result;
    IF Fpos = 2 THEN PRINT #1, "": Fpos = 0
LOOP
PRINT #1, :  PRINT #1, : PRINT #1, STRING$(40, "-"): PRINT #1, : PRINT #1,
COLOR 14: FOR L = 1 TO 22: LOCATE L, 19: PRINT "³": NEXT L

END SUB

SUB Intro

COLOR 9: CLS
center 2, "QuickPercentage": COLOR 15: center 3, "By CHarles Martin"
COLOR 14: LOCATE 6, 1:                        'f
PRINT "This program will show you different    "
PRINT "percentages of a given number.  For     "
PRINT "example, the number is 200, the program "
PRINT "displays:  25%=50   33%=66.6  50%=100..."
PRINT
PRINT "After using this program, the file      "
PRINT "QP.txt will contain everything displayed"
PRINT "on the screen, oldest calculations      "
PRINT "first.                                  "

GTN:
DO UNTIL INKEY$ = "": LOOP
COLOR 15: LOCATE 18, 1: PRINT "What is the number?  (0 to quit)": PRINT ">"; : COLOR 13
ntd = VAL(limitinput$(7, "0123456789.e", 19, 2, ""))
IF ntd < 1 THEN SYSTEM
IF ntd > 999999.99# THEN SOUND 622, 1.5: PRINT : PRINT : PRINT "1 to 999,999.99, please.": SLEEP 3: VIEW PRINT 17 TO 23: CLS : VIEW PRINT: GOTO GTN:
IF ntd = 1 THEN ntd = INT(RND * 9999) + 1

END SUB

FUNCTION limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)


'   USAGE:  StringVariable$ = LimitInput$ (<# characters allowed>, <characters allowed in string>, <Row>, <Collumn>, <Existing tecxt>)
'EXAMPLES:  NUM = val(LimitInput$ (12, "0123456789.", 5, 5, ""))
            'up to 12 digits, only numbers and decimal allowed, start typing at 5,5         

allowesc = 1   'allow escape to be pushed during input

'---------
LOCATE row, col: PRINT et$; : CONTENTS$ = et$
LT$ = CHR$(0) + CHR$(75): RT$ = CHR$(0) + CHR$(77)
ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8)
IF allowesc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27) + LT$ + RT$
TC = LEN(et$): CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
tos:
     DO
     LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
      EndCol = LEN(CONTENTS$): CurCol = POS(0)
    LOOP WHILE CHAR$ = ""
     IF INSTR(ALLOWEDCHARS$, CHAR$) = 0 THEN GOTO tos:
     SELECT CASE CHAR$
         CASE IS = CHR$(8)
            IF CONTENTS$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
            IF CONTENTS$ <> "" THEN CONTENTS$ = LEFT$(CONTENTS$, LEN(CONTENTS$) - 1): TC = TC - 1
         CASE IS = CHR$(13): limitinput$ = CONTENTS$: EXIT FUNCTION
         CASE IS = CHR$(27)
            IF allowesc = 1 THEN limitinput$ = CHR$(27): EXIT FUNCTION
         CASE IS = LT$: IF TC > 0 THEN PRINT CHR$(29); : TC = TC - 1
         CASE IS = RT$: IF TC <= ALLOWEDCHARS THEN PRINT CHR$(28); : TC = TC + 1
         CASE ELSE:
         SELECT CASE TC
              CASE IS < ALLOWEDCHARS: PRINT CHAR$; : TC = TC + 1: CONTENTS$ = CONTENTS$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l29B": GOTO tos:
         END SELECT
     END SELECT
LOOP
END FUNCTION

