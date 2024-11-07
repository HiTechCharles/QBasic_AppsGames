DECLARE SUB CalcScore ()           'Shows & calcuslates score
DECLARE SUB center (row, text$)     'centers text on a line
DECLARE SUB ClearBoard ()           'clears the keyboard
DECLARE SUB clearline (rw)          'deletes a line of text from the screen
DECLARE SUB delay (sec)             'Stops everything for the specified time
DECLARE FUNCTION GetKey$ (allowed$) 'gets a keypress from the player
DECLARE SUB GetTopTen ()            'sorts the list of top 10 scores after a game
DECLARE FUNCTION I2A$ (h)           'converts numbers
DECLARE SUB LoadScores ()          'Loads top 10 scores into memory
DECLARE FUNCTION LimitInput$ (AllowedChars)
DECLARE SUB Pcard (PS, PRN)        'places and removes cards from the grid
DECLARE SUB playsounds (SD)        'plays sounds
DECLARE SUB ScoreStat ()           'shows stuff at top of screen during game
DECLARE SUB SetCards ()            'Picks the cards to use when a game starts
DECLARE SUB ShowHiScores ()        'Shows the top 10 scores on screen
DECLARE SUB SoundToggle ()         'Turn sound on and off
COMMON SHARED misses, TRIPS, matches, inarow, ndx, ndx2, g, na$, SND
COMMON SHARED SCORE, sc1, k$, cr

TYPE ScorePacket
	nam AS STRING * 12
   scor AS INTEGER
	DAT AS STRING * 10
END TYPE
DIM SHARED CT$(12), cs$(12), cn(13), HIS(11), hin$(11), hid$(11), sdata AS ScorePacket
CALL LoadScores

mmbegin:
WIDTH 40, 25: COLOR 12: RANDOMIZE TIMER: CLS
center 2, "Memory Match": COLOR 14: center 3, "By Charles Martin"

COLOR 11: LOCATE 8, 1: PRINT "What's your name?  "; : COLOR 15: na$ = UCASE$(LimitInput$(12))
IF LEN(na$) < 2 THEN GOTO mmbegin:

MainGame:
CLS : SetCards: LOCATE 10, 1: COLOR 7: ERASE cn
PRINT "        ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿"
PRINT "        ³  ³³  ³³  ³³  ³³  ³³  ³"
PRINT "        ³  ³³  ³³  ³³  ³³  ³³  ³"
PRINT "        ÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙ"
PRINT "        ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿"
PRINT "        ³  ³³  ³³  ³³  ³³  ³³  ³"
PRINT "        ³  ³³  ³³  ³³  ³³  ³³  ³"
PRINT "        ÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙ"

FOR i = 1 TO 12: Pcard i, 1: NEXT i

DO UNTIL matches = 6
	ScoreStat
	COLOR 13: center 20, "Press a letter to flip": center 21, "the first card:"
gky:
	LOCATE , , 0
	k$ = GetKey$("abcdefghijkls")
	IF k$ = "S" THEN SoundToggle: GOTO gky:
   
	ndx = INSTR("ABCDEFGHIJKL", k$)
	IF cn(ndx) = 1 THEN playsounds 5: GOTO gky:
	cn(ndx) = 1: Pcard ndx, 2
gky2:
	LOCATE , , 0
	clearline 20: clearline 21: COLOR 10: center 20, "Press a letter to flip"
										  center 21, "the second card:"
	k$ = GetKey$("ABCDEFGHIJKLS")
	IF k$ = "S" THEN SoundToggle: GOTO gky2:

	ndx2 = INSTR("ABCDEFGHIJKL", k$)
	IF cn(ndx2) = 1 THEN playsounds 5: GOTO gky2:
	cn(ndx2) = 1
	clearline 20: clearline 21: Pcard ndx2, 2
   
	IF CT$(ndx) = CT$(ndx2) THEN
		playsounds 2: inarow = inarow + 1: matches = matches + 1
			IF inarow = 3 THEN
				delay .3: playsounds 3: TRIPS = TRIPS + 1: inarow = 0
			END IF
		Pcard ndx, 0: Pcard ndx2, 0
	ELSE
		cn(ndx) = 0: cn(ndx2) = 0:
		IF SND = 1 AND inarow = 2 THEN playsounds 7: delay .175
		inarow = 0: misses = misses + 1
		playsounds 1: delay 1.75: Pcard ndx, 1: Pcard ndx2, 1
		ndx = 0: ndx2 = 0
