SCREEN 9: DIM x  AS INTEGER, y AS INTEGER, r AS INTEGER

DO
  c = INT(RND * 15) + 1
  COLOR c
  x = RND * 720
  y = (RND * 100) + 200
  r = (RND * 20) + 10
  CIRCLE (x, y), r, , , , .8
  PRINT ""
LOOP WHILE INKEY$ = ""

