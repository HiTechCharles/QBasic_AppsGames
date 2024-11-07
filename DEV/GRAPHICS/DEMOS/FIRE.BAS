'FIRE.BAS by Matt Bross, 1997
'HOMEPAGE - http://www.GeoCities.Com/SoHo/7067/
'EMAIL    - oh_bother@GeoCities.Com
DEFINT A-Z
SCREEN 13: CLS
RANDOMIZE TIMER

OUT &H3C8, 0
FOR a = 0 TO 63
  OUT &H3C9, (a * 34) \ 10
  OUT &H3C9, (a * 212) \ 100
  OUT &H3C9, (a * 4) \ 10
NEXT

CIRCLE (160, 100), 20, 15

DEF SEG = &HA000
DO
  FOR Y = 140 TO 60 STEP -1: FOR X = 180 TO 140 STEP -1
    C% = PEEK(X + Y * 320&)
      IF C% <> 0 THEN
        C% = C% - INT(RND * 5): IF C% < 0 THEN C% = 0
        POKE (X% + (Y% - 1) * 320&), C%
      END IF
  NEXT: NEXT
LOOP UNTIL INKEY$ <> ""
DEF SEG

