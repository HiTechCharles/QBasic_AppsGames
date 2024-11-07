DECLARE SUB AddGame ()
DECLARE SUB CalcStats ()
DECLARE SUB center (row!, text$)
DECLARE SUB centerfile (fi, text$)
DECLARE SUB Cleararea (tl, bl)
DECLARE SUB clearboard ()
DECLARE FUNCTION datefix$ (doe$)
DECLARE SUB display ()
DECLARE SUB EditGame (GTE!)
DECLARE FUNCTION GetKey$ (allowed$)
DECLARE FUNCTION i2a$ (h)
DECLARE FUNCTION inputfield$ (nos)
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
DECLARE SUB LoadHitData ()
DECLARE SUB Menu ()
DECLARE SUB MHS ()
DECLARE FUNCTION NoGamesCheck ()
DECLARE FUNCTION Quote$ (stq$)
DECLARE SUB ReCreate ()
DECLARE SUB REduce (n!, D!)
DECLARE FUNCTION replace$ (text$, LookFor$, ReplaceWith$)
DECLARE FUNCTION row2ltr$ (r)
DECLARE SUB SavePrint ()
DECLARE SUB ShowStats ()
DECLARE SUB sqrpaint (l$, n, S, sh$)
DECLARE SUB StartReport ()
DECLARE FUNCTION trim$ (ttt$)
DECLARE SUB Waitkey ()

TYPE GameRec
     opp AS STRING * 30
 winloss AS INTEGER
  scoref AS INTEGER
  scorea AS INTEGER
  misses AS INTEGER
playdate AS STRING * 10
END TYPE   '48

COMMON SHARED wins, losses, avgmiss, winperc, AvgScore, avgopp, NumGames, edit
COMMON SHARED head$, head2$, fmt$, rpt$, na, da, totalshots, totalhits, nodata

DIM SHARED game AS GameRec, wd$(3), hitcount(10, 10), NOH(100), gridloc$(100)
CONST true = 1: false = -1

'###   Opponent          Result   Score   Misses   Date
'XXX   XXXXXXXXXXXXXXX   XXXX     XX-XX   XX/XX    XX-XX-XXXX

ON ERROR GOTO ErrorHandler:
    'ReCreate
    OPEN "BatStats.dat" FOR RANDOM AS #1 LEN = 48
    CalcStats
    LoadHitData
    Menu


ErrorHandler:
    SELECT CASE ERR
        CASE IS = 53:
            nodata = true: RESUME NEXT
        CASE ELSE:
            PRINT "Error #"; ERR; "occured.": SYSTEM
        END SELECT

SUB AddGame
    GTS = NumGames + 1

abegin:
    COLOR 13, 8: CLS : center 2, "Add a new game"
    LOCATE 6, 1:  COLOR 15, 8
    PRINT "                Game #:  "; USING "###"; GTS
    PRINT "Opponent's name/handle:  "; inputfield$(30);
    opp$ = trim$(Limitinput$(30, "", CSRLIN, POS(0), ""))
    IF opp$ = CHR$(27) THEN COLOR , 8: EXIT SUB
    IF LEN(opp$) < 3 THEN GOTO abegin:
    game.opp = opp$
    Cleararea 7, 23: COLOR 15, 8: LOCATE 7, 1: PRINT "Opponent's name/handle:  "; game.opp

    COLOR 15, 8: LOCATE 10, 1: PRINT "Did you WIN or LOSE the gaem?  (Press W or L)"
    w$ = GetKey$("WL")
    IF w$ = CHR$(27) THEN EXIT SUB
    IF w$ = "W" THEN game.winloss = 1 ELSE game.winloss = -1

    Cleararea 9, 11
    LOCATE 8, 1: PRINT "    Winner of the game:  ";
    IF w$ = "W" THEN PRINT "You" ELSE PRINT "Your opponent"

    SELECT CASE w$
        CASE IS = "W"  'player wins
            game.scoref = 17
            LOCATE 9, 1: PRINT "            Your score:   17"
OppScore:
            COLOR 15, 8: LOCATE 12, 1: PRINT "(0-16, total # of hits on ALL OF YOUR SHIPS)"
            LOCATE 11, 1: PRINT "      Opponent's score:  "; inputfield$(2);
            ni$ = Limitinput$(2, "0123456789", CSRLIN, POS(0), "")
            IF ni$ = CHR$(27) THEN EXIT SUB
            game.scorea = VAL(ni$)
            IF game.scorea < 0 OR game.scorea > 16 THEN Cleararea 11, 12: GOTO OppScore:
            COLOR 15: Cleararea 11, 12: LOCATE 10, 1: PRINT "      Opponent's score:  "; USING "###"; game.scorea
        CASE IS = "L"
            game.scorea = 17
            COLOR 15: LOCATE 9, 1: PRINT "      Opponent's score:   17"
