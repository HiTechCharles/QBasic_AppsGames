DECLARE SUB limitinput (AllowedChars!)
DECLARE SUB center (row, text$)
DIM SHARED answer$(10), revealed(10)
COMMON SHARED question$, NumAnswers, AnswersLeft, contents$

FFbegin:
SCREEN 0: WIDTH 40, 25: CLS
COLOR 9: center 2, "The Family Feud Anser Board"
COLOR 14: center 3, "Program by Charles Martin"

COLOR 11: LOCATE 12, 1: PRINT "How many answers?  (1 to 10): ";
limitinput 2
NumAnswers = VAL(contents$): PRINT
IF NumAnswers < 1 OR NumAnswers > 10 THEN PRINT : PRINT "Between 1 and 10, please.": SLEEP 3: GOTO FFbegin:

VIEW PRINT 6 TO 23: CLS : LOCATE 6, 1
FOR B = 1 TO NumAnswers
toil:
    am$ = STR$(B): am$ = LTRIM$(am$): COLOR 13
    PRINT : PRINT "#"; am$; " answer:  "; : COLOR 15: INPUT "", answer$(B)
    IF LEN(answer$(B)) < 2 OR LEN(answer$(B)) > 18 THEN PRINT : PRINT : PRINT "Between 2 and 18 letters, please.": SLEEP 3: CLS : GOTO toil:
NEXT B

FOR B = 1 TO NumAnswers
    revealed(B) = -1
    answer$(B) = LTRIM$(RTRIM$(answer$(B))): answer$(B) = UCASE$(answer$(B))
NEXT B

TheBoard:
FOR B = NumAnswers + 1 TO 10
    revealed(B) = 1
NEXT B


VIEW PRINT: COLOR 13, 8: CLS : LOCATE 6, 3:
IF NumAnswers = 1 THEN PRINT "The top answer is on the board." ELSE PRINT "The top"; NumAnswers; "answers are on the board."
COLOR 9, 8:  LOCATE 8, 1: COLOR 14, 12
PRINT "ีออออออออออออออออออัออออออออออออออออออธ"
PRINT "ณ                  ณ                  ณ"
PRINT "รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด"
PRINT "ณ                  ณ                  ณ"
PRINT "รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด"
PRINT "ณ                  ณ                  ณ"
PRINT "รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด"
PRINT "ณ                  ณ                  ณ"
PRINT "รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด"
PRINT "ณ                  ณ                  ณ"
PRINT "ิออออออออออออออออออฯออออออออออออออออออพ"

AnswersLeft = NumAnswers
FOR I = 1 TO 10
    N$ = LTRIM$(RTRIM$(STR$(I)))
    READ r: READ c
    SELECT CASE revealed(I)
        CASE IS = -1: LOCATE r, c: COLOR 11, 9: PRINT "-"; N$; "-"
        CASE ELSE: LOCATE r, c - 8: COLOR 15, 12: PRINT "X X X X X X X X X"
    END SELECT
NEXT I

gtn:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN bTR = 1: GOTO CHK:
IF k$ = "2" THEN bTR = 2: GOTO CHK:
IF k$ = "3" THEN bTR = 3: GOTO CHK:
IF k$ = "4" THEN bTR = 4: GOTO CHK:
IF k$ = "5" THEN bTR = 5: GOTO CHK:
IF k$ = "6" THEN bTR = 6: GOTO CHK:
IF k$ = "7" THEN bTR = 7: GOTO CHK:
IF k$ = "8" THEN bTR = 8: GOTO CHK:
IF k$ = "9" THEN bTR = 9: GOTO CHK:
IF k$ = "10" THEN bTR = 10: GOTO CHK:
GOTO gtn:

CHK:
IF revealed(bTR) <> -1 THEN GOTO gtn:
s = 18 - LEN(answer$(bTR)): AnswersLeft = AnswersLeft - 1: COLOR 15, 8
SELECT CASE bTR:
CASE IS = 1:  LOCATE 9, 2: PRINT answer$(1); SPACE$(s): GOTO ADY:
CASE IS = 2: LOCATE 11, 2: PRINT answer$(2); SPACE$(s): GOTO ADY:
CASE IS = 3: LOCATE 13, 2: PRINT answer$(3); SPACE$(s): GOTO ADY:
CASE IS = 4: LOCATE 15, 2: PRINT answer$(4); SPACE$(s): GOTO ADY:
CASE IS = 5: LOCATE 17, 2: PRINT answer$(5); SPACE$(s): GOTO ADY:
CASE IS = 6: LOCATE 9, 21: PRINT answer$(6); SPACE$(s): GOTO ADY:
CASE IS = 7: LOCATE 11, 21: PRINT answer$(7); SPACE$(s): GOTO ADY:
CASE IS = 8: LOCATE 13, 21: PRINT answer$(8); SPACE$(s): GOTO ADY:
CASE IS = 9: LOCATE 15, 21: PRINT answer$(9); SPACE$(s): GOTO ADY:
CASE IS = 10: LOCATE 17, 21: PRINT answer$(10); SPACE$(s): GOTO ADY:
END SELECT

ADY:
revealed(bTR) = 1
SELECT CASE AnswersLeft
CASE IS = 0: SYSTEM
CASE ELSE: GOTO gtn:
END SELECT

DATA 9, 10, 11, 10, 13, 10, 15, 10, 17, 10
DATA 9, 29, 11, 29, 13, 29, 15, 29, 17, 29, 0

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB limitinput (AllowedChars)
tc = 0: contents$ = "": CHAR$ = ""
DO UNTIL INKEY$ = "": LOOP
DO
TOS:
     DO
     LOCATE CSRLIN, POS(0), 1: CHAR$ = INKEY$
     LOOP WHILE CHAR$ = ""
     SELECT CASE ASC(CHAR$)
         CASE IS = 8
            IF contents$ <> "" THEN PRINT CHR$(29); " "; CHR$(29); : tc = tc - 1
            IF contents$ <> "" THEN contents$ = LEFT$(contents$, LEN(contents$) - 1)
         CASE IS = 13: EXIT SUB
         CASE ELSE:
         SELECT CASE tc
              CASE IS < AllowedChars: PRINT CHAR$; : tc = tc + 1: contents$ = contents$ + CHAR$
              CASE ELSE: GOTO TOS:
         END SELECT
     END SELECT
LOOP

END SUB

