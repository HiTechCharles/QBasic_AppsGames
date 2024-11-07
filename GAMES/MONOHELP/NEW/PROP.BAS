DECLARE SUB DiceStats ()
DECLARE SUB bankrupt ()
DECLARE SUB Box (row%, Column%, BoxWidth%, Height%, BoxColor%, BoxCharacter%, BorderType%, BorderColor%)
DECLARE SUB center (row, text$)
DECLARE SUB ClearLines (lo, hi, start)
DECLARE FUNCTION colorchoices ()
DECLARE SUB Change ()
DECLARE SUB Check4Save ()
DECLARE SUB diceroll ()
DECLARE SUB Displaymdf (row!, col!, file$)
DECLARE SUB ExitTasks ()
DECLARE FUNCTION getkey$ (allowed$)
DECLARE SUB GetNames ()
DECLARE SUB help ()
DECLARE FUNCTION I2a$ (h!)
DECLARE FUNCTION IsColorUsed (clr)
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
DECLARE SUB LOAD ()
DECLARE SUB PlayerInfo ()
DECLARE SUB playsounds (stp)
DECLARE SUB propcount ()
DECLARE SUB PropInit ()
DECLARE SUB propsforplayer (ptd!)
DECLARE SUB save ()
DECLARE SUB ShortGame ()
DECLARE SUB ShowAll ()
DECLARE SUB ShowFileDetails ()
DECLARE SUB TitleDeeds ()
COMMON SHARED nop, avail$, currentdeed, SG, f1$, f2$, f3$, f4$, F5$, f6$
COMMON SHARED filemode, fi$, fec, fileerror, eog, rolls, dspch, mortcolor

'Prop$(28)          Porperty names
'PropColor(28)      Colors of the properties when printed on-screen
'price(28)          Prices of the properties
'Owned(28)          Owner of a property  (X) = player #
'Group$(10)         Property groups  (ex:Oriental/Vermont/Connecticut)
'PlayerColor(9)     color for each player in the game
'Name$(9)           Names of the players
'nopo(9)            Number of properties owned per player
'Maxraiss(9)        amount of $$ a player can raise by mortgaging all owned properties
'Mortgage(28)       determines if a property is mortgaged  1=morgaged
'MaxPay(8)          max amount to pay to unmortgage all properties a player owns
'nop                # of players
'avail$             Available player #s  ex: 1239
'currentdeed        Title deed group currently being displayed
'FileMode          
'EOG                end of game-gets set to 1 when game is over
'dspch              dice roll speech on / off toggle

CONST true = 1, false = -1
DIM SHARED prop$(28), propcolor(28), price(28), owned(28), Group$(10), playercolor(9), name$(9), nopo(9), maxraise(9), mortgage(28), maxpay(9), dice(2 TO 16)
dspch = 1: mortcolor = 9

begin:
    ON ERROR GOTO errorhandler:
    f1$ = CHR$(0) + CHR$(59)
    f2$ = CHR$(0) + CHR$(60): f3$ = CHR$(0) + CHR$(61): f4$ = CHR$(0) + CHR$(62)
    F5$ = CHR$(0) + CHR$(63): f6$ = CHR$(0) + CHR$(64): f7$ = CHR$(0) + CHR$(65)
    F8$ = CHR$(0) + CHR$(66): F9$ = CHR$(0) + CHR$(67): F10$ = CHR$(0) + CHR$(68)
   
    Check4Save
    IF filemode = 1 THEN PropInit: GOTO main:

    GetNames
    PropInit
    ShortGame
main:
    playsounds 14
    ShowAll
    propcount
    PlayerInfo
    COLOR 14, 8: : LOCATE 22, 1:
    PRINT "F1-Help         F2-Title Deeds   F3-Change Calculator    F4-Unowned properties"
    PRINT "F5-Show board   F6-Dice Roller   F7-Eliminate players   ESC-Quit"

ST$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ09" + avail$ + f1$ + f2$ + f3$ + f4$ + F5$ + f6$ + f7$
k$ = getkey$(ST$)
IF k$ = CHR$(27) THEN ExitTasks
IF k$ = f1$ THEN help: GOTO main:
IF k$ = f2$ THEN TitleDeeds: GOTO main:
IF k$ = f3$ THEN Change: GOTO main:
IF k$ = f4$ THEN propsforplayer 9: GOTO main:
IF k$ = F5$ THEN fi$ = "graphics\board.mdf": SHELL "read graphics\board.mdf": GOTO main:
IF k$ = f6$ THEN diceroll: GOTO main:
IF k$ = f7$ THEN
    bankrupt
    IF eog = 1 THEN CLEAR : GOTO begin:
    GOTO main:
END IF
IF INSTR(avail$, k$) THEN
    propsforplayer VAL(k$):
    GOTO main:
END IF

IF INSTR(ST$, k$) > 0 THEN
    pn = INSTR(ST$, k$): m$ = ""
    IF mortgage(pn) = 0 AND owned(pn) <> 9 THEN m$ = "M"
    IF mortgage(pn) = 1 THEN m$ = "U"
    LOCATE 14, 55: COLOR 14: PRINT "Who owns"
    LOCATE 15, 55: PRINT prop$(pn); "?"
    LOCATE 17, 55: PRINT "Press the player's NUMBER,"
    LOCATE 18, 55:
    IF owned(pn) <> 9 THEN
        IF m$ = "M" THEN PRINT "M to mortgage, or" ELSE PRINT "U to unmortgage, or"
    END IF
    LOCATE CSRLIN, 55: PRINT "D to see its title deed"
    
    pfp$ = getkey$(avail$ + "D" + m$)
    IF pfp$ = CHR$(27) THEN GOTO main:
    IF pfp$ = "M" THEN mortgage(pn) = 1: GOTO main:
    IF pfp$ = "U" THEN mortgage(pn) = 0: GOTO main:
    IF pfp$ = "D" THEN
        SELECT CASE pn
            CASE 1 TO 2: currentdeed = 1
            CASE 3 TO 5: currentdeed = 2
            CASE 6 TO 8: currentdeed = 3
            CASE 9 TO 11: currentdeed = 4
            CASE 12 TO 14: currentdeed = 5
            CASE 15 TO 16: currentdeed = 6
            CASE 17 TO 19: currentdeed = 7
            CASE 20 TO 22: currentdeed = 8
            CASE 23 TO 24: currentdeed = 9
            CASE 25 TO 28: currentdeed = 10
    END SELECT
    TitleDeeds
    GOTO main:
    END IF

    pfp = VAL(pfp$)
    owned(pn) = pfp: GOTO main:
END IF


DollarAmounts:
DATA 500, 100, 50, 20,10,5,1


errorhandler:
IF fec <> 1 THEN SOUND 1600, 4
SELECT CASE ERR
    CASE IS = 53:
    IF fec <> 1 THEN PRINT "FILE NOT FOUND OR NOT ACCESSABLE - "; fi$
    fileerror = 1
    IF fec = 1 THEN RESUME NEXT ELSE SYSTEM
    CASE IS = 61: PRINT "Disk Is full.  Delete unneeded files from the disk.": SYSTEM: RESUME NEXT
    CASE ELSE: PRINT : PRINT "ERROR"; ERR
END SELECT
SYSTEM

SUB bankrupt
    COLOR 9: CLS : center 2, "Eliminate a Player"

    COLOR 13: LOCATE 6, 1
    FOR P = 1 TO 8
        IF name$(P) <> "" THEN PRINT : PRINT "     "; P; "- "; name$(P)
    NEXT P
    PRINT : PRINT "      9 - Return to game"
    COLOR 15:
    PRINT : PRINT : PRINT "Press the number next to the player who is to be eliminated:"

    k$ = getkey$(avail$ + "9")
        IF k$ = CHR$(27) THEN EXIT SUB
    pe = VAL(k$)
        IF pe = 9 THEN EXIT SUB
son:
    CLS : COLOR 15: LOCATE 7, 1: PRINT "Are you SURE you want to remove"
             PRINT : PRINT name$(pe); " from the game?  (Press Y or N)"
snp:
    k$ = getkey$("yn")
        IF k$ = "Y" THEN name$(pe) = "": playercolor(pe) = 0: nop = nop - 1
        IF k$ = "N" THEN EXIT SUB
        IF k$ = CHR$(27) THEN EXIT SUB

        IF nop = 1 THEN
    DO UNTIL found$ <> ""
        IF name$(nop) <> "" THEN found$ = name$(nop)
        nop = nop + 1
    LOOP
    CLS : COLOR 15: center 11, ". . . AND THE WINNER IS . . ."
    COLOR playercolor(nop - 1): center 13, found$
        IF filemode <> 0 THEN KILL "monohelp.dat"
        COLOR 13: LOCATE 21, 1: PRINT "Play Again?  (Press Y or N)"
        k$ = getkey$("yn")
            IF k$ = CHR$(27) THEN playsounds 13: SYSTEM
            IF k$ = "Y" THEN eog = 1: EXIT SUB ELSE playsounds 13: SYSTEM
        END IF
