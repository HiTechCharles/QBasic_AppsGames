DECLARE SUB shutdown ()
DECLARE SUB autoformat (ntf)             'places commas in numbers > 999
DECLARE FUNCTION Capitalize$ (Orig$)     'capitalize name
DECLARE SUB center (Row, text$)          'Center text on a given line
DECLARE FUNCTION Ceil (ntr)              'rounds number to next intever
DECLARE SUB checkforsetup ()             'checks for saved name/weight data
DECLARE SUB clearlines (fl%, sl%, c%)    'erase lines of the screen
DECLARE FUNCTION i2a$ (h)                'converts numbers to strings
DECLARE FUNCTION InputString$ (Row%, column%, inputfield$, Foreground%, Background%, ValidCharacters$, ReturnMode%, EntryMode%, CaseMode%)
DECLARE FUNCTION kg! (lbm!)              'convert a weight to kilograms
DECLARE FUNCTION LB! (kgm!)              'convert a weight to pounds
DECLARE SUB loaddetails ()               'load details  TotalWeeks, etc.
DECLARE FUNCTION LossGain$ (old!, new!)  'print message for gain/loss of weight
DECLARE SUB menu ()                      'main menu:  weigh-in,status,options,exit
DECLARE SUB Nameinline ()                'prints player nme at top of screen
DECLARE SUB PlayerSetup ()               'asks for names,weights,amt to lose
DECLARE SUB playerstatus ()              'shows info on all players
DECLARE SUB Questions ()                 'asks for # of weeks and players
DECLARE SUB savedetails ()               'save new details to file
DECLARE FUNCTION Trim$ (ttt$)            'removes leading/trailing spaces fro mstrings
DECLARE FUNCTION Unitabbr$ ()            'prints 'pound' or 'kilogram'
DECLARE FUNCTION UnitWord$ (w)           'prints 'lb' or 'kg'
DECLARE SUB weeklyweighin ()             'asks for weekly weigh-in data
COMMON SHARED TotalPlayers, debugmode

TYPE DetailClass
    weekscompleted AS INTEGER
       totalweeks AS INTEGER
       weightunit AS INTEGER
      lastweighin AS STRING * 10
         Password AS STRING * 30
             Hint AS STRING * 30
END TYPE    '76

TYPE WeightClass
           name AS STRING * 25
       starting AS SINGLE
       lastweek AS SINGLE
        current AS SINGLE
     weeklygoal AS INTEGER
    desiredloss AS INTEGER
END TYPE
CONST RecLen = 41
DIM SHARED weight AS WeightClass, detail AS DetailClass

ON ERROR GOTO Errorhandler:
    checkforsetup
    SYSTEM

    

Errorhandler:
    SELECT CASE ERR
        CASE IS = 6: RESUME NEXT
        CASE ELSE: PRINT "ERROR #"; ERR; "occured.": SYSTEM
    END SELECT

SUB autoformat (ntf)
    ntf$ = i2a$(ntf): dp = INSTR(ntf$, ".")
    IF dp > 0 THEN
        wp$ = MID$(ntf$, 1, dp - 1)
        dp$ = MID$(ntf$, (dp + 1), (LEN(ntf$) - dp))
    ELSE
        wp$ = ntf$: dp$ = ""
    END IF

    SELECT CASE LEN(wp$)
        CASE IS = 1: FMT$ = "#"
        CASE IS = 2: FMT$ = "##"
        CASE IS = 3: FMT$ = "###"
        CASE IS = 4: FMT$ = "#,###"
        CASE IS = 5: FMT$ = "##,###"
        CASE IS = 6: FMT$ = "###,###"
        CASE IS = 7: FMT$ = "#,###,###"
        CASE IS = 8: FMT$ = "##,###,###"
        CASE IS = 9: FMT$ = "###,###,###"
        CASE IS = 10: FMT$ = "#,###,###,###"
        CASE IS = 11: FMT$ = "##,###,###,###"
        CASE IS = 12: FMT$ = "###,###,###,###"
        CASE ELSE: FMT$ = "###,###,###,###,###"
    END SELECT

    IF dp > 0 THEN FMT$ = FMT$ + "." + STRING$(LEN(ntf$) - dp, "#")

    PRINT USING FMT$; VAL(wp$ + "." + dp$);
