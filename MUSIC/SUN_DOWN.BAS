DECLARE SUB sing (words$)
'Kenny chesney - When the Sun Goes Down

COLOR 13: CLS

sing "When the sun"
PLAY "mf o2 l8 t125 de g p4"

sing "goes down,"
PLAY "g48 a8 p8 g p2"
 
sing "We'll be groovin'": PRINT
PLAY "g48 a4 a48 b8 ag"

sing "when the sun"
PLAY "geg p8"

sing "goes down,"
PLAY "g48 a8 p12 e24 d24 p4"
 
sing "we'll be feelin'"
PLAY "d16 d16 a16a16 a"

sing "all right.": PRINT
PLAY "g a20 b20 p8"

sing "When the sun"
PLAY "bb >d8 <a8 b8"

sing "sinks down"
PLAY "a p8 ag p3"

sing "over the water,": PRINT
PLAY "aa a48 b8  a g p4"

sing "Everything"
PLAY "a12 p24 b12 p24 a12 p24"

sing "gets hotter"
PLAY "b12 p24 ag"

sing "when the sun"
PLAY "geg"

sing "goes down."
PLAY "g48 a48 g8 p12 g p2"

PLAY "l16 bbb p12 aaa p12 ggg p3 eee p16 f# p16 f#48 g4 F#8 p4"
PLAY "bbb p12 aaa p12 ggg p5 g p16 a4 g4"

SUB sing (words$)
    PRINT words$; " ";
END SUB

