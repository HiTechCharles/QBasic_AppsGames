10    ' Morse Code Practice Program. Elwood Downey, WB0OEW, August, 1983.
20    ' Written for the IBM PC in Microsoft Basica, V1.1, for PC-DOS V1.1.
30    ' This program may be freely used, traded or copied but the author's
40    ' name and this stipulation shall remain as comments and the program
50    ' shall never be sold for profit.
60    '
70  COLOR 15:
80    KEY OFF
90    '
100   ' select input source: either from a file, the keyboard or random.
101 PRINT : PRINT "   ALL entries are to be in LOWER case letters": PRINT
104   ' check for color or monochrome
107   CLS
110   INPUT "Name of input file? (or `random' or `con:' or file name) ", F$
120   IF F$ = "random" THEN RANFILE = 1 ELSE RANFILE = 0
130   IF RANFILE = 1 THEN RANDOMIZE VAL(RIGHT$(TIME$, 2)): NCHRS = 0: NGRPS = 0
140   IF RANFILE = 0 THEN OPEN F$ FOR INPUT AS #1
150   '
160   ' select speed
170   INPUT "wpm? ", WPM
180   '
190   ' initialize code strings
200   ' to add more characters, such as apostrophe, increase numcodes,
210   ' add code string and character at end of current lists and add case
220   ' to main loop, below.
230   NUMCODES = 41  ' . , / ? - plus 26 + 10
240   DIM CODES$(NUMCODES - 1)
250   DIM CHARS$(NUMCODES - 1)
260   FOR I = 0 TO NUMCODES - 1
270     READ CODES$(I)
280   NEXT
290  FOR I = 0 TO NUMCODES - 1
300    READ CHARS$(I)
310  NEXT
320  ' code strings. in one-to-one correspondence with characters, below.
330  DATA ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "...."
340  DATA "..", ".---", "-.-", ".-..", "--"
350  DATA "-.", "---", ".--.", "--.-", ".-.", "...", "-"
360  DATA "..-", "...-", ".--", "-..-", "-.--", "--.."
370  DATA "-----", ".----", "..---", "...--", "....-", "....."
380  DATA "-....", "--...", "---..", "----."
390  DATA ".-.-.-", "--..--", "-..-.", "..--..", "-...-"
400  ' characters.
410  DATA "A", "B", "C", "D", "E", "F", "G", "H"
420  DATA "I", "J", "K", "L", "M"
430  DATA "N", "O", "P", "Q", "R", "S", "T"
440  DATA "U", "V", "W", "X", "Y", "Z"
450  DATA "0", "1", "2", "3", "4", "5"
460  DATA "6", "7", "8", "9"
470  DATA ".", ",", "/", "?", "-"
480 '
490 ' set up arrow keys to change speed and frequency.
500 PRINT
510 PRINT CHR$(24); " "; CHR$(25); " to raise or lower tone,   ";
520 PRINT CHR$(27); " "; CHR$(26); " for slower or faster code."
530 PRINT "Ctrl-Break to quit, F9 to pause."
540 PRINT
550 ON KEY(11) GOSUB 1040: KEY(11) ON
560 ON KEY(14) GOSUB 1050: KEY(14) ON
570 ON KEY(12) GOSUB 1090: KEY(12) ON
580 ON KEY(13) GOSUB 1080: KEY(13) ON
590 ON KEY(9) GOSUB 1330: KEY(9) ON
600 '
610 ' set defaults, init screen.
620 F = 600             ' initial tone frequency
630 SIL = 32767         ' special code for no tone
640 GOSUB 1120   ' calculate dit, dah and space lengths.
650 GOSUB 1180   ' display wpm and freq
660 '
670 ' define character type checking functions
680  DEF FNLOWER (C$) = "a" <= C$ AND C$ <= "z"
690  DEF FNUPPER (C$) = "A" <= C$ AND C$ <= "Z"
700  DEF FNDIGIT (C$) = "0" <= C$ AND C$ <= "9"
710 '
720 ' main loop. read (or generate) each character, sound it and print it.
730  IF RANFILE THEN GOSUB 1240: GOSUB 900: PRINT CHARS$(MORSE); : GOTO 870
740  C$ = INPUT$(1, #1)
750  IF " " = C$ OR C$ = CHR$(13) THEN GOSUB 990: GOTO 860
760  IF "." = C$ THEN MORSE = 36: GOTO 850' morse <- codes$ array index
770  IF "," = C$ THEN MORSE = 37: GOTO 850
780  IF "/" = C$ THEN MORSE = 38: GOTO 850
790  IF "?" = C$ THEN MORSE = 39: GOTO 850
800  IF "-" = C$ THEN MORSE = 40: GOTO 850
810  IF FNLOWER(C$) THEN C$ = CHR$(ASC(C$) - 32)
820  IF FNUPPER(C$) THEN MORSE = ASC(C$) - ASC("A"): GOTO 850
830  IF FNDIGIT(C$) THEN MORSE = ASC(C$) - ASC("0") + 26: GOTO 850
840  GOTO 870
850 GOSUB 900
860 PRINT C$;
870 GOTO 730
880 '
890 ' sound dit for each ".", dah for each "-" in string codes$(morse)
900 FOR I = 1 TO LEN(CODES$(MORSE))
910   IF MID$(CODES$(MORSE), I, 1) = "." THEN GOSUB 1000 ELSE GOSUB 1010
920 NEXT
930 GOSUB 980
940 RETURN
950 '
960 ' produce elemental sounds, or silences.
970  SOUND SIL, DIT: RETURN     ' element space
980 SOUND SIL, ELE * 2: RETURN  ' character space, allow for previous trailing
990 SOUND SIL, ELE * 6: RETURN' word space, allow for trailing.
1000 SOUND F, DIT: GOSUB 970: RETURN       ' dit
1010 SOUND F, DAH: GOSUB 970: RETURN       ' dah
1020 '
1030 ' change frequency of tone
1040 F = F * 1.104: GOSUB 1180: RETURN
1050 F = F / 1.104: GOSUB 1180: RETURN
1060 '
1070 ' change speed; update element timings.
1080 WPM = WPM + 1: GOSUB 1120: GOSUB 1180: RETURN
1090 WPM = WPM - 1: GOSUB 1120: GOSUB 1180: RETURN
1100 '
1110 ' calculate element timings. units are clock ticks, which are at 18.2hz.
1120 IF WPM < 13 THEN CWPM = 13 ELSE CWPM = WPM
1130 DIT = 21.84 / CWPM: DAH = 3 * DIT
1140 IF WPM >= 13 THEN ELE = DIT ELSE ELE = DIT * ((CWPM / WPM - 1) * 13 + 2) / 2
1150 RETURN
1160 '
1170 ' display current speed and frequency. return cursor where it was.
1180 COL = POS(0): ROW = CSRLIN: LOCATE 1, 60
1190 PRINT " wpm: "; WPM: LOCATE 2, 60: PRINT "freq: "; F; "     "
1200 LOCATE 2, 5: PRINT WPM; "   "
1210 LOCATE ROW, COL
1220 RETURN
1230 '
1240 ' set MORSE to random value from 0 up to numcodes to select random char.
1250 ' force a space character after every fifth time we are called
1260 ' and a newline before every 13 groups.
1270 IF NCHRS = 5 THEN PRINT " "; : GOSUB 990: NCHRS = 0: NGRPS = NGRPS + 1
1280 IF NCHRS = 0 AND NGRPS = 13 THEN PRINT : NGRPS = 0
1290 MORSE = INT(RND * NUMCODES)
1300 NCHRS = NCHRS + 1: RETURN
1310 '
1320 ' handle F9, the pause control.
1330 COL9 = POS(0): ROW9 = CSRLIN
1340 LOCATE 24, 30: COLOR 16, 7: PRINT " Press any key to continue ";
1350 X$ = INKEY$: IF X$ = "" THEN 1350
1360 LOCATE 24, 30: COLOR 7, 1: PRINT "                           ";
1370 LOCATE ROW9, COL9: RETURN

