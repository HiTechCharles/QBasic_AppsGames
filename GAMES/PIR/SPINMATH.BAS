DECLARE FUNCTION Cents$ (ctp)    'Print a number with the › sign next to it
DECLARE FUNCTION I2a$ (h)        'Convert numeric variables to strings
DECLARE FUNCTION Percent$ (ptp)  'Print numbers with the % sign

WIDTH 40, 25: COLOR 9, 8: CLS


firstSpin = 20
SecondSpin = 100 - firstSpin
FOR I = 100 TO 5 STEP -5
    IF firstSpin + I > 100 THEN OverSpaces = OverSpaces + 1
NEXT I
GoOverProb = (OverSpaces / 20) * 100


COLOR 14
LOCATE 11, 1
PRINT "To get $1, you have to get " + Cents$(SecondSpin) + " on your  second spin."
PRINT
PRINT "You have a " + Percent$(GoOverProb) + " chance of going over -"
PRINT "because " + I2a$(OverSpaces) + " out of the 20 amounts will put"
PRINT "you over."

FUNCTION Cents$ (ctp)
    Cents$ = I2a$(ctp) + "›"
END FUNCTION

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION Percent$ (ptp)
    Percent$ = I2a$(ptp) + "%"
END FUNCTION