yourscore:
            COLOR 15: LOCATE 12, 1: PRINT "(0-16, TOTAL # OF HITS you've made on the OPPONENT'S ships.)"
            LOCATE 11, 1: PRINT "            Your score:  "; inputfield$(2);
            ni$ = Limitinput$(2, "0123456789", CSRLIN, POS(0), "")
            IF ni$ = CHR$(27) THEN EXIT SUB
            game.scoref = VAL(ni$)
            IF game.scoref < 0 OR game.scoref > 16 THEN Cleararea 11, 12: GOTO yourscore:
            COLOR 15: Cleararea 11, 12: LOCATE 10, 1: PRINT "            Your score:  "; USING "###"; game.scoref
        END SELECT

getmiss:
    COLOR 15, 8: LOCATE 13, 1: PRINT "(If you don't know, use 0, or your best guess.)"
    LOCATE 12, 1: PRINT "     # of missed shots:  "; inputfield$(2);
    ni$ = Limitinput$(2, "0123456789", CSRLIN, POS(0), "")
   IF ni$ = CHR$(27) THEN EXIT SUB
   game.misses = VAL(ni$)
    IF game.misses = 0 THEN RANDOMIZE TIMER: game.misses = INT(RND * 40) + 20
    IF game.misses < 5 OR game.misses > 99 THEN Cleararea 12, 13: GOTO getmiss:
    Cleararea 11, 13: LOCATE 11, 1: COLOR 15: PRINT "     # of missed shots:  "; USING "###"; game.misses

GetDate:
    COLOR 15, 8: LOCATE 14, 1: PRINT "(EXAMPLE:  7-15-2005   3/11/82   12-14-05)"
    LOCATE 13, 1: PRINT "      Date of the game:  "; inputfield$(10);
    pl$ = trim$(Limitinput$(10, "0123456789/-", CSRLIN, POS(0), DATE$))
    IF pl$ = CHR$(27) THEN EXIT SUB
    IF pl$ = "" THEN pl$ = DATE$
    pl$ = datefix$(pl$)
    game.playdate = pl$
    Cleararea 12, 15: LOCATE 12, 1: PRINT "      Date of the game:  "; pl$

    PUT #1, GTS, game
    ShowStats
END SUB

SUB CalcStats
    wins = 0: losses = 0: avgmiss = 0: winperc = 0: AvgScore = 0: avgopp = 0: NumGames = LOF(1) / 48: totalshots = 0: totalhits = 0
    'wins     losses  avg misses,      winning %,   avg score,    avg opp. score, # of games played,  total shots,    total hits for all games

IF NumGames = 0 THEN EXIT SUB
    FOR I = 1 TO NumGames
        GET #1, I, game
        IF game.winloss = 1 THEN wins = wins + 1 ELSE losses = losses + 1
        AvgScore = AvgScore + game.scoref
        avgopp = avgopp + game.scorea
        avgmiss = avgmiss + game.misses
        totalshots = totalshots + (game.misses + game.scoref)
        totalhits = totalhits + game.scoref
    NEXT I
    avgmiss = avgmiss / NumGames
    AvgScore = AvgScore / NumGames
    avgopp = avgopp / NumGames
    winperc = (wins / NumGames) * 100
END SUB

SUB center (row, text$)
    col = 41 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB centerfile (fi, text$)
   ns = 41 - LEN(text$) / 2
   PRINT #fi, TAB(ns); text$
END SUB

SUB Cleararea (tl, bl)
    FOR I = tl TO bl
        LOCATE I, 1: COLOR , 8: PRINT SPACE$(80)
    NEXT I
END SUB

SUB clearboard
    DO UNTIL INKEY$ = "": LOOP
END SUB

FUNCTION datefix$ (doe$)
    IF LEN(doe$) < 6 THEN datefix$ = "ERROR - valid date not passed to function"
    doe$ = replace$(doe$, "/", "-")

    WordSep$ = "-"   'this is what separates each word/part
    LOS = LEN(doe$): wd = 1

    FOR LTR = 1 TO LOS
        CH$ = MID$(doe$, LTR, 1)
        SELECT CASE CH$
            CASE IS = WordSep$: wd$(wd) = WSF$: wd = wd + 1: WSF$ = ""
            CASE ELSE:  WSF$ = WSF$ + CH$
        END SELECT
    NEXT LTR

    wd$(wd) = WSF$

    IF LEN(wd$(1)) = 1 THEN wd$(1) = "0" + wd$(1)
    IF LEN(wd$(2)) = 1 THEN wd$(2) = "0" + wd$(2)
    CY$ = MID$(DATE$, 7, 2)
    IF LEN(wd$(3)) = 1 THEN datefix$ = "INVALID YEAR - MUST BE 2 OR 4 DIGITS!"
    IF LEN(wd$(3)) = 2 THEN wd$(3) = CY$ + wd$(3)
    datefix$ = wd$(1) + "-" + wd$(2) + "-" + wd$(3)
END FUNCTION

SUB display

IF NoGamesCheck = -1 THEN GOTO cancel:

DBEgin:
    COLOR 9: CLS : center 2, "Display, and search"
    COLOR 11: LOCATE 6, 1
     head$ = "  #   Opponent                         Result   Score   Misses   Date"
    head2$ = "ÍÍÍ   ÍÍÍÍÍÍÍÍ                         ÍÍÍÍÍÍ   ÍÍÍÍÍ   ÍÍÍÍÍÍ   ÍÍÍÍ"
      fmt$ = "###   \                            \   \   \    ##-##   ##/##    \        \"

    PRINT "       A. All records"
    PRINT
    PRINT "       D. Games played on a specific date"
    PRINT
    PRINT "       P. Games Vs. a certain player"
    PRINT
    IF wins <> 0 THEN PRINT "       W. Games you've won":  PRINT
    IF losses <> 0 THEN PRINT "       L. Games you've lost":  PRINT
    PRINT "       X. Return to main menu"

    COLOR 14: PRINT : PRINT : center CSRLIN, "Press the letter next to"
    center CSRLIN, "the desired search criteria:"
    k$ = GetKey$("adpwlx")
        IF k$ = "W" AND wins = 0 THEN center 21, "You have not won any games!": SLEEP 3: GOTO DBEgin:
        IF k$ = "L" AND losses = 0 THEN center 21, "You have not lost any games!": SLEEP 3: GOTO DBEgin:
        IF k$ = CHR$(27) OR k$ = "X" THEN GOTO cancel:

    COLOR 13: CLS : PRINT head$
    COLOR 14: PRINT head2$:  LN = 3: nummatch = 0: COLOR 15

    SELECT CASE k$
        CASE IS = "A": rpt$ = "All records": StartReport
            FOR I = 1 TO NumGames
                GET #1, I, game
                IF game.winloss = 1 THEN WL$ = "Win" ELSE WL$ = "Loss"
                LOCATE LN, 1: PRINT USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                PRINT #2, USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                LN = LN + 1
                IF LN = 23 THEN
                    COLOR 10: center 23, "ÄÄÄ Press any key for more ÄÄÄ": SLEEP: clearboard
                    LN = 3: Cleararea 3, 23: COLOR 15
                END IF
            NEXT I
            GOTO Action:
        CASE IS = "D"
            COLOR 10: LOCATE 5, 1: PRINT "Type in the date you want to find in the records:"
            PRINT "EXAMPLE:  7-15-2005      3/11/82     12-14-05"
            PRINT ">"; : COLOR 13: pl$ = UCASE$(Limitinput$(10, "0123456789/-", 7, 2, DATE$))
            pl$ = datefix$(pl$): COLOR 15
            Cleararea 3, 23: wf = 0: wa = 0
            rpt$ = "Games played on " + pl$: StartReport
            FOR I = 1 TO NumGames
                GET #1, I, game
                IF game.winloss = 1 THEN WL$ = "Win" ELSE WL$ = "Loss"
                IF INSTR(UCASE$(game.playdate), pl$) > 0 THEN
                    IF game.winloss = 1 THEN wf = wf + 1 ELSE wa = wa + 1
                    LOCATE LN, 1: PRINT USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                    PRINT #2, USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                    LN = LN + 1: nummatch = nummatch + 1
                END IF
                IF LN = 22 THEN
                    COLOR 10: center 23, "ÄÄÄ Press any key for more ÄÄÄ": SLEEP
                    LN = 3: Cleararea 3, 23
                END IF
            NEXT I
            IF nummatch = 0 THEN GOTO NoDateMatch:
            PRINT #2, ""
            centerfile 2, "You are " + i2a$(wf) + " and " + i2a$(wa) + " on this date."
            LOCATE 23, 1: COLOR 10: PRINT "You are"; wf; "and"; wa; "on this date.": Waitkey
            GOTO Action:
        CASE IS = "P"
                COLOR 10:  LOCATE 5, 1: PRINT "Type in the name of the player you want to search for:"
                PRINT ">"; : COLOR 13: pl$ = UCASE$(Limitinput$(15, "", 6, 2, ""))
                Cleararea 3, 23: wf = 0: wa = 0
                rpt$ = "Games played Vs. " + Quote$(pl$): StartReport: COLOR 15
            FOR I = 1 TO NumGames
                GET #1, I, game
                IF game.winloss = 1 THEN WL$ = "Win" ELSE WL$ = "Loss"
                IF INSTR(UCASE$(game.opp), pl$) > 0 THEN
                    IF game.winloss = 1 THEN wf = wf + 1 ELSE wa = wa + 1
                    LOCATE LN, 1: PRINT USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                    PRINT #2, USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                    LN = LN + 1: nummatch = nummatch + 1
                END IF
                IF LN = 22 THEN
                    COLOR 10: center 23, "ÄÄÄ Press any key for more ÄÄÄ": SLEEP
                    LN = 3: Cleararea 3, 23
                END IF
            NEXT I
            IF nummatch = 0 THEN GOTO nonamematch:
            PRINT #2, ""
            centerfile 2, "You are " + i2a$(wf) + " and " + i2a$(wa) + " against this player."
            LOCATE 23, 1: COLOR 10: PRINT "You are"; wf; "and"; wa; "against this player."
            GOTO Action:
         CASE IS = "W": rpt$ = "Games you've won": StartReport
            FOR I = 1 TO NumGames
                GET #1, I, game
                IF game.winloss = 1 THEN WL$ = "Win" ELSE WL$ = "Loss"
                IF game.winloss = 1 THEN
                LOCATE LN, 1: PRINT USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                PRINT #2, USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                LN = LN + 1: nummatch = nummatch + 1
                END IF
                IF LN = 22 THEN
                    COLOR 10: center 23, "ÄÄÄ Press any key for more ÄÄÄ": SLEEP
                    LN = 3: Cleararea 3, 23
                END IF
            NEXT I
            GOTO Action:
        CASE IS = "L": rpt$ = "Games you've lost": StartReport
            FOR I = 1 TO NumGames
                GET #1, I, game
                IF game.winloss = 1 THEN WL$ = "Win" ELSE WL$ = "Loss"
                IF game.winloss = -1 THEN
                LOCATE LN, 1: PRINT USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                PRINT #2, USING fmt$; I; game.opp; WL$; game.scoref; game.scorea; game.misses; (game.misses + game.scoref); game.playdate$
                LN = LN + 1: nummatch = nummatch + 1
                END IF
                IF LN = 22 THEN
                    COLOR 10: center 23, "ÄÄÄ Press any key for more ÄÄÄ": SLEEP
                    LN = 3: Cleararea 3, 23
                END IF
            NEXT I
            GOTO Action:
        CASE IS = "X": rpt$ = "": GOTO cancel:
    END SELECT

