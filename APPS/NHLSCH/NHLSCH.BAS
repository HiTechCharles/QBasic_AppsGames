DECLARE SUB center (row, text$)
DECLARE SUB cleararea (f, l, fc)
DECLARE SUB clearboard ()
DECLARE SUB FirstTeam ()
DECLARE SUB OptionNames ()
DECLARE SUB OptionValues ()
DECLARE SUB OutOfBounds ()
DECLARE FUNCTION Quote$ (q$)
DECLARE SUB Search ()
DECLARE FUNCTION trim$ (ttt$)
DECLARE SUB waitforkey (msg$)
COMMON SHARED opt, MaxCol, TS, ds, HOA, opp, dir

TYPE gameline
    DATE AS STRING * 6    'XXX YY    X=month abbreviation, Y=day #
     day AS STRING * 3     'Thu Fri Sat Sun Mon Tue Wed
     HOA AS STRING * 1     'H=Home, A=Away
opponent AS STRING * 12    'Flames, Stars, Oilers
    TIME AS STRING * 5     '7:30, 10:00     All games are PM,, not needed
 NETWORK AS STRING * 11    'TV network  TSN,OLN,NBC
END TYPE

TYPE TeamLine
    city AS STRING * 12
    name AS STRING * 12
    abbr AS STRING * 3
    conf AS STRING * 2
     div AS STRING * 9
END TYPE  '38

uP$ = CHR$(0) + CHR$(72): dn$ = CHR$(0) + CHR$(80): lt$ = CHR$(0) + CHR$(75)
Rt$ = CHR$(0) + CHR$(77): enter$ = CHR$(13): escape$ = CHR$(27): F1$ = CHR$(0) + CHR$(59)
f2$ = CHR$(0) + CHR$(60): f3$ = CHR$(0) + CHR$(61): f4$ = CHR$(0) + CHR$(62)

DIM SHARED game AS gameline, team AS TeamLine, day$(0 TO 7)
OPEN "raf\teams.dat" FOR RANDOM AS #2 LEN = 38

day$(0) = "Any day": day$(1) = "Sunday": day$(2) = "Monday": day$(3) = "Tuesday"
day$(4) = "Wednesday": day$(5) = "Thursday": day$(6) = "Friday": day$(7) = "Saturday"

FirstTeam

MenU:
WIDTH 40, 25: COLOR , 0: CLS : opt = 1: MaxCol = 40
clearboard
COLOR 10, 8:  LOCATE 4, 1: PRINT "  Up &  Down - move between options"
                        PRINT "Left & Right - change setting"
                        PRINT "       Enter - start the search"
                        PRINT "      Escape - exit the program"
                        PRINT "           H - Help"
                        PRINT "           R - Reset search form"
OptionNames
OptionValues

gak:
    k$ = UCASE$(INKEY$)
    IF k$ = dn$ THEN opt = opt + 1: OutOfBounds: OptionNames:
    IF k$ = uP$ THEN opt = opt - 1: OutOfBounds: OptionNames:

    IF k$ = lt$ THEN
        SELECT CASE opt
            CASE IS = 1: ds = ds - 1: dir = -1
            CASE IS = 2: HOA = HOA - 1: dir = -1
            CASE IS = 3: opp = opp - 1: dir = -1
        END SELECT
        CALL OutOfBounds: OptionValues
        END IF

    IF k$ = Rt$ THEN
        SELECT CASE opt
            CASE IS = 1: ds = ds + 1: dir = 1
            CASE IS = 2: HOA = HOA + 1: dir = 1
            CASE IS = 3: opp = opp + 1: dir = 1
        END SELECT
        CALL OutOfBounds: OptionValues
        END IF
        
    IF k$ = "R" THEN ds = 0: HOA = 0: opp = 0: OptionValues
    IF k$ = escape$ THEN SYSTEM
    IF k$ = enter$ THEN
        IF ds = 0 AND HOA = 0 AND opp = 0 THEN PLAY "L64 mb O4 eg eg eg eg eg eg eg eg eg eg eg eg eg eg eg": GOTO MenU:
        Search
        GOTO MenU
    END IF
GOTO gak:

SUB center (row, text$)
    LOCATE row, (MaxCol / 2) - LEN(text$) / 2: PRINT text$
