DECLARE SUB GetInput ()     'Get keyboard input from the user
DECLARE FUNCTION i2a$ (h)   'Convert numeric variable to string
DECLARE SUB Init ()         'Set up the screen for gfx, ans set initial values
DECLARE SUB redraw ()       'Redraw the graphic with the suze and color specified
DECLARE SUB ShowInfo ()     'Display the color #, and scale factor

'Variables that all SUBsand Functions need access to
COMMON SHARED dcolor, size

    Init
    GetInput

SUB GetInput
    DO
inloop:
    SELECT CASE INKEY$
            CASE IS = "6": dcolor = dcolor + 1: GOTO AfterInput:
            CASE IS = "4": dcolor = dcolor - 1: GOTO AfterInput:
            CASE IS = "8", "+": size = size + 1: GOTO AfterInput:
            CASE IS = "2", "-": size = size - 1: GOTO AfterInput:
            CASE IS = CHR$(27): SYSTEM
        END SELECT
    LOOP

AfterInput:
    IF size < 1 THEN size = 100
    IF size > 100 THEN size = 1
    IF dcolor < 1 THEN dcolor = 200
    IF dcolor > 200 THEN dcolor = 1
    redraw
    ShowInfo
    GOTO inloop:
END SUB

FUNCTION i2a$ (h)
    i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB Init
    SCREEN 13
    RANDOMIZE TIMER
    dcolor = INT(RND * 200) + 1
    size = INT(RND * 100) + 1
    redraw
    ShowInfo
END SUB

SUB redraw
    CLS
    DRAW "S" + i2a$(size) + "C" + i2a$(dcolor)
    DRAW "BM160,5r3m+1,3d2R1ND2u1r2d4l2u1l1"
    DRAW "d7R1nd2u2r3d6l3u2l1d3m-1,1l3"
    DRAW "m-1,-1u3l1d2l3u6r3d2nd2r1u7l1d1l2"
    DRAW "u4r2d1nd2R1U2"
    DRAW "M+1,-3"
    DRAW "BD10D2R3U2M-1,-1L1M-1,1"
    DRAW "BD3D1R1U1L1BR2R1D1L1U1"
    DRAW "BD2BL2D1R1U1L1BR2R1D1L1U1"
    DRAW "BD2BL2D1R1U1L1BR2R1D1L1U1"
END SUB

SUB ShowInfo
    LOCATE 1, 1: PRINT "COLOR: "; USING "###"; dcolor
                 PRINT " SIZE: "; USING "###"; size
END SUB

