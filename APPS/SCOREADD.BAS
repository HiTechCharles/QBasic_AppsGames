DECLARE SUB center (row, Text$)
DECLARE SUB ClearBoard ()
DECLARE FUNCTION CurrentTime$ ()
DECLARE SUB DisplayScores ()
DECLARE SUB flashprompt (clr!)
DECLARE SUB GetNames ()
DECLARE SUB GetScore (player!)
DECLARE FUNCTION I2a$ (h)
DECLARE SUB IsGameOver ()
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
DECLARE FUNCTION PlayAgain ()
DECLARE FUNCTION ReallyZero ()
DECLARE SUB RightJustify (r, c, t$)
DECLARE SUB ScoreInput ()
DECLARE SUB SetupScreen ()
DECLARE SUB status (Text$)
DECLARE SUB WhenIsGameOver ()
DECLARE SUB WhoWon ()

COMMON SHARED Players, turn, limit&, AlwaysZero, fmt$, row, quit, LimitMode
DIM SHARED names$(3), scores&(3), rounds&(3), avg&(3), tcolor(3)
ON ERROR GOTO ErrorHandler:

Begin:
    IF INSTR(COMMAND$, "/Z") > 0 OR INSTR(COMMAND$, "-Z") > 0 THEN AlwaysZero = 1
    GetNames
    WhenIsGameOver
BeginSame:
    SetupScreen
    ScoreInput
    WhoWon
    SELECT CASE PlayAgain
        CASE 1
            ERASE scores&, rounds&, avg&: turn = 1
            GOTO BeginSame:
        CASE 2
            CLEAR : GOTO Begin:
        CASE 3
            GOTO BeginSame:
        END SELECT


'screen collumn #s for players' scores on-screen
DATA 1, 15, 29

ErrorHandler:
    SELECT CASE ERR
        CASE 6: RESUME NEXT
        CASE ELSE: PRINT "Error #"; ERR; "occured.": SYSTEM
    END SELECT

SUB center (row, Text$)
    col = 21 - LEN(Text$) / 2: LOCATE row, col: PRINT Text$
END SUB

SUB ClearBoard
    DO UNTIL INKEY$ = "": LOOP
END SUB

FUNCTION CurrentTime$
'C0urrentTime - Stores the current time in 12-hour (am/pm) format, unlike TIME$

'   USAGE:  Print CurrentTime$
'EXAMPLES:  TM$ = CurrentTime$  'current time is stored in TM$
'           IF CurrentTime$ = "1:00 PM" then BEEP     'beep if it's 1 PM
h = VAL(LEFT$(TIME$, 2))
m = VAL(MID$(TIME$, 4, 2)): m$ = I2a$(m)
S = VAL(RIGHT$(TIME$, 2)): S$ = I2a$(S)

SELECT CASE h
    CASE IS = 0: AP$ = "A": SH = 12
    CASE IS < 12: AP$ = "A": SH = h
    CASE IS = 12: AP$ = "P": SH = h
    CASE IS > 12: AP$ = "P": SH = h - 12
END SELECT

SH$ = I2a$(SH)
'             hour : minute <AM or PM>
IF LEN(m$) = 1 THEN m$ = "0" + m$
CurrentTime$ = SH$ + ":" + m$ + AP$

END FUNCTION

SUB DisplayScores
dsc:
    sat& = scores&(1) + scores&(2) + scores&(3)
    IF sat& <> 0 THEN
        COLOR 11: center 19, "ÄÄÄ  TOTALS  ÄÄÄ"
        RESTORE
        FOR pl = 1 TO Players
            READ pcol
            IF scores&(pl) <> 0 THEN COLOR tcolor(pl): LOCATE 20, pcol, 0: PRINT USING fmt$; scores&(pl)
        NEXT pl
    
        COLOR 12: LOCATE 21, 1: PRINT "ÄÄÄÄÄÄÄ AVERAGE SCORES PER ROUND ÄÄÄÄÄÄÄ"
        RESTORE
        FOR pl = 1 TO Players
            READ pcol
            IF scores&(pl) <> 0 THEN avg&(pl) = scores&(pl) / rounds&(pl)
            IF avg&(pl) <> 0 THEN COLOR tcolor(pl): LOCATE 22, pcol: PRINT USING fmt$; avg&(pl)
        NEXT pl
    END IF
