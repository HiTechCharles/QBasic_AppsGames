DECLARE FUNCTION i2a$ (h)
DECLARE SUB jfont (a$, c, XCoordinate, YCoordinate, Size)
DIM SHARED charset(128, 8, 6)
COMMON SHARED num, printnrm, ct$, pt$
CLS

DO UNTIL TIME$ = "00:00:00"
Tol:
    ct$ = TIME$
    IF pt$ <> ct$ THEN jfont "        ", 15, 999, 10, 7
    pt$ = TIME$
    L$ = LEFT$(TIME$, 2): h = VAL(L$)
    m$ = MID$(TIME$, 4, 2)
    R$ = RIGHT$(TIME$, 2)
    IF LEN(m$) = 1 THEN m$ = "0" + m$
   
    SELECT CASE h
        CASE IS = 0: AP$ = "A": sh = 12
        CASE IS < 12: AP$ = "A": sh = h
        CASE IS = 12: AP$ = "P": sh = h
        CASE IS > 12: AP$ = "P": sh = h - 12
    END SELECT
    L$ = i2a$(sh)
    ts$ = L$ + ":" + m$ + ":" + R$: LOCATE 8, 39: COLOR 15: PRINT AP$ + "M"

    jfont ts$, 15, 999, 10, 7
    SELECT CASE TIME$
        CASE IS = "23:59:50": num = 10:  GOTO PrintNum:
        CASE IS = "23:59:51": num = 9:  GOTO PrintNum:
        CASE IS = "23:59:52": num = 8:  GOTO PrintNum:
        CASE IS = "23:59:53": num = 7:  GOTO PrintNum:
        CASE IS = "23:59:54": num = 6:  GOTO PrintNum:
        CASE IS = "23:59:55": num = 5:  GOTO PrintNum:
        CASE IS = "23:59:56": num = 4:  GOTO PrintNum:
        CASE IS = "23:59:57": num = 3:  GOTO PrintNum:
        CASE IS = "23:59:58": num = 2:  GOTO PrintNum:
        CASE IS = "23:59:59": num = 1:  GOTO PrintNum:
        CASE IS = "24:00:00": num = 0: GOTO NewYear:
    END SELECT
LOOP

PrintNum:
IF PrintNum <> num THEN CLS
jfont i2a$(num), 12, 999, 100, 10
PrintNum = num
GOTO Tol:


NewYear:
SYSTEM

FUNCTION i2a$ (h)
i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB jfont (a$, c, XCoordinate, YCoordinate, Size)

RANDOMIZE TIMER
SCREEN 13

OPEN "fontdata.dat" FOR INPUT AS #1

FOR a = 1 TO 126
FOR x = 1 TO 8
    
      FOR y = 1 TO 6
        INPUT #1, B
        charset(a, x, y) = B        'loads font data into 3-D array.
      NEXT y

   NEXT x
NEXT a

CLOSE

PALETTE 200, 0
PAINT (160, 100), 200




Size = INT(Size)             'No decimals allowed!
IF Size > 10 THEN Size = 10  'Check and fix invalid size calls
IF Size < 1 THEN Size = 1    'likewise for <.

YCoordinate = INT(YCoordinate / Size)     'Prevent ballooning of YCoordinates
                                          'that is a result of using
                                          'size values larger than 1 for size


'Enter 999 as XCoordinate for centered text...
IF XCoordinate = 999 THEN XCoordinate = 160 - (LEN(a$) * 3 * Size)

startx = XCoordinate               'set Starting X-Val for character drawing

FOR e = 1 TO LEN(a$)

   B$ = MID$(a$, e, 1)     ' read each character of the string
   a = ASC(B$)             ' get ASCII values of each character

      FOR x = 1 TO 8

         FOR y = 1 TO 6

            SELECT CASE charset(a, x, y)       'use ASCII value (a) to point
                                               'to the correct element in
                                               'the array

               CASE 0: col = 0                 ' Don't draw pixel

               CASE 1: col = c                 ' Draw pixel
              
               CASE ELSE                       ' Error!
                  CLS
                  SCREEN 9
                  BEEP
                  COLOR 4
                  PRINT "Error in FONTDATA.DAT"
                  PRINT "This could be the result of unauthorized tampering with the file."
                  PRINT "To fix: edit FONTDATA.DAT; make sure only 1's, 0's, and commas are there."
                  PRINT
                  PRINT "If you are still having trouble..."
                  PRINT "Send email to: davison_soft@geocities.com"
                  PRINT "to obtain a fresh copy of the file"
                  PRINT
                  PRINT "Program will now continue, but may exhibit erratic behavior..."
                  DO: LOOP UNTIL INKEY$ <> ""
                  SCREEN 13

            END SELECT

          IF col <> 0 THEN        'Draw a pixel!
           LINE (startx + pixelsright, (x + YCoordinate) * Size)-(startx + pixelsright + (Size - 1), ((x + YCoordinate) * Size) + (Size - 1)), col, BF
          END IF

          startx = startx + Size     'Set starting X-value for next pixel
       
        NEXT y
      
       startx = XCoordinate          'reset startx for next line of pixels
    
     NEXT x
   pixelsright = pixelsright + (6 * Size)   ' add pixels for next character

NEXT e

END SUB

