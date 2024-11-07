DECLARE FUNCTION CEIL (ntr)
DECLARE SUB center (row, text$)
DECLARE SUB center80 (row, text$)
DECLARE SUB cleararea (t, B)
DECLARE SUB delay (sec)
DECLARE SUB DisplayCPA ()
DECLARE FUNCTION FindLetter! (ltr$)
DECLARE SUB GetInput ()
DECLARE FUNCTION GetKey$ (allowed$)
DECLARE SUB GetWord ()
DECLARE SUB glocate (xxp, yyp)
DECLARE SUB Hint ()
DECLARE FUNCTION i2a$ (h)
DECLARE SUB JFont (a$, c!, XCoordinate!, YCoordinate!, Size!)
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
DECLARE SUB LoadHiScores ()
DECLARE SUB playsounds (stp!)
DECLARE SUB realtime (nos)
DECLARE SUB SaveAndExit ()
DECLARE SUB SetandScramble ()
DECLARE SUB ShowHIScores ()
DECLARE SUB ShowStats ()
DECLARE SUB solveword1p ()
DECLARE SUB SolveWord2p ()
DECLARE SUB SortArray ()
DECLARE FUNCTION timeremain$ (minleft)
DECLARE FUNCTION trim$ (ttt$)

TYPE ScorePacket    '30
  name AS STRING * 12
 score AS INTEGER
solved AS INTEGER
	hu AS INTEGER
   lvl AS INTEGER
  date AS STRING * 10
END TYPE

COMMON SHARED nol, hintsused, word$, CPA$, SEL$, Wordsindic, snd, nop, GameOver
COMMON SHARED totalmoves, movesused, min, sec, gamelevel, sel1, st
DIM SHARED hsp AS ScorePacket, orig$(9), CPA$(9), score(12), name$(12), solved(12), charset(128, 8, 6), hu(12), pd$(11), lvl(11)

c$ = COMMAND$
IF c$ = "" THEN dfn$ = "Scram.dic"
IF c$ <> "" AND INSTR(c$, ".") = 0 THEN dfn$ = c$ + ".DIC"

OPEN "fontdata.dat" FOR INPUT AS #9
RANDOMIZE TIMER
FOR a = 1 TO 126
FOR x = 1 TO 8

	  FOR y = 1 TO 6
		INPUT #9, B
		charset(a, x, y) = B        'loads font data into 3-D array.
	  NEXT y

   NEXT x
NEXT a
CLOSE

'GameLevel      letters allowed in each word  (4-9, or 1 for mixed)
'NOL            letters in the word
'HintsUsed      Hints used this game
'Sel1, Sel2     letter positions to switch  if equal, no switch, no count move
'Word$          The unscrambled version of the word
'CPA$           current arrangemant of the letters by the player

'Orig$(9)     Letters in the original word
'CPA$(9)      current arrangement of the letters by the player
'score(12)*   Scores
'solved(12)*  # of words solved
'name$(12)*   Player names
'HU(12)*      TOTAL Hints used in a single game
'pd$(12)*     Dates of played games
'LVL(12)*     Game levels players use

'* means the array stores high score data, as well as current player stats

SCREEN 13: CLS : PRINT "LOADING DICTIONARY..."; : PALETTE 200, 0
OPEN dfn$ FOR INPUT AS #2
	DO UNTIL EOF(2): LINE INPUT #2, w$:  Wordsindic = Wordsindic + 1: LOOP
	CLOSE #2: PRINT "Done --"; Wordsindic; "words": LoadHiScores
new:
	GetInput
ret:
	GetWord
	SetandScramble
	IF nop = 1 THEN solveword1p ELSE SolveWord2p

playsounds 3
IF nop = 1 THEN SortArray: ShowHIScores
cleararea 14, 23:  LOCATE , , 0
COLOR 10: center80 18, "GAME OVER - Would you like to play again?  (Press Y or N):"

k$ = GetKey$("yn")
	IF k$ = CHR$(27) OR k$ = "N" THEN SaveAndExit
		  
		  cleararea 14, 23
		  c$ = "Same player":  IF nop = 2 THEN c$ = c$ + "s"
		  center80 18, c$ + " and game level?  (Press Y or N)"

		  k$ = GetKey$("yn"): GameOver = 0
		  IF k$ = CHR$(27) THEN SaveAndExit
		  IF k$ = "Y" THEN SCREEN 13: GOTO ret:  ELSE SCREEN 13: GOTO new:

DATA " 1    ","2    ","3   ","4","    5   ","6   ","7    ","8   ","9"

FUNCTION CEIL (ntr)
	CEIL = -INT(-ntr)
END FUNCTION

SUB center (row, text$)
	col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB center80 (row, text$)
	col = 41 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB cleararea (t, B)
	FOR J = t TO B
		LOCATE J, 1: PRINT SPACE$(40)
	NEXT J
END SUB

SUB delay (sec)
	start = TIMER
	IF start + sec < 86400 THEN
		DO WHILE TIMER < start + sec: LOOP
	ELSE
		DO UNTIL TIMER = 0: LOOP
		DO WHILE TIMER < start + sec - 86400: LOOP
	END IF
END SUB

SUB DisplayCPA
	CPA$ = ""
	FOR i = 1 TO nol
		CPA$ = CPA$ + CPA$(i)
	NEXT i

	cleararea 16, 23
	JFont CPA$, 9, 0, 125, 6
	LOCATE 22, 1: COLOR 15: PRINT SEL$
END SUB

FUNCTION FindLetter (ltr$)
	FOR F = nol TO 1 STEP -1
		IF CPA$(F) = ltr$ THEN FindLetter = F: EXIT FUNCTION
	NEXT F
END FUNCTION

SUB GetInput
	COLOR 9: SCREEN 13: CLS : center 2, "Scramble"
	COLOR 44: center 3, "By Charles Martin"
	LOCATE 7, 1: COLOR 15: PRINT "How many players?  (Pres 1 or 2)"
	k$ = GetKey$("129")
	IF k$ = CHR$(27) THEN SaveAndExit
	nop = VAL(k$): LOCATE 9, 1:

	IF nop = 9 THEN
		name$(11) = "Charles": name$(12) = "Troy"
		gamelevel = 4: nop = 2: EXIT SUB
	END IF

FOR i = 1 TO nop
GNA:
		LOCATE 9 + i, 1:
		COLOR 10: PRINT "Name of player"; i; "- >";
		COLOR 13: name$(i + 10) = Limitinput$(12, "", CSRLIN, POS(0), "")
		IF LEN(name$(i + 10)) < 3 THEN cleararea 9, 23: GOTO GNA:
	NEXT i
	
	COLOR 10: LOCATE 15, 1: PRINT "Play sounds during the game?"
	PRINT "(press Y or N)"
	k$ = GetKey$("yn")
		IF k$ = CHR$(27) THEN SaveAndExit
		IF k$ = "Y" THEN snd = 1:  ELSE snd = 0

	COLOR 15: LOCATE 19, 1:
	PRINT "How many letters should be in each word?"
	PRINT "(From 4 to 9, or 1 for mixed:"

	k$ = GetKey$("1456789")
	IF k$ = CHR$(27) THEN SaveAndExit
	gamelevel = VAL(k$)
END SUB

FUNCTION GetKey$ (allowed$)
	allowesc = 1: allowed$ = UCASE$(allowed$)
GTT:
	KY$ = UCASE$(INKEY$)
	  IF st <> 0 THEN
		IF nop = 1 THEN COLOR 78: LOCATE 7, 20: PRINT "Time Left:  "; timeremain(5)
		IF nop = 2 THEN COLOR 100: center 6, "GAME " + i2a$(solved(11) + solved(12) + 1) + ", " + timeremain(10)
	 END IF

	IF GameOver = 1 AND st <> 0 THEN st = 0: GetKey$ = "": EXIT FUNCTION
	IF KY$ <> "" AND INSTR(allowed$, KY$) > 0 THEN GetKey$ = KY$: EXIT FUNCTION
	IF allowesc <> 0 AND KY$ = CHR$(27) THEN GetKey$ = CHR$(27): EXIT FUNCTION  'Allow ESCape
GOTO GTT:
END FUNCTION

SUB GetWord
	RANDOMIZE TIMER:

	IF gamelevel = 1 THEN