END IF
LOOP
CALL ScoreStat: g = g + 1: COLOR 15: center 21, "You have paired up all of the cards!":
IF SND = 0 THEN delay 2.5 ELSE delay .3: playsounds 4
CalcScore
GetTopTen

PlayAgain:
CLS : COLOR 10: ClearBoard
COLOR 13: center 2, "LAST SCORE WAS " + I2A$(SCORE) + " BY " + na$

LOCATE 6, 1: COLOR 11: LOCATE , , 0
PRINT : PRINT "PRESS   ESCape to exit"
PRINT : PRINT "         ENTER to play again"
PRINT : PRINT "             C to change player"
PRINT : PRINT "             H to show High Scores"
PRINT : PRINT "             R to review your score"
SPF:
	k$ = LCASE$(INKEY$)
	IF k$ = CHR$(13) THEN ERASE CT$, cs$, cn: misses = 0: TRIPS = 0: matches = 0: inarow = 0: GOTO MainGame:
	IF k$ = "c" THEN ERASE CT$, cs$, cn: misses = 0: TRIPS = 0: matches = 0: inarow = 0: g = 0: GOTO mmbegin:
	IF k$ = "h" THEN ShowHiScores: GOTO PlayAgain:
	IF k$ = "r" THEN CalcScore: GOTO PlayAgain:
	IF k$ = CHR$(27) THEN CLOSE #1: playsounds 6: SYSTEM
GOTO SPF:

'---------------------Files to check for existance----------------------------
DATA 10.wav,2.wav,3.wav,4.wav,5.wav,6.wav,7.wav,8.wav,9.wav,a.wav,adios.wav
DATA CSoff.wav,cson.wav,error.wav,j.wav,K.wav,la.wav,lb.wav,lc.wav,ld.wav,le.wav
DATA lf.wav,lg.wav,lh.wav,li.wav,list.txt,lj.wav,lk.wav,ll.wav,match.wav,memmatch.txt
DATA miss.wav,OHNO.mp3,play.exe,q.wav,triplet.wav,win1.wav,win10.mid,Win11.mid
DATA win2.wav,win3.wav,win4.wav,win5.mid,win6.mid,win7.mid,Win8.mid,win9.mid,END

ErrorHandler:
SELECT CASE ERR
	CASE IS = 53: : PRINT "File not found - "; r$: filemissing = 1: RESUME NEXT
	CASE ELSE: PRINT "ERROR #"; ERR; "ON LINE"; ERL: SYSTEM
END SELECT

SUB CalcScore
COLOR 7: CLS : center 1, "Scoring Points"
COLOR 15: LOCATE 4, 1: PRINT "Each match you make gets you 4 points."
					   PRINT "You lose 2 points for every miss."
					   PRINT "You get 6 points if you make"
					   PRINT "  3 matches in a row.  (Triplets)"
'Points for matches are in MatchPts
MatchPts = 24
tripPts = TRIPS * 6
'# of points lost to misses is MT
MT = -2 * misses
SCORE = (tripPts + MatchPts) + MT
PF$ = "##"

COLOR 13: LOCATE 10, 1: : PRINT "ÍÍÍ": COLOR 12
c$ = RIGHT$(na$, 1)
SELECT CASE c$
CASE IS = "S": LOCATE 10, 4: PRINT na$; "' SCORE";
CASE IS <> "s": LOCATE 10, 4: PRINT na$; "'S SCORE";
CASE ELSE: LOCATE 10, 4: PRINT na$; "'S SCORE";
END SELECT

PRINT " after game #"; I2A$(g); : COLOR 13: PRINT "ÍÍÍ"

IF g = 1 THEN sc1 = SCORE:  avg = SCORE
IF g > 1 THEN avg = (SCORE + sc1) / 2

