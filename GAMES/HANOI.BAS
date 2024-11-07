DECLARE SUB Win ()
DECLARE FUNCTION EmptyPeg% (Empt%)
DECLARE SUB DrawBoard ()
COLOR 15: CLS
' The variable Disk is a two dimensional array
'with values of Disk Width and Disk Column
DIM SHARED Disk(10, 1), NumDisks%
DIM SHARED MOVES, STARTtIME, ELAPSEDTIME, MINUTES, SECONDS

Y = 3
STARTtIME = TIMER

DO
   LOCATE 10, 1
   INPUT "How many disks do you want?  (Between 4 and 10):  ", NumDisks%
   IF NumDisks% < 4 OR NumDisks% > 10 THEN
      LOCATE 10, 1: PRINT STRING$(40, " ");
   END IF
LOOP UNTIL NumDisks% >= 4 AND NumDisks% <= 10
FOR X = 1 TO NumDisks%
   Y = Y + 1
   Disk(X, 0) = X + Y
   Disk(X, 1) = 1
NEXT X
DrawBoard

DO
   DO
      IF MOVES > 0 THEN LOCATE 23, 10: COLOR 9: PRINT "MOVES TAKEN: "; MOVES
      ELAPSEDTIME = TIMER - STARTtIME
      MINUTES = INT(ELAPSEDTIME / 60): IF MINUTES < 1 THEN MINUTES = 0
      SECONDS = ELAPSEDTIME MOD 60
       IF SECONDS > 5 THEN COLOR 11: LOCATE 23, 31: PRINT "Elapsed time: "; MINUTES; "minutes,"; : PRINT SECONDS; "seconds"
stf:
      LOCATE 20, 1: COLOR 14, 8: INPUT "Move Disk Of Which Column: ", movediskof%
      LOCATE 20, 1: PRINT STRING$(32, " ")
      IF movediskof% = 0 THEN
          COLOR 10, 9: LOCATE 20, 1: PRINT "QUIT GAME?  (Press Y or N):"
gkt:
          k$ = LCASE$(INPUT$(1))
          IF k$ = "y" THEN SYSTEM
          IF k$ = "n" THEN COLOR , 8: LOCATE 20, 1: PRINT SPACE$(80): GOTO stf:
          GOTO gkt:
END IF
     
      IF movediskof% < 1 OR movediskof% > 3 THEN GOTO stf:
      IF SGN(movediskof%) = -1 THEN SYSTEM
   LOOP UNTIL movediskof% < 4 AND movediskof% > 0
   DO
tfs:
      LOCATE 20, 1: INPUT "Move Disk To Which Column: ", movediskto%
      LOCATE 20, 1: PRINT STRING$(32, " ")
      IF movediskto% < 1 OR movediskto% > 3 THEN GOTO tfs:
      IF SGN(movediskof%) = -1 THEN SYSTEM
   LOOP UNTIL movediskto% < 4 AND movediskto% > 0
   FOR X = 1 TO NumDisks%
      IF Disk(X, 1) = movediskof% THEN J = X: EXIT FOR
   NEXT X
   FOR B = 1 TO NumDisks%
      IF Disk(B, 1) = movediskto% THEN
         IF Disk(J, 0) < Disk(B, 0) THEN
            Disk(J, 1) = movediskto%
            EXIT FOR
         ELSE
            LOCATE 20, 1: PRINT "Sorry That Move Is Unavailable.": SOUND 65, 9
            z$ = INPUT$(1)
            LOCATE 20, 1: PRINT STRING$(32, " ")
            G = 1
            EXIT FOR
         END IF
      ELSEIF EmptyPeg%(movediskto%) = 0 THEN
         Disk(J, 1) = movediskto%
         EXIT FOR
      END IF
   NEXT B
   Win
   IF G = 0 THEN DrawBoard: PLAY "o4l19c": SOUND 800, 1: MOVES = MOVES + 1:
   G = 0
LOOP

SUB DrawBoard
   CLS
   COLOR 15: LOCATE 1, 32: PRINT "Towers  Of  Hanoi"
   LOCATE 18, 1: PRINT STRING$(80, "Ü");
   FOR X = 7 TO 18
      LOCATE X, 15: PRINT "Û"
      LOCATE X, 40: PRINT "Û"
      LOCATE X, 65: PRINT "Û"
   NEXT X
   REDIM Rows(3)
   FOR X = NumDisks% TO 1 STEP -1
      IF Disk(X, 1) = 1 THEN
         Rows(1) = Rows(1) + 1
         COLOR Disk(X, 0) \ 2
         LOCATE 18 - Rows(1), 15 - Disk(X, 0) \ 2
         PRINT STRING$(Disk(X, 0), "Ü");
         LOCATE 18 - Rows(1), 15: PRINT LTRIM$(RTRIM$(STR$(X)))
      ELSEIF Disk(X, 1) = 2 THEN
         Rows(2) = Rows(2) + 1
         COLOR Disk(X, 0) \ 2
         LOCATE 18 - Rows(2), 40 - Disk(X, 0) \ 2
         PRINT STRING$(Disk(X, 0), "Ü");
         LOCATE 18 - Rows(2), 40: PRINT LTRIM$(RTRIM$(STR$(X)))
      ELSEIF Disk(X, 1) = 3 THEN
         Rows(3) = Rows(3) + 1
         COLOR Disk(X, 0) \ 2
         LOCATE 18 - Rows(3), 65 - Disk(X, 0) \ 2
         PRINT STRING$(Disk(X, 0), "Ü");
         LOCATE 18 - Rows(3), 65: PRINT LTRIM$(RTRIM$(STR$(X)))
      END IF
   NEXT X
   COLOR 7
END SUB

FUNCTION EmptyPeg% (Empt%)
   EmptyPeg% = 0
   FOR X = 1 TO 10
      IF Disk(X, 1) = Empt% THEN EmptyPeg% = 1: EXIT FOR ELSE EmptyPeg% = 0
   NEXT X
END FUNCTION

SUB Win
   FOR X = 1 TO NumDisks%
      IF Disk(X, 1) = 2 THEN V = 1 ELSE V = 0: EXIT FOR
   NEXT X
   FOR X = 1 TO NumDisks%
      IF Disk(X, 1) = 3 THEN W = 1 ELSE W = 0: EXIT FOR
   NEXT X
   IF V = 1 OR W = 1 THEN
      CLS
      LOCATE 12, 36: PRINT "You Win!"
      LOCATE 13, 34: PRINT "With"; NumDisks%; "Disks"
         ELAPSEDTIME = TIMER - STARTtIME
         MINUTES = INT(ELAPSEDTIME / 60): IF MINUTES < 1 THEN MINUTES = 0
         SECONDS = ELAPSEDTIME MOD 60
         COLOR 11: LOCATE 16, 12: PRINT "Elapsed time: "; MINUTES; "minutes,"; : PRINT SECONDS; "seconds"
         COLOR 12: LOCATE 18, 12: PRINT "You used"; MOVES; "moves to win."
         COLOR 14: LOCATE 20, 12: PRINT "Press a key to exit"
         SLEEP
         END
   END IF
   V = 0
   W = 0
END SUB

