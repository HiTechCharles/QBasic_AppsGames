DECLARE SUB center (row!, text$)
DIM SHARED names$, ingame, scores(9)
COMMON SHARED NOP, pl

begin:
WIDTH 40, 25: VIEW PRINT: CLS : COLOR 15, 9:
center 2, "     TheScore     "
center 3, "By Charles Martin"

COLOR 14, 8: LOCATE 7, 1:
PRINT "How many players?  (from 2 to 9)  ";
npl:
k$ = LCASE$(INKEY$)
IF k$ = "2" THEN NOP = 2: GOTO GTN:
IF k$ = "3" THEN NOP = 3: GOTO GTN:
IF k$ = "4" THEN NOP = 4: GOTO GTN:
IF k$ = "5" THEN NOP = 5: GOTO GTN:
IF k$ = "6" THEN NOP = 6: GOTO GTN:
IF k$ = "7" THEN NOP = 7: GOTO GTN:
IF k$ = "8" THEN NOP = 8: GOTO GTN:
IF k$ = "9" THEN NOP = 9: GOTO GTN:
IF k$ = CHR$(27) THEN SYSTEM
GOTO npl:

GTN: COLOR 13: PRINT NOP: LOCATE 10, 1:
PRINT "Please type in the names": PRINT "of the"; NOP; "players..."
LOCATE 13, 1: COLOR 15

FOR xy = 1 TO NOP
tol:
    PRINT "Player"; xy; "- "; : INPUT "", names$(xy)
    IF LEN(names$(xy)) < 2 OR LEN(names$(xy)) > 12 THEN PRINT : PRINT "between 2 and 12 letters, please.": SLEEP 3: CLS : GOTO tol:
    ingame(xy) = 1
NEXT xy

gr:
VIEW PRINT: CLS : COLOR 14, 12: LOCATE 2, 1:
PRINT " 1   2   3   4   5   6   7   8   9  ณ123"
PRINT "1-2 5-6 9-0 Q-W O-P A-S K-L Z-X N-M ณ456"
PRINT "                                    ณ789"
VIEW PRINT 7 TO 23

scoretable:
LOCATE 7, 1: COLOR 15, 9
PRINT "ีออออออออออออัออออออออออออัออออออออออออธ"
PRINT "ณ            ณ            ณ            ณ"
PRINT "ณ            ณ            ณ            ณ"
PRINT "รฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤด"
PRINT "ณ            ณ            ณ            ณ"
PRINT "ณ            ณ            ณ            ณ"
PRINT "รฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤด"
PRINT "ณ            ณ            ณ            ณ"
PRINT "ณ            ณ            ณ            ณ"
PRINT "ิออออออออออออฯออออออออออออฯออออออออออออพ"
COLOR 11
LOCATE 8, 2: PRINT names$(1)
LOCATE 9, 2: PRINT USING "###,###,###"; scores(1)
LOCATE 8, 15: PRINT names$(2)
LOCATE 9, 15: PRINT USING "###,###,###"; scores(2)
LOCATE 8, 28: PRINT names$(3)
IF ingame(3) = 1 THEN LOCATE 9, 28: PRINT USING "###,###,###"; scores(3)
LOCATE 11, 2: PRINT names$(4)
IF ingame(4) = 1 THEN LOCATE 12, 2: PRINT USING "###,###,###"; scores(4)
LOCATE 11, 15: PRINT names$(5)
IF ingame(5) = 1 THEN LOCATE 12, 15: PRINT USING "###,###,###"; scores(5)
LOCATE 11, 28: PRINT names$(6)
IF ingame(6) = 1 THEN LOCATE 12, 28: PRINT USING "###,###,###"; scores(6)
LOCATE 14, 2: PRINT names$(7)
IF ingame(7) = 1 THEN LOCATE 15, 2: PRINT USING "###,###,###"; scores(7)
LOCATE 14, 15: PRINT names$(8)
IF ingame(8) = 1 THEN LOCATE 15, 15: PRINT USING "###,###,###"; scores(8)
LOCATE 14, 28: PRINT names$(9)
IF ingame(9) = 1 THEN LOCATE 15, 28: PRINT USING "###,###,###"; scores(9)

