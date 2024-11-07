DECLARE SUB MP (K$)
DECLARE SUB center (row, text$)
DIM SHARED bh, a$, K$

CLEAR
WIDTH 40, 25: COLOR 12: CLS : center 2, "MusicSpace"
COLOR 15: center 4, "By Charles Martin"
COLOR 13: LOCATE 8, 1: PRINT "Hit all of the letter and number keys"
PRINT "to make music.  Also try the ENTER and": PRINT "SPACE BAR keys, too!"
COLOR 14: center 13, "Press any key to start!": SLEEP:

'o0  `123456  o4  7890-=\
'01  qwertyu  o5  iop[]kl
'o2  asdfghj  06  ;'<CR>,./ <space>
'o3  zxcvbnm 

plmusic:
DO WHILE INKEY$ <> "": LOOP
CLEAR : CLS
COLOR 13: LOCATE 2, 1: PRINT "Hit all of the letter and number keys"
                       PRINT "to make music.  Try the ENTER and SPACE"
                       PRINT "BAR keys, too!  "; : COLOR 10: PRINT "To quit playing music,"
                       PRINT "Hit the ESCape key."

COLOR 14: center 7, "The buttons you are hitting..."
VIEW PRINT 8 TO 23: COLOR 11:
DO UNTIL K$ = CHR$(27): K$ = LCASE$(INKEY$): MP K$: LOOP

COLOR 12: PRINT : PRINT : PRINT "You hit "; : PRINT USING "###,###"; bh; : PRINT " buttons."
PRINT : PRINT "Press any key.": SLEEP: SYSTEM

SUB center (row, text$)

col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

SUB MP (K$)

SELECT CASE K$
CASE IS = "`": PLAY "o0l9a": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "1": PLAY "o0l9b": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "2": PLAY "o0l9c": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "3": PLAY "o0l9d": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "4": PLAY "o0l9e": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "5": PLAY "o0l9f": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "6": PLAY "o0l9g": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "q": PLAY "o1l9a": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "w": PLAY "o1l9b": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "e": PLAY "o1l9c": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "r": PLAY "o1l9d": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "t": PLAY "o1l9e": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "y": PLAY "o1l9f": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "u": PLAY "o1l9g": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "a": PLAY "o2l9a": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "s": PLAY "o2l9b": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "d": PLAY "o2l9c": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "f": PLAY "o2l9d": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "g": PLAY "o2l9e": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "h": PLAY "o2l9f": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "j": PLAY "o2l9g": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "z": PLAY "o3l9a": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "x": PLAY "o3l9b": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "c": PLAY "o3l9c": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "v": PLAY "o3l9d": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "b": PLAY "o3l9e": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "n": PLAY "o3l9f": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "m": PLAY "o3l9g": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos
CASE IS = "7": PLAY "o4l9a": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "8": PLAY "o4l9b": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "9": PLAY "o4l9c": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "0": PLAY "o4l9d": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "-": PLAY "o4l9e": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "=": PLAY "o4l9f": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "\": PLAY "o4l9g": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "i": PLAY "o5l9a": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "o": PLAY "o5l9b": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "p": PLAY "o5l9c": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "[": PLAY "o5l9d": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "]": PLAY "o5l9e": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "k": PLAY "o5l9f": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "l": PLAY "o5l9g": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = ";": PLAY "o6l9a": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "'": PLAY "o6l9b": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = CHR$(13): PLAY "o6l9c": bh = bh + 1: a$ = "<ENTER>": PRINT a$; " "; : GOTO eos:
CASE IS = ",": PLAY "o6l9d": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = ".": PLAY "o6l9e": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = "/": PLAY "o6l9f": bh = bh + 1: a$ = UCASE$(K$): PRINT a$; " "; : GOTO eos:
CASE IS = " ": PLAY "o6l9g": bh = bh + 1: a$ = "<SPACE>": PRINT a$; " "; : GOTO eos:
CASE ELSE: GOTO eos:
END SELECT

eos:
END SUB