END SUB

SUB cleararea (f, l, fc)
    COLOR , 0
    FOR I = f TO l: LOCATE I, fc: PRINT SPACE$(MaxCol - fc): NEXT I
END SUB

SUB clearboard
    DO UNTIL INKEY$ = "": LOOP
END SUB

SUB FirstTeam
    uP$ = CHR$(0) + CHR$(72): dn$ = CHR$(0) + CHR$(80): lt$ = CHR$(0) + CHR$(75)
    Rt$ = CHR$(0) + CHR$(77): enter$ = CHR$(13): escape$ = CHR$(27): F1$ = CHR$(0) + CHR$(59)
    MaxCol = 40
    
    WIDTH 40, 25: COLOR 9: CLS
    center 2, "NHL 2006-07 Season Schedule": COLOR 14
    center 4, "Schedule data provided by WWW.NHL.com"
    center 5, "Program by Charles Martin"
    COLOR 15:  center 11, "Use the LEFT and RIGHT arrows to"
               center 12, "select the team you wish to"
               center 13, "investigate.  Press ENTER when done."

    COLOR 10: TS = 11: GOTO PrintSelection:

    DO
TOP:    k$ = UCASE$(INKEY$)
        IF k$ = Rt$ OR k$ = uP$ THEN TS = TS + 1: GOTO PrintSelection:
        IF k$ = lt$ OR k$ = dn$ THEN TS = TS - 1: GOTO PrintSelection:
        IF k$ = escape$ THEN SYSTEM
        IF k$ = enter$ THEN GOTO OpenFile:
        IF k$ = "A" THEN TS = 1: GOTO PrintSelection:
        IF k$ = "B" THEN TS = 3: GOTO PrintSelection:
        IF k$ = "C" THEN TS = 5: GOTO PrintSelection:
        IF k$ = "D" THEN TS = 10: GOTO PrintSelection:
        IF k$ = "E" THEN TS = 12: GOTO PrintSelection:
        IF k$ = "F" THEN TS = 13: GOTO PrintSelection:
        IF k$ = "L" THEN TS = 14: GOTO PrintSelection:
        IF k$ = "M" THEN TS = 15: GOTO PrintSelection:
        IF k$ = "N" THEN TS = 17: GOTO PrintSelection:
        IF k$ = "O" THEN TS = 21: GOTO PrintSelection:
        IF k$ = "P" THEN TS = 22: GOTO PrintSelection:
        IF k$ = "S" THEN TS = 25: GOTO PrintSelection:
        IF k$ = "T" THEN TS = 27: GOTO PrintSelection:
        IF k$ = "V" THEN TS = 29: GOTO PrintSelection:
        IF k$ = "W" THEN TS = 30: GOTO PrintSelection:
    LOOP

PrintSelection:
    IF TS < 1 THEN TS = 30: SOUND 650, 1
    IF TS > 30 THEN TS = 1: SOUND 650, 1
    
    GET #2, TS, team
    cleararea 16, 18, 1
    center 16, trim$(team.city) + " " + trim$(team.name) + "  (" + trim$(team.abbr) + ")"
    center 17, trim$(team.conf) + "stern Conference"
    center 18, trim$(team.div) + " Division"
    GOTO TOP:

OpenFile:
    OPEN "RAF\" + trim$(team.abbr) + ".sch" FOR RANDOM AS #1 LEN = 38
END SUB

SUB OptionNames
    COLOR 15, 8
    LOCATE 14, 5: PRINT "             Team:"
    
    IF opt = 1 THEN COLOR 15, 9 ELSE COLOR 15, 8
    LOCATE 16, 5: PRINT "  Day of the week:"

    IF opt = 2 THEN COLOR 15, 9 ELSE COLOR 15, 8
    LOCATE 18, 5: PRINT "Home or Away game:"

    IF opt = 3 THEN COLOR 15, 9 ELSE COLOR 15, 8
    LOCATE 21, 5: PRINT "         Opponent:"
END SUB

