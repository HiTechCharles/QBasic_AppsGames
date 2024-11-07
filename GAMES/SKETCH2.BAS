DECLARE FUNCTION Limitinput$ (AllowedChars!)
DECLARE SUB bigletter (w$, sz, colr, style, Xpos, Ypos)
DECLARE SUB center (row, text$)
DECLARE SUB choosefile (fext$)
DECLARE SUB ClearSL ()
DECLARE SUB DisplayFile ()
DECLARE FUNCTION I2a$ (h)
DECLARE SUB RestartFile ()
DECLARE SUB SetupScreen ()
COMMON SHARED dr, BNF, fr, xp, yp, SS$, linelength, llt, lls, llc, xyt, xys, xyc, fil$, selected$
ON ERROR GOTO ErrorHandler:

C$ = COMMAND$
IF C$ = "" THEN fil$ = "sketch2.skc" ELSE fil$ = C$
IF C$ = "/?" OR C$ = "-?" THEN GOTO USAGE:

IF RIGHT$(fil$, 1) = "." THEN fil$ = fil$ + ".skc"
IF INSTR(fil$, ".") = 0 THEN fil$ = fil$ + ".skc"

SCREEN 13: linelength = 5: fr = 1
CONST CursorColor = 14, XYmin = 12, XpMAX = 308, YpMAX = 187, sketchback = 27

bigletter "Sketch", 3, 42, 1, -1, 0
bigletter "2", 4, 78, 1, -1, 22
COLOR 15: center 8, "By Charles Martin":  DRAW "bm290,150"

DO UNTIL R$ = "END"
   READ R$: DRAW R$
LOOP
LOCATE 13, 31: PRINT "7": LOCATE 13, 33: PRINT "8": LOCATE 13, 36: PRINT "9"
LOCATE 16, 31: PRINT "4": LOCATE 16, 36: PRINT "6"
LOCATE 18, 31: PRINT "1": LOCATE 18, 33: PRINT "2": LOCATE 18, 36: PRINT "3"

LOCATE 12, 1: PRINT "Use the NUMBER PAD keys to"
PRINT "draw as shown to the right."
PRINT
PRINT " +  Increase line length"
PRINT " -  Decrease line length"
PRINT " C  Circle"
PRINT
PRINT " T  Triangle -- Press"
PRINT "    direction of point"
COLOR 10: center 23, "Press any key to start!": SLEEP

skbegin:
    SetupScreen

IF fr = 1 THEN DisplayFile
fr = 0: IF linelength < 1 THEN linelength = 5

DO
inl:
    IF llc = 1 AND llt >= 2 THEN ClearSL: llt = 0: llc = 0: lls = 0
    IF xyc = 1 AND xyt >= 2 THEN ClearSL: xyt = 0: xyc = 0: xys = 0
    
    IF llc = 1 THEN llt = TIMER - lls
    IF xyc = 1 THEN xyt = TIMER - xys
   
    K$ = LCASE$(INKEY$)
        PSET STEP(0, 0), CursorColor
        IF K$ = CHR$(13) AND dr <> 0 THEN RestartFile: GOTO skbegin:
        IF K$ = CHR$(27) THEN CLOSE #4: SYSTEM
        IF K$ = "1" THEN ds$ = "g" + I2a$(linelength): GOTO drwi:
        IF K$ = "2" THEN ds$ = "d" + I2a$(linelength): GOTO drwi:
        IF K$ = "3" THEN ds$ = "f" + I2a$(linelength): GOTO drwi:
        IF K$ = "4" THEN ds$ = "l" + I2a$(linelength): GOTO drwi:
        IF K$ = "6" THEN ds$ = "r" + I2a$(linelength): GOTO drwi:
        IF K$ = "7" THEN ds$ = "h" + I2a$(linelength): GOTO drwi:
        IF K$ = "8" THEN ds$ = "u" + I2a$(linelength): GOTO drwi:
        IF K$ = "9" THEN ds$ = "e" + I2a$(linelength): GOTO drwi:
        IF K$ = "+" THEN J = 1: GOTO changeLL:
        IF K$ = "-" THEN J = -1: GOTO changeLL:
        IF K$ = "*" THEN J = linelength: GOTO changeLL:
        IF K$ = "/" THEN J = -INT(linelength / 2): GOTO changeLL:
        IF K$ = "c" THEN GOTO DRWC:
        IF K$ = "f" AND dr <> 0 THEN PAINT STEP(0, 0), 0, 0: dr = 1: GOTO inl:
        IF K$ = "t" THEN GOTO DrwT:
        'IF K$ = "o" THEN GOTO OpenFIle:
LOOP

drwi:
    PRESET STEP(0, 0), sketchback:
      SELECT CASE LEFT$(ds$, 1)
           CASE IS = "l": xtm = -linelength: ytm = 0
           CASE IS = "r": xtm = linelength: ytm = 0
           CASE IS = "u": xtm = 0: ytm = -linelength
           CASE IS = "d": xtm = 0: ytm = linelength
           CASE IS = "e": xtm = linelength: ytm = -linelength
           CASE IS = "f": xtm = linelength: ytm = linelength
           CASE IS = "g": xtm = -linelength: ytm = linelength
           CASE IS = "h": xtm = -linelength: ytm = -linelength
      END SELECT

    IF xp + xtm < XYmin OR xp + xtm > XpMAX THEN PLAY "o2 t120 L55B":     GOTO inl:
    IF yp + ytm < XYmin OR yp + ytm > YpMAX THEN PLAY "o2 t120 L55B":    GOTO inl:
    xp = xp + xtm: yp = yp + ytm
        
    DRAW "c0" + ds$: dr = 1
    WRITE #4, ds$: ds$ = ""
    GOTO inl:

DRWC:
    xtm = linelength: ytm = linelength: ' ytm = ytm - 3
    IF xp - xtm < XYmin OR xp + xtm > XpMAX THEN PLAY "o2 t120 L55B":    GOTO inl:
    IF yp - ytm < XYmin OR yp + ytm > YpMAX THEN PLAY "o2 t120 L55B":   GOTO inl:
    CIRCLE STEP(0, 0), linelength, 0: dr = 1: WRITE #4, "CI=" + I2a$(linelength): GOTO inl:
DrwT:
    xtm = linelength: ytm = linelength
    X$ = I2a$(xtm)
gtd:
    K$ = LCASE$(INKEY$)
        IF K$ = "4" THEN a$ = " u": B$ = " g": C$ = " f": D$ = " u": GOTO DIT:
        IF K$ = "6" THEN a$ = " u": B$ = " f": C$ = " g": D$ = " u": GOTO DIT:
        IF K$ = "2" THEN a$ = " r": B$ = " g": C$ = " h": D$ = " r":  GOTO DIT:
        IF K$ = "8" THEN a$ = " r": B$ = " h": C$ = " g": D$ = " r": GOTO DIT:
        IF K$ = CHR$(27) THEN GOTO inl
    GOTO gtd:
DIT:
    SELECT CASE K$
        CASE IS = "4"
            IF xp - xtm < XYmin THEN PLAY "o2 t120 L55B":    GOTO inl:  'L
            IF yp - ytm < XYmin THEN PLAY "o2 t120 L55B":    GOTO inl:  'U
            IF yp + ytm > YpMAX THEN PLAY "o2 t120 L55B":    GOTO inl:  'D
            GOTO DtT:
        CASE IS = "6"
            IF xp + xtm > XpMAX THEN PLAY "o2 t120 L55B":    GOTO inl:  'R
            IF yp - ytm < XYmin THEN PLAY "o2 t120 L55B":    GOTO inl:  'U
            IF yp + ytm > YpMAX THEN PLAY "o2 t120 L55B":    GOTO inl:  'D
            GOTO DtT:     
        CASE IS = "2"
            IF yp + ytm > YpMAX THEN PLAY "o2 t120 L55B":   GOTO inl:  'D
            IF xp + xtm > XpMAX THEN PLAY "o2 t120 L55B":   GOTO inl:  'R
            IF xp - xtm < XYmin THEN PLAY "o2 t120 L55B":   GOTO inl:  'L
            GOTO DtT:
       CASE IS = "8"
            IF xp + xtm > XpMAX THEN PLAY "o2 t120 L55B":   GOTO inl:  'R
            IF xp - xtm < XYmin THEN PLAY "o2 t120 L55B":   GOTO inl:  'L
            IF yp - ytm < XYmin THEN PLAY "o2 t120 L55B":   GOTO inl:  'U
            GOTO DtT:
    END SELECT
