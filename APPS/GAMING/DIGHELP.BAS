DECLARE SUB LoadINI ()
DECLARE SUB BigList (EXT$)
DECLARE SUB OQ ()
DECLARE SUB GetLevel ()
DECLARE SUB LoadRec ()
DECLARE SUB lve ()
DECLARE SUB ptg ()
DECLARE SUB MENU ()
DECLARE SUB center (row!, text$)
DECLARE FUNCTION trim$ (ttt$)
COMMON SHARED fec, fileerror, DOC$, lev$, rec$, acmd$, f$, cmd$, DOC, op$, SF, USEEDIT
ON ERROR GOTO errorhandler:

IF INSTR(COMMAND$, "/E") > 0 OR INSTR(COMMAND$, "-E") > 0 THEN USEEDIT = 1
LoadINI

DO
    SCREEN 0: WIDTH 40, 25: CLS
    MENU
LOOP

errorhandler:
IF fec <> 1 THEN SOUND 1600, 4
SELECT CASE ERR
    CASE IS = 53:
    IF fec <> 1 THEN PRINT "FILE NOT FOUND OR NOT ACCESSABLE - "; fi$
    fileerror = 1
    IF fec = 1 THEN RESUME NEXT ELSE SYSTEM
    CASE IS = 61: PRINT "Disk Is full.  Delete unneeded files from the disk.": SYSTEM: RESUME NEXT
    CASE ELSE: PRINT : PRINT "ERROR"; ERR
END SELECT
SYSTEM

SUB BigList (EXT$)

EXT$ = UCASE$(EXT$)
SHELL "DIR /B " + EXT$ + " > L"
OPEN "L" FOR INPUT AS #1

ENVIRON "DIRCMD="

DispList:
CLS : COLOR 15
FOR I = 2 TO 18
tol:
IF EOF(1) THEN GOTO Eol:
INPUT #1, L$
L$ = UCASE$(L$)
IF L$ = "L" THEN GOTO tol:
PRINT L$: NEXT I

TRC:
FOR I = 2 TO 18
tol2:
IF EOF(1) THEN GOTO Eol:
INPUT #1, L$
L$ = UCASE$(L$)
IF L$ = "L" THEN GOTO tol2:
LOCATE I, 21: PRINT L$: NEXT I

COLOR 10: center 23, "Press any key for more...": SLEEP: DO UNTIL INKEY$ = "": LOOP: GOTO DispList:

Eol:
CLOSE #1: KILL "l"

END SUB

SUB center (row, text$)

col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$

END SUB

SUB GetLevel

BigList lev$ + "*.DLF"

AFN2: COLOR 14
PRINT : PRINT "Please type in the name of the lovel"
        PRINT "you want to play:"
COLOR 15: INPUT ">", f$: f$ = trim$(f$)
IF f$ = "" THEN EXIT SUB
IF RIGHT$(f$, 3) <> "DLF" THEN f$ = f$ + ".DLF"
cmd$ = "DIGGER /L:" + lev$ + f$: OQ

END SUB

SUB LoadINI
fec = 1: OPEN "dighelp.ini" FOR INPUT AS 7: PT = 1
IF fileerror = 1 THEN EXIT SUB  'no INI file  all docs,levels,recordings
                                'are in main digger directory
DO UNTIL EOF(7)
    LINE INPUT #7, L$
    IF LEFT$(L$, 1) = ";" THEN GOTO Eoil:  'if ; begins a line, disregard  (comment)

    SELECT CASE PT  'Helps decide which section of the INI file is being read
        CASE IS = 1: DOC$ = L$: PT = PT + 1 'The first non-comment line is the
        CASE IS = 2: lev$ = L$: PT = PT + 1 'documents directory, second is levels,
        CASE IS = 3: rec$ = L$: PT = PT + 1 'third is recordings, last is command-line
        CASE IS = 4: acmd$ = L$: PT = PT + 1'args you want to use every time digger starts
    END SELECT
Eoil:
LOOP
CLOSE #7
IF RIGHT$(DOC$, 1) <> "\" THEN DOC$ = DOC$ + "\"
IF RIGHT$(lev$, 1) <> "\" THEN lev$ = lev$ + "\"
IF RIGHT$(rec$, 1) <> "\" THEN rec$ = rec$ + "\"






END SUB

SUB LoadRec

BigList rec$ + "*.DRF"

AFN:
COLOR 14
PRINT : PRINT "Please type in the name of the game"
        PRINT "recording file you want to play back:"
COLOR 15: INPUT ">", f$:  f$ = trim$(f$)
IF f$ = "" THEN EXIT SUB
IF RIGHT$(f$, 3) <> "DRF" THEN f$ = f$ + ".DRF"
WIDTH 80, 25: CLS
SHELL "DIGGER /E:" + rec$ + f$

END SUB

SUB lve

BigList lev$ + "*.DLF"

