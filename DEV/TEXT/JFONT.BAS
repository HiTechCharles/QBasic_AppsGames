DECLARE SUB JFont (a$, c, XCoordinate, YCoordinate, Size)

SCREEN 13: CLS

'----------------------------------------
DIM SHARED charset(128, 8, 6)   'array for storing font information
OPEN "fontdata.dat" FOR INPUT AS #9
RANDOMIZE TIMER
FOR a = 1 TO 126
FOR x = 1 TO 8

      FOR y = 1 TO 6
        INPUT #9, B
        charset(a, x, y) = B        'loads font data into 3-D array.
      NEXT y

   NEXT x
NEXT a
CLOSE

PALETTE 200, 0
'----------------------------------------

JFont "ABCDEFGHI", 9, 0, 0, 6
JFont "JKLMNOPQR", 9, 0, 50, 6
JFont "STUVWXYZ0", 9, 0, 100, 6
JFont "23456789 ", 9, 0, 150, 6
SLEEP

SUB JFont (a$, c, XCoordinate, YCoordinate, Size)

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