Action:
    COLOR 14, 8: LOCATE 23, 1: PRINT "Press E to edit a geme's details, S to save results to file, or X to exit:"
    ans$ = GetKey("qESX ")
    SELECT CASE ans$
        CASE IS = "E"
GEN:        Cleararea 23, 23
            COLOR 13: LOCATE 23, 1: PRINT "Edit which game?  (0 or ESC to cancel)   #"; inputfield$(3)
            edit$ = Limitinput$(3, "0123456789", 23, 43, "")
            edit = VAL(edit$)
            IF edit$ = CHR$(27) THEN GOTO cancel:
            IF edit = 0 THEN GOTO cancel:
            IF edit > NumGames THEN SOUND 700, 1: GOTO GEN:
            EditGame (edit): GOTO cancel:
        CASE IS = "S": SavePrint: GOTO cancel:
        CASE CHR$(27), "X", "Q", " ":   GOTO cancel:
    END SELECT





nonamematch:
    CLS : COLOR 13: center 7, "The player name " + Quote$(pl$) + " does not"
    center 8, "match any names in the records."
    center 11, "Try fewer letter in your search.  For example,"
    center 12, Quote$("Charlie Martin") + " would become " + Quote$("Charlie.")
    CLOSE #2: KILL "rt.txt"
    CALL Waitkey: GOTO cancel:
NoDateMatch:
    CLS : COLOR 13: center 7, "No games were played on " + pl$
    center 9, "Try a new date, or use the " + Quote$("ALL") + " option"
    center 10, "from the display & Search menu."
    CLOSE #2: KILL "rt.txt"
    CALL Waitkey: GOTO cancel:
cancel:
    CLOSE #2
END SUB

SUB EditGame (GTE)
Ebegin:
    GET #1, GTE, game
    COLOR 13, 8: CLS : center 2, "Edit a game's details"
    LOCATE 6, 1:  COLOR 15, 8
    PRINT "                Game #:  "; USING "###"; GTE
    PRINT "Opponent's name/handle:  "; inputfield$(30);
    opp$ = trim$(Limitinput$(30, "", CSRLIN, POS(0), trim$(game.opp)))
    IF opp$ = CHR$(27) THEN COLOR , 8: EXIT SUB
    IF LEN(opp$) < 3 THEN GOTO Ebegin:
    game.opp = opp$
    Cleararea 7, 23: COLOR 15, 8: LOCATE 7, 1: PRINT "Opponent's name/handle:  "; game.opp

    COLOR 15, 8: LOCATE 10, 1: PRINT "Did you WIN or LOSE the gaem?  (Press W or L)"
    w$ = GetKey$("WL")
    IF w$ = CHR$(27) THEN EXIT SUB
    IF w$ = "W" THEN game.winloss = 1 ELSE game.winloss = -1

    Cleararea 9, 11
    LOCATE 8, 1: PRINT "    Winner of the game:  ";
    IF w$ = "W" THEN PRINT "You" ELSE PRINT "Your opponent"

    SELECT CASE w$
        CASE IS = "W"  'player wins
            game.scoref = 17
            LOCATE 9, 1: PRINT "            Your score:   17"