END SUB

FUNCTION Capitalize$ (Orig$)


'   if original is null, return null
    IF Orig$ = "" THEN
       Capitalize$ = ""
       EXIT FUNCTION
    END IF

    new$ = LCASE$(Orig$)

'   capitalize the first character
    MID$(new$, 1, 1) = UCASE$(MID$(new$, 1, 1))

'   process string, capitalizing anything that follows a space
    FOR X% = 1 TO (LEN(new$) - 1)
        IF MID$(new$, X%, 1) = " " THEN
           MID$(new$, (X% + 1), 1) = UCASE$(MID$(new$, (X% + 1), 1))
        END IF
    NEXT X%

    Capitalize$ = new$


END FUNCTION

FUNCTION Ceil (ntr)
    Ceil = -INT(-ntr)
END FUNCTION

SUB center (Row, text$)
    col = 21 - LEN(text$) / 2: LOCATE Row, col: PRINT text$
END SUB

SUB checkforsetup
    OPEN "Loser.dat" FOR RANDOM AS #1 LEN = RecLen
    IF LOF(1) < RecLen THEN
        Questions
        PlayerSetup
    ELSE
        TotalPlayers = LOF(1) / RecLen
        loaddetails
        menu
    END IF
END SUB

DEFINT A-Z
SUB clearlines (fl%, sl%, c)
    COLOR , 0
    FOR X = fl TO sl
        LOCATE X, c: PRINT SPACE$((40 - c) + 1)
    NEXT X
END SUB