END SUB

SUB Box (row%, Column%, BoxWidth%, Height%, BoxColor%, BoxCharacter%, BorderType%, BorderColor%)
    StartRow% = row%

    SELECT CASE BorderType%

'      no border

       CASE 0
          UpperLeft$ = CHR$(BoxCharacter%)
          UpperRight$ = CHR$(BoxCharacter%)
          LowerLeft$ = CHR$(BoxCharacter%)
          LowerRight$ = CHR$(BoxCharacter%)
          Vertical$ = CHR$(BoxCharacter%)
          Horizontal$ = CHR$(BoxCharacter%)

'      single border

       CASE 1
          UpperLeft$ = CHR$(218)
          UpperRight$ = CHR$(191)
          LowerLeft$ = CHR$(192)
          LowerRight$ = CHR$(217)
          Vertical$ = CHR$(179)
          Horizontal$ = CHR$(196)

'      double border

       CASE 2
          UpperLeft$ = CHR$(201)
          UpperRight$ = CHR$(187)
          LowerLeft$ = CHR$(200)
          LowerRight$ = CHR$(188)
          Vertical$ = CHR$(186)
          Horizontal$ = CHR$(205)

    END SELECT

    InnerWidth% = BoxWidth% - 2
    InnerHeight% = Height% - 2
    InnerFilling$ = STRING$(InnerWidth%, CHR$(BoxCharacter%))
    BoxTopBottom$ = STRING$(InnerWidth%, Horizontal$)

    COLOR BorderColor%, BoxColor%
    LOCATE StartRow%, Column%
    PRINT UpperLeft$ + BoxTopBottom$ + UpperRight$;
    StartRow% = StartRow% + 1

    FOR FillLoop% = 1 TO InnerHeight%
        LOCATE StartRow%, Column%
        PRINT Vertical$ + InnerFilling$ + Vertical$;
        StartRow% = StartRow% + 1
    NEXT FillLoop%

    LOCATE StartRow%, Column%
    PRINT LowerLeft$ + BoxTopBottom$ + LowerRight$;
END SUB

SUB center (row, text$)
    col = 41 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB Change
CBegin:
    COLOR 9: CLS
    LOCATE 3, 1: PRINT "How much money is owed?   >"; : COLOR 15
    owed = VAL(Limitinput$(6, "0123456789", CSRLIN, POS(0), ""))
        IF owed < 1 THEN EXIT SUB

    LOCATE 5, 1: COLOR 9: PRINT "How much money was given for payment?  >"; : COLOR 15
    paid = VAL(Limitinput$(6, "0123456789", CSRLIN, POS(0), ""))
        IF paid < 1 THEN EXIT SUB

    ch = paid - owed
    SELECT CASE ch
        CASE IS < 0: COLOR 10: PRINT : PRINT
                PRINT "Not enough money was given for payment - short by "; USING "$$###,###"; ABS(ch)
                PRINT : PRINT "Press any key...": SLEEP: GOTO CBegin:
        CASE IS = 0: COLOR 13: PRINT : PRINT
                PRINT "The play paid exactly the amount owed - NO change given"
                SLEEP: GOTO CBegin:
    END SELECT

    COLOR 15: LOCATE 8, 1: PRINT "The player gets "; USING "$$###,### back."; ch

    CashLeft = ch: RESTORE DollarAmounts:
    FOR i = 1 TO 7
        nob = 0: READ moneyamt

tol:
         IF CashLeft - moneyamt < 0 THEN
             GOTO eol:
        ELSE
            CashLeft = CashLeft - moneyamt: nob = nob + 1
            IF CashLeft - moneyamt >= 0 THEN GOTO tol:
        END IF

        PRINT I2a$(nob); " $"; I2a$(moneyamt); " bill";
            IF nob <> 1 THEN PRINT "s";
        PRINT "    ";
eol:
    NEXT i

    COLOR 14: LOCATE 11, 1: PRINT "Press any key...": SLEEP
END SUB

SUB Check4Save
    fec = 1: fi$ = "Monohelp.dat"
    OPEN "monohelp.dat" FOR INPUT AS #1
        IF fileerror = 1 THEN
            filemode = 0: : fec = 0: EXIT SUB
        ELSEIF fileerror = 0 THEN
            CLOSE #1: fec = 0: COLOR 10: CLS
            PRINT : PRINT "A previously saved game exists with the following details:"
            ShowFileDetails

            COLOR 15: PRINT : PRINT : PRINT "Would you like to continue where you left off? (Press Y or N)"
            k$ = getkey$("yn")
                IF k$ = "Y" THEN filemode = 1: LOAD: EXIT SUB ELSE filemode = 2: EXIT SUB
        END IF