COLOR 9: LOCATE 12, 1: PRINT "Making 6 matches  (4 ù  6)   ": LOCATE 12, 33: PRINT USING PF$; MatchPts: PRINT
SELECT CASE misses
CASE IS = 0: GOTO ST:
CASE IS = 1:           PRINT "Missing  1 time   (1 ù -2)"; : LOCATE 14, 32: PRINT "-"; USING PF$; ABS(MT)
CASE ELSE:             PRINT "Missing "; : PRINT USING PF$; misses; : PRINT " times  ("; I2A$(misses); " ù -2)"; : LOCATE 14, 32: PRINT "-"; USING PF$; ABS(MT)
END SELECT

ST:
SELECT CASE TRIPS
CASE IS = 0: GOTO SFS:
CASE IS > 1: LOCATE 16, 1: PRINT "Making"; TRIPS; "Triplets ("; I2A$(TRIPS); " ù  6)": LOCATE 16, 33: PRINT USING PF$; tripPts
CASE IS = 1: LOCATE 16, 1: PRINT "Making a Triplet  (1 ù  6)": LOCATE 16, 33: PRINT USING PF$; tripPts
END SELECT

SFS:
COLOR 10: LOCATE 19, 1: PRINT "FINAL SCORE: "; SCORE: LOCATE 19, 21: PRINT "AVERAGE SCORE: "; avg
COLOR 15: center 22, "Press any key...": SLEEP
END SUB

SUB center (row, text$)
	col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB ClearBoard
DO UNTIL INKEY$ = "": LOOP
END SUB

SUB clearline (rw)
LOCATE rw, 1: PRINT SPACE$(40)
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

FUNCTION GetKey$ (allowed$)
allowed$ = UCASE$(allowed$)
GTT:
	ky$ = UCASE$(INKEY$)
		IF ky$ <> "" AND INSTR(allowed$, ky$) > 0 THEN GetKey$ = ky$: EXIT FUNCTION
	IF ky$ = CHR$(27) THEN CLOSE #1: playsounds 6: SYSTEM
GOTO GTT:

END FUNCTION

SUB GetTopTen

hin$(11) = na$
HIS(11) = SCORE
hid$(11) = DATE$

EL = 11: gap = INT(EL / 2)
DO WHILE gap > 0
   SwapFlag = 0
   DO WHILE SwapFlag = 0
	  SwapFlag = 1
		FOR N = 1 TO EL - gap
			 IF HIS(N) < HIS(N + gap) THEN
			  SWAP HIS(N), HIS(N + gap)
			  SWAP hin$(N), hin$(N + gap)
			  SWAP hid$(N), hid$(N + gap)
			  SwapFlag = 0
			END IF
		NEXT N
   LOOP
	  gap = INT(gap / 2)
LOOP

FOR i = 1 TO 10
	sdata.nam = hin$(i)
	sdata.scor = HIS(i)
	sdata.DAT = hid$(i)
	PUT #1, i, sdata
NEXT i
END SUB

FUNCTION I2A$ (h)
	I2A$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION LimitInput$ (AllowedChars)
tc = 0: CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
TOS:
	 DO
	 LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
	 LOOP WHILE CHAR$ = ""
	 SELECT CASE ASC(CHAR$)
		 CASE IS = 8
			IF contents$ <> "" THEN PRINT CHR$(29); " "; CHR$(29);
			IF contents$ <> "" THEN contents$ = LEFT$(contents$, LEN(contents$) - 1): tc = tc - 1
		 CASE IS = 13: LimitInput$ = contents$: EXIT FUNCTION
		 CASE ELSE:
		 SELECT CASE tc
			  CASE IS < AllowedChars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
			  CASE ELSE: PLAY " o2 t120 l9B": GOTO TOS:
		 END SELECT
	 END SELECT
LOOP

END FUNCTION

SUB LoadScores

OPEN "MemMatch.HI" FOR RANDOM AS #1 LEN = 24
FOR i = 1 TO 10
	GET #1, i, sdata
	hin$(i) = RTRIM$(sdata.nam)
	HIS(i) = sdata.scor
	hid$(i) = sdata.DAT
NEXT i

GET #1, 11, sdata
sw$ = RTRIM$(sdata.nam)
IF sw$ <> "SOUND" THEN SND = 1 ELSE SND = sdata.scor

