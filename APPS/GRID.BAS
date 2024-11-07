DECLARE FUNCTION C2I (CV)
DECLARE SUB Center (Row, text$)
DECLARE FUNCTION i2a$ (h)
DECLARE FUNCTION I2C (IV)
DECLARE FUNCTION limitinput$ (allowedchars)
DECLARE FUNCTION MesUnit$ ()
DECLARE SUB SavePCX (FileName$, MinX, MinY, MaxX, MaxY)
DEFSNG A-Z
DIM SHARED hm, gridsize, PixelsPerInch, pixelspercentimeter, st, et, x, y, mu, mu$

PixelsPerInch = 22:      pixelspercentimeter = 8
    GridColor = 15:           gridbackground = 25

h$ = COMMAND$
IF h$ = "/?" OR h$ = "-?" OR h$ = "HELP" THEN
    COLOR 15: PRINT : PRINT
    PRINT "GridMaker - Makes a grid of squares"
    PRINT "with the size you choose"
    PRINT
    PRINT "   USAGE:  Grid <SIZE><UNIT OF MEASURE>"
    PRINT "EXAMPLES:  Grid 1.5in  (1-inch squares)"
    PRINT "           GRID 7CM    (7-centimeter squares"
    PRINT "           GRID 9px    (9-pixel squares)"
    PRINT : PRINT : SYSTEM
ELSEIF h$ = "" THEN
    GOTO begin:
ELSE
    IF RIGHT$(h$, 1) = "." THEN h$ = LEFT$(h$, LEN(h$) - 1)
    um$ = RIGHT$(h$, 2): hm = VAL(h$)
    SELECT CASE um$
        CASE "IN": mu = 1: gridsize = PixelsPerInch: GOTO StartDrawing:
        CASE "CM": mu = 2: gridsize = pixelspercentimeter: GOTO StartDrawing:
        CASE "PX": mu = 3: gridsize = 1: GOTO StartDrawing:
        CASE ELSE: GOTO begin:
    END SELECT
END IF

begin:
SCREEN 13: COLOR 14: CLS : Center 2, "Grid Maker": Center 3, "By Charles Martin"

COLOR 13: LOCATE 6, 1: PRINT "How large should the squares be - Choose"
PRINT "one of the following by letter:"

LOCATE 9, 1:
PRINT "     C.  Centimeters"
PRINT
PRINT "     I.  Inches"
PRINT
PRINT "     P.  Pixels"
PRINT
PRINT "     Q.  Quit"
tk:
k$ = LCASE$(INKEY$)
    IF k$ = "i" THEN gridsize = PixelsPerInch: mu = 1: GOTO howmany:
    IF k$ = "c" THEN gridsize = pixelspercentimeter: mu = 2: GOTO howmany:
    IF k$ = "p" THEN gridsize = 1: mu = 3: GOTO howmany:
    IF k$ = "q" THEN SYSTEM
    IF k$ = CHR$(27) THEN SYSTEM
GOTO tk:

howmany:
IF hm <> 0 THEN GOTO StartDrawing:
VIEW PRINT 4 TO 23: CLS : VIEW PRINT: COLOR 15: LOCATE 6, 1: PRINT "How many "; MesUnit$;
PRINT " should": PRINT "each square be?   >"; : COLOR 14
hm = VAL(limitinput$(5))
IF hm < .1 THEN GOTO howmany:

StartDrawing:
gridsize = INT(gridsize * hm)
SCREEN 13: CLS : PAINT (0, 0), gridbackground, gridbackground
gridsize$ = i2a$(gridsize): DRAW "bm0,0 c" + i2a$(GridColor)

st = TIMER
FOR R = 1 TO INT(199 / gridsize)
    x = 0
    FOR c = 1 TO INT((319 / gridsize))
        DRAW "r" + gridsize$ + "d" + gridsize$ + "l" + gridsize$ + "u" + gridsize$ + "r" + gridsize$
        x = x + gridsize
    NEXT c
    y = y + gridsize: y$ = i2a$(y):  DRAW "bm0," + y$:
NEXT R
et = TIMER - st: SLEEP
SavePCX "Grid.pcx", 0, 0, x, y

COLOR 14
LOCATE 1, 1, 0: PRINT i2a$(et); "s   "; : c = POS(0): PRINT USING "###.## "; hm; : PRINT MesUnit$;
SELECT CASE mu
    CASE IS = 1:
        LOCATE 2, c: PRINT USING "###.## "; I2C(hm); : PRINT "Centimeters"
        LOCATE 3, c: PRINT USING "###.## "; gridsize; : PRINT "Pixels"
    CASE IS = 2:
        LOCATE 2, c: PRINT USING "###.## "; C2I(hm); : PRINT "Inches"
        LOCATE 3, c: PRINT USING "###.## "; gridsize; : PRINT "Pixels"
    CASE IS = 3:
        in = gridsize / PixelsPerInch
        LOCATE 2, c: PRINT USING "###.## "; in; : PRINT "Inches"
        LOCATE 3, c: PRINT USING "###.## "; I2C(in); : PRINT "Centimeters"
END SELECT

PRINT : PRINT :
PRINT "A copy of the grid you just made"
PRINT "is in the file GRID.PCX, located"
PRINT "in the current directory.": SLEEP

FUNCTION C2I (CV)
C2I = CV * .39
END FUNCTION

SUB Center (Row, text$)
Col = 21 - LEN(text$) / 2: LOCATE Row, Col: PRINT text$
END SUB

FUNCTION i2a$ (h)
i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION I2C (IV)
I2C = IV * 2.54
END FUNCTION

FUNCTION limitinput$ (allowedchars)
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
         CASE IS = 13: limitinput$ = contents$: EXIT FUNCTION
         CASE ELSE:
         SELECT CASE tc
              CASE IS < allowedchars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l9B": GOTO TOS:
         END SELECT
     END SELECT
LOOP

END FUNCTION

FUNCTION MesUnit$

IF mu = 1 THEN
    IF hm <> 1 THEN MesUnit$ = "Inches" ELSE MesUnit = "Inch"
    EXIT FUNCTION
ELSEIF mu = 2 THEN
    IF hm <> 1 THEN MesUnit$ = "Centimeters" ELSE MesUnit = "Centimeter"
    EXIT FUNCTION
ELSE
    IF mu = 3 THEN MesUnit$ = "Pixels" ELSE MesUnit = "Pixel"
    EXIT FUNCTION
END IF
END FUNCTION

SUB SavePCX (FileName$, MinX, MinY, MaxX, MaxY)
FF = FREEFILE

OPEN FileName$ FOR BINARY AS #FF
IF LOF(FF) <> 0 THEN
   '/* If the file is not empty then it is deleted */'
   CLOSE #FF
   KILL FileName$
   OPEN FileName$ FOR BINARY AS #FF
END IF

ValidPCX1$ = CHR$(10): PCXVersion$ = CHR$(5): ValidPCX2$ = CHR$(1)
BitsPerPixel$ = CHR$(8)
ScreenMinX$ = MKI$(MinX): ScreenMinY$ = MKI$(MinY)
ScreenMaxX$ = MKI$(MaxX): ScreenMaxY$ = MKI$(MaxY)
PixelWidth$ = MKI$((MaxX - MinX) + 1): PixelHeight$ = MKI$((MaxY - MinY) + 1)
Palette4Bit$ = SPACE$(48): Reserved$ = CHR$(0): NoOfPlanes$ = CHR$(1)
BytesPerLine$ = PixelWidth$: PaletteInfo$ = CHR$(1): FillHeader$ = STRING$(59, 0)
ValidPCX3$ = CHR$(12)