END SUB

SUB ClearLines (lo, hi, start)
    FOR CC = lo TO hi: LOCATE CC, start: PRINT SPACE$(81 - start): NEXT CC
END SUB

FUNCTION colorchoices
    ald$ = "": ClearLines 12, 19, 65

    LOCATE 12, 65: COLOR 6: IF IsColorUsed(6) <> 1 THEN PRINT "A. Brown": ald$ = ald$ + "A"
    LOCATE 13, 65: COLOR 9: IF IsColorUsed(9) <> 1 THEN PRINT "B. Blue": ald$ = ald$ + "B"
    LOCATE 14, 65: COLOR 10: IF IsColorUsed(10) <> 1 THEN PRINT "C. Green": ald$ = ald$ + "C"
    LOCATE 15, 65: COLOR 11: IF IsColorUsed(11) <> 1 THEN PRINT "D. Cyan": ald$ = ald$ + "D"
    LOCATE 16, 65: COLOR 12: IF IsColorUsed(12) <> 1 THEN PRINT "E. Orange": ald$ = ald$ + "E"
    LOCATE 17, 65: COLOR 13: IF IsColorUsed(13) <> 1 THEN PRINT "F. Purple": ald$ = ald$ + "F"
    LOCATE 18, 65: COLOR 14: IF IsColorUsed(14) <> 1 THEN PRINT "G. Yellow": ald$ = ald$ + "G"
    LOCATE 19, 65: COLOR 15: IF IsColorUsed(15) <> 1 THEN PRINT "H. White": ald$ = ald$ + "H"

    ltr$ = getkey$(ald$)

    SELECT CASE ltr$
        CASE IS = "A": colorchoices = 6
        CASE IS = "B": colorchoices = 9
        CASE IS = "C": colorchoices = 10
        CASE IS = "D": colorchoices = 11
        CASE IS = "E": colorchoices = 12
        CASE IS = "F": colorchoices = 13
        CASE IS = "G": colorchoices = 14
        CASE IS = "H": colorchoices = 15
        CASE IS = CHR$(27): SYSTEM
    END SELECT

    ClearLines 12, 19, 65
END FUNCTION

SUB diceroll
    RANDOMIZE TIMER
TopRoll:
    COLOR 14, 9: CLS : d1 = INT(RND * 6) + 1: d2 = INT(RND * 6) + 1

show:
    tot = d1 + d2: COLOR 15, 0: Displaymdf 4, 2, "graphics\d" + I2a$(d1)
    Displaymdf 10, 2, "graphics\d" + I2a$(d2)
    dice(16) = dice(16) + 1: dice(tot) = dice(tot) + 1: DiceStats

    COLOR 14, 9: Displaymdf 18, 1, "graphics\dicegrid"
    LOCATE 20, 2, 0: PRINT USING "###³###³###³###³###³###³###³###³###³###³###³   ##³  ##³#,###"; dice(2); dice(3); dice(4); dice(5); dice(6); dice(7); dice(8); dice(9); dice(10); dice(11); dice(12); dice(13); dice(14); dice(16)
                             
    COLOR 14, 9: LOCATE 4, 31: PRINT "A"; d1; "and a"; d2; "was rolled."
                 LOCATE 6, 31: PRINT "The player moves"; tot; "spaces."
    IF d1 = d2 THEN playsounds 14

diceopts:
    COLOR 15, 9: LOCATE 10, 31: PRINT "Press  ENTER to roll again"
                 LOCATE 11, 31: PRINT "      ESCape to exit"
                 LOCATE 12, 31: PRINT "           R to repeat "
                 LOCATE 13, 31: PRINT "           S to turn speech o";
                     IF dspch = 1 THEN PRINT "ff " ELSE PRINT "n "

        IF dspch = 1 THEN playsounds tot

GDI:
    k$ = getkey$(CHR$(13) + CHR$(27) + " 23456789rs")
        nyn = VAL(k$): IF nyn <> 0 THEN GOTO cht:
        SELECT CASE k$
            CASE IS = CHR$(13), " ": GOTO TopRoll:
            CASE IS = CHR$(27): EXIT SUB
            CASE IS = "R": playsounds tot: GOTO GDI:
            CASE IS = "S": dspch = dspch + 1
                   IF dspch > 1 THEN dspch = 0
                   GOTO diceopts:
        END SELECT

cht:
    d1 = INT(RND * 6) + 1
        IF d1 >= nyn THEN GOTO cht:
    d2 = nyn - d1
        IF d2 > 6 THEN GOTO cht:
    CLS : GOTO show:
END SUB

SUB DiceStats
    most = 0: least = 9999: avg = 0: mostn = 0: leastn = 16: dice(13) = 0
    dice(14) = 0: dice(15) = 0
    FOR i = 2 TO 12
        IF dice(i) < least AND dice(i) <> 0 THEN least = dice(i): leastn = i
        IF dice(i) > most THEN most = dice(i): mostn = i
    NEXT i

    IF least = 9999 THEN least = 0: leastn = 0

    dice(13) = leastn: dice(14) = mostn: dice(15) = INT(avg * dice(16))
END SUB

SUB Displaymdf (row, col, file$)
    OPEN file$ + ".MDF" FOR INPUT AS #9
    DO UNTIL EOF(9)
        LINE INPUT #9, fl$
        LOCATE row, col: PRINT fl$
        row = row + 1
    LOOP
    CLOSE #9
END SUB

SUB ExitTasks

'file modes    0=no file exists, save with no prompt
'              1=file exists, and loaded, save with no prompt      
'              2=file exists, and NOT loaded, ask before overwriting

SELECT CASE filemode
    CASE 0, 1: save: playsounds 13: SYSTEM
    CASE IS = 2: COLOR 13: CLS
    PRINT : PRINT "A previously saved game exists with the following details:"
    ShowFileDetails

    COLOR 15: PRINT : PRINT : PRINT "Would you like to overwrite this saved game?  (Press Y or N)"
    k$ = getkey$("yn")
    SELECT CASE k$
        CASE IS = "Y": save: playsounds 13: SYSTEM
        CASE IS = "N": playsounds 13: SYSTEM
    END SELECT
END SELECT
END SUB

FUNCTION getkey$ (allowed$)
    allowesc = true: allowed$ = UCASE$(allowed$)
GTT:
    KY$ = UCASE$(INKEY$)
    IF KY$ <> "" AND INSTR(allowed$, KY$) > 0 THEN getkey$ = KY$: EXIT FUNCTION
    IF allowesc <> 0 AND KY$ = CHR$(27) THEN getkey$ = CHR$(27): EXIT FUNCTION  'Allow ESCape
GOTO GTT:
END FUNCTION

SUB GetNames
    WIDTH 80, 25: COLOR 9: CLS
    center 2, "Property Control": COLOR 14: center 3, "By Charles Martin"

    LOCATE 9, 1: COLOR 15: PRINT "How many players?  (2-8)?"
    nop = VAL(getkey$("23456789"))
    IF nop = 0 THEN SYSTEM


IF nop = 9 THEN
    name$(1) = "Charles": playercolor(1) = 15
    name$(2) = "Amanda": playercolor(2) = 13
    name$(3) = "Troy": playercolor(3) = 9
    nop = 3
    EXIT SUB
END IF

    COLOR 14
    FOR cp = 1 TO nop
TONIL:
        COLOR 14: LOCATE 11 + cp, 1
        PRINT "Name of player"; cp; "- ";
        name$(cp) = Limitinput$(12, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-' ", CSRLIN, POS(0), "")
        IF name$(cp) = CHR$(27) THEN ExitTasks
        IF LEN(name$(cp)) < 3 THEN ClearLines 11 + cp, 23, 1: GOTO TONIL:

        ClearLines 11 + cp, 11 + cp, 1: LOCATE 11 + cp: PRINT name$(cp); ", Choose a color by its letter:"
        playercolor(cp) = colorchoices
        ClearLines 11 + cp, 11 + cp, 1: LOCATE 11 + cp: COLOR playercolor(cp): PRINT "Player"; cp; "- "; name$(cp)
    NEXT cp
END SUB

SUB help
    ClearLines 22, 23, 1
    COLOR 15: LOCATE 22, 1: PRINT "F1-Program Help  F2-Official Monopoly Rules"

    k$ = getkey$(f1$ + f2$)
    SELECT CASE k$
        CASE IS = CHR$(27): EXIT SUB
        CASE IS = f1$: SHELL "read monohelp.txt": EXIT SUB
        CASE IS = f2$: SHELL "read Rules.txt": EXIT SUB
    END SELECT
END SUB

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

FUNCTION IsColorUsed (clr)
FOR i = 1 TO 8
        IF playercolor(i) = clr THEN IsColorUsed = true: EXIT FUNCTION
    NEXT i
    IsColorUsed = false
END FUNCTION

FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)

allowesc = true   'allow escape to be pushed during input