DEFSNG A-Z
FUNCTION i2a$ (h)
    i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION InputString$ (Row%, column%, inputfield$, Foreground%, Background%, ValidCharacters$, ReturnMode%, EntryMode%, CaseMode%)
    true% = 1                             ' logical true
    False% = 0                            ' logical false

    EnterKey$ = CHR$(13)                  ' signifies end of entry
    Escape$ = CHR$(27)                    ' emergency exit from function
    EraseToEOF$ = CHR$(20)                ' ^T erase from cursor to EOF
    RestoreField$ = CHR$(18)              ' ^R restore original field
    EraseField$ = CHR$(25)                ' ^Y erase entire field
    BackSpace$ = CHR$(8)                  ' dragging, destructive backspace
    RightArrow$ = "M"                     ' input cursor right
    LeftArrow$ = "K"                      ' input cursor left
    InsertKey$ = "R"                      ' insert mode toggle
    DeleteKey$ = "S"                      ' character delete
    HomeKey$ = "G"                        ' input cursor start of field
    EndKey$ = "O"                         ' input cursor after last char

    InputFinished% = False%               ' set to true on enter or escape
    InsertMode% = False%                  ' start off in insert off mode

    OriginalField$ = inputfield$          ' for ^R restore original field
    Length% = LEN(inputfield$)            ' total input field length
    CursorPosition% = LEN(Trim$(inputfield$)) + 1                 ' 1st position in entry string
    EndColumn% = column% + Length% - 1    ' last column in entry string

    COLOR Foreground%, Background%        ' set specified colors
    LOCATE Row%, column%, 0               ' locate cursor
    PRINT inputfield$;                    ' display original field
    CurrentColumn% = column% + LEN(Trim$(inputfield$))
    LOCATE Row%, CurrentColumn%, 1, 6, 7         ' locate at first character

    WHILE InputFinished% = False%         ' main loop

       InputKey$ = INKEY$                 ' get a keystroke if present
       EditKey$ = MID$(InputKey$, 2, 1)   ' editing key pressed?

       IF EditKey$ <> "" THEN

          SELECT CASE EditKey$

             CASE RightArrow$
                IF CurrentColumn% <= EndColumn% THEN
                   CurrentColumn% = CurrentColumn% + 1
                   CursorPosition% = CursorPosition% + 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE LeftArrow$
                IF CurrentColumn% > column% THEN
                   CurrentColumn% = CurrentColumn% - 1
                   CursorPosition% = CursorPosition% - 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE InsertKey$
                IF InsertMode% = true% THEN
                   LOCATE Row%, CurrentColumn%, 1, 6, 7
                   InsertMode% = False%
                ELSE
                   LOCATE Row%, CurrentColumn%, 1, 3, 7
                   InsertMode% = true%
                END IF

             CASE DeleteKey$
                IF CurrentColumn% <= EndColumn% THEN
                   FOR Index% = CursorPosition% TO Length% - 1
                       MID$(inputfield$, Index%, 1) = MID$(inputfield$, Index% + 1, 1)
                   NEXT Index%
                   MID$(inputfield$, Length%, 1) = " "
                   LOCATE Row%, column%, 0
                   PRINT inputfield$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE HomeKey$
                IF CursorPosition% > 1 THEN
                   CurrentColumn% = column%
                   CursorPosition% = 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE EndKey$
                IF CursorPosition% < Length% THEN
                   FOR Index% = Length% TO 1 STEP (-1)
                       IF MID$(inputfield$, Index%, 1) <> " " THEN
                          EXIT FOR
                       END IF
                   NEXT Index%
                   CursorPosition% = Index% + 1
                   CurrentColumn% = column% + Index%
                   LOCATE Row%, CurrentColumn%, 1
                END IF

          END SELECT

       ELSE

          SELECT CASE InputKey$

             CASE Escape$
                InputString$ = InputKey$
                EXIT FUNCTION

             CASE BackSpace$
                IF CurrentColumn% > column% THEN
                   n$ = ""
                   FOR Index% = 1 TO CursorPosition% - 2
                       n$ = n$ + MID$(inputfield$, Index%, 1)
                   NEXT Index%
                   FOR Index% = CursorPosition% TO Length%
                       n$ = n$ + MID$(inputfield$, Index%, 1)
                   NEXT Index%
                   inputfield$ = LEFT$(n$ + SPACE$(Length%), Length%)
                   CurrentColumn% = CurrentColumn% - 1
                   CursorPosition% = CursorPosition% - 1
                   LOCATE Row%, column%, 0
                   PRINT inputfield$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE EraseField$
                inputfield$ = SPACE$(Length%)
                LOCATE Row%, column%, 0
                PRINT inputfield$;
                CursorPosition% = 1
                CurrentColumn% = column%
                LOCATE Row%, column%, 1

             CASE EraseToEOF$
                IF CurrentColumn% <= EndColumn% THEN
                   MID$(inputfield$, CursorPosition%, Length% - CursorPosition% + 1) = SPACE$(Length% - CursorPosition% + 1)
                   LOCATE Row%, column%
                   PRINT inputfield$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE RestoreField$
                inputfield$ = OriginalField$
                LOCATE Row%, column%, 0
                PRINT inputfield$;
                CursorPosition% = 1
                CurrentColumn% = column%
                LOCATE Row%, column%, 1

             CASE EnterKey$
                InputFinished% = true%

             CASE ELSE

                ValidKey% = False%