DtT:
      DRAW "c0 " + a$ + X$ + B$ + X$ + C$ + X$ + D$ + X$
      WRITE #4, a$ + X$: WRITE #4, B$ + X$: WRITE #4, C$ + X$: WRITE #4, D$ + X$: dr = 1
      GOTO inl:
changeLL:
    linelength = linelength + J
    IF linelength < 1 THEN linelength = 1
    IF linelength > 295 THEN linelength = 5
    COLOR 15: LOCATE 1, 3: PRINT "LINE LENGTH: "; USING "###"; linelength
    llc = 1: lls = TIMER
    GOTO inl:

ErrorHandler:
    SELECT CASE ERR
           CASE IS = 53: OPEN fil$ FOR APPEND AS #4: BNF = 1
               RESUME NEXT
           CASE ELSE: LOCATE 5, 5: PRINT "ERROR #"; ERR; ; "OCCURED": SYSTEM  ' RESUME NEXT
    END SELECT

'------------DATA for Instruction screen
DATA l20, l20, l20
DATA u20
DATA u20
DATA u20
DATA r20
DATA r20
DATA r20
DATA d20
DATA d20
DATA d20
DATA l20
DATA u20
DATA u20
DATA u20
DATA l20
DATA d20
DATA d20
DATA d20
DATA l20
DATA u20
DATA r20
DATA r20
DATA r20
DATA u20
DATA l20
DATA l20
DATA l20
DATA u20
DATA h15
DATA f15
DATA r10
DATA r10
DATA r10
DATA u10
DATA d10
DATA u10
DATA d10
DATA r10
DATA r10
DATA r10
DATA e15
DATA g15
DATA d10
DATA d10
DATA d10
DATA r10
DATA l10
DATA d10
DATA d10
DATA d10
DATA f15
DATA h15
DATA l10
DATA l10
DATA l10
DATA d10
DATA u10
DATA l10
DATA l10
DATA l10
DATA g15
DATA e15
DATA u10
DATA u10
DATA u10
DATA l10
DATA r10
DATA d10
DATA d10
DATA d10
DATA g10
DATA e10
DATA r10
DATA r10
DATA r10
DATA d10
DATA u10
DATA d15
DATA u15
DATA l10
DATA l10
DATA l10
DATA u10
DATA u10
DATA u10
DATA l15
DATA r15
DATA u10
DATA u10
DATA u10
DATA r10
DATA r10
DATA r10
DATA u15
DATA d15
DATA r10
DATA r10
DATA r10
DATA d10
DATA d10
DATA d10
DATA r15
DATA l15
DATA r15
DATA g7
DATA e7
DATA h7
DATA f7
DATA l15
DATA d15
DATA d15
DATA f15
DATA h15
DATA l15
DATA l15
DATA d15
DATA h7
DATA f7
DATA e7
DATA g7
DATA u7
DATA d7
DATA u15
DATA l10
DATA l10
DATA l10
DATA u10
DATA u10
DATA u10
DATA l15
DATA f7
DATA h7
DATA e7
DATA g7
DATA r15
DATA u10
DATA u10
DATA u10
DATA r10
DATA r10
DATA r10
DATA u15
DATA g7
DATA e7
DATA f7
DATA h7
DATA d15
DATA r15
DATA r15
DATA e15
DATA l7
DATA r7
DATA f7
DATA h7
DATA l7
DATA r7
DATA l7
DATA l7
DATA r7
DATA r7
DATA g15
DATA d15
DATA d5
DATA d10
DATA d10
DATA d10
DATA d10
DATA f15
DATA h15
DATA f15
DATA e7
DATA g7
DATA l7
DATA l7
DATA r7
DATA r7
DATA h15
DATA l10
DATA l10
DATA l10
DATA l10
DATA l10
DATA l10
DATA g10
DATA e10
DATA g15
DATA h7
DATA f7
DATA e7
DATA g7
DATA r7
DATA r7
DATA l7
DATA l7
DATA e15
DATA u15
DATA u5
DATA u10
DATA u10
DATA u10
DATA u10
DATA h15
DATA g7
DATA e7
DATA r7
DATA r7
DATA l7
DATA l7
DATA f15
DATA END