'---------
LOCATE row, col: PRINT et$; : CONTENTS$ = et$
lt$ = CHR$(0) + CHR$(75): rt$ = CHR$(0) + CHR$(77)
ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8) + lt$ + rt$
IF allowesc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27)
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
            IF allowesc = true THEN Limitinput$ = CHR$(27): EXIT FUNCTION
         CASE IS = lt$: IF TC > 0 THEN PRINT CHR$(29); : TC = TC - 1
         CASE IS = rt$: IF TC <= ALLOWEDCHARS THEN PRINT CHR$(28); : TC = TC + 1
         CASE ELSE:
         SELECT CASE TC
              CASE IS < ALLOWEDCHARS: PRINT CHAR$; : TC = TC + 1: CONTENTS$ = CONTENTS$ + CHAR$
              CASE ELSE: PLAY "o2 t120 l29B": GOTO tos:
         END SELECT
     END SELECT
LOOP


END FUNCTION

SUB LOAD
    ERASE owned, name$, playercolor
    OPEN "monohelp.dat" FOR INPUT AS #1
    INPUT #1, nop
    INPUT #1, playdate$
    FOR i = 1 TO 8: INPUT #1, name$(i): NEXT i
    FOR i = 1 TO 8: INPUT #1, playercolor(i): NEXT i
    FOR i = 1 TO 28: INPUT #1, owned(i): NEXT i
    FOR i = 1 TO 28: INPUT #1, mortgage(i): NEXT i
    CLOSE #1
END SUB

SUB PlayerInfo
    ln = 2: avail$ = "": ClearLines 2, 9, 55

    Box 1, 53, 27, nop + 3, 0, 0, 1, 15

    FOR i = 1 TO 9
        IF name$(i) <> "" THEN
            LOCATE ln, 55: COLOR playercolor(i): PRINT I2a$(i); ". ";
            PRINT name$(i); SPACE$(12 - LEN(name$(i))); USING "  ## pr."; nopo(i)
            ln = ln + 1
        END IF
    NEXT i

    FOR pl = 1 TO 8
        IF name$(pl) <> "" THEN avail$ = avail$ + I2a$(pl)
    NEXT pl
END SUB

SUB playsounds (stp)

SELECT CASE stp
    CASE 2 TO 12: SHELL "play sounds\" + I2a$(stp) + " /q"
    CASE 13: SHELL "play sounds\adios /q"
    CASE i4: SHELL "play sounds\doubles /q"
END SELECT

END SUB

SUB propcount
    ERASE nopo, maxraise, maxpay
    FOR i = 1 TO 28
        nopo(owned(i)) = nopo(owned(i)) + 1
        IF mortgage(i) = 1 THEN
            maxpay(owned(i)) = maxpay(owned(i)) + (price(i) / 2) + (price(i) / 10)
        ELSE
            maxraise(owned(i)) = maxraise(owned(i)) + ((price(i) / 2))
        END IF
    NEXT i
END SUB