END SUB

SUB flashprompt (clr)
    COLOR clr + 16: PRINT ">"; : COLOR clr
END SUB

SUB GetNames
    fmt$ = "###,###,###": tcolor(1) = 15: tcolor(2) = 14: tcolor(3) = 13
    WIDTH 40, 25: COLOR 9: CLS : center 2, "Score Adder"
    COLOR 15: center 4, "By Charles Martin"

    LOCATE 8, 1
    FOR p = 1 TO 2:
GN1:
        COLOR 15: VIEW PRINT CSRLIN TO 23
        PRINT : PRINT "Name of player"; p; "- "; : COLOR tcolor(p)
        names$(p) = Limitinput$(11, "", CSRLIN, POS(0), names$(p))
        IF LEN(names$(p)) < 3 THEN CLS : GOTO GN1:
        PRINT
    NEXT p

    COLOR 10: LOCATE 14, 1, 0: PRINT "Is there a third player?  (Y or N):  ";
tpyn:
    k$ = UCASE$(INKEY$)
        IF k$ = "Y" THEN Players = 3: PRINT "Yes": GOTO GN3:
        IF k$ = "N" THEN Players = 2: PRINT "No": EXIT SUB
        IF k$ = CHR$(27) THEN EXIT SUB
    GOTO tpyn:

GN3:
    VIEW PRINT 13 TO 23: CLS
    COLOR 15:  PRINT "Name of player 3 - "; : COLOR tcolor(3)
    names$(3) = Limitinput$(11, "", 13, POS(0), names$(3))
    IF LEN(names$(3)) < 3 THEN CLS : GOTO GN3:
END SUB

SUB GetScore (player)
        SELECT CASE player
            CASE 1: col = 1
            CASE 2: col = 15
            CASE 3: col = 29
        END SELECT

gsn:    CALL ClearBoard:  DisplayScores: LOCATE row, col: flashprompt tcolor(player)
        Sc$ = Limitinput$(10, "0123456789-", row, col + 1, ""): Sc = VAL(Sc$)
        IF Sc$ = CHR$(27) THEN turn = player: quit = 1: EXIT SUB
        IF Sc > 999999999 THEN LOCATE row, col: PRINT SPACE$(14): GOTO gsn:
        IF Sc = 0 THEN z = ReallyZero
        IF z = 1 THEN Sc = 0
        IF z = -1 THEN GOTO gsn:
        COLOR tcolor(player): LOCATE row, col: PRINT USING fmt$; Sc: scores&(player) = scores&(player) + Sc
END SUB

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB IsGameOver
    SELECT CASE LimitMode
        CASE 1
            IF rounds&(1) = limit& THEN
                status LTRIM$(STR$(rounds&(1))) + " rounds completed. Press any key..."
                quit = 2: : SLEEP: EXIT SUB
            END IF
        CASE 2
            FOR pl = 1 TO Players
                IF scores&(pl) >= limit& THEN
                    status names$(pl) + " has reached the target score."
                    quit = 2: SLEEP: EXIT SUB
                END IF
            NEXT pl
    END SELECT
END SUB

FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
'
'LimitInput$ -- Allows the user to type only a certain number of characters
'all common editing functions can be used to delete/edit characters.

'   USAGE:  StringVariable$ = LimitInput$ (<# characters allowed>, <characters allowed in string>, <Row>, <Collumn>, <Existing tecxt>)
'EXAMPLES:  NUM = val(LimitInput$ (12, "0123456789.", 5, 5, ""))
            'up to 12 digits, only numbers and decimal allowed, start typing at 5,5

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

