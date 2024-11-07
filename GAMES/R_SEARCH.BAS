DECLARE SUB center (row, text$)
DECLARE FUNCTION GetLetter$ ()
DECLARE FUNCTION Limitinput$ (AllowedChars)
SHELL "if exist puzzles.txt del puzzles.txt"
OPEN "puzzles.txt" FOR APPEND AS #1

SCREEN 13: COLOR 15: CLS : RANDOMIZE TIMER: LOCATE 7, 1:
COLOR 9: center 2, "R-Search": center 3, "By Charles Martin"
LOCATE 7, 1: COLOR 11
PRINT "Each player gets a 20x20 grid of"
PRINT "letters.  The object of the game is to"
PRINT "find hidden words in the grid; either"
PRINT "across, down, or diagonally."
PRINT
PRINT "The player that finds the"
PRINT "most words wins!"
PRINT
PRINT
PRINT
RESTORE
DRAW "bm230, 75"
DO:  READ l$: DRAW l$: LOOP UNTIL l$ = "END"

COLOR 13: PRINT "Press any key to start!": SLEEP

CLS : LOCATE 7, 1: COLOR 15
PRINT "How many puzzles?   >"; : COLOR 14: NumPuzzles = VAL(Limitinput$(6))
IF NumPuzzles < 1 THEN SYSTEM
NumPuzzles = INT(NumPuzzles): CLS

st = TIMER: COLOR 15
FOR p = 1 TO NumPuzzles
    PRINT #1, "---------------------------------------"
    FOR R = 1 TO 20
        FOR C = 1 TO 20
            et = TIMER - st: LOCATE 2, 1, 0: PRINT USING "###,### OF ###,### PUZZLES"; p; NumPuzzles
            LOCATE 3, 1: PRINT USING "IN     ###,###,###.####### SECONDS"; et
            PRINT #1, GetLetter$; " ";
        NEXT C
    PRINT #1, ""
    NEXT R
PRINT #1, "---------------------------------------": PRINT #1, "": PRINT #1, "": PRINT #1, ""
NEXT p
et = TIMER - st: LOCATE 2, 1, 0: PRINT USING "###,### OF ###,### PUZZLES"; p - 1; NumPuzzles
            LOCATE 3, 1: PRINT USING "IN     ###,###,###.####### SECONDS"; et
COLOR 13: center 9, "様様様様様 DONE! 様様様様様": CLOSE #1: SYSTEM

DATA "r10","r10","r10","h5","f5","g5","e5","l10","l10","l10","d10","d10","d10"
DATA "e5","g5","h5","f5","u10","u10","u10","f10","f10","f10","e5","g5","l5","l5", "END"

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

FUNCTION GetLetter$
l$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ": H = INT(RND * 26) + 1
GetLetter$ = MID$(l$, H, 1)
END FUNCTION

FUNCTION Limitinput$ (AllowedChars)
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
         CASE IS = 13: Limitinput$ = contents$: EXIT FUNCTION
         CASE ELSE:
         SELECT CASE tc
              CASE IS < AllowedChars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l29B": GOTO TOS:
         END SELECT
     END SELECT
LOOP

END FUNCTION