END SUB

SUB Pcard (PS, PRN)

SELECT CASE PS
	CASE 1 TO 6: l = 11
	CASE 7 TO 12: l = 15
END SELECT

SELECT CASE PS
	CASE IS = 1, 7: c = 10
	CASE IS = 2, 8: c = 14
	CASE IS = 3, 9: c = 18
	CASE IS = 4, 10: c = 22
	CASE IS = 5, 11: c = 26
	CASE IS = 6, 12: c = 30
END SELECT

SELECT CASE PRN
	CASE IS = 0: COLOR 0, 0
		FOR i = (l - 1) TO (l + 2)
			LOCATE i, c - 1: PRINT "    "
		NEXT i
	EXIT SUB
	CASE IS = 1: COLOR 14: LOCATE l, c: LT$ = "ABCDEFGHIJKL": PRINT " " + MID$(LT$, PS, 1): LOCATE l + 1, c: PRINT "  "
	CASE IS = 2: COLOR 15: LOCATE l, c:
		IF CT$(PS) = "10" THEN PRINT "10" ELSE PRINT " "; CT$(PS)
		LOCATE l + 1, c + 1: PRINT cs$(PS)
END SELECT
'PRN #s
'0  remove card
'1  LETTER
'2  CARD

END SUB

SUB playsounds (SD)
IF SND = 0 THEN EXIT SUB
'1 MISS
'2 MATCH
'3 TRIPLET
'4 DONE
'5 ERROR
'6 EXIT
'7 oh no
PLAY "ms t120"
SELECT CASE SD
	CASE IS = 1: SOUND 300, 3.2: SOUND 150, 3.2
	CASE IS = 2: SOUND 700, 1: SOUND 1400, 1
	CASE IS = 3: PLAY "T240L64MLO4EGEGEGCFCFCFGEGEGE"
	CASE IS = 4: r = INT(RND * 10) + 1
		SELECT CASE r
			CASE IS = 1: PLAY " T250cccfg"
			CASE IS = 2: PLAY "t120 o2l15ddeeffggfdp7d"
			CASE IS = 3: PLAY "t120 o1 l4 dl16cl3fp25l7ff": SOUND 0, 3: PLAY " o1 l10 p45gp45gp45gp45": PLAY " o1 l15 agf p 20 dp15d"
			CASE IS = 4: FOR A = 1 TO 3: PLAY " t120 o4l25 c": SOUND 0, 1: NEXT A: SOUND 0, 2: FOR A = 1 TO 3: PLAY " o4l25 c": SOUND 0, 1: NEXT A: SOUND 0, 2: FOR A = 1 TO 3: PLAY " o4l25 c": SOUND 0, 1: NEXT A: FOR A = 1 TO 5: PLAY " o4l25 c":  _
SOUND 0, 1: NEXT A: SOUND 0, 2
			CASE IS = 5: PLAY " T160O1>L20CDEDCDL10ECCDEDCp8l2c"
			CASE IS = 6: PLAY " t120 o4 L10CEFGP16L8EL3G"
			CASE IS = 7: FOR i = 37 TO 520 STEP 3: SOUND i, .1: NEXT i: SOUND 0, 2: SOUND 530, 2: SOUND 0, 2: SOUND 130, 2
			CASE IS = 8: PLAY "t240o3l8d#fgl8b-p8l8gl2b-": PLAY "mb":
			CASE IS = 9
			PLAY "L16T162O2<BBB8BBB8"
				PLAY "BB>E8F#8G#8<BBB8BB>E8G#"
				PLAY "G#F#8D#8<B8BBB8BBB8BB>E8"
				PLAY "F#8G#8EG#"
				c = INT(RND * 2) + 1
				IF c = 1 THEN PLAY "MLB3MSAG#F#E8G#8E8" ELSE PLAY "L5MSAG#F#E8G#8E8"
		CASE IS = 10: PLAY "t120 o4 l19 cdeg": PLAY "p8 d p16 e ml dd p12 c"
		END SELECT
	CASE IS = 5: SOUND 790, 1: SOUND 0, 1: SOUND 790, 1
	CASE IS = 6: PLAY "T255L32mlO3CD<CD>>CD<<CD>>CD<<CD>CD"
	CASE IS = 7: FOR i = 999 TO 240 STEP -45: SOUND i, 1: NEXT i
	CASE ELSE: PRINT : PRINT "PlaySound # out of range of 1-6!": SYSTEM