FUNCTION PlayAgain
    COLOR 9: LOCATE , , 0
    LOCATE 20, 7: PRINT "S - New game, same players"
    LOCATE 21, 7: PRINT "D - New game, different players"
    IF quit <> 2 THEN LOCATE 22, 7: PRINT "R - Return to game in progress"
    LOCATE 23, 7: PRINT "X - Exit"

gcc:
    k$ = UCASE$(INKEY$)
        IF k$ = "S" THEN PlayAgain = 1: EXIT FUNCTION
        IF k$ = "D" THEN PlayAgain = 2: EXIT FUNCTION
        IF k$ = "R" AND quit <> 2 THEN PlayAgain = 3: EXIT FUNCTION
        IF k$ = "X" OR k$ = CHR$(27) THEN SYSTEM
    GOTO gcc:
END FUNCTION

FUNCTION ReallyZero
    IF AlwaysZero = 1 THEN ReallyZero = 1: EXIT FUNCTION
    SOUND 490, 2: SOUND 0, 1.5: SOUND 490, 1.5: : LOCATE 23, 1, 0: PRINT SPACE$(40)
    status "Make this score ZERO?  (Press Y or N):"
zon:
        k$ = LCASE$(INKEY$)
        IF k$ = "y" THEN ReallyZero = 1: GOTO eoz:
        IF k$ = "n" THEN ReallyZero = -1: GOTO eoz:
        IF k$ = CHR$(13) THEN ReallyZero = 1: GOTO eoz:
        IF k$ = CHR$(27) THEN ReallyZero = -1: GOTO eoz:
    GOTO zon

eoz:
    status ""
END FUNCTION

SUB RightJustify (r, c, t$)
    rj = c - LEN(t$) + 1
    LOCATE r, rj: PRINT t$

END SUB

SUB ScoreInput
    DO UNTIL INKEY$ = CHR$(27)
gsa:
        IF row > 18 THEN SetupScreen
        
        FOR loopturn = 1 TO Players
            IF turn > loopturn THEN loopturn = turn
            turn = loopturn
            IF turn = 1 THEN IsGameOver
                IF quit = 2 THEN EXIT SUB

            COLOR 10: LOCATE 23, 1: PRINT "Play";
            SELECT CASE LimitMode
                CASE 1: PRINT "ing round"; rounds&(loopturn) + 1; "of"; limit&;
                CASE 2: PRINT " to"; limit&; "points";
            END SELECT
            PRINT TAB(35); CurrentTime$
           
            GetScore (loopturn)

            IF quit = 1 THEN EXIT SUB
            rounds&(loopturn) = rounds&(loopturn) + 1
            DisplayScores
        NEXT loopturn

eol:
        row = row + 1: turn = 1
    LOOP
END SUB

SUB SetupScreen
    VIEW PRINT: ClearBoard: CLS : row = 3: quit = 0
    status ""
 
    RESTORE
    FOR pl = 1 TO Players
        READ col:  COLOR tcolor(pl)
        RightJustify 1, col + 10, names$(pl)
        RightJustify 2, col + 10, STRING$(LEN(names$(pl)), 196)
    NEXT pl
END SUB

SUB status (Text$)
    COLOR 30: LOCATE 23, 1: PRINT SPACE$(40)
    LOCATE 23, 1: PRINT Text$
    COLOR , 0
    END SUB

SUB WhenIsGameOver
    VIEW PRINT 17 TO 23
    COLOR 13: LOCATE 17, 1
        PRINT "At what point does the game end?": COLOR 10
        PRINT "     R.  After a number of rounds/hands"
        PRINT "         are completed by each player"
        PRINT "     S.  Ween a Player reaches"
        PRINT "         a certain score"
        PRINT "     N.  None of the above"

