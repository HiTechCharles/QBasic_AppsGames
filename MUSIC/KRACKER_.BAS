DECLARE SUB mp (k$)
DECLARE SUB pause (n!)
CLS: COLOR 13: PLAY "t105"
PRINT "Follow me (charlie) and everything is all right"
mp "j": mp "a": mp "j": pause 10: mp "h": mp "h": mp "f": mp "h": mp "h":  mp "h": mp "j": mp "j"
PRINT "I'll be the one to tuck you in at night"
pause 3: mp "j": mp "j": mp "a": mp "j": mp "h": mp "h": mp "f": mp "h": mp "h": mp "j": mp "j"
PRINT "and if you ";
pause 8: mp "d": mp "f": mp "h"
PRINT "want to leave, I can gaurentee"
pause 8: mp "j": mp "a": mp "j": pause 8: mp "h": mp "h": mp "f": mp "h": mp "h": mp "j": mp "j"
PRINT "you won't find nobody else like me!"
pause 8: mp "h": mp "j": pause 8: mp "a": pause 8: mp "a": pause 8: mp "j": mp "h": pause 8: mp "j": mp "h": mp "h": pause 8: mp "h"
pause 8: mp "d": mp "f": mp "h"

DEFSNG A-Z
SUB mp (k$)
SELECT CASE LCASE$(k$)
CASE IS = "a": PLAY "o2l9a": GOTO eos:
CASE IS = "s": PLAY "o2l9b": GOTO eos:
CASE IS = "d": PLAY "o2l9c": GOTO eos
CASE IS = "f": PLAY "o2l9d": GOTO eos
CASE IS = "g": PLAY "o2l9e": GOTO eos
CASE IS = "h": PLAY "o2l9f": GOTO eos
CASE IS = "j": PLAY "o2l9g": GOTO eos
CASE IS = "k": PLAY "o5l9f": GOTO eos:
CASE IS = "l": PLAY "o5l9g": GOTO eos:
CASE ELSE: GOTO eos:
END SELECT
eos:
END SUB

SUB pause (n)
PLAY "P" + LTRIM$(STR$(n))
END SUB