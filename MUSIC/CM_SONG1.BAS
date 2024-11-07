DECLARE FUNCTION i2a$ (h)

speed = 130
octave = 3

PLAY "t" + i2a$(speed) + " o" + i2a$(octave) + " L12"
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

FUNCTION i2a$ (h)
    i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