wigo:
    k$ = UCASE$(INKEY$)
    IF k$ = "R" THEN GOTO HMRounds
    IF k$ = "S" THEN GOTO ScoreLimit:
    IF k$ = "N" THEN EXIT SUB
    IF k$ = "X" OR k$ = CHR$(27) THEN SYSTEM
GOTO wigo:

HMRounds:
    COLOR 15: CLS :
    PRINT "How many rounds/hands for each";
    PRINT "player?  (3 to 999,999,999)  "; : flashprompt (9)
    Sc$ = Limitinput$(9, "0123456789", 18, POS(0), ""): Sc& = VAL(Sc$)
    IF Sc$ = CHR$(27) THEN SYSTEM
    IF Sc& < 3 THEN GOTO HMRounds:
    limit& = Sc&: LimitMode = 1
    EXIT SUB

ScoreLimit:
    COLOR 15: CLS : PRINT "Winning Score:  "; : flashprompt (9)
    Sc$ = Limitinput$(9, "0123456789", 17, POS(0), ""): Sc& = VAL(Sc$)
    IF Sc$ = CHR$(27) THEN turn = player: quit = 1: EXIT SUB
    IF Sc& < 5 THEN GOTO ScoreLimit:
    IF Sc& > 999999999 THEN GOTO ScoreLimit:
    limit& = Sc&: LimitMode = 2
END SUB

SUB WhoWon
    DIM Sortedscores&(3), order(3)
    FOR pl = 1 TO 3
        Sortedscores&(pl) = scores&(pl)
        order(pl) = pl
    NEXT pl

    IF Sortedscores&(2) > Sortedscores&(1) THEN SWAP Sortedscores&(2), Sortedscores&(1): SWAP order(2), order(1)  '2>1
    IF Sortedscores&(3) > Sortedscores&(1) THEN SWAP Sortedscores&(3), Sortedscores&(1):  SWAP order(3), order(1)  '3>1
    IF Sortedscores&(3) > Sortedscores&(2) THEN SWAP Sortedscores&(3), Sortedscores&(2): SWAP order(3), order(2)  '3>2
    
     COLOR 13: CLS
     LOCATE 4, 5
     SELECT CASE LimitMode
        CASE 1:  PRINT "Game ends after"; limit&; " rounds"
        CASE 2: PRINT "First to reach"; limit&; "points wins"
     END SELECT

     r = rounds&(order(1))
     IF r = 0 THEN GOTO ShowScores:

     SELECT CASE turn
        CASE 1: LOCATE 5, 5: PRINT "After" + STR$(r) + " round";
            IF r > 1 THEN PRINT "s";
            PRINT " of play..."
        CASE 2
            IF Players = 2 THEN
                r = r - 1
                IF r = 0 THEN r$ = "« round" ELSE r$ = STR$(r) + "« rounds"
                LOCATE 5, 5: PRINT "After " + r$ + " of play..."
            END IF
        END SELECT
    
ShowScores:
    COLOR 10: LOCATE 8, 1: BoxScorefmt$ = "\         \  ###,###,###  ###,###"
    FOR pl = 1 TO Players
        COLOR tcolor(order(pl)): LOCATE 7 + pl, 5: PRINT USING BoxScorefmt$; names$(order(pl)); scores&(order(pl)); rounds&(order(pl))
    NEXT pl

    COLOR 15
    IF Sortedscores&(1) <> Sortedscores&(2) THEN
        center 13, names$(order(1)) + " has the highest score."
        center 14, "Margin of Victory:  " + STR$(Sortedscores&(1) - Sortedscores&(2))
    ELSE
        IF Players = 2 THEN
            center 13, "Both players have the same score."
        ELSE
            IF Sortedscores&(1) <> Sortedscores&(3) THEN
                center 13, names$(order(1)) + " & " + names$(order(2)) + " have the highest score."
            ELSE
                center 13, "All players have the same score!"
            END IF
        END IF
    END IF
END SUB