USAGE:
PRINT : PRINT : PRINT
PRINT "SKETCH 2 - An Etch-A-Sketch-type drawing program"
PRINT : PRINT "BY Charles Martin"
PRINT : PRINT
PRINT "As you draw, your moves are saved to a file so it can be continued later."
PRINT
PRINT "   USAGE:  SKETCH2 <FIleName>"
PRINT "EZAMPLES:  SKETCH2 wheel"
PRINT "           SKETCH2 drawing"
SYSTEM


OpenFIle:
choosefile "SKC"
fil$ = selected$: CLOSE #4
GOTO skbegin:

SUB bigletter (w$, sz, colr, style, Xpos, Ypos)
COLOR 15
DIM box(-1 TO 7, -1 TO 15)
wordlength = LEN(w$) * sz * 8
wordheight = sz * 16
IF Xpos = -1 THEN Xpos = 160 - (wordlength / 2)

PALETTE 15, 0
FOR LETTER = 1 TO LEN(w$)
LOCATE 1, 1
PRINT MID$(w$, LETTER, 1)
FOR X = 0 TO 7
FOR y = 0 TO 15
box(X, y) = POINT(X, y)
NEXT y
NEXT X
FOR X = 0 TO 7
left = Xpos + (X * sz)
right = left + sz
lr = (left + right) \ 2
FOR y = 0 TO 15
up = Ypos + (y * sz)
down = up + sz
ud = (up + down) \ 2
IF box(X, y) THEN
SELECT CASE style
CASE 1
LINE (left, up)-(right, down), colr, BF
CASE 2
LINE (left, up)-(right, down), colr, B
END SELECT
END IF
NEXT y
NEXT X
Xpos = Xpos + (sz * 8)
NEXT LETTER
LOCATE 1, 1
PRINT " "
PALETTE
END SUB

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB choosefile (fext$)
     
DIM fil$(69): COLOR 15: CLS : C = -20: LN = 1: HIGHEST = 1: SHELL "DIR /-p /o:gn /b *." + fext$ + " > CMFL": OPEN "CMFL" FOR INPUT AS #8
DO UNTIL EOF(8)
   INPUT #8, fil$(HIGHEST): fil$(HIGHEST) = UCASE$(fil$(HIGHEST))
   HIGHEST = HIGHEST + 1
LOOP
CLOSE #8: KILL "CMFL": HIGHEST = HIGHEST - 1
IF HIGHEST = 0 THEN BEEP: PRINT "NO FILES WERE FOUND OF TYPE "; UCASE$(fext$): SLEEP 2: SYSTEM
FOR F = 1 TO HIGHEST
    C = C + 21
    IF C > 22 THEN C = 1: LN = LN + 1
    IF LN > 21 THEN
       LOCATE 23, 5: COLOR 10: PRINT "PRESS ANY KEY FOR MORE...": SLEEP
       COLOR 15: LN = 1: C = 1: CLS
END IF
    LOCATE LN, C, 0: PRINT USING "##="; F; : PRINT fil$(F)
NEXT F
GTF:
LOCATE 23, 1: PRINT SPACE$(40):  : COLOR 14: LOCATE 23, 1: PRINT "Type in a number beteeen 1 and"; HIGHEST; "   "; : F = VAL(Limitinput$(2))
IF F < 1 OR F > HIGHEST THEN GOTO GTF:
selected$ = fil$(F)
LOCATE 23, 1: PRINT SPACE$(40): LOCATE 23, 1: PRINT "FILE SELECTED:  "; selected$
SLEEP 3: ERASE fil$