SUB OptionValues
    COLOR 14: cleararea 14, 23, 25
    GET #2, TS, team
    LOCATE 13, 25: PRINT team.city
    LOCATE 14, 25: PRINT team.name
    LOCATE 16, 25: PRINT day$(ds)
    LOCATE 18, 25:
    SELECT CASE HOA
        CASE 0: PRINT "No preference"
        CASE 1: PRINT "Home"
        CASE 2: PRINT "Away"
    END SELECT
    SELECT CASE opp
            CASE IS > 0: GET #2, opp, team: LOCATE 20, 25: PRINT team.city: LOCATE 21, 25: PRINT team.name
            CASE IS = 0: LOCATE 21, 25: PRINT "Any team"
        END SELECT
END SUB

SUB OutOfBounds
    IF opt < 1 THEN opt = 3
    IF opt > 3 THEN opt = 1

    IF ds < 0 THEN ds = 7
    IF ds > 7 THEN ds = 0

    IF HOA < 0 THEN HOA = 2
    IF HOA > 2 THEN HOA = 0

    IF opp > 30 THEN opp = 0
    IF opp < 0 THEN opp = 30

    IF opp = TS THEN opp = opp + dir
END SUB

FUNCTION Quote$ (q$)
    Quote$ = CHR$(34) + trim$(q$) + CHR$(34)
END FUNCTION

SUB Search
    COLOR , 0: WIDTH 80, 25: ptm = 0: match = 0: hos$ = "": ds$ = "": opp$ = "": msg$ = "": MaxCol = 80
    IF ds <> 0 THEN ptm = ptm + 1:  ds$ = LEFT$(day$(ds), 3)

    IF HOA <> 0 THEN
        ptm = ptm + 1
        IF HOA = 1 THEN HOA$ = "H" ELSE HOA$ = "A"
    END IF
    
    IF opp <> 0 THEN
        ptm = ptm + 1
        GET #2, opp, team
        opp$ = trim$(team.name)
    END IF
    
    COLOR 13: CLS
    PRINT "DATE          H/A     OPPONENT        TIME     NETWORK": COLOR 10
    PRINT "----          ---     --------        ----     -------": COLOR 15
    
    FOR I = 1 TO 82
        GET #1, I, game

       SELECT CASE ds
            CASE 0: GOTO HOA:
            CASE ELSE
                 IF game.day <> ds$ THEN GOTO EOL ELSE GOTO HOA:
       END SELECT

HOA:   SELECT CASE HOA
            CASE 0: GOTO opp:
            CASE ELSE
                 IF game.HOA <> HOA$ THEN GOTO EOL:  ELSE GOTO opp:
       END SELECT

opp:   SELECT CASE opp
            CASE 0: GOTO PrintGame:
            CASE ELSE
                 IF trim$(game.opponent) <> opp$ THEN GOTO EOL:  ELSE GOTO PrintGame:
       END SELECT

PrintGame:
        match = match + 1: COLOR 15: PRINT game.day + " " + game.DATE + "    ";
        IF game.HOA = "H" THEN PRINT "HOME";  ELSE PRINT "AWAY";
        PRINT "    " + game.opponent + "    " + game.TIME + "    " + game.NETWORK

        IF match / 19 = 1 THEN
            waitforkey "Press any key for more"
            cleararea 3, 23, 1:  LOCATE 3, 1
        END IF
EOL:
    NEXT I

    SELECT CASE match
        CASE IS <> 0: waitforkey "Press any key": EXIT SUB
        CASE ELSE:
            IF ds <> 0 THEN msg$ = day$(ds) ELSE msg$ = ""
            SELECT CASE HOA
                CASE 1: msg$ = msg$ + " Home games"
                CASE 2: msg$ = mgg$ + " Away games"
                CASE ELSE: msg$ = msg$ + " Games"
            END SELECT
         IF opp$ <> "" THEN msg$ = msg$ + " Vs. " + opp$
         COLOR 10: center 7, "No games match your search of"
         center 8, Quote$(msg$)
         center 11, "First, select " + Quote$("any team") + " from the search pannel."
         center 13, "Second, set the HOME/AWAY option to " + Quote$("No preference")
         center 15, "If you're still haveing problems, press V on the search pannel to"
         center 16, "see the full schedule for the team you selected at startup."
         waitforkey "Press any key to try again"
    END SELECT
END SUB

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

SUB waitforkey (msg$)
    COLOR 10: center 23, "ÄÄÄÄÄ" + msg$ + "ÄÄÄÄÄ": SLEEP
END SUB