'               null string for valid characters means all input accepted
                IF ValidCharacters$ = "" OR INSTR(ValidCharacters$, UCASE$(InputKey$)) > 0 THEN
                   ValidKey% = true%
                END IF

                IF ValidKey% = true% AND InputKey$ <> "" AND CurrentColumn% <= EndColumn% THEN

                   SELECT CASE CaseMode%
                      CASE 1
                         ' do nothing, accept as entered
                      CASE 2
                         InputKey$ = UCASE$(InputKey$)
                      CASE 3
                         InputKey$ = LCASE$(InputKey$)
                   END SELECT

                   SELECT CASE InsertMode%
                      CASE true%
                         inputfield$ = LEFT$(inputfield$, CursorPosition% - 1) + InputKey$ + RIGHT$(inputfield$, Length% - CursorPosition% + 1)
                         inputfield$ = LEFT$(inputfield$, Length%)
                         LOCATE Row%, column%
                         PRINT inputfield$;
                      CASE False%
                         PRINT InputKey$;
                         MID$(inputfield$, CursorPosition%, 1) = InputKey$
                   END SELECT

                   CursorPosition% = CursorPosition% + 1
                   CurrentColumn% = CurrentColumn% + 1
                   LOCATE Row%, CurrentColumn%, 1

'                  check entry mode to see if end of field entry terminates entry
                   IF CurrentColumn% > EndColumn% AND EntryMode% = 2 THEN
                      InputFinished% = true%
                   END IF

                END IF

          END SELECT

       END IF

    WEND

