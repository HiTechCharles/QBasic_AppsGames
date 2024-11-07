DECLARE SUB CBS ()

DIM SHARED balls, strikes, outs, turn, inning, ot
DIM SHARED name$(2): DIM SHARED runs(2): DIM SHARED hits(2): DIM SHARED errors(2)

IF INSTR(COMMAND$, "/N") > 0 OR INSTR(COMMAND$, "-N") > 0 THEN WIDTH 80, 25: GOTO GetN:

WIDTH 40, 25:
GetN:
CLS
COLOR 15: PRINT : PRINT :
INPUT "WHo's the VISITING team?  ", name$(1)
name$(1) = LTRIM$(RTRIM$(name$(1)))
IF LEN(name$(1)) < 3 OR LEN(name$(1)) > 12 THEN PRINT : PRINT "Team names should be between 3 and 12   letters in it.": SLEEP 2: GOTO GetN:

gsn:
COLOR 14: PRINT : PRINT : PRINT :
INPUT "WHo's the HOME team?  ", name$(2)
name$(2) = LTRIM$(RTRIM$(name$(2)))
IF LEN(name$(2)) < 3 OR LEN(name$(2)) > 12 THEN PRINT : PRINT "Team names should be between 3 and 12   letters in it.": SLEEP 2: CLS : GOTO gsn:

COLOR 9: PRINT : PRINT : PRINT "OK, it's "; name$(1); " Vs. "; name$(2): SLEEP 2
inning = 1: turn = 1
FOR z = 1 TO 2: name$(z) = LTRIM$(RTRIM$(name$(z))): name$(z) = UCASE$(name$(z)): NEXT

tol:
CLS
COLOR 15: LOCATE 1, 1:
PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄRÄÄHÄÄEÄ¿"
PRINT "³                       ³"
PRINT "³                       ³"
PRINT "ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
PRINT "³                       ³"
PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"





IF turn = 1 THEN COLOR 14:
IF turn = 2 THEN COLOR 15:
LOCATE 2, (14 - LEN(name$(1))): PRINT name$(1); : PRINT USING "  ## ## ##"; runs(1); hits(1); errors(1)

IF turn = 2 THEN COLOR 14:
IF turn = 1 THEN COLOR 15:
LOCATE 3, (14 - LEN(name$(2))): PRINT name$(2); : PRINT USING "  ## ## ##"; runs(2); hits(2); errors(2)

COLOR 10:
SELECT CASE outs
 CASE IS = 0: LOCATE 5, 3: PRINT USING "# AND #     NO Outs"; balls; strikes
 CASE IS = 1: LOCATE 5, 3: PRINT USING "# AND #     1 Out"; balls; strikes
   CASE ELSE: LOCATE 5, 3: PRINT USING "# AND #     # Outs"; balls; strikes; outs
END SELECT

COLOR 9: LOCATE 1, 3
IF turn = 1 THEN PRINT "TOP"; inning
IF turn = 2 THEN PRINT "BOTTOM"; inning

COLOR 15, 12: FOR x = 22 TO 23: LOCATE x, 1: PRINT SPACE$(40): NEXT
COLOR 14, 12: LOCATE 21, 1: PRINT "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ": COLOR 15
LOCATE 22, 1: PRINT "B=Ball   E=Error   H=Hit   O=Out   R=Run"
              PRINT "S=Strike ESC=End of game / Quit": LOCATE 21, 15: PRINT "/COMMANDS\": COLOR , 8

gec:
k$ = LCASE$(INKEY$)
IF k$ = "b" THEN balls = balls + 1: GOTO Proc:
IF k$ = "e" THEN GOTO AddError:
IF k$ = "h" THEN hits(turn) = hits(turn) + 1: balls = 0: strikes = 0: GOTO tol:
IF k$ = "o" THEN outs = outs + 1: balls = 0: strikes = 0: GOTO Proc:
IF k$ = "r" THEN runs(turn) = runs(turn) + 1: balls = 0: strikes = 0: GOTO tol:
IF k$ = "s" THEN strikes = strikes + 1: GOTO Proc:
IF k$ = CHR$(27) THEN GOTO ConQ:
GOTO gec:

Proc:
IF balls = 4 THEN balls = 0: strikes = 0: COLOR 10: LOCATE 10, 1: PRINT "Batter, take your base!": SLEEP 2: GOTO tol:
IF strikes = 3 THEN outs = outs + 1: strikes = 0: balls = 0: COLOR 12: LOCATE 10, 1: PRINT "The batter STRIKES OUT!": SLEEP 2
IF outs >= 3 THEN outs = 0: strikes = 0: balls = 0: GOTO SwitchTurn:
GOTO tol:

ConQ:
COLOR 15, 9: LOCATE 10, 1: PRINT "Are you sure you want to"
                           PRINT "Quit?  (Press Y or N)   "
COLOR , 8
yo:                 
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN SLEEP 2: SYSTEM
IF k$ = "n" THEN GOTO tol:
IF k$ = CHR$(27) THEN SLEEP 2: SYSTEM
GOTO yo:


AddError:
IF turn = 1 THEN
    errors(2) = errors(2) + 1
ELSE
    errors(1) = errors(1) + 1
END IF
GOTO tol:

SwitchTurn:
IF turn = 1 THEN ot = 1: turn = 2: GOTO att:
IF turn = 2 THEN ot = 2: inning = inning + 1: turn = 1: GOTO att:

att:
COLOR 13: LOCATE 10, 1:

SELECT CASE ot
CASE IS = 1: z$ = RIGHT$(name$(1), 1)
IF z$ = "S" THEN PRINT "That's all for the "; name$(1): SLEEP 2: GOTO tol:
IF z$ <> "S" THEN PRINT "That's all for "; name$(1): SLEEP 2: GOTO tol:

CASE IS = 2: : z$ = RIGHT$(name$(2), 1)
IF z$ = "S" THEN PRINT "That's all for the "; name$(2): SLEEP 2: GOTO tol:
IF z$ <> "S" THEN PRINT "That's all for "; name$(2): SLEEP 2: GOTO tol:
END SELECT

ENG:
CLS
IF runs(1) > runs(2) THEN PRINT name$(1); " defeats "; name$(2); " by": PRINT "a score of"; runs(1); "to"; runs(2)
IF runs(2) > runs(1) THEN PRINT name$(2); " defeats "; name$(1); " by": PRINT "a score of"; runs(2); "to"; runs(1)

SUB CBS
balls = 0: strikes = 0
END SUB