GRN:
		nol = INT(RND * 9) + 4
		IF nol < 4 OR nol > 9 THEN GOTO GRN:
	ELSE
		nol = gamelevel
	END IF

PAN:
	skip = INT(RND * Wordsindic)

	OPEN "Scram.dic" FOR INPUT AS #2: word$ = ""
	DO
		IF skip = 0 THEN EXIT DO
		LINE INPUT #2, w$: skip = skip - 1
	LOOP

	DO UNTIL word$ <> ""
		IF EOF(2) THEN CLOSE #2: GOTO PAN:
		INPUT #2, w$: w$ = trim$(w$)
		IF LEN(w$) = nol THEN word$ = w$: CLOSE #2: EXIT SUB
	LOOP
END SUB

SUB glocate (xxp, yyp)
	xxp$ = i2a$(xxp): yyp$ = i2a$(yyp): DRAW "bm" + xxp$ + "," + yyp$
END SUB

SUB Hint
	HP = 0: hintsused = hintsused + 1: hu(11) = hu(11) + 1: movesused = movesused + 1
	FOR i = 1 TO nol
		IF orig$(i) <> CPA$(i) THEN HP = i: l$ = orig$(i): EXIT FOR
	NEXT i

	SWAP CPA$(HP), CPA$(FindLetter(l$))
END SUB

FUNCTION i2a$ (h)
	i2a$ = trim$(STR$(h))
END FUNCTION

SUB JFont (a$, c, XCoordinate, YCoordinate, Size)

Size = INT(Size)             'No decimals allowed!
IF Size > 10 THEN Size = 10  'Check and fix invalid size calls
IF Size < 1 THEN Size = 1    'likewise for <.

YCoordinate = INT(YCoordinate / Size)     'Prevent ballooning of YCoordinates
										  'that is a result of using
										  'size values larger than 1 for size


'Enter 999 as XCoordinate for centered text...
IF XCoordinate = 999 THEN XCoordinate = 160 - (LEN(a$) * 3 * Size)

startx = XCoordinate               'set Starting X-Val for character drawing

FOR e = 1 TO LEN(a$)

   B$ = MID$(a$, e, 1)     ' read each character of the string
   a = ASC(B$)             ' get ASCII values of each character

	  FOR x = 1 TO 8

		 FOR y = 1 TO 6

			SELECT CASE charset(a, x, y)       'use ASCII value (a) to point
											   'to the correct element in
											   'the array

			   CASE 0: col = 0                 ' Don't draw pixel

			   CASE 1: col = c                 ' Draw pixel

			   CASE ELSE                       ' Error!
				  CLS
				  SCREEN 9
				  BEEP
				  COLOR 4
				  PRINT "Error in FONTDATA.DAT"
				  PRINT "This could be the result of unauthorized tampering with the file."
				  PRINT "To fix: edit FONTDATA.DAT; make sure only 1's, 0's, and commas are there."
				  PRINT
				  PRINT "If you are still having trouble..."
				  PRINT "Send email to: davison_soft@geocities.com"
				  PRINT "to obtain a fresh copy of the file"
				  PRINT
				  PRINT "Program will now continue, but may exhibit erratic behavior..."
				  DO: LOOP UNTIL INKEY$ <> ""
				  SCREEN 13

			END SELECT

		  IF col <> 0 THEN        'Draw a pixel!
		   LINE (startx + pixelsright, (x + YCoordinate) * Size)-(startx + pixelsright + (Size - 1), ((x + YCoordinate) * Size) + (Size - 1)), col, BF
		  END IF

		  startx = startx + Size     'Set starting X-value for next pixel

		NEXT y

	   startx = XCoordinate          'reset startx for next line of pixels

	 NEXT x
   pixelsright = pixelsright + (6 * Size)   ' add pixels for next character

NEXT e


END SUB

FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
allowesc = 1   'allow escape to be pushed during input