END SUB

SUB ClearSL
LINE (0, 0)-(319, 199), sketchback, B
DRAW "c8 bm10,10 r299 d178 l299 u178"
PAINT (5, 5), 4, 8: LINE (0, 0)-(319, 199), 27, B
CIRCLE (10, 194), 5, 15: PAINT (10, 194), 15, 15
CIRCLE (309, 194), 5, 15: PAINT (309, 194), 15, 15
DRAW "c8 bm" + I2a$(xp) + "," + I2a$(yp)

END SUB

SUB DisplayFile
DO UNTIL INKEY$ = "": LOOP

OPEN fil$ FOR INPUT AS #4
IF BNF = 1 THEN EXIT SUB ELSE DRAW "bm160,100"
xp = 160: yp = 100

     IF INKEY$ <> "" THEN GOTO LAX:
TOL:
    IF EOF(4) THEN GOTO LAX:
    INPUT #4, D$: LOI = LEN(D$)
   
    SELECT CASE LEFT$(D$, 3)
        CASE IS = "CI="
        num = VAL(RIGHT$(D$, LOI - 3))
        IF num <> 0 THEN LL = num
        CIRCLE STEP(0, 0), num, 0
        GOTO TOL:
      CASE ELSE
          LTR$ = UCASE$(LEFT$(D$, 1))
          num = VAL(RIGHT$(D$, LOI - 1))
          IF num <> 0 THEN LL = num
          DRAW "c0" + D$
          SELECT CASE LTR$
            CASE IS = "L": xp = xp - num: GOTO TOL:
            CASE IS = "R": xp = xp + num: GOTO TOL:
            CASE IS = "U": yp = yp - num: GOTO TOL:
            CASE IS = "D": yp = yp + num: GOTO TOL:
            CASE IS = "E": xp = xp + num: yp = yp - num: GOTO TOL:
            CASE IS = "F": xp = xp + num: yp = yp + num: GOTO TOL:
            CASE IS = "G": xp = xp - num: yp = yp + num: GOTO TOL:
            CASE IS = "H": xp = xp - num: yp = yp - num: GOTO TOL:
            END SELECT
    END SELECT
    GOTO TOL:

LAX:
linelength = LL
CLOSE #4: OPEN fil$ FOR APPEND AS #4
END SUB

FUNCTION I2a$ (h)
I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION Limitinput$ (AllowedChars)
tc = 0: CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
TOS:
     DO
        LOCATE CSRLIN, POS(0), 0: CHAR$ = INKEY$
     LOOP WHILE CHAR$ = ""
     SELECT CASE ASC(CHAR$)
         CASE IS = 8
            IF contents$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
            IF contents$ <> "" THEN contents$ = LEFT$(contents$, LEN(contents$) - 1): tc = tc - 1
         CASE IS = 13: Limitinput$ = contents$: EXIT FUNCTION
         CASE ELSE:
         SELECT CASE tc
              CASE IS < AllowedChars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l9B": GOTO TOS:
         END SELECT
     END SELECT
LOOP





END FUNCTION

SUB RestartFile
CLOSE #4
KILL fil$
OPEN fil$ FOR APPEND AS #4
xp = 160: yp = 100: llt = 0: lls = 0: llc = 0: xyc = 0: xys = 0: xyt = 0
END SUB

SUB SetupScreen
CLS : dr = 0
LINE (0, 0)-(319, 199), sketchback, B
LINE (10, 10)-(309, 188), sketchback, BF
PAINT (3, 3), 4, sketchback
LINE (10, 10)-(309, 188), 0, B

CIRCLE (10, 194), 5, 15: PAINT (10, 194), 15, 15
CIRCLE (309, 194), 5, 15: PAINT (309, 194), 15, 15
DRAW "bm160,100": xp = 160: yp = 100
END SUB

