DECLARE SUB center (row, text$)
DECLARE SUB ClearBoard ()
DECLARE SUB ClearLines (top, btm, col)
DECLARE SUB DisplayOptions ()
DECLARE SUB EraseResults ()
DECLARE SUB ErrorSound ()
DECLARE FUNCTION FirstLetterNav (ltr$)
DECLARE SUB GetInput ()
DECLARE SUB HiliteControl ()
DECLARE FUNCTION I2a$ (h)
DECLARE SUB Intro ()
DECLARE FUNCTION IsAlpha! (ltr$)
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
DECLARE SUB MCenter (row, text$)
DECLARE SUB OtherRate ()
DECLARE SUB PrintResult ()
DECLARE SUB SelectState ()
DECLARE SUB Setupscreen ()
DECLARE SUB TaxData ()
DECLARE FUNCTION TaxToPay! (Rate!, amount!)

COMMON SHARED TaxRate!, NRP, SaleAmt!, TaxPaid!, Total!, state$, mhf, mhb
COMMON SHARED mtop, mbottom, mcol, MenuItems, MCurItem, mlongest, ors, mf, mb
DIM SHARED stateName$(45), abbr(45) AS STRING * 2, Rate(45) AS SINGLE

    TaxData
    Intro
    SelectState
    Setupscreen
    IF ors = 0 THEN COLOR 9: LOCATE 23, 1: PRINT "Using "; state$; "'s "; I2a$(TaxRate!); "% tax rate.": SLEEP 3
main:
    GetInput
    EraseResults
    TaxPaid! = TaxToPay!(TaxRate!, SaleAmt!)
    PrintResult
GOTO main



'------------------STATE DATA-----------------------------------------------
'    State name, Abbreviation, STATE tax rate
DATA Alabama,AL,4
DATA Arizona,AZ,5.6
DATA Arkansas,AR,6
DATA California,CA,7.25
DATA Colorado,CO,2.9
DATA Connecticut,CT,6
DATA Florida,FL,6
DATA Georgia,GA,4
DATA Idaho,ID,5
DATA Illinois,IL,6.25
DATA Indiana,IN,6
DATA Iowa,IA,5
DATA Kansas,KS,5.3
DATA Kentucky,KY,6
DATA Louisiana,LA,4
DATA Maine,ME,5
DATA Maryland,MD,5
DATA Massachusetts,MA,5
DATA Michigan,MI,6
DATA Minnesota,MN,6.5
DATA Mississippi,MS,7
DATA Missouri,MO,5
DATA Nebraska,NE,5.5
DATA Nevada,NV,6.5
DATA New Jersey, NJ, 7
DATA New Mexico, NM, 5
DATA New York, NY, 4
DATA North Carolina, NC, 4.5
DATA North Dakota, ND, 5
DATA Ohio,OH,5.5
DATA Oklahoma,OK,4.5
DATA Pennsylvania,PA,6
DATA Rhode Island, RI, 7
DATA South Carolina, SC, 5
DATA South Dakota, SD, 4
DATA Tennessee,TN,6
DATA Texas,TX,6.25
DATA Utah,UT,4.75
DATA Vermont,VT,6
DATA Virginia,VA,5
DATA Washington,WA,6.5
DATA West Virginia, WV, 6
DATA Wisconsin,WI,5
DATA Wyoming,WY,4
DATA END

SUB center (row, text$)
    col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB ClearBoard
    DO UNTIL INKEY$ = "": LOOP
END SUB

SUB ClearLines (top, btm, col)
    COLOR , 0
    FOR I = top TO btm
        LOCATE I, col: PRINT SPACE$((40 - col) + 1)
    NEXT I
END SUB

SUB DisplayOptions
    'SL         Screen line that shows the selected item
    'Up,down    # of options above, and below the center point

    sl = INT((mtop + mbottom) / 2)
    up = sl - mtop
    down = mbottom - sl
    pc = MCurItem - up

    FOR Ml = mtop TO mbottom
        IF pc < 1 OR pc > MenuItems THEN MCenter Ml, SPACE$(mlongest): GOTO sk:
        MCenter Ml, SPACE$(mlongest)
        IF Ml = sl THEN COLOR mhf, mhb ELSE COLOR mf, mb
        MCenter Ml, stateName$(pc)
