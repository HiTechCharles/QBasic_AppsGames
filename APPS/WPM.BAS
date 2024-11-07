DECLARE SUB ClearTypingArea ()
DECLARE SUB center (row!, text$)
DECLARE SUB delay (SEC)
TOP:
WIDTH 40, 25: COLOR 15: CLS : LOCATE 13, 8:
COLOR 14: center 13, "ÍÍÍÍÍÍÍPress any Key to Start!ÍÍÍÍÍÍÍÍ": SLEEP
		 
CLS : LOCATE 13, 1, 0: COLOR 15
PRINT "ÄÄÄ3ÄÄÄ"; : SOUND 250, 2: delay 1: COLOR 14
PRINT "ÄÄÄ2ÄÄÄ"; : SOUND 250, 2: delay 1: COLOR 12
PRINT "ÄÄÄ1ÄÄÄ"; : SOUND 250, 2: delay 1: COLOR 4
PRINT "ÄÄÄGO!ÄÄÄ": SOUND 550, 4

DO UNTIL INKEY$ = "": LOOP
CLS : COLOR 10: LOCATE 4, 1: PRINT "ÍÍÍÍÛÍÍÍÍÛÍÍÍÍÛÍÍÍÍÛÍÍÍÍÛÍÍÍÍÛÍÍÍÍÛÍÍÍÍÛ": ST = TIMER
DO UNTIL ET >= 60
tol:
	ET = TIMER - ST
	LOCATE 2, 1: COLOR 15: PRINT "TIME: "; USING "##.########"; ET
	ch$ = ch$ + INKEY$: rch$ = RIGHT$(ch$, 1)
	IF INKEY$ = CHR$(27) THEN SYSTEM
	IF rch$ = CHR$(8) OR rch$ = CHR$(13) OR rch$ = CHR$(9) THEN
		ch$ = LEFT$(ch$, LEN(ch$) - 1)
	END IF
	LOCATE 2, 21: PRINT USING "WPM:  ###,###.#"; LEN(ch$) / 5
	LOCATE 5, 1: COLOR 13: PRINT ch$
LOOP

PLAY "T240L64MLO4EGEGEGEGEGEGEGEGEGEGEGEGEGEGEGegegegegegegegegegegegegegegegegegegegegegegeg"
LOCATE 2, 1: PRINT SPACE$(40)
COLOR 15: LOCATE 18, 1
CharsTyped = LEN(ch$): WPM = CharsTyped / 5
PRINT "Characters typed:  "; USING "    ###"; CharsTyped
PRINT "Words per minute:  "; USING "###,###.#"; WPM
PRINT : PRINT "Try again?  (Press Y or N):"
taon:
	k$ = LCASE$(INKEY$)
	IF k$ = "y" THEN CLEAR : GOTO TOP:
	IF k$ = "n" THEN SYSTEM
	IF k$ = CHR$(27) THEN SYSTEM
GOTO taon:

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB ClearTypingArea
FOR I = 5 TO 23:
	LOCATE I, 1: PRINT SPACE$(40)
NEXT I
END SUB

SUB delay (SEC)
start = TIMER
IF start + SEC < 86400 THEN
   DO WHILE TIMER < start + SEC: LOOP
ELSE
   DO UNTIL TIMER = 0: LOOP
   DO WHILE TIMER < start + SEC - 86400: LOOP
END IF
END SUB