'---------
IF UCASE$(ALLOWEDCHARS$) = "ALL" OR ALLOWEDCHARS$ = "" THEN ALLOWEDCHARS$ = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+`~[]{};:'" + CHR$(34) + ",<.>/?\| "
LOCATE row, col: PRINT et$; : CONTENTS$ = et$
LT$ = CHR$(0) + CHR$(75): RT$ = CHR$(0) + CHR$(77)
ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8)
IF allowesc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27) + LT$ + RT$
TC = LEN(et$): CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
tos:
	 DO
	 LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
	  EndCol = LEN(CONTENTS$): CurCol = POS(0)
	LOOP WHILE CHAR$ = ""
	 IF INSTR(ALLOWEDCHARS$, CHAR$) = 0 THEN GOTO tos:
	 SELECT CASE CHAR$
		 CASE IS = CHR$(8)
			IF CONTENTS$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
			IF CONTENTS$ <> "" THEN CONTENTS$ = LEFT$(CONTENTS$, LEN(CONTENTS$) - 1): TC = TC - 1
		 CASE IS = CHR$(13): Limitinput$ = CONTENTS$: EXIT FUNCTION
		 CASE IS = CHR$(27)
			IF allowesc = 1 THEN Limitinput$ = CHR$(27): EXIT FUNCTION
		 CASE IS = LT$: IF TC > 0 THEN PRINT CHR$(29); : TC = TC - 1
		 CASE IS = RT$: IF TC <= ALLOWEDCHARS THEN PRINT CHR$(28); : TC = TC + 1
		 CASE ELSE:
		 SELECT CASE TC
			  CASE IS < ALLOWEDCHARS: PRINT CHAR$; : TC = TC + 1: CONTENTS$ = CONTENTS$ + CHAR$
			  CASE ELSE: PLAY "o2 t120 l29B": GOTO tos:
		 END SELECT
	 END SELECT
LOOP



END FUNCTION

SUB LoadHiScores
	OPEN "Scores.dat" FOR RANDOM AS #1 LEN = 30

	FOR i = 1 TO 10
		GET #1, i, hsp
		name$(i) = hsp.name
		score(i) = hsp.score
	   solved(i) = hsp.solved
		   hu(i) = hsp.hu
		  lvl(i) = hsp.lvl
		  pd$(i) = hsp.date
	NEXT i
END SUB

SUB playsounds (stp)
	IF snd = 0 THEN EXIT SUB
	SELECT CASE stp
		CASE IS = 1: SHELL "play swap" + i2a$(snd) + " /q"
		CASE IS = 2:
			ss = INT(RND * 5) + 1: SHELL "play solve" + i2a$(ss) + " /q"
			IF snd <> 0 THEN
				snd = snd + 1
				IF snd > 5 THEN snd = 1
			END IF
		CASE IS = 3: ss = INT(RND * 5) + 1: SHELL "play over" + i2a$(ss) + " /q"
		CASE IS = 4: SHELL "play adios /q"
	END SELECT
END SUB

SUB realtime (nos)
	IF nos < 60 THEN
		hrs = 0: min = 0: sec = nos: GOTO 50    'if < 1 min, all seconds, done
	ELSEIF nos >= 60 AND nos < 3600 THEN
		hrs = 0: min = INT(nos / 60): sim = min * 60: sec = nos - sim: GOTO 50
	ELSEIF nos >= 3600 THEN
		min = INT(nos / 60): hrs = INT(min / 60):
		sim = min * 60: sec = nos - sim: min = min - (hrs * 60): GOTO 50
	END IF
50
END SUB

SUB SaveAndExit

	FOR i = 1 TO 10
		hsp.name = name$(i)
	   hsp.score = score(i)
	  hsp.solved = solved(i)
		  hsp.hu = hu(i)
		 hsp.lvl = lvl(i)
		hsp.date = pd$(i)
		PUT #1, i, hsp
	NEXT i
	CLOSE #1: SYSTEM
END SUB

SUB SetandScramble
	ERASE orig$, CPA$: totalmoves = CEIL((nol / 2))
	
	SEL$ = "": RESTORE: movesused = 0: hintsused = 0
	FOR i = 1 TO nol
		orig$(i) = MID$(word$, i, 1)
		 CPA$(i) = MID$(word$, i, 1)
		   READ RD$: SEL$ = SEL$ + RD$
	NEXT i

scramble:
	FOR i = 1 TO nol
tows:   RANDOMIZE TIMER: RSS = INT(RND * nol) + 1
		IF RSS = i OR RSS > nol THEN GOTO tows:
		SWAP CPA$(i), CPA$(RSS)
	NEXT
	IF CPA$ = word$ THEN GOTO scramble:
END SUB

SUB ShowHIScores
SCREEN 0: WIDTH 80, 25: COLOR 13: CLS
 PRINT "                             WORDS   HINTS     WORD   PLAY"
 PRINT "##   NAME           SCORE   SOLVED    USED   LENGTH   DATE": COLOR 10
 PRINT "ออ   ออออออออออออ   อออออ   ออออออ   อออออ   ออออออ   ออออ"
fmt$ = "##   \          \   #,###   ##,###   #,###   \    \   \        \"

	COLOR 15
	FOR i = 1 TO 10
		IF lvl(i) = 1 THEN l$ = " MIXED" ELSE l$ = "     " + i2a$(lvl(i))
		PRINT USING fmt$; i; name$(i); score(i); solved(i); hu(i); l$; pd$(i)
	NEXT i
END SUB

SUB ShowStats
	COLOR 78: fmt$ = "    ###"
	LOCATE 4, 17: PRINT "Words solved:"; USING fmt$; solved(11)
	LOCATE 5, 17: PRINT "  Hints used:"; USING fmt$; hu(11)
	LOCATE 6, 17: PRINT "       Score:"; USING fmt$; score(11)
END SUB

SUB solveword1p
	st = TIMER: score(11) = 0: solved(11) = 0: pd$(11) = DATE$: lvl(11) = gamelevel
clearbegin:
	CLS
begin:
	CALL DisplayCPA: ShowStats
	IF CPA$ = word$ THEN GOTO gotit:
	st$ = "123456789": sel1 = 0: sel2 = 0
	
	k$ = GetKey$(LEFT$(st$, nol) + CHR$(13) + CHR$(27))
	IF k$ = "" THEN EXIT SUB
	IF GameOver = 1 THEN EXIT SUB
	IF k$ = CHR$(27) THEN SaveAndExit
	IF k$ = CHR$(13) THEN Hint: GOTO begin:
	IF VAL(k$) THEN sel1 = VAL(k$)

	playsounds 1
	xp = 0: xp = xp + (sel1 * 34): xp = xp - 34
	IF xp <> 0 THEN xp = xp + 3
	glocate xp, 123:  DRAW "c44 r32 d42 l32 u42"

	k$ = GetKey$(LEFT$(st$, nol) + CHR$(27))
	IF GameOver = 1 THEN EXIT SUB
	IF k$ = "" THEN EXIT SUB
	IF k$ = CHR$(27) THEN GOTO begin:
	IF VAL(k$) THEN sel2 = VAL(k$)

	IF sel1 <> sel2 THEN movesused = movesused + 1
	SWAP CPA$(sel1), CPA$(sel2): playsounds 1: GOTO begin:

gotit:
	solved(11) = solved(11) + 1
	oldscore = score(11)
	score(11) = score(11) + nol + (totalmoves - movesused) + -hintsused: ShowStats
	dif = score(11) - oldscore

	SELECT CASE dif
		CASE IS < -1, IS > 1: n$ = i2a$(ABS(dif))
			IF dif < 0 THEN p$ = "points lost" ELSE p$ = "points gained"
		CASE IS = 0: p$ = "points scored": n$ = "No": n$ = "No"
		CASE IS = -1, 1: n$ = i2a$(ABS(dif))
			IF dif < 0 THEN p$ = "point lost" ELSE p$ = "point gained"
	END SELECT
	
	COLOR 44: center 13, "Word solved - " + n$ + " " + p$
	
	IF snd > 0 THEN playsounds 2 ELSE delay 2
	CALL GetWord: SetandScramble:  GOTO clearbegin:
END SUB

SUB SolveWord2p

st = TIMER: score(11) = 0: solved(11) = 0: score(12) = 0: solved(12) = 0

ClearB2:
	CLS : turn = INT(RND * 2) + 1
	COLOR 44: LOCATE 2, 1: PRINT name$(11); TAB(40 - LEN(name$(12))); name$(12)
	fmt$ = "###":  LOCATE 3, 5: PRINT USING fmt$; solved(11); :
	PRINT TAB(33); USING fmt$; solved(12):  LOCATE 4, 5: PRINT USING fmt$; score(11); :
	PRINT TAB(33); USING fmt$; score(12)

	COLOR 78: : center 2, "PLAYER":  center 3, "WORDS SOLVED"
	center 4, "SCORE": LINE (0, 0)-(95, 35), 44, B
	LINE (319, 0)-(224, 35), 44, B:

begin2:
	 DO UNTIL GameOver = 1
tol:
		CALL DisplayCPA

		SELECT CASE turn
			CASE IS = 1: PAINT (5, 5), 1, 44: PAINT (314, 5), 0, 44
			CASE IS = 2: PAINT (5, 5), 0, 44: PAINT (314, 5), 1, 44
		END SELECT

		st$ = "123456789": sel1 = 0: sel2 = 0
		k$ = GetKey$(LEFT$(st$, nol) + CHR$(27))
		IF GameOver = 1 THEN EXIT SUB
		IF k$ = CHR$(27) THEN SaveAndExit
		IF k$ = "" THEN EXIT SUB
		IF VAL(k$) THEN sel1 = VAL(k$)

		playsounds 1
		xp = 0: xp = xp + (sel1 * 34): xp = xp - 34
		IF xp <> 0 THEN xp = xp + 3
		glocate xp, 123:  DRAW "c44 r32 d42 l32 u42"

		k$ = GetKey$(LEFT$(st$, nol) + CHR$(27))
		IF GameOver = 1 THEN EXIT SUB
		IF k$ = "" THEN EXIT SUB
		IF k$ = CHR$(27) THEN GOTO begin2:
		IF VAL(k$) THEN sel2 = VAL(k$)

		IF sel1 <> sel2 THEN movesused = movesused + 1 ELSE GOTO tol:
		SWAP CPA$(sel1), CPA$(sel2): playsounds 1

		DisplayCPA
		IF word$ = CPA$ THEN winner = turn: GOTO solved:
		turn = turn + 1: IF turn > 2 THEN turn = 1
	LOOP
	IF GameOver = 1 THEN EXIT SUB

solved:
	solved(winner + 10) = solved(winner + 10) + 1
	score(winner + 10) = score(winner + 10) + nol
	COLOR 44: center 13, name$(winner + 10) + " has solved the word"

	IF snd > 0 THEN playsounds 2 ELSE delay 2
	CALL GetWord: SetandScramble:  GOTO ClearB2:
END SUB

SUB SortArray

EL = 11   'number of items to sort  (# of elements in the array)
'------------------------
gap = INT(EL / 2): start = TIMER

DO WHILE gap > 0
   SwapFlag = 0
   DO WHILE SwapFlag = 0
	  SwapFlag = 1
		FOR n = 1 TO EL - gap
			IF score(n) < score(n + gap) THEN   'change array name here if desired
			  SWAP score(n), score(n + gap): SwapFlag = 0  'this line also
			  SWAP solved(n), solved(n + gap)
			  SWAP name$(n), name$(n + gap)
			  SWAP hu(n), hu(n + gap)
			  SWAP lvl(n), lvl(n + gap)
			  SWAP pd$(n), pd$(n + gap)
			END IF
		NEXT n
   LOOP
	  gap = INT(gap / 2)
LOOP
et = TIMER - start  'calculate amount of seconds the sort took
				   'COMMON SHARE ET if you want to display the sort time

END SUB

FUNCTION timeremain$ (minleft)
	realtime TIMER - st: ml = minleft: minleft = minleft - min
	IF min = ml THEN GameOver = 1: EXIT FUNCTION
	secleft = 60 - sec: minleft = minleft - 1
	ml$ = i2a$(minleft): sl$ = i2a$(secleft)
	IF minleft < 10 THEN ml$ = "0" + ml$
	IF secleft < 10 THEN sl$ = "0" + sl$
	sl$ = LEFT$(sl$, INSTR(sl$, ".") + 2)
	IF LEFT$(sl$, 2) = "0." THEN sl$ = "0" + sl$
	timeremain$ = ml$ + ":" + sl$
END FUNCTION

FUNCTION trim$ (ttt$)
	trim$ = LTRIM$(RTRIM$(UCASE$(ttt$)))
END FUNCTION

