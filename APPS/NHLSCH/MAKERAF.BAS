'  This program takes the raw text and turns into
'  random-access file
'  CSV file for spreadsheet programs
'  Remakes the original text file


DECLARE SUB CSVfile ()
DECLARE FUNCTION Quote$ (tq$)
DECLARE SUB RedoTextFile ()
DECLARE SUB ScheduleTest ()
DECLARE FUNCTION stp$ (pr$, f, l)
DECLARE FUNCTION trim$ (ttt$)
DECLARE SUB TXT2SCH ()

COMMON SHARED team$
TYPE gameline
    date AS STRING * 6     'XXX YY    X=month abbreviation, Y=day #
     day AS STRING * 3     'Thu Fri Sat Sun Mon Tue Wed
     hoa AS STRING * 1     'H=Home, A=Away
OPPONENT AS STRING * 12    'Flames, Stars, Oilers
    TIME AS STRING * 5     '7:30, 10:00     All games are PM,, not needed
 NETWORK AS STRING * 11    'TV network  TSN,OLN,NBC
END TYPE

DIM SHARED game AS gameline

TXT2SCH
ScheduleTest
CSVfile
RedoTextFile

SUB CSVfile
    P$ = "CSV\" + team$ + ".csv"
    SHELL "if exist " + P$ + " del " + P$
    OPEN P$ FOR APPEND AS #3
    
    mon$ = "O"
    FOR i = 1 TO 82
        GET #2, i, game
        IF LEFT$(game.date, 1) <> mon$ THEN
            mon$ = LEFT$(game.date, 1): PRINT #3, ""
        END IF

        PRINT #3, Quote$(trim$(game.day + " " + game.date)) + ",";
        IF game.hoa = "H" THEN PRINT #3, "HOME,";  ELSE PRINT #3, "AWAY,";
        PRINT #3, trim$(game.OPPONENT) + "," + Quote$(trim$(game.TIME)) + "," + Quote$(trim$(game.NETWORK))
    NEXT i
    CLOSE #3
END SUB

FUNCTION Quote$ (tq$)
    Quote$ = CHR$(34) + tq$ + CHR$(34)
END FUNCTION

SUB RedoTextFile
    mon$ = "O"
    NAME "txt\" + team$ + ".txt" AS "txt\" + team$ + ".bak"
    OPEN "txt\" + team$ + ".txt" FOR APPEND AS #5

    FOR i = 1 TO 82
        GET #2, i, game
        IF LEFT$(game.date, 1) <> mon$ THEN
            mon$ = LEFT$(game.date, 1)
            PRINT #5, ""
        END IF

        PRINT #5, trim$(game.day + " " + game.date);
        PRINT #5, TAB(14);
                  IF game.hoa = "H" THEN PRINT #5, "HOME";  ELSE PRINT #5, "AWAY";
        PRINT #5, TAB(21); trim$(game.OPPONENT);
        PRINT #5, TAB(36); game.TIME;
        PRINT #5, TAB(44); trim$(game.NETWORK)
    NEXT i
    CLOSE #5     '1,6  14  21,32  36,40  44,0
END SUB

SUB ScheduleTest

    COLOR 13: CLS
    PRINT "DATE          H/A     OPPONENT        TIME     NETWORK": COLOR 10
    PRINT "----          ---     --------        ----     -------": COLOR 15

    FOR i = 1 TO 82
        GET #2, i, game
        PRINT game.day + " " + game.date + "    ";
        IF game.hoa = "H" THEN PRINT "HOME";  ELSE PRINT "AWAY";
        PRINT "    " + game.OPPONENT + "    " + game.TIME + "    " + game.NETWORK
    NEXT i
END SUB

FUNCTION stp$ (pr$, f, l)
    IF f < 1 THEN f = 1
    IF l > LEN(pr$) OR l = 0 THEN l = LEN(pr$)
    IF f > l THEN SWAP f, l
    stp$ = MID$(pr$, f, (l - f) + 1)
END FUNCTION

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

SUB TXT2SCH
GetTeamCode:
    WIDTH 80, 25: COLOR 15: CLS
    INPUT "Which team?  (3 letters):   >", team$
    team$ = UCASE$(trim$(team$))
    IF LEN(team$) < 2 OR LEN(team$) > 3 THEN GOTO GetTeamCode:

    OPEN "TXT\" + team$ + ".txt" FOR INPUT AS #1
    OPEN "RAF\" + team$ + ".sch" FOR RANDOM AS #2 LEN = 38

    DO UNTIL EOF(1)
        LINE INPUT #1, l$: l$ = trim$(l$)
            IF trim$(l$) = "" THEN GOTO eol:  ELSE gr = gr + 1
            game.date = stp$(l$, 1, 6)
             game.day = stp$(l$, 9, 11)
             game.hoa = stp$(l$, 13, 16)
        game.OPPONENT = stp$(l$, 21, 32)
            game.TIME = stp$(l$, 35, 39)
        game.NETWORK = stp$(l$, 41, 0)
        IF (LEN(trim$(game.TIME))) = 4 THEN game.TIME = " " + game.TIME
        PUT #2, gr, game
eol:
    LOOP
    CLOSE 1
END SUB