EdOppScore:
            COLOR 15, 8: LOCATE 12, 1: PRINT "(0-16, total # of hits on ALL OF YOUR SHIPS)"
            LOCATE 11, 1: PRINT "      Opponent's score:  "; inputfield$(2);
            ps = game.scorea
            IF ps <> 17 THEN ps$ = i2a$(ps) ELSE ps$ = ""
            ni$ = Limitinput$(2, "0123456789", CSRLIN, POS(0), ps$)
            IF ni$ = CHR$(27) THEN EXIT SUB
            game.scorea = VAL(ni$)
            IF game.scorea < 0 OR game.scorea > 16 THEN Cleararea 11, 12: GOTO EdOppScore:
            COLOR 15: Cleararea 11, 12: LOCATE 10, 1: PRINT "      Opponent's score:  "; USING "###"; game.scorea
        CASE IS = "L"
            game.scorea = 17
            COLOR 15: LOCATE 9, 1: PRINT "      Opponent's score:   17"
Edyourscore:
            COLOR 15: LOCATE 12, 1: PRINT "(0-16, TOTAL # OF HITS you've made on the OPPONENT'S ships.)"
            LOCATE 11, 1: PRINT "            Your score:  "; inputfield$(2);
            ps = game.scoref
            IF ps <> 17 THEN ps$ = i2a$(ps) ELSE ps$ = ""
            ni$ = Limitinput$(2, "0123456789", CSRLIN, POS(0), ps$)
            IF ni$ = CHR$(27) THEN EXIT SUB
            game.scoref = VAL(ni$)
            IF game.scoref < 0 OR game.scoref > 16 THEN Cleararea 11, 12: GOTO Edyourscore:
            COLOR 15: Cleararea 11, 12: LOCATE 10, 1: PRINT "            Your score:  "; USING "###"; game.scoref
        END SELECT

Edgetmiss:
    COLOR 15, 8: LOCATE 13, 1: PRINT "(If you don't know, use 0, or your best guess.)"
    LOCATE 12, 1: PRINT "     # of missed shots:  "; inputfield$(2);
    ni$ = Limitinput$(2, "0123456789", CSRLIN, POS(0), "")
    IF ni$ = CHR$(27) THEN EXIT SUB
    ni = VAL(ni$)
    IF ni = 0 THEN RANDOMIZE TIMER: game.misses = INT(RND * 40) + 20: GOTO edgetdate:
    IF ni < 5 OR ni > 99 THEN Cleararea 12, 13: GOTO Edgetmiss:
    game.misses = VAL(ni$)
    Cleararea 11, 13: LOCATE 11, 1: COLOR 15: PRINT "     # of missed shots:  "; USING "###"; game.misses

edgetdate:
    COLOR 15, 8: LOCATE 14, 1: PRINT "(EXAMPLE:  7-15-2005   3/11/82   12-14-05)"
    LOCATE 13, 1: PRINT "      Date of the game:  "; inputfield$(10);
    pl$ = trim$(Limitinput$(10, "0123456789/-", CSRLIN, POS(0), trim$(game.playdate)))
    IF pl$ = CHR$(27) THEN EXIT SUB
    IF pl$ = "" THEN pl$ = DATE$
    pl$ = datefix$(pl$)
    game.playdate = pl$
    Cleararea 12, 15: LOCATE 12, 1: PRINT "      Date of the game:  "; pl$

    PUT #1, GTE, game
END SUB

FUNCTION GetKey$ (allowed$)
    allowesc = 1: allowed$ = UCASE$(allowed$)
GTT:
    KY$ = UCASE$(INKEY$)
        IF KY$ <> "" AND INSTR(allowed$, KY$) > 0 THEN GetKey$ = KY$: EXIT FUNCTION
        IF allowesc <> 0 AND KY$ = CHR$(27) THEN GetKey$ = CHR$(27): EXIT FUNCTION  'Allow ESCape
    GOTO GTT:
END FUNCTION

FUNCTION i2a$ (h)
    i2a$ = trim$(STR$(h))
END FUNCTION

FUNCTION inputfield$ (nos)
    col = POS(0): COLOR 14, 9: PRINT SPACE$(nos); : LOCATE CSRLIN, col, 1
END FUNCTION

FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)

allowesc = 1   'allow escape to be pushed during input

