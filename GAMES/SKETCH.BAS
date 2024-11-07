DECLARE SUB center (row, text$)
DIM SHARED r, c
WIDTH 40, 25: COLOR 12: CLS : center 2, "S K E T C H"
COLOR 14: center 4, "by Charles Martin":  LOCATE 7, 1: COLOR 11:
PRINT "This is the computerized version of the"
PRINT "classic toy, the Etch-a-Sketch!  "
PRINT
PRINT "To draw, use the arrow keys.  To"
PRINT "start a new drawing, hit the ENTER"
PRINT "key.  Press ESCape to quit this"
PRINT "program  Enjoy!"
PRINT : PRINT : COLOR 13: PRINT "Press a key to start drawing!": SLEEP

sketch:
CONST down = 80, up = 72, left = 75, right = 77
SCREEN 0: r = 5: c = 5: CLS : COLOR 9, 9: LOCATE 1, 1: PRINT SPACE$(40)
FOR cl = 2 TO 22: LOCATE cl, 40: PRINT " ": NEXT cl: LOCATE 22, 1: PRINT SPACE$(40)
FOR cl = 2 TO 23: LOCATE cl, 1: PRINT " ": NEXT cl:
COLOR 14, 8: LOCATE 23, 1: PRINT "HIT ENTER TO CLEAR DRAWING, ESC TO QUIT"

RC: RANDOMIZE TIMER
sc = INT(RND * 14) + 1
IF sc = 8 OR sc = 9 OR sc = 11 OR sc = 3 OR sc = 7 THEN GOTO RC:
IF sc = 2 OR sc = 10 THEN cc = 8: GOTO drw:
cc = 15: GOTO drw:

drw:
DO UNTIL INKEY$ = CHR$(27)
PP:
IF r < 2 THEN r = 21
IF r > 21 THEN r = 2
IF c < 2 THEN c = 39
IF c > 39 THEN c = 2
LOCATE r, c: COLOR cc, cc: PRINT " "
LOCATE r, c: COLOR sc, sc: PRINT " "
a$ = INKEY$
   IF a$ = CHR$(0) + CHR$(up) THEN
      r = r - 1: GOTO PP
   END IF
   IF a$ = CHR$(0) + CHR$(down) THEN
      r = r + 1: GOTO PP:
   END IF
   IF a$ = CHR$(0) + CHR$(left) THEN
      c = c - 1: GOTO PP
   END IF
   IF a$ = CHR$(0) + CHR$(right) THEN
      c = c + 1: GOTO PP
   END IF
   IF a$ = CHR$(13) THEN
    CLEAR : COLOR 8, 8: GOTO sketch
   END IF
LOOP

SUB center (row, text$)

col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

