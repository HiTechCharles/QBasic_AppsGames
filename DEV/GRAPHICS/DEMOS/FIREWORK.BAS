CLS
SCREEN 12
RANDOMIZE TIMER
pi = 3.141592654#
min = 100
max = 200
n = 1
g = .05
delay = 0
delf = 1
disperse = 0        '0=diffuse 1=regular
IF disperse = 1 THEN delf = 1
DIM rocket(n, 6) AS DOUBLE
DO
 a$ = INKEY$
 FOR x = 1 TO n
  IF rocket(x, 5) = 0 THEN
   rocket(x, 1) = RND * 5 + 2
   rocket(x, 2) = RND * 4 - 2
   rocket(x, 3) = INT(RND * 640)
   rocket(x, 4) = 481
   rocket(x, 5) = 1
   rocket(x, 6) = 7
  END IF
 NEXT
 FOR x = 1 TO n
  IF rocket(x, 5) = 1 THEN
   oldx = rocket(x, 3)
   oldy = rocket(x, 4)
   rocket(x, 3) = rocket(x, 3) + rocket(x, 2)
   rocket(x, 4) = rocket(x, 4) - rocket(x, 1)
   rocket(x, 1) = rocket(x, 1) - g
   IF rocket(x, 1) <= 0 THEN
    rocket(x, 5) = 2
    flares = INT(RND * (max - min)) + min
    REDIM flare(flares, 8) AS DOUBLE
    flcolor = INT(RND * 15) + 1
    FOR y = 1 TO flares
     IF disperse = 0 THEN
      flare(y, 1) = RND * 4 - 2
      flare(y, 2) = RND * 4 - 2
     ELSEIF disperse = 1 THEN
      d = 360 / flares
      flare(y, 1) = SIN(d * y * pi / 180) * 2
      flare(y, 2) = COS(d * y * pi / 180) * 2
     END IF
     flare(y, 3) = rocket(x, 3)
     flare(y, 4) = rocket(x, 4)
     flare(y, 5) = 1
     flare(y, 6) = flcolor
     flare(y, 7) = INT(RND * 80) + 20
     flare(y, 8) = 0
    NEXT
   END IF
   PSET (rocket(x, 3), rocket(x, 4)), rocket(x, 6)
   PSET (oldx, oldy), 0
   IF rocket(x, 3) < -1 OR rocket(x, 3) > 640 OR rocket(x, 4) < -1 THEN rocket(x, 5) = 0
  END IF
  IF rocket(x, 5) = 2 THEN
   FOR y = 1 TO flares
    IF flare(y, 5) = 1 THEN
     flok = flok + 1
     flare(y, 8) = flare(y, 8) + 1
     IF flare(y, 8) >= flare(y, 7) OR flare(y, 3) < 0 OR flare(y, 3) > 639 OR flare(y, 4) < 0 OR flare(y, 4) > 479 THEN flare(y, 5) = 0
     oldx = flare(y, 3)
     oldy = flare(y, 4)
     flare(y, 3) = flare(y, 3) + flare(y, 2)
     flare(y, 4) = flare(y, 4) - flare(y, 1)
     flare(y, 1) = flare(y, 1) - g
     IF flare(y, 5) <> 0 THEN PSET (flare(y, 3), flare(y, 4)), flare(y, 6)
     IF delf = 1 THEN PSET (oldx, oldy), 0
    END IF
   NEXT
   IF flok = 0 THEN rocket(x, 5) = 0
   flok = 0
  END IF
 NEXT
 FOR x = 1 TO delay: NEXT
LOOP WHILE a$ = ""