'/*  ------ Header Info -------- */'
'/* The first Byte of a PCX is chr$(10) */'
PUT #FF, , ValidPCX1$
'/* The PCX Version is from 2.5 - 3 | We are using Version 3 */'
PUT #FF, , PCXVersion$
'/* The PCX has a reserved byte of chr$(1) */'
PUT #FF, , ValidPCX2$
'/* No of Bits per Pixel */'
PUT #FF, , BitsPerPixel$
'/* The Screen Ranges */'
PUT #FF, , ScreenMinX$
PUT #FF, , ScreenMinY$
PUT #FF, , ScreenMaxX$
PUT #FF, , ScreenMaxY$
'/* The Image Width and Height */'
PUT #FF, , PixelWidth$
PUT #FF, , PixelHeight$
'/* The Palette for 4-Bit images */'
PUT #FF, , Palette4Bit$
'/* Reserved byte of chr$(0)
PUT #FF, , Reserved$
'/* Number of Planes, always 1 */'
PUT #FF, , NoOfPlanes$
'/* Bytes per line */'
PUT #FF, , BytesPerLine$
'/* Palette type 0-2 */'
PUT #FF, , PaletteInfo$
'/* Header fill to fill the first 128 bytes of the file */'
PUT #FF, , FillHeader$

'/*  ------ Picture Data -------- */'

'/* Saves the screen into BSAVE format */'
DIM Image%(1 TO 32767)
GET (MinX, MinY)-(MaxX, MaxY), Image%
ImageVarSeg = VARSEG(Image%(1))
ImageVarOffset = VARPTR(Image%(1))
DEF SEG = ImageVarSeg
BSAVE "temp.fil", ImageOffset, 65535

Bytes11$ = SPACE$(11)
OPEN "temp.fil" FOR BINARY AS #254
'/* Extract the unnecessary bytes from the Bsave file */'
GET #254, , Bytes11$

LineExtract$ = SPACE$(CVI(PixelWidth$))
FOR Yaxis% = MinY TO MaxY
   GET #254, , LineExtract$
   LINE (MinX, Yaxis%)-(MaxX, Yaxis%), 0

   XPixel% = 1: NewLine$ = ""
   DO
      PixelColor$ = MID$(LineExtract$, XPixel%, 1)
      IF MID$(LineExtract$, XPixel% + 1, 1) = PixelColor$ THEN
         XPixel% = XPixel% + 2
         SamePixels = 2
         DO
         IF MID$(LineExtract$, XPixel%, 1) = PixelColor$ THEN
            SamePixels = SamePixels + 1
            XPixel% = XPixel% + 1
         ELSE
            EXIT DO
         END IF
         LOOP UNTIL SamePixels = 63
         NewLine$ = NewLine$ + CHR$(SamePixels + 192) + PixelColor$
      ELSE
         IF ASC(PixelColor$) > 191 THEN
            NewLine$ = NewLine$ + CHR$(193)
         END IF
         NewLine$ = NewLine$ + PixelColor$
         XPixel% = XPixel% + 1
      END IF
   LOOP UNTIL XPixel% > LEN(LineExtract$)
   PUT #FF, , NewLine$
NEXT Yaxis%
CLOSE #254: KILL "temp.fil"

'/*  ------ Palette Data -------- */'
PUT #FF, , ValidPCX3$
FOR Colors% = 0 TO 255
   '/* Extracts the Palette of each of the 256 colors into a red, green and blue */'
   '/* sections and places them into their corresponding variables */'
   OUT &H3C6, &HFF
   OUT &H3C7, Colors%
   Red$ = CHR$(INP(&H3C9) * 4): Green$ = CHR$(INP(&H3C9) * 4): Blue$ = CHR$(INP(&H3C9) * 4)
   '/* Places the extracted colors into the given file */'
   PUT #FF, , Red$
   PUT #FF, , Green$
   PUT #FF, , Blue$
NEXT Colors%
CLOSE #FF
END SUB

