DECLARE SUB AssembleWord ()
DECLARE SUB center (row, text$)
DECLARE SUB CheckForDuplicate ()
DECLARE SUB ClearBoard ()
DECLARE FUNCTION limitinput$ (allowedchars)
DECLARE SUB quote (wd$)
DECLARE SUB ScrambleWord ()
DECLARE SUB WordPos ()
COMMON SHARED word$, noa, low, ana$, ap, DUP, bw, CP, wos
DIM SHARED wd$(10000)
WIDTH 40, 25

boa:
ClearBoard
CLEAR : COLOR 14: VIEW PRINT: CLS : center 2, "Anagrammer"
COLOR 15: center 3, "By Charles Martin"

LOCATE 8, 1: COLOR 13: PRINT "What's the word?  (Leave this"
PRINT "blank to quit.)  "; : COLOR 15: PRINT ">";
word$ = UCASE$(limitinput$(12))
IF word$ = CHR$(27) THEN SYSTEM
low = LEN(word$)
IF low = 0 THEN SYSTEM
IF low < 3 OR low > 12 THEN PRINT "Between 3 and 12 letters, please.": GOTO boa:

DIM SHARED ltr$(low)
FOR sl = 1 TO low
ltr$(sl) = MID$(word$, sl, 1)
NEXT sl

PRG:
COLOR 14: CLS : LOCATE 1, 4: PRINT "Anagrams of "; : quote word$: VIEW PRINT 2 TO 23
PRINT : ap = 1: wos = 0: CP = 1: COLOR 15
DO UNTIL bw = 100
    ana$ = ""
    ScrambleWord
    AssembleWord
    CheckForDuplicate
    IF DUP <> 1 THEN
        ap = ap + 1: wos = wos + 1: bw = 0: WordPos: wd$(ap) = ana$
        IF wos >= 60 THEN COLOR 13: center 23, "Press any key for more...": SLEEP: CLS : wos = 0: COLOR 15
    ELSE
        bw = bw + 1
    END IF
IF bw >= 100 THEN EXIT DO
LOOP

COLOR 10: center 22, "ANAGRAMS FOUND: " + STR$(ap - 1)
center 23, "PRESS ANY KEY...": SLEEP: CLEAR : GOTO boa:

SUB AssembleWord

FOR z = 1 TO low
    ana$ = ana$ + ltr$(z)
NEXT z

END SUB

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB CheckForDuplicate

DUP = 0
FOR i = 1 TO ap
    IF wd$(i) = ana$ THEN DUP = 1: EXIT SUB
NEXT i

END SUB

SUB ClearBoard
DO UNTIL INKEY$ = "": LOOP
END SUB

FUNCTION limitinput$ (allowedchars)
                                         
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
         CASE IS = 13: limitinput$ = contents$: EXIT FUNCTION
         CASE IS = 27: limintinput$ = CHR$(27): EXIT FUNCTION
         CASE ELSE:
         SELECT CASE tc
              CASE IS < allowedchars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l9B": GOTO TOS:
         END SELECT
     END SELECT
LOOP

END FUNCTION

SUB quote (wd$)
PRINT CHR$(34); wd$; CHR$(34);
END SUB

SUB ScrambleWord

RANDOMIZE TIMER
FOR z = 1 TO low:
GRAN:
    rl = INT(RND * low) + 1
    IF z = rl THEN GOTO GRAN:
    SWAP ltr$(z), ltr$(rl)
NEXT z

END SUB

SUB WordPos
IF CP < 1 OR CP > 3 THEN CP = 1: PRINT
SELECT CASE CP
CASE IS = 1: LOCATE CSRLIN, 1: GOTO ptw:
CASE IS = 2: LOCATE CSRLIN, 15: GOTO ptw:
CASE IS = 3: LOCATE CSRLIN, 29: GOTO ptw:
END SELECT

ptw:
PRINT ana$; : CP = CP + 1
END SUB