END SELECT
END SUB

SUB ScoreStat
VIEW PRINT 2 TO 6: COLOR 11, 0: CLS
LOCATE 2, 1: PRINT " CURRENT PLAYER:  "; na$
			 PRINT "         MISSES: "; : PRINT USING "#,###"; misses
			 PRINT "       TRIPLETS: "; : PRINT USING "#,###"; TRIPS
			
			 IF HIS(1) <> 0 THEN
				PRINT "       HI SCORE: "; : PRINT USING "#,###"; HIS(1);
				PRINT " BY "; hin$(1)
			 END IF
			 VIEW PRINT
END SUB

SUB SetCards
RANDOMIZE TIMER
FOR i = 1 TO 6
PAN:
	c = INT(RND * 13) + 1
	IF cn(c) = 1 THEN GOTO PAN:  ELSE cn(c) = 1
	SELECT CASE c  'determine card symbol  (A, 7, J, etc)
		CASE IS = 1: CT$(i) = "A": CT$(i + 6) = "A"
		CASE IS = 11: CT$(i) = "J": CT$(i + 6) = "J"
		CASE IS = 12: CT$(i) = "Q": CT$(i + 6) = "Q"
		CASE IS = 13: CT$(i) = "K": CT$(i + 6) = "K"
		CASE ELSE: CT$(i) = I2A$(c): CT$(i + 6) = I2A$(c)
	END SELECT
NEXT i

FOR i = 1 TO 6
TOSL:
	X = INT(RND * 4) + 1
	Y = INT(RND * 4) + 1
	IF X = Y THEN GOTO TOSL:
  
	SELECT CASE X
		CASE IS = 1: cs$(i) = ""
		CASE IS = 2: cs$(i) = ""
		CASE IS = 3: cs$(i) = ""
		CASE IS = 4: cs$(i) = ""
	END SELECT
	SELECT CASE Y
		CASE IS = 1: cs$(i + 6) = ""
		CASE IS = 2: cs$(i + 6) = ""
		CASE IS = 3: cs$(i + 6) = ""
		CASE IS = 4: cs$(i + 6) = ""
	END SELECT
NEXT i

FOR S = 1 TO 4
	FOR i = 1 TO 12
		c = INT(RND * 12) + 1
		SWAP CT$(i), CT$(c): SWAP cs$(i), cs$(c)
	NEXT i
NEXT S

END SUB

SUB ShowHiScores
CLS
COLOR 14: center 3, "Memory Match High Scores"
COLOR 13: LOCATE 7, 1: PRINT "##"; TAB(6); "NAME"; TAB(22); "SCORE"; TAB(30); "DATE"
COLOR 10: LOCATE 8, 1: PRINT "ÄÄ"; TAB(6); "ÄÄÄÄÄÄÄÄÄÄÄÄ"; TAB(22); "ÄÄÄÄÄ"; TAB(30); "ÄÄÄÄÄÄÄÄÄÄ"
COLOR 15
FOR i = 1 TO 10
 IF HIS(i) <> 0 THEN
	PRINT USING "##"; i; : PRINT TAB(6); hin$(i); TAB(21); USING "##,###"; HIS(i); : PRINT TAB(30); hid$(i)
END IF
NEXT i
COLOR 13: center 21, "Press any key...": SLEEP
END SUB

SUB SoundToggle
   COLOR 13: sdata.nam = "SOUND": sdata.DAT = ""
  
	SELECT CASE SND
		CASE IS = 1
			SND = 0: center 8, "SOUND IS OFF": delay .75: clearline 8: : GOTO eost:
		CASE IS = 0
			SND = 1: center 8, "SOUND IS ON": delay .75: clearline 8: playsounds 2: GOTO eost:
	END SELECT
eost:
	sdata.scor = SND: PUT #1, 11, sdata

END SUB