cts:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN pl = 1: tn = 1: GOTO CHK:
IF k$ = "2" THEN pl = 1: tn = -1: GOTO CHK:
IF k$ = "5" THEN pl = 2: tn = 1: GOTO CHK:
IF k$ = "6" THEN pl = 2: tn = -1: GOTO CHK:
IF k$ = "9" THEN pl = 3: tn = 1: GOTO CHK:
IF k$ = "0" THEN pl = 3: tn = -1: GOTO CHK:
IF k$ = "q" THEN pl = 4: tn = 1: GOTO CHK:
IF k$ = "w" THEN pl = 4: tn = -1: GOTO CHK:
IF k$ = "o" THEN pl = 5: tn = 1: GOTO CHK:
IF k$ = "p" THEN pl = 5: tn = -1: GOTO CHK:
IF k$ = "a" THEN pl = 6: tn = 1: GOTO CHK:
IF k$ = "s" THEN pl = 6: tn = -1: GOTO CHK:
IF k$ = "k" THEN pl = 7: tn = 1: GOTO CHK:
IF k$ = "l" THEN pl = 7: tn = -1: GOTO CHK:
IF k$ = "z" THEN pl = 8: tn = 1: GOTO CHK:
IF k$ = "x" THEN pl = 8: tn = -1: GOTO CHK:
IF k$ = "n" THEN pl = 9: tn = 1: GOTO CHK:
IF k$ = "m" THEN pl = 9: tn = -1: GOTO CHK:
IF k$ = CHR$(27) THEN GOTO TheEnd:
IF k$ = CHR$(0) + CHR$(59) THEN GOTO hlp:     'F1 HELP
IF k$ = CHR$(0) + CHR$(61) THEN GOTO NuGame:  'F3 NewGame
IF k$ = CHR$(0) + CHR$(63) THEN GOTO CAS:     'F5 ClearAllScores
IF k$ = CHR$(0) + CHR$(65) THEN GOTO SetIt:   'Set a score
IF k$ = CHR$(0) + CHR$(68) THEN GOTO TheEnd:  'QUIT
GOTO cts:

CHK:
COLOR , 8
IF ingame(pl) <> 1 THEN GOTO cts
IF ingame(pl) = 1 THEN scores(pl) = scores(pl) + tn
GOTO scoretable:

CAS:
COLOR 15, 8: center 20, "CLEAR scores for ALL players?"
center 21, "(Press Y or N)"
con:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN ERASE scores: PRINT : GOTO gr:
IF k$ = "n" THEN GOTO gr:
IF k$ = CHR$(27) THEN GOTO scoretable:
GOTO con:

hlp:
PRINT "Help not coded yet": SYSTEM

SetIt:
GOTO LongForm:

TheEnd:
SYSTEM

NuGame:
COLOR 10, 8: LOCATE 19, 1
PRINT "Using this option will restart the"
PRINT "program, allowing you to create a new"
PRINT "set of players.  PROCEED?  (Hit Y or N)"
rson:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN CLEAR : GOTO begin:
IF k$ = "n" THEN GOTO gr:
IF k$ = CHR$(27) GOTO gr:
GOTO rson:

LongForm:
VIEW PRINT: COLOR 8, 8: CLS
COLOR 10, 8: center 2, "The Players..."
COLOR 13: LOCATE 3, 1: PRINT "PLAY #   Name                Score"
COLOR 14: LOCATE 4, 1: PRINT "ฤฤฤฤฤฤ   ฤฤฤฤ                ฤฤฤฤฤ"
COLOR 15:
FOR I = 1 TO NOP
PRINT I; TAB(10); names$(I); TAB(24); USING "###,###,###"; scores(I)
NEXT I
COLOR 14: center 18, "Press the NUMBER next"
center 19, "to the desired player:"
SYSTEM

SUB center (row!, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

