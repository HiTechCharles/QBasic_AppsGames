DECLARE SUB delay (sec)
COLOR 14, 9: CLS

FOR bottles = 99 TO 2 STEP -1
   PRINT bottles; "bottles of beer on the wall,"; bottles; "bottles of beer."
   PRINT " Take one down, pass it around,"; bottles - 1;
     IF bottles - 1 <> 1 THEN PRINT "bottles of beer on the wall."
     IF bottles - 1 = 1 THEN PRINT "bottle of beer on the wall."
   PRINT : delay .05
NEXT
 
PRINT " 1 bottle of beer on the wall, 1 bottle of beer."
PRINT " Take one down, pass it around, no more bottles of beer on the wall."
PRINT : SLEEP 1
PRINT " Go to the store, buy some more,"
PRINT " 99 bottles of beer on the wall."

FOR I = 1 TO 3: PLAY "o2l9c": NEXT  '99
FOR I = 1 TO 3: PLAY "o1l9g": NEXT  'bottles of
FOR I = 1 TO 4: PLAY "o2l9c": NEXT  'beer on the wall
PLAY "P4"
FOR I = 1 TO 3: PLAY "o2l9d": NEXT        '99
FOR I = 1 TO 3: PLAY "o1l9a": NEXT        'bottles of beer
PLAY "o2l9d"

PLAY "P2"
PLAY "o2l9c"                              'you
PLAY "o1L8b"                              'take
PLAY "p12"
PLAY "o1L14b"                             'one
PLAY "p16"
PLAY "o1L14b"                             'down
PLAY "p4"
FOR I = 1 TO 4: PLAY "p32": PLAY "o1L14b": NEXT   'pass it around
PLAY "p4"
FOR A = 1 TO 4: PLAY "o1l9g": NEXT        '99 bott..
PLAY "o1l9a":   PLAY "o1l9b"              '...tles of
FOR I = 1 TO 4: PLAY "o2l9c": NEXT        'beer on the wall

SLEEP 1

SUB delay (sec)

start = TIMER
IF start + sec < 86400 THEN
   DO WHILE TIMER < start + sec: LOOP
ELSE
   DO UNTIL TIMER = 0: LOOP
   DO WHILE TIMER < start + sec - 86400: LOOP
END IF


END SUB

