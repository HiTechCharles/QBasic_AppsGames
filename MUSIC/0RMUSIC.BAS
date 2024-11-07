DECLARE SUB RandomMusic ()
DECLARE SUB RandomMusci ()

RandomMusic
SLEEP 1

SUB RandomMusic
    RANDOMIZE TIMER
    NUMSONGS = 16
    SONGTOPLAY = INT(RND * NUMSONGS) + 1
    SELECT CASE SONGTOPLAY
        CASE 1
            PLAY "t130 o3 L12"
            PLAY "ccc f p06 a"
            PLAY "p12"
            PLAY "ccc f p06 a"
            PLAY "p2"
            PLAY "ff ee dd c"
            PLAY "p3"
            PLAY "ccc p48 e p06 g"
            PLAY "p10"
            PLAY "ccc p48 e p06 g"
            PLAY "p3"
            PLAY "gg p12 gfegf > p4 f"
        CASE 2
            PLAY "t200 o3 e p4 g p4 g a a p4 > l8 c<b>c<b>c<b l4 g g aa"
        CASE 3
            FOR i = 1 TO 3: PLAY "o2l9c": NEXT  '99
            FOR i = 1 TO 3: PLAY "o1l9g": NEXT  'bottles of
            FOR i = 1 TO 4: PLAY "o2l9c": NEXT  'beer on the wall
            PLAY "P4"
            FOR i = 1 TO 3: PLAY "o2l9d": NEXT        '99
            FOR i = 1 TO 3: PLAY "o1l9a": NEXT        'bottles of beer
            PLAY "o2l9d"
            PLAY "P2"
            PLAY "o2l9c"                              'you
            PLAY "o1L8b"                              'take
            PLAY "p12"
            PLAY "o1L14b"                             'one
            PLAY "p16"
            PLAY "o1L14b"                             'down
            PLAY "p4"
            FOR i = 1 TO 4: PLAY "p32": PLAY "o1L14b": NEXT   'pass it around
            PLAY "p4"
            FOR A = 1 TO 4: PLAY "o1l9g": NEXT        '99 bott..
            PLAY "o1l9a":   PLAY "o1l9b"              '...tles of
            FOR i = 1 TO 4: PLAY "o2l9c": NEXT        'beer on the wall
        CASE 4
            SOUND 197, 6: SOUND 0, 3
            SOUND 235, 6: SOUND 0, 3
            SOUND 259, 12: SOUND 0, 2
            SOUND 197, 6: SOUND 0, 3
            SOUND 235, 6: SOUND 0, 3
            SOUND 280, 5
            SOUND 259, 12: SOUND 0, 5
            SOUND 197, 6: SOUND 0, 3
            SOUND 235, 6: SOUND 0, 3
            SOUND 259, 9: SOUND 0, .1
            SOUND 259, 4
            SOUND 235, 6: SOUND 0, 3
            SOUND 197, 12: SOUND 0, 5
        CASE 5
            PLAY "L16T162O2<BBB8BBB8"
            PLAY "BB>E8F#8G#8<BBB8BB>E8G#"
            PLAY "G#F#8D#8<B8BBB8BBB8BB>E8"
            PLAY "F#8G#8EG#"
            c = INT(RND * 2) + 1
            IF c = 1 THEN PLAY "MLB3MSAG#F#E8G#8E8" ELSE PLAY "L5MSAG#F#E8G#8E8"
        CASE 6
            PLAY "mf o2 l8 t125 de g p4"
            PLAY "g48 a8 p8 g p2"
            PLAY "g48 a4 a48 b8 ag"
            PLAY "geg p8"
            PLAY "g48 a8 p12 e24 d24 p4"
            PLAY "d16 d16 a16a16 a"
            PLAY "g a20 b20 p8"
            PLAY "bb >d8 <a8 b8"
            PLAY "a p8 ag p3"
            PLAY "aa a48 b8  a g p4"
            PLAY "a12 p24 b12 p24 a12 p24"
            PLAY "b12 p24 ag"
            PLAY "geg"
            PLAY "g48 a48 g8 p12 g p2"
        CASE 7
            PLAY "o2 t100g f# e d l8 ee p4 ee"
            PLAY "l16 <bb>de"
            PLAY "l4o3 t100g f# e d l8 ee p4 ee"
            CASE 8: PLAY " T250cccfg"
            CASE 9: PLAY "t120 o2l15ddeeffggfdp7d"
            CASE 10: PLAY "t120 o1 l4 dl16cl3fp25l7ff": SOUND 0, 3: PLAY " o1 l10 p45gp45gp45gp45": PLAY " o1 l15 agf p 20 dp15d"
            CASE 11: FOR A = 1 TO 3: PLAY " t120 o4l25 c": SOUND 0, 1: NEXT A: SOUND 0, 2: FOR A = 1 TO 3: PLAY " o4l25 c": SOUND 0, 1: NEXT A: SOUND 0, 2: FOR A = 1 TO 3: PLAY " o4l25 c": SOUND 0, 1: NEXT A: FOR A = 1 TO 5: PLAY " o4l25 c":   SOUND _
 0, 1: NEXT A: SOUND 0, 2
            CASE 12: PLAY " T160O1>L20CDEDCDL10ECCDEDCp8l2c"
            CASE 13: PLAY " t120 o4 L10CEFGP16L8EL3G"
            CASE 14: FOR i = 37 TO 520 STEP 3: SOUND i, .1: NEXT i: SOUND 0, 2: SOUND 530, 2: SOUND 0, 2: SOUND 130, 2
            CASE 15: PLAY "t240o3l8d#fgl8b-p8l8gl2b-": PLAY "mb":
            CASE 16: PLAY "t120 o4 l19 cdeg": PLAY "p8 d p16 e ml dd p12 c"
    END SELECT
END SUB