COLOR 14
PRINT : PRINT "Please type in the name of the lovel"
        PRINT "you want to edit, or the name of a"
        PRINT "new level to create:"
COLOR 15: INPUT ">", f$:  f$ = trim$(f$)
IF f$ = "" THEN EXIT SUB
IF RIGHT$(f$, 3) <> "DLF" THEN f$ = f$ + ".DLF"
PRINT : PRINT : SHELL "DIGLEVED " + f$: EXIT SUB

END SUB

SUB MENU
DMB:
SCREEN 0: WIDTH 80, 25: CLS : SCREEN 0: WIDTH 40, 25: CLS
COLOR 11: center 2, "DigHelp - Help with Digger Remastered"
COLOR 12: center 4, "By Charles Martin":  LOCATE 7, 1: COLOR 14
PRINT "     D.  Read documents about Digger"
PRINT
PRINT "     E.  Use the Level Editor"
PRINT
PRINT "     G.  PLAY THE GAME!"
PRINT
PRINT "     L.  Choose a different game level"
PRINT
PRINT "     P.  Play back a game recording"
PRINT
PRINT "     X.  Exit this program"
COLOR 9: PRINT : PRINT : PRINT "Press the letter next"
                         PRINT "to the desired choice:"
gmc:
k$ = UCASE$(INKEY$)
IF k$ = "D" THEN GOTO DigDocs:
IF k$ = "E" THEN lve: GOTO DMB:
IF k$ = "G" THEN ptg: : GOTO DMB:
IF k$ = "L" THEN GetLevel: GOTO DMB:
IF k$ = "P" THEN LoadRec: GOTO DMB:
IF k$ = "X" THEN SYSTEM
IF k$ = CHR$(27) THEN SYSTEM
GOTO gmc:

DigDocs:
CLS : COLOR 14: center 2, "Documents about Digger..."
LOCATE 5, 1:  COLOR 11
PRINT "     A.  Manual/FAQ/Much more!"
PRINT "     B.  Info on the Extra Levels pack"
PRINT
COLOR 13: PRINT "Level Information": COLOR 15
PRINT "     C.  Challenge of the Nobbins"
PRINT "     D.  Digger's Revenge"
PRINT "     E.  Digger's Years"
PRINT
PRINT "     M.  Return to the Main Menu"

COLOR 10: PRINT : PRINT
center 16, "Press the letter next to the"
center 17, "document you want to read:"
gdd:
k$ = LCASE$(INKEY$)
IF k$ = "a" THEN DOC = 1: GOTO DisplayDoc:
IF k$ = "b" THEN DOC = 2: GOTO DisplayDoc:
IF k$ = "c" THEN DOC = 3: GOTO DisplayDoc:
IF k$ = "d" THEN DOC = 4: GOTO DisplayDoc:
IF k$ = "e" THEN DOC = 5: GOTO DisplayDoc:
IF k$ = "m" THEN GOTO DMB:
IF k$ = CHR$(27) THEN GOTO DMB:
GOTO gdd:

DisplayDoc:
IF USEEDIT = 1 THEN ed$ = "EDIT " ELSE WIDTH 80, 25: ed$ = "READ "

SELECT CASE DOC
CASE IS = 1:  SHELL ed$ + DOC$ + "Digger.TXT": GOTO btm:
CASE IS = 2:  SHELL ed$ + DOC$ + "Extras.TXT": GOTO btm:
CASE IS = 3:  SHELL ed$ + DOC$ + "cnobbins.TXT": GOTO btm:
CASE IS = 4:  SHELL ed$ + DOC$ + "drevenge.TXT": GOTO btm:
CASE IS = 5:  SHELL ed$ + DOC$ + "years.txt ": GOTO btm:
END SELECT

btm:
WIDTH 40, 25: GOTO DigDocs:

END SUB

SUB OQ
COLOR 13: CLS
PRINT : PRINT "Would you like to hear sounds & music?"
PRINT "(Press Y or N)"
gsn:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO GRF:
IF k$ = "n" THEN cmd$ = cmd$ + " /M /Q": GOTO GRF:
IF k$ = CHR$(27) THEN MENU
GOTO gsn:

GRF:
COLOR 10: PRINT : PRINT "Please choose a name for your game"
PRINT "recording file:   "; : INPUT ">", f$
f$ = trim$(f$)
IF LEN(f$) > 11 THEN PRINT : PRINT "The name should have": PRINT "between 1 and 8 letters. ": SLEEP 3: CLS : GOTO GRF:
IF LEN(f$) < 2 THEN f$ = "LASTGAME.DRF": GOTO tpl:
IF RIGHT$(f$, 3) <> "DRF" THEN f$ = f$ + ".DRF"

tpl:
cmd$ = cmd$ + " /R:" + rec$ + f$
COLOR 12: PRINT : PRINT "Two players?  (Press Y or N):"
tpon:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN cmd$ = cmd$ + " /2": GOTO RED:
IF k$ = "n" THEN GOTO RED:
IF k$ = CHR$(27) THEN GOTO RED:
GOTO tpon:

RED:
COLOR 14: PRINT : PRINT "Would you like to change the keys that"
PRINT "control gameplay?  (Press Y or N):"
rkn:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN cmd$ = cmd$ + " /K": GOTO altl:
IF k$ = "n" THEN GOTO altl:
IF k$ = CHR$(27) THEN GOTO altl:
GOTO rkn:

altl:
COLOR 15: PRINT : PRINT "Game level number to start at:"
PRINT "Press a number between 1 and 8:"
alm:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN L = 1: GOTO letsgo:
IF k$ = "2" THEN L = 2: GOTO letsgo:
IF k$ = "3" THEN L = 3: GOTO letsgo:
IF k$ = "4" THEN L = 4: GOTO letsgo:
IF k$ = "5" THEN L = 5: GOTO letsgo:
IF k$ = "6" THEN L = 6: GOTO letsgo:
IF k$ = "7" THEN L = 7: GOTO letsgo:
IF k$ = "8" THEN L = 8: GOTO letsgo:
IF k$ = "r" THEN L = INT(RND * 8) + 1: GOTO RAL:
IF k$ = CHR$(27) THEN L = 1: GOTO letsgo:
GOTO alm:

RAL:
SELECT CASE L
CASE IS = 1: k$ = "1": GOTO letsgo:
CASE IS = 2: k$ = "2": GOTO letsgo:
CASE IS = 3: k$ = "3": GOTO letsgo:
CASE IS = 4: k$ = "4": GOTO letsgo:
CASE IS = 5: k$ = "5": GOTO letsgo:
CASE IS = 6: k$ = "6": GOTO letsgo:
CASE IS = 7: k$ = "7": GOTO letsgo:
CASE IS = 8: k$ = "8": GOTO letsgo:
CASE ELSE: k$ = "1": GOTO letsgo:
END SELECT

letsgo:
cmd$ = cmd$ + " /I:" + k$

COLOR 9: CLS : PRINT : PRINT "Would you like to give other command-"
                       PRINT "line parameters?  (Press Y or N)"
cmp:         
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO GCM:
IF k$ = "n" THEN GOTO eoq:
IF k$ = CHR$(27) THEN GOTO eoq:
GOTO cmp:

GCM:
COLOR 15: CLS
SHELL "type usage.txt"
COLOR 14: PRINT : PRINT "THE COMMAND LINE SO FAR:"
PRINT cmd$
COLOR 15: INPUT ">", ac$
ac$ = trim$(ac$)
IF ac$ <> "" THEN cmd$ = cmd$ + " " + ac$

eoq:
SCREEN 0: WIDTH 80, 25: CLS
SHELL cmd$
END SUB

SUB ptg

gams:
COLOR 12: CLS : center 2, "Choose a game mode...": COLOR 11
LOCATE 5, 1: PRINT "     O.  Regular Digger"
PRINT
PRINT "     G.  Gauntlet Mode - Play for X"
PRINT "         amount of minutes, using as"
PRINT "         many lives as you want to"
PRINT
PRINT "     R.  Return to the Main Menu"
COLOR 9: PRINT : PRINT : PRINT "Press the letter next"
                PRINT "to the desired option:"

cgm:
k$ = LCASE$(INKEY$)
IF k$ = "o" THEN cmd$ = "DIGGER ": OQ: EXIT SUB
IF k$ = "g" THEN GOTO gau:
IF k$ = "m" THEN MENU
IF k$ = CHR$(27) THEN MENU
GOTO cgm:

gau:
COLOR 15: CLS
PRINT : PRINT "The GAUNTLET MODE..."
PRINT : PRINT "Play for how many minutes?  (1-60)"
PRINT "Enter 0 for a random amount of time."
COLOR 14: INPUT ">", M
IF M > 60 THEN PRINT : PRINT "Between 1 and 60 minutes, please.": SLEEP 3: GOTO gau:
IF M < 1 THEN GOTO rgt:
GOTO SGM:

rgt:
RANDOMIZE TIMER
M = INT(RND * 60) + 1
PRINT : PRINT "Hope you feel like playing"
PRINT "for"; M; "minutes!": GOTO SGM:

SGM:
s = M * 60
s$ = LTRIM$(RTRIM$(STR$(s))): cmd$ = "DIGGER /G:" + s$
COLOR 9: PRINT : PRINT : PRINT "Press any key...": SLEEP: OQ: EXIT SUB

'UI functions list
'Use Level Editor - Choose a level file, Run the editor -- DONE
'Playback a game recording - Choose a file, play the recording file -- DONE
'Documents - Choose a document, Display it -- DONE
'Play the game - Choose a mode, ask other questions, play! -- game will not run
'Alternate game level - Choose a level file, ask other questons, play -- DONE
'Other questions -- ask about sound, 2 players, etc, play -- All questions DONE

END SUB

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(UCASE$(ttt$)))
END FUNCTION