'---------
IF UCASE$(ALLOWEDCHARS$) = "ALL" OR ALLOWEDCHARS$ = "" THEN ALLOWEDCHARS$ = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+`~[]{};:'" + CHR$(34) + ",<.>/?\| "
LOCATE row, col: PRINT et$; : CONTENTS$ = et$
LT$ = CHR$(0) + CHR$(75): rt$ = CHR$(0) + CHR$(77)
ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8)
IF allowesc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27) + LT$ + rt$
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
         CASE IS = rt$: IF TC <= ALLOWEDCHARS THEN PRINT CHR$(28); : TC = TC + 1
         CASE ELSE:
         SELECT CASE TC
              CASE IS < ALLOWEDCHARS: PRINT CHAR$; : TC = TC + 1: CONTENTS$ = CONTENTS$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l29B": GOTO tos:
         END SELECT
     END SELECT
LOOP
END FUNCTION

SUB LoadHitData
    OPEN "Hitcount.dat" FOR INPUT AS #4
    IF nodata = false THEN
        FOR row = 1 TO 10
            FOR col = 1 TO 10
                INPUT #4, ssn
                hitcount(row, col) = ssn
            NEXT col
        NEXT row
    CLOSE #4
    END IF

END SUB

SUB Menu
mbegin:
    WIDTH 80, 25: COLOR 9, 8: CLS :
    center 2, "BattStats - BattleShip Statistics"
    COLOR 14: center 3, "By Charles Martin": COLOR 15: LOCATE 7, 1
    PRINT "       A. Add a new game"
    PRINT
    PRINT "       D. Display/Search game records"
    PRINT
    PRINT "       H. Most common 'hit' locations"
    PRINT
    PRINT "       S. Statistics"
    PRINT
    PRINT "       X. Exit"
    COLOR 13: center 16, "Press the letter next to": center 17, "the desired choice:"

    clearboard
    LOCATE , , 0
    k$ = GetKey$("adhsx")
    SELECT CASE k$
        CASE IS = "A": AddGame: GOTO mbegin:
        CASE IS = "D": display: GOTO mbegin:
        CASE IS = "H": MHS: GOTO mbegin:
        CASE IS = "S": ShowStats: GOTO mbegin:
        CASE IS = "X", CHR$(27): CLOSE #1: SYSTEM
    END SELECT
END SUB

SUB MHS
    IF nodata = 1 THEN
        COLOR 14, 4: center 21, " No hit location data to display."
                     center 22, "Complete games using BS-Pegs to  "
                     center 23, "        use this feature.        "
        PLAY "o4 l19 cdag": COLOR , 8: SLEEP: EXIT SUB
    END IF

    COLOR 7, 8: CLS : LOCATE 1, 1
    PRINT "ÉÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍ»"
    PRINT "¶ ³ 1 ³ 2 ³ 3 ³ 4 ³ 5 ³ 6 ³ 7 ³ 8 ³ 9 ³10 º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºA³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºB³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºC³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºD³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºE³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºF³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºG³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºH³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºI³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÇÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶"
    PRINT "ºJ³   ³   ³   ³   ³   ³   ³   ³   ³   ³   º"
    PRINT "ÊÍÏÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍ¼"

    COLOR 11
    LOCATE 2, 5: PRINT "1": LOCATE 2, 9: PRINT "2": LOCATE 2, 13: PRINT "3"
    LOCATE 2, 17: PRINT "4": LOCATE 2, 21: PRINT "5": LOCATE 2, 25: PRINT "6"
    LOCATE 2, 29: PRINT "7": LOCATE 2, 33: PRINT "8": LOCATE 2, 37: PRINT "9"
    LOCATE 2, 40: PRINT "10":  LOCATE 4, 2: PRINT "A": LOCATE 6, 2: PRINT "B"
    LOCATE 8, 2: PRINT "C": LOCATE 10, 2: PRINT "D": LOCATE 12, 2: PRINT "E"
    LOCATE 14, 2: PRINT "F": LOCATE 16, 2: PRINT "G": LOCATE 18, 2: PRINT "H"
    LOCATE 20, 2: PRINT "I": LOCATE 22, 2: PRINT "J":

    shl = 1
    FOR row = 1 TO 10
        FOR col = 1 TO 10
            IF hitcount(row, col) = 0 THEN
                sqrpaint row2ltr(row), col, 6, ""
            ELSE
                sqrpaint row2ltr(row), col, 7, STR$(hitcount(row, col))
                NOH(shl) = hitcount(row, col): gridloc$(shl) = row2ltr(row) + "-" + i2a$(col)
                IF col <> 10 THEN gridloc$(shl) = " " + gridloc$(shl)
                shl = shl + 1
            END IF
        NEXT col
    NEXT row

    EL = shl   'number of items to sort  (# of elements in the array)
    gap = INT(EL / 2): start = TIMER
    DO WHILE gap > 0
        SwapFlag = 0
        DO WHILE SwapFlag = 0
            SwapFlag = 1
            FOR n = 1 TO EL - gap
                    IF NOH(n) < NOH(n + gap) THEN   'change array name here if desired
                    SWAP NOH(n), NOH(n + gap): SwapFlag = 0  'this line also
                    SWAP gridloc$(n), gridloc$(n + gap)
                END IF
            NEXT n
        LOOP
    gap = INT(gap / 2)
    LOOP
                                   '-#----#----#----#----#----#----|
      COLOR 13: LOCATE 2, 49: PRINT "Most Common Locations"
                LOCATE 3, 49: PRINT "for scoring hits"

      COLOR 10: LOCATE 6, 49: PRINT "The purpose of this screen is"
                LOCATE 7, 49: PRINT "to show the grid locations"
                LOCATE 8, 49: PRINT "where the most hits have been"
                LOCATE 9, 49: PRINT "made over time."
      
               LOCATE 11, 49: PRINT "For each grid location, the"
               LOCATE 12, 49: PRINT "TOTAL number of hits scored at"
               LOCATE 13, 49: PRINT "that location is displayed."

     COLOR 15: LOCATE 16, 49: PRINT "Most common hit locations:"
    COLOR 12
    FOR I = 1 TO 5
        LOCATE 16 + I, 55: PRINT gridloc$(I); TAB(63); USING "###"; NOH(I)
    NEXT I

     Waitkey
END SUB

FUNCTION NoGamesCheck
    IF NumGames = 0 THEN
        COLOR 14, 4: center 21, " No game records in the database.  Use the " + Quote$("Add")
     center 22, "option to add new games.  Completing games using"
     center 23, "     BS-Pegs will also add new game records.    "
     PLAY "o4 l19 cdag": COLOR , 8: SLEEP: NoGamesCheck = -1: EXIT FUNCTION
     END IF
     NoGamesCheck = 1
END FUNCTION

FUNCTION Quote$ (stq$)
    Quote$ = CHR$(34) + stq$ + CHR$(34)
END FUNCTION

SUB ReCreate
    OPEN "BatStats.dat" FOR RANDOM AS #1 LEN = 48
    OPEN "Batstats.new" FOR RANDOM AS #2 LEN = 48

    FOR I = 1 TO (LOF(1) / 48)
        GET #1, I, game
        PUT #2, I, game
    NEXT I

    CLOSE 1, 2
    NAME "batstats.dat" AS "batstats.old"
    NAME "batstats.new" AS "batstats.dat"

END SUB

SUB REduce (n, D)

    VIEW PRINT: CLS : fln = 9: fpos = 1: na = n: da = D
    LOCATE 5, 1: PRINT SPACE$(5): st = TIMER

        IF na > da THEN HI = na ELSE HI = da

    FOR X = HI TO 2 STEP -1
        IF na > da THEN
            HI = na: lo = da
        ELSE
            HI = da: lo = na
       END IF
       IF na MOD X = 0 AND da MOD X = 0 THEN MA = 1 ELSE MA = 0
    SELECT CASE MA
        CASE IS <> 1: GOTO EOL:
        CASE IS = 1: na = na / X: da = da / X: ona = na: oda = da
    END SELECT
EOL:
        IF n = D THEN na = 1: da = 1: GOTO GotIt:
NEXT X

GotIt:
    et = TIMER - st
        IF na <> n AND da <> D THEN
        IF ona <> na AND oda <> da THEN  ELSE EXIT SUB
    END IF
END SUB

FUNCTION replace$ (text$, LookFor$, ReplaceWith$)

'   check for null original string, not in at all, or equal
    IF (text$ = "") OR (INSTR(text$, LookFor$) < 1) OR (text$ = ReplaceWith$) OR LEN(text$) < LEN(LookFor$) THEN
       replace$ = text$
       EXIT FUNCTION
    END IF

    new$ = ""

    LengthOfReplacement% = LEN(ReplaceWith$)
    LengthOfText% = LEN(text$)
    LengthOfStringToLookFor% = LEN(LookFor$)

    I% = 1
    WHILE I% <= LengthOfText% - LengthOfStringToLookFor% + 1
        IF MID$(text$, I%, LengthOfStringToLookFor%) = LookFor$ THEN
           new$ = new$ + ReplaceWith$
           I% = I% + LengthOfStringToLookFor%
        ELSE
           new$ = new$ + MID$(text$, I%, 1)
           I% = I% + 1
        END IF
    WEND

    replace$ = new$
END FUNCTION

FUNCTION row2ltr$ (r)
    tmp$ = "ABCDEFGHIJ"
    row2ltr$ = MID$(tmp$, r, 1)
END FUNCTION

SUB SavePrint
    CLOSE #2: both = 0:  COLOR 9: CLS : center 2, "Save and Print"
    COLOR 14: LOCATE 6, 1: DO UNTIL INKEY$ = "": LOOP
    PRINT "       P.  Print"
    PRINT
    PRINT "       S.  Save to file"
    PRINT
    PRINT "       B.  Both print AND save"
    PRINT
    PRINT "       N.  None of the above"

    COLOR 15:  center 15, "Press the letter next to the"
    center 16, "desired report option:"
    
    k$ = GetKey$("PSBNX")
GetRptOption:
    SELECT CASE k$
        CASE IS = "P"
            Cleararea 14, 23: COLOR 15, 4: center 18, "  Make sure printer is ready - Press ENTER  "
            center 19, "   to start, or ESCape to cancel printing:  "
            COLOR 14, 8
            k$ = GetKey$(CHR$(13) + CHR$(27))
                IF k$ = CHR$(13) THEN
                    SHELL "type rt.txt > PRN"
                    IF both <> 1 THEN KILL "rt.txt" ELSE k$ = "S": GOTO GetRptOption:
                ELSE
                    KILL "rt.txt": EXIT SUB
                END IF
            CASE IS = "S"
GetName:
        COLOR 13: Cleararea 14, 23: LOCATE 18, 7: PRINT "FILE NAME:  "
        rf$ = trim$(Limitinput$(12, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.0123456789-", 18, 19, ""))
        IF rf$ = CHR$(27) OR rf$ = "" THEN KILL "rt.txt": EXIT SUB
        IF INSTR(rf$, ".") = 0 THEN rf$ = rf$ + ".txt"
        IF INSTR(rf$, ".") > 9 THEN COLOR 11: center 21, "Only 1 to 8 characters before the " + Quote$(".") + " and file extension.": SLEEP 3: Cleararea 14, 23: GOTO GetName:
        IF UCASE$(rf$) = "RT.TXT" THEN EXIT SUB
        SHELL "copy rt.txt " + rf$ + " > nul": KILL "rt.txt": : EXIT SUB
        CASE IS = "B": both = 1: k$ = "P": GOTO GetRptOption:
        CASE IS = "N", "X", CHR$(27): KILL "rt.txt": : EXIT SUB
    END SELECT
END SUB

SUB ShowStats

    IF NoGamesCheck = -1 THEN EXIT SUB
    CalcStats
    COLOR 9: CLS : center 2, "BattleShip Statistics"
    COLOR 15: LOCATE 6, 1: : fmt2$ = "   ###": fmt3$ = ".##"
    IF INSTR(i2a$(winperc), ".") > 0 THEN fmt4$ = fmt3$ ELSE fmt4$ = ""

    hitperc = (totalhits / totalshots) * 100

    REduce totalshots, totalhits
    PRINT "         Number of games played:"; USING fmt2$; NumGames
    PRINT
    PRINT "                           Wins:"; USING fmt2$; wins
    PRINT "             Winning percentage:"; USING fmt2$ + fmt4$ + "%"; winperc
    PRINT "                         Losses:"; USING fmt2$; losses
    PRINT
    PRINT "         Average score per game:"; USING fmt2$; AvgScore
    PRINT "    Average score for opponents:"; USING fmt2$; avgopp
    PRINT

    IF INSTR(i2a$(hitperc), ".") > 0 THEN fmt4$ = fmt3$ ELSE fmt4$ = ""
    PRINT "                  Hit frequency:   "; USING "### out of every #### shots"; da; na
    PRINT "                 Hit percentage:"; USING fmt2$ + fmt4$ + "%"; hitperc
    PRINT "      Average # of missed shots:"; USING fmt2$; avgmiss
    Waitkey
END SUB

SUB sqrpaint (l$, n, S, sh$)
    SELECT CASE l$
        CASE IS = "A": l = 4
        CASE IS = "B": l = 6
        CASE IS = "C": l = 8
        CASE IS = "D": l = 10
        CASE IS = "E": l = 12
        CASE IS = "F": l = 14
        CASE IS = "G": l = 16
        CASE IS = "H": l = 18
        CASE IS = "I": l = 20
        CASE IS = "J": l = 22
    END SELECT

    SELECT CASE n
        CASE IS = 1:  z = 4
        CASE IS = 2:  z = 8
        CASE IS = 3:  z = 12
        CASE IS = 4:  z = 16
        CASE IS = 5:  z = 20
        CASE IS = 6:      z = 24
        CASE IS = 7:  z = 28
        CASE IS = 8:  z = 32
        CASE IS = 9:  z = 36
        CASE IS = 10:  z = 40
    END SELECT

    LOCATE l, z
    l% = l: z% = z
    SELECT CASE S
        CASE IS = 6: COLOR 8, 8: PRINT "   "
        CASE IS = 7: COLOR 14, 8: PRINT USING "###"; VAL(sh$)
    END SELECT

END SUB

SUB StartReport
    OPEN "rt.txt" FOR OUTPUT AS #2
    centerfile 2, "BattleShip Stats Report"
    centerfile 2, "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ"
    PRINT #2, ""
    PRINT #2, ""
    PRINT #2, TAB(34); "Created:  "; DATE$
    PRINT #2, TAB(34); "   Type:  " + rpt$
    PRINT #2, ""
    PRINT #2, ""
    PRINT #2, head$
    PRINT #2, head2$
END SUB

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

SUB Waitkey
    COLOR 26: LOCATE 23, 66: PRINT "Press ENTER..."
    DO
        k$ = INKEY$
            IF k$ = CHR$(13) THEN EXIT DO
            IF k$ = CHR$(27) THEN EXIT DO
            IF k$ = " " THEN EXIT DO
    LOOP
END SUB