SUB PropInit
    name$(9) = "UNOWNED/BANK": playercolor(9) = 7

    prop$(1) = "Mediterranean Ave.": price(1) = 60: propcolor(1) = 5
    prop$(2) = "Baltic Ave.": price(2) = 60: propcolor(2) = 5

    prop$(3) = "Oriental Ave.": price(3) = 100: propcolor(3) = 11
    prop$(4) = "Vermont Ave.": price(4) = 100: propcolor(4) = 11
    prop$(5) = "Connecticut Ave.": price(5) = 120: propcolor(5) = 11

    prop$(6) = "St. Charles Place": price(6) = 140: propcolor(6) = 13
    prop$(7) = "States Ave.": price(7) = 140: propcolor(7) = 13
    prop$(8) = "Virginia Ave.": price(8) = 160: propcolor(8) = 13

    prop$(9) = "St. James Place": price(9) = 180: propcolor(9) = 12
    prop$(10) = "Tenessee Ave.": price(10) = 180: propcolor(10) = 12
    prop$(11) = "New York Ave.": price(11) = 200: propcolor(11) = 12

    prop$(12) = "Kentucky Ave.": price(12) = 220: propcolor(12) = 4
    prop$(13) = "Indiana Ave.": price(13) = 220: propcolor(13) = 4
    prop$(14) = "Illinois Ave.": price(14) = 240: propcolor(14) = 4

    prop$(15) = "Electric Company": price(15) = 150: propcolor(15) = 7
    prop$(16) = "Water works": price(16) = 150: propcolor(16) = 7

    prop$(17) = "Atlantic Ave.": price(17) = 260: propcolor(17) = 14
    prop$(18) = "Ventnor Ave.": price(18) = 260: propcolor(18) = 14
    prop$(19) = "Marvin Gardens": price(19) = 280: propcolor(19) = 14
                             
    prop$(20) = "Pacific Ave.": price(20) = 300: propcolor(20) = 2
    prop$(21) = "No. Carolina Ave.": price(21) = 300: propcolor(21) = 2
    prop$(22) = "Pensylvania Ave.": price(22) = 320: propcolor(22) = 2

    prop$(23) = "Park Place": price(23) = 350: propcolor(23) = 9
    prop$(24) = "Boardwalk": price(24) = 400: propcolor(24) = 9

    prop$(25) = "Reading Railroad": price(25) = 200: propcolor(25) = 15
    prop$(26) = "Pensylvania Railroad": price(26) = 200: propcolor(26) = 15
    prop$(27) = "B & O Railroad": price(27) = 200: propcolor(27) = 15
    prop$(28) = "Short Line Railroad": price(28) = 200: propcolor(28) = 15

    IF filemode <> 1 THEN FOR i = 1 TO 28: owned(i) = 9: NEXT i

    Group$(1) = "Mediterranean & Baltic"
    Group$(2) = "Oriental, Vermont, Connecticut"
    Group$(3) = "St. Charles Pl., States, Virginia"
    Group$(4) = "St. James Pl., Tenessee, New York"
    Group$(5) = "Kentucky, Indiana, Illinois"
    Group$(6) = "Electric Company & Water Works"
    Group$(7) = "Atlantic, Ventnor, Marven Gardens"
    Group$(8) = "Pacific, North Carolina, Pensylvania Ave."
    Group$(9) = "Park Place & BoardWalk"
    Group$(10) = "The RailRoads"

    currentdeed = 1
END SUB

SUB propsforplayer (ptd)
    IF nopo(ptd) = 0 THEN EXIT SUB
    COLOR playercolor(ptd): CLS
    IF RIGHT$(name$(ptd), 1) = "s" THEN center 2, name$(ptd) + "' Properties..." ELSE center 2, name$(ptd) + "'s Properties..."

    ln = 6: col = 1

    FOR i = 1 TO 28
        LOCATE ln, col: COLOR propcolor(i)
        IF owned(i) = ptd THEN
            IF mortgage(i) = 1 THEN COLOR , mortcolor ELSE COLOR , 8
            PRINT prop$(i): ln = ln + 1
        END IF

    IF ln > 19 THEN ln = 6: col = 27
    NEXT i


    COLOR 15, 8: LOCATE 21, 1: PRINT "       # of properties:"; USING " #,###"; nopo(ptd)
                            PRINT "  Total mortgage value:"; USING "$#,###"; maxraise(ptd)
     IF maxpay(ptd) <> 0 THEN LOCATE 23, 1: PRINT "Total unmortgage value:"; USING "$#,###"; maxpay(ptd)
    COLOR 10: LOCATE 23, 65, 0: PRINT "Press any key...": SLEEP
END SUB

SUB save
    OPEN "Monohelp.dat" FOR OUTPUT AS #1: fi$ = "MONOHELP.DAT"
    ' # of players, play date, player names, player colors, owned property values, mortgaged values
    WRITE #1, nop, DATE$
    FOR i = 1 TO 8: WRITE #1, name$(i): NEXT i
    FOR i = 1 TO 8: WRITE #1, playercolor(i): NEXT i
    FOR i = 1 TO 28: WRITE #1, owned(i): NEXT i
    FOR i = 1 TO 28: WRITE #1, mortgage(i): NEXT i
    CLOSE #1
END SUB

SUB ShortGame

    CLS
    COLOR 15, 8: LOCATE 3, 1: PRINT "Do you want to play a short game?  (Press Y or N)"
    PRINT
    PRINT "In a 'short game,' Each player gets 2 random properties from the pack of"
    PRINT "property cards.  Each player pays (the price on the board) for the"
    PRINT "properties that they receive."
    PRINT
    COLOR 9, 8: PRINT "All normal Monopoly rules apply to a 'short game' except:"
    PRINT "     - You only need 3 houses on each property to build a hotel."
    PRINT "     - When selling a hotel, the player selling gets only 3 houses back."

    k$ = getkey$("YN")
        IF k$ = CHR$(27) THEN SYSTEM
        IF k$ = "N" THEN EXIT SUB

    RANDOMIZE TIMER: CLS : ln = 2: col = 1: ERASE maxraise
    FOR i = 1 TO nop
        FOR L = 1 TO 2
            COLOR playercolor(i): LOCATE ln, col: PRINT "Properties for "; name$(i)