'   return entered string appropriately

    SELECT CASE ReturnMode%

       CASE 1     ' return entire field
          InputString$ = inputfield$

       CASE 2     ' return field less any trailing blanks
          InputString$ = RTRIM$(inputfield$)

       CASE 3     ' return field less any leading blanks
          InputString$ = LTRIM$(inputfield$)

       CASE 4     ' return field less both leading and trailing blanks
          InputString$ = LTRIM$(RTRIM$(inputfield$))

       CASE 5     ' return field with all blanks removed
          n$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(inputfield$, Index%, 1) <> " " THEN
                 n$ = n$ + MID$(inputfield$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = n$

       CASE 6     ' left justify and kill blanks between 1st and last char
          n$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(inputfield$, Index%, 1) <> " " THEN
                 n$ = n$ + MID$(inputfield$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = RIGHT$(n$ + SPACE$(Length%), Length%)

       CASE 7     ' right justify and kill inner blanks
          n$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(inputfield$, Index%, 1) <> " " THEN
                 n$ = n$ + MID$(inputfield$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = RIGHT$(SPACE$(Length%) + n$, Length%)

    END SELECT
END FUNCTION

FUNCTION kg! (lbm!)
    kg! = .45359237# * lbm!
END FUNCTION

FUNCTION LB! (kgm!)
    LB! = kgm! * 2.2
END FUNCTION

SUB loaddetails
    OPEN "L_Detail.dat" FOR RANDOM AS #2 LEN = 76
    IF LOF(2) < 76 THEN
        Questions
    ELSE
        GET #2, 1, detail: CLOSE #2
    END IF
    CLOSE #2
END SUB

FUNCTION LossGain$ (old, new)
    diff = ABS(old - new)    'difference between weights
    IF old > new THEN   'if new weight less than old,
        LossGain$ = "lost " + i2a(diff) + " " + UnitWord(diff) 'lost
    ELSE                                                  'otherwise gained
        LossGain$ = "gained " + i2a(diff) + " " + UnitWord(diff)
    END IF
END FUNCTION

SUB menu
    COLOR 14: CLS
    center 2, "Loser - Main Menu"
    COLOR 9: LOCATE 6, 1
    PRINT "Press a letter to choose an option:"
    COLOR 15
    PRINT "     W - Weigh-in"
    PRINT
    PRINT "     P - Player Status"
    PRINT
    PRINT "     O - Options"
    PRINT
    PRINT "     X - Exut"
    SLEEP

menukey:
    k$ = UCASE$(INPUT$(1))
    SELECT CASE k$
        CASE "W": weeklyweighin
        CASE "P": playerstatus
        CASE "X": shutdown
        CASE ELSE: GOTO menukey:
    END SELECT


END SUB

SUB Nameinline
    n$ = Trim$(weight.name)
    LineSide = INT((40 - LEN(n$) + 2) / 2) - 2
    LOCATE 2, 1:  COLOR 15, 0: PRINT STRING$(LineSide, 205) + " ";
    COLOR 9: PRINT n$ + " "; : COLOR 15: PRINT STRING$(LineSide, 205)
END SUB

SUB PlayerSetup
    IF debugmode = 1 THEN GOTO dbm:

    COLOR 14, 0: CLS : LOCATE 1, 1
          '----#----#----#----#----#----#----#----|
    PRINT "Type in the mames, and starting weights"
    PRINT "of the"; TotalPlayers; "participants."
    PRINT
    PRINT "Fractions of a "; UnitWord(1); " are allowed,"
    PRINT "such as 186.25   98.5   220.8"
    PRINT : PRINT : COLOR 9
    PRINT "## Name                           Weight"
    COLOR 15

    OnRow% = 9

    FOR cp = 1 TO TotalPlayers
Ton:
        COLOR 15, 0: LOCATE OnRow%, 1: PRINT USING "##"; cp
        LOCATE OnRow%, 4: PRINT ">"
        weight.name = InputString$(OnRow%, 5, SPACE$(25), 14, 9, "", 3, 1, 1)
        IF Trim$(weight.name) = CHR$(27) THEN CLOSE #1: KILL "loser.dat": SYSTEM
        IF LEN(Trim$(weight.name)) < 3 THEN clearlines OnRow%, OnRow%, 1: GOTO Ton:
        
        weight.name = Capitalize$(weight.name)
        COLOR 15, 0: LOCATE OnRow%, 4: PRINT weight.name; " "
Tosw:   LOCATE OnRow%, 32: PRINT ">"

        w$ = InputString$(OnRow%, 33, SPACE$(4), 14, 9, "0123456789.", 5, 1, 1)
        IF w$ = CHR$(27) THEN CLOSE #1: KILL "loser.dat": SYSTEM
        IF VAL(w$) < 1 THEN clearlines OnRow%, OnRow%, 33: GOTO Tosw:
        IF VAL(w$) > 9999 THEN
            COLOR 10, 0: SOUND 1330, 2.5: center 23, "Between 1 and 9,999 " + UnitWord$(2): SLEEP 3
            clearlines OnRow%, 23, 33: clearlines 23, 23, 1: GOTO Tosw:
        END IF

        weight.starting = VAL(w$): weight.current = weight.starting
        COLOR 15, 0: LOCATE OnRow%, 32: PRINT USING " #,###.##"; weight.starting
        OnRow% = OnRow% + 1:  PUT #1, cp, weight
    NEXT cp

dbm:
    FOR cp = 1 TO TotalPlayers
hmtl:
        COLOR 10, 0: CLS
        GET #1, cp, weight
        Nameinline
        COLOR 10, 0: LOCATE 5, 1: PRINT "How much do you want to lose?  >"
        COLOR 15: PRINT "     ù Currently, you are ";
        autoformat weight.current:  PRINT Unitabbr$
        PRINT "     ù 10% of this is "; : autoformat weight.current / 10
        PRINT Unitabbr$: DO UNTIL INKEY$ = "": LOOP

         n = Ceil(weight.current / 10)
         w$ = i2a$(n) + SPACE$(4 - LEN(i2a$(n)))
         weight.desiredloss = VAL(InputString$(5, 33, w$, 14, 9, "0123456789", 5, 1, 1))
         IF weight.desiredloss < 5 THEN GOTO hmtl:
         IF weight.desiredloss > weight.current THEN
            SOUND 1330, 2.5: COLOR 10, 8: LOCATE 23, 5: PRINT "between 1 and ";
            autoformat weight.current
            PRINT UnitWord$(weight.current); "s": SLEEP 3: GOTO hmtl:
         END IF
        
        COLOR 15, 0: LOCATE 5, 32: autoformat INT(weight.desiredloss): PRINT SPACE$(4)
wg:     COLOR 15, 0: LOCATE 11, 1
        PRINT "It is suggested that you choose a weekly"
        PRINT "goal.  It might be easier to think " + CHR$(34); "5"
        PRINT "per week," + CHR$(34); " rather than " + CHR$(34); "lose 25 pounds." + CHR$(34)
        PRINT : COLOR 10
        PRINT "Weekly wight loss goal:  "; : COLOR 15: PRINT ">"

         n = Ceil(weight.desiredloss / detail.totalweeks)
         w$ = i2a$(n) + SPACE$(2 - LEN(i2a$(n)))
         weight.weeklygoal = VAL(InputString$(15, 27, w$, 14, 9, "0123456789", 5, 1, 1))
         IF weight.weeklygoal < 1 THEN GOTO wg:
         IF weight.weeklygoal > weight.current THEN
            SOUND 1330, 2.5: COLOR 10, 8: LOCATE 23, 5: PRINT "between 1 and ";
            autoformat weight.current
            PRINT UnitWord$(2): SLEEP 3: clearlines 11, 23, 1: GOTO wg:
         END IF
        PUT #1, cp, weight
    NEXT cp
            END SUB

SUB playerstatus
    WIDTH 80, 25: COLOR 14, 8: CLS
    LOCATE 2, 25: PRINT "Player Statistics";
    COLOR 9: LOCATE 4, 5: PRINT "All weights in "; UnitWord(2);
    LOCATE , 45:
    SELECT CASE detail.weekscompleted
        CASE 0: PRINT detail.totalweeks; " week program"
        CASE 1: PRINT "1 of"; detail.totalweeks; "weeks completed"
        CASE ELSE: PRINT detail.weekscompleted; "of"; detail.totalweeks; "weeks completed"
    END SELECT

    

    LOCATE 7, 1:
              COLOR 13:       PRINT "                                                             Weekly    Wants"
                              PRINT "## Name                       Starting  Last Week   Current    Goal  to Lose"
              COLOR 14:       PRINT "ÄÄ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ  ÄÄÄÄÄÄÄÄ  ÄÄÄÄÄÄÄÄÄ  ÄÄÄÄÄÄÄÄ  ÄÄÄÄÄÄ  ÄÄÄÄÄÄÄ"

    FOR cp = 1 TO TotalPlayers
              GET #1, cp, weight
              COLOR 15: PRINT USING "## \                       \  #,###.##   #,###.##  #,###.##   #,###    #,###"; cp; weight.name; weight.starting; weight.lastweek; weight.current; weight.weeklygoal; weight.desiredloss
    NEXT cp
    COLOR 28: LOCATE 23, 34: PRINT "Press a key...": SLEEP
    WIDTH 40: menu
END SUB

SUB Questions
    WIDTH 40, 25
bq:
    COLOR 10, 0: CLS
    
    IF TotalPlayers THEN LOCATE 5, 1: PRINT "There are"; TotalPlayers; "players": GOTO hmw:
    LOCATE 5, 1: PRINT "How many people?  (1 to 15)"
    LOCATE 5, 30: COLOR 15, 0: PRINT ">"
    TotalPlayers = VAL(InputString$(5, 31, SPACE$(2), 14, 9, "0123456789", 5, 1, 1))
    IF TotalPlayers = 26 THEN
        TotalPlayers = 3: debugmode = 1
        detail.totalweeks = 12
        detail.weightunit = 1
        savedetails

        weight.name = "Amanda": weight.starting = 115: weight.current = 115
        PUT #1, 1, weight
        weight.name = "Charlie": weight.starting = 193: weight.current = 193
        PUT #1, 2, weight
        weight.name = "Troy": weight.starting = 130: weight.current = 130
        PUT #1, 3, weight
        EXIT SUB
    ELSEIF TotalPlayers > 15 THEN
        TotalPlayers = 0: GOTO bq:
    ELSEIF TotalPlayers = 0 THEN
        SYSTEM
    END IF
    COLOR 15, 0: LOCATE 5, 29: PRINT TotalPlayers; SPACE$(9)
    
hmw:
    COLOR 10, 0: LOCATE 8, 1: PRINT "How many weeks?  (2 to ì)"
    COLOR 15: PRINT "1 month  =  4 weeks  3 months = 12 weeks"
              PRINT "4 months = 16 weeks  6 months = 24 weeks"
              PRINT "9 months = 36 weeks 12 months = 48 weeks"
    LOCATE 8, 28: PRINT ">"
    detail.totalweeks = VAL(InputString$(8, 29, SPACE$(4), 14, 9, "0123456789", 5, 1, 1))
    IF detail.totalweeks < 2 AND detail.totalweeks <> 0 THEN COLOR 10, 0: CLS : GOTO hmw:
    IF detail.totalweeks = 0 THEN SYSTEM
    COLOR 15, 0: LOCATE 8, 27: PRINT detail.totalweeks; SPACE$(10)

    COLOR 10, 0: LOCATE 14, 1, 0: PRINT "Which unit of mass?"
                                  PRINT "press P for Pounds (lb)      -OR-"
                                  PRINT "      K for Kilograms (kg)"
    DO
        k$ = UCASE$(INKEY$)
        IF k$ = "P" THEN detail.weightunit = 1: EXIT DO
        IF k$ = "K" THEN detail.weightunit = 2: EXIT DO
        IF k$ = CHR$(27) THEN SYSTEM
    LOOP

    savedetails
END SUB

SUB savedetails
    OPEN "l_detail.dat" FOR RANDOM AS #2 LEN = 76
    PUT #2, 1, detail:  CLOSE #2
END SUB

SUB shutdown
    savedetails
    CLOSE 1, 2
    SYSTEM
END SUB

FUNCTION Trim$ (ttt$)
    Trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

FUNCTION Unitabbr$
    IF detail.weightunit = 1 THEN Unitabbr$ = "lb" ELSE Unitabbr$ = "kg"
END FUNCTION

FUNCTION UnitWord$ (w)
    IF detail.weightunit = 1 THEN U$ = "pound" ELSE U$ = "kilogram"
    IF w <> 1 THEN UnitWord$ = U$ + "s" ELSE UnitWord$ = U$
    END FUNCTION

SUB weeklyweighin
    COLOR 4, 0: CLS
    LOCATE 1, 5: PRINT "Weigh-in for Week"; detail.weekscompleted + 1; "of"; detail.totalweeks
    FOR cp = 1 TO TotalPlayers
         DO UNTIL INKEY$ = "": LOOP
         clearlines 3, 23, 1
         GET #1, cp, weight
         Nameinline
         
         IF weight.lastweek > 0 THEN
             COLOR 15: LOCATE 6, 1: PRINT "Last week, you "; LossGain$(weight.lastweek, weight.current); ", and"
             PRINT "weigh ";
             autoformat (weight.current)
             PRINT " "; UnitWord(weight.current)
         ELSE
            COLOR 15: LOCATE 6, 1: PRINT "Your starting weight is ";
            autoformat weight.starting
            PRINT " "; UnitWord(aeight.starting)
        END IF

curweight:
        COLOR 9, 0: LOCATE 11, 1: PRINT "Your current weight is:"
        w$ = InputString$(11, 24, SPACE$(7), 14, 9, "0123456789.", 5, 1, 1)
        IF VAL(w$) < 1 OR VAL(w$) > 9999 THEN
            COLOR 10, 0: SOUND 1330, 2.5: center 23, "Between 1 and 9,999 " + UnitWord$(2)
            GOTO curweight:
        END IF

        weight.lastweek = weight.current
        weight.current = VAL(w$)
        PUT #1, cp, weight

        COLOR 14, 0: LOCATE 15, 1
        PRINT "You "; LossGain$(weight.lastweek, weight.current) + "."

        COLOR 26: LOCATE 23, 10: PRINT "Press a key for next player..."
        SLEEP
    NEXT cp
    detail.weekscompleted = detail.weekscompleted + 1
    detail.lastweighin = DATE$ + "  " + TIME$
    savedetails
    menu
END SUB