sk:     pc = pc + 1: COLOR , 0: LOCATE , , 0
    NEXT Ml
END SUB

SUB EraseResults
    LOCATE 23, 1: PRINT SPACE$(40)
    IF NRP > 21 THEN
        VIEW PRINT 3 TO 21: CLS : VIEW PRINT
        NRP = 3
    END IF
END SUB

SUB ErrorSound
    IF INKEY$ <> "" THEN EXIT SUB
    SOUND 1357, 1: SOUND 0, .1
END SUB

FUNCTION FirstLetterNav (ltr$)

    startpoint = MCurItem
    IF startpoint = MenuItems THEN GOTO SrchFromTop:

SrchFromCursor:
    FOR srch = startpoint + 1 TO MenuItems
        sltr$ = LEFT$(stateName$(srch), 1)
        IF sltr$ = ltr$ THEN FirstLetterNav = srch: EXIT FUNCTION
    NEXT srch

    IF startpoint = 1 THEN GOTO NoMatch:

SrchFromTop:
    FOR srch = 1 TO startpoint
        sltr$ = LEFT$(stateName$(srch), 1)
        IF sltr$ = ltr$ THEN FirstLetterNav = srch: EXIT FUNCTION
    NEXT srch

NoMatch:
    FirstLetterNav = startpoint
    ErrorSound
END FUNCTION

SUB GetInput
HowMuch:
    LOCATE 23, 1: PRINT SPACE$(40):
    IF ors = 1 THEN
        COLOR 15: LOCATE 23, 35: PRINT I2a$(TaxRate!); "%"
    ELSE
        COLOR 15: LOCATE 23, 30: PRINT abbr(MCurItem); " @ "; I2a$(TaxRate!); "%"
    END IF

    COLOR 9: LOCATE 23, 1: PRINT "Amount of sale:  ";
    COLOR 14: PRINT "$";
    ae$ = Limitinput$(9, "0123456789.", 23, 19, et$)
    SaleAmt! = VAL(ae$)

    IF ae$ = CHR$(27) OR SaleAmt! = 0 THEN SYSTEM
    IF SaleAmt! < .01 OR SaleAmt! > 999999.99# THEN
        ErrorSound
        LOCATE 23, 1: PRINT SPACE$(40): GOTO HowMuch:
    END IF
END SUB

SUB HiliteControl
    up$ = CHR$(0) + CHR$(72): dn$ = CHR$(0) + CHR$(80): lt$ = CHR$(0) + CHR$(75)
    rt$ = CHR$(0) + CHR$(77): enter$ = CHR$(13): escape$ = CHR$(27)
    delete$ = CHR$(0) + CHR$(83): home$ = CHR$(0) + CHR$(71): f1$ = CHR$(0) + CHR$(59)
    end$ = CHR$(0) + CHR$(79): pgup$ = CHR$(0) + CHR$(73): pgdn$ = CHR$(0) + CHR$(81)

gtk:
    k$ = UCASE$(INKEY$)
    SELECT CASE k$
        CASE home$: MCurItem = 1: GOTO ch:
        CASE end$: MCurItem = MenuItems: GOTO ch
        CASE pgup$: MCurItem = MCurItem - 10
            IF MCurItem < 11 THEN MCurItem = 1
            GOTO ch:
        CASE pgdn$: MCurItem = MCurItem + 10
            IF MCurItem > MenuItems THEN MCurItem = MenuItems
            GOTO ch:
        CASE enter$: EXIT SUB
        CASE escape$: SYSTEM
        CASE up$, lt$: MCurItem = MCurItem - 1: GOTO ch:
        CASE dn$, rt$: MCurItem = MCurItem + 1: GOTO ch:
        CASE "A" TO "Z"
            MCurItem = FirstLetterNav(k$)
            GOTO ch:
        CASE f1$: OtherRate:
            IF TaxRate! = 0 THEN
                ClearLines 12, 14, 20
                GOTO gtk:
            ELSE
                MCurItem = 45: EXIT SUB
            END IF
        CASE ELSE: GOTO gtk:
    END SELECT

ch:
    IF MCurItem < 1 THEN MCurItem = 1: ErrorSound: GOTO gtk:
    IF MCurItem > MenuItems THEN MCurItem = MenuItems: ErrorSound: GOTO gtk:
    CALL DisplayOptions: ClearBoard: GOTO gtk:
END SUB

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB Intro
   WIDTH 40, 25: COLOR 9: CLS
              center 2, "TaxFax"
              center 3, "Calculate state sales tax for a sale"
    COLOR 14: center 4, "By Charles Martin"
    COLOR 11: center 12, "State sales tax rates last updated:"
              center 13, "August 17, 2006  (WWW.wikipedia.org)"
    COLOR 10: center 22, "ESCape will exit this program"
    COLOR 26: LOCATE 23, 9: PRINT "Press a key to continue..."
    SLEEP: ClearBoard
END SUB

FUNCTION IsAlpha (ltr$)
    IF INSTR("ABCDEFGHIJKLMNOPQRSTUVWXYZ", ltr$) > 0 THEN
        IsAlpha = 1
    ELSE
        IsAlpha = -1
    END IF
END FUNCTION

FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)
    allowesc = 1   'allow escape to be pushed during input

    '---------
    IF UCASE$(ALLOWEDCHARS$) = "ALL" OR ALLOWEDCHARS$ = "" THEN ALLOWEDCHARS$ = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+`~[]{};:'" + CHR$(34) + ",<.>/?\| "
    LOCATE row, col: PRINT et$; : CONTENTS$ = et$
    lt$ = CHR$(0) + CHR$(75): rt$ = CHR$(0) + CHR$(77)
    ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(13) + CHR$(8)
    IF allowesc <> 0 THEN ALLOWEDCHARS$ = ALLOWEDCHARS$ + CHR$(27) + lt$ + rt$
    TC = LEN(et$): CHAR$ = ""
    ClearBoard
    DO
tos:    DO
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

SUB MCenter (row, text$)
    col = mcol - (LEN(text$)) / 2: LOCATE row, col: PRINT text$
END SUB

SUB OtherRate
    COLOR 14, 9: LOCATE 12, 20: PRINT "Type in a rate, and "
                 LOCATE 13, 20: PRINT "Press ENTER.  ESCape"
                 LOCATE 14, 20: PRINT "to cancel:  >"
                LOCATE 14, 33: PRINT SPACE$(5); "% "
    ae$ = Limitinput$(5, "0123456789.", 14, 33, et$)
    TaxRate! = VAL(ae$)

    IF ae$ = CHR$(27) OR TaxRate! = 0 THEN EXIT SUB
    IF TaxRate! < .01 OR TaxRate! > 99.99 THEN
        ErrorSound
    END IF
    ors = 1: COLOR , 0
END SUB

SUB PrintResult
    fmt$ = "$###,###.##   ##,###.##   ###,###.## "
    LOCATE NRP, 1: PRINT USING fmt$; SaleAmt!; TaxPaid!; Total!
    NRP = NRP + 1
END SUB

SUB SelectState
    mtop = 2: mbottom = 23: ors = 0
    mcol = 10:  mlongest = 18
    mf = 14:  mhf = 15: mhb = 9
    MCurItem = 1: COLOR 13, 0: CLS
    LOCATE 2, 20: PRINT "Choose a state with"
    LOCATE 3, 20: PRINT "the arrow keys, press"
    LOCATE 4, 20: PRINT "ENTER to continue."
    LOCATE 6, 20: PRINT "To specify your own"
    LOCATE 7, 20: PRINT "tax rate, press F1"
    
    DisplayOptions
    HiliteControl

    IF ors = 0 THEN
        state$ = stateName$(MCurItem)
        TaxRate! = Rate(MCurItem)
    END IF
END SUB

SUB Setupscreen
    CLS
    COLOR 13: PRINT "     Amount   Sales Tax        Total!"
    COLOR 10: PRINT "     컴컴컴   컴컴컴컴�        컴컴�"
    COLOR 15: LOCATE 22: PRINT STRING$(40, 205)
    NRP = 3
END SUB

SUB TaxData
    ERASE stateName$, abbr, Rate
    RESTORE: sel = 0

    DO
        sel = sel + 1
        READ stateName$(sel)
            IF stateName$(sel) = "END" THEN EXIT DO
        READ abbr(sel)
        READ Rate(sel)
        MenuItems = MenuItems + 1
    LOOP
END SUB

FUNCTION TaxToPay (Rate, amount)
    STP = amount * (Rate / 100)
    TaxToPay = STP
    Total! = amount + STP
END FUNCTION