Pag:
            pr = INT(RND * 28) + 1
            IF owned(pr) = 9 THEN
                COLOR propcolor(pr): LOCATE ln + L, col: PRINT prop$(pr)
                maxraise(i) = maxraise(i) + price(pr): owned(pr) = i
            ELSE
                GOTO Pag:
            END IF
        NEXT L
        COLOR playercolor(i): LOCATE ln + 3, col: PRINT name$(i); " pays $"; I2a$(maxraise(i))
        ln = ln + 5
        IF ln >= 22 THEN ln = 2: col = 41
    NEXT i
    COLOR 10: LOCATE 23, 65: PRINT "Press any key...": SLEEP
END SUB

SUB ShowAll
    COLOR , 8: CLS : DO UNTIL INKEY$ = "": LOOP
    ST$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ09"
    FOR i = 1 TO 14
        ltr$ = MID$(ST$, i, 1): LOCATE i + 5, 1:
        IF owned(i) = 9 THEN COLOR 7 ELSE COLOR playercolor(owned(i))
        IF mortgage(i) = 1 THEN COLOR , mortcolor ELSE COLOR , 8
        PRINT ltr$; ". "; prop$(i)
    NEXT i

    FOR i = 15 TO 28
        ltr$ = MID$(ST$, i, 1): LOCATE i - 9, 27
        IF owned(i) = 9 THEN COLOR 7 ELSE COLOR playercolor(owned(i))
        IF mortgage(i) = 1 THEN COLOR , mortcolor ELSE COLOR , 8
        PRINT ltr$; ". "; prop$(i)
    NEXT i
    COLOR , 8
END SUB

SUB ShowFileDetails
    ' # of players, date, player names, player colors, owned property values
    OPEN "monohelp.dat" FOR INPUT AS #1
    INPUT #1, nopf
    COLOR 9: PRINT "# of players: "; nopf;
    INPUT #1, pd$: PRINT "      PLAY DATE:"; pd$
    PRINT "NAMES:";
    FOR i = 1 TO 8
        INPUT #1, n$
        IF i = 5 THEN PRINT : PRINT "        ";
        PRINT n$;
        IF i <> nopf THEN PRINT "  ";
    NEXT i
    CLOSE #1
END SUB

SUB TitleDeeds
    lt$ = CHR$(0) + CHR$(75): rt$ = CHR$(0) + CHR$(77): esc$ = CHR$(27)

displaycurrent:
    IF currentdeed > 10 THEN currentdeed = 1
    IF currentdeed < 1 THEN currentdeed = 10

    SELECT CASE currentdeed
        CASE IS = 1: fi$ = "deeds\dpurple"
        CASE IS = 2: fi$ = "deeds\lblue"
        CASE IS = 3: fi$ = "deeds\lpurple"
        CASE IS = 4: fi$ = "deeds\orange"
        CASE IS = 5: fi$ = "deeds\red"
        CASE IS = 6: fi$ = "deeds\utility"
        CASE IS = 7: fi$ = "deeds\yellow"
        CASE IS = 8: fi$ = "deeds\green"
        CASE IS = 9: fi$ = "deeds\blue"
        CASE IS = 10: fi$ = "deeds\Railroad"
    END SELECT

    COLOR 15: CLS : Displaymdf 1, 1, fi$: COLOR 14
    COLOR 9: LOCATE 22, 1: PRINT "ÄÄÄPREVIOUS": COLOR 14: LOCATE 23, 1
    IF currentdeed - 1 <> 0 THEN
        PRINT Group$(currentdeed - 1)
    ELSE
        PRINT Group$(10)
    END IF

    COLOR 9: LOCATE 22, 72: PRINT "NEXTÄÄÄ"; CHR$(16): COLOR 14
    IF currentdeed + 1 <> 11 THEN
        LOCATE 23, 80 - LEN(Group$(currentdeed + 1)), 0
        PRINT Group$(currentdeed + 1)
    ELSE
        LOCATE 23, 80 - LEN(Group$(1)):
        PRINT Group$(1)
    END IF

GK:
    k$ = getkey$(lt$ + rt$ + esc$ + " ")
    SELECT CASE k$
        CASE IS = lt$: currentdeed = currentdeed - 1: GOTO displaycurrent:
        CASE IS = rt$: currentdeed = currentdeed + 1: GOTO displaycurrent:
        CASE IS = " ": currentdeed = currentdeed + 1: GOTO displaycurrent:
        CASE IS = esc$: EXIT SUB
    END SELECT
END SUB

