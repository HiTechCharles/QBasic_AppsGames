DECLARE SUB DelConfirm ()
DECLARE SUB DisplayOptions ()
DECLARE SUB HiliteControl ()
DECLARE SUB LoadOptions ()
DECLARE SUB MCenter (row, text$)
DECLARE SUB MenuSetup ()

COMMON SHARED mtop, mbottom, mcol, MItems, mfilesel, MCurItem, mlongest
COMMON SHARED mf, mb, mhf, mhb
DIM SHARED Option$(100)

'MTop, MBottom      First and last lines of menu options can print
'Mcol               Horizontal collumn to center options
'MItems             # of items in the menu
'MFileSel           Is this menu for selecting a file name?
'MCurItem           Current item selected
'MLongest           Longest single option  (in characters)
'mf, mb             Foreground & background of options
'MHF, MHB           Hilited option colors

Start:
    LoadOptions
    MenuSetup
    MCurItem = 1:  CLS
    DisplayOptions
    HiliteControl
    
DATA Knight Rider, "Star Trek: TNG", Charles in Charge, Miami Vice, Magnum PI
DATA The A-Team, Seinfeld, Law & Order, CSI, NYPD Blue, The Brady Bunch
DATA I Love Lucy, The Waltons, GunSmoke,Lassie,END

SUB DelConfirm
END SUB

SUB DisplayOptions
    'SL         Screen line that shows the selected item
    'Up,down    # of options above, and below the center point

    sl = INT((mtop + mbottom) / 2)
    up = sl - mtop
    down = mbottom - sl
    pc = MCurItem - up
    
    FOR ml = mtop TO mbottom
        IF pc < 1 OR pc > MItems THEN MCenter ml, SPACE$(mlongest): GOTO sk:
        MCenter ml, SPACE$(mlongest)
        IF ml = sl THEN COLOR mhf, mhb ELSE COLOR mf, mb
        MCenter ml, Option$(pc)
sk:     pc = pc + 1: COLOR , 0
    NEXT ml
END SUB

SUB HiliteControl
    up$ = CHR$(0) + CHR$(72): dn$ = CHR$(0) + CHR$(80): lt$ = CHR$(0) + CHR$(75)
    rt$ = CHR$(0) + CHR$(77): enter$ = CHR$(13): escape$ = CHR$(27)
    delete$ = CHR$(0) + CHR$(83): home$ = CHR$(0) + CHR$(71)
    end$ = CHR$(0) + CHR$(79): pgup$ = CHR$(0) + CHR$(73): pgdn$ = CHR$(0) + CHR$(81)

gtk:
    K$ = UCASE$(INKEY$)
    SELECT CASE K$
        CASE home$: MCurItem = 1: GOTO ch:
        CASE end$: MCurItem = MItems: GOTO ch
        CASE pgup$: MCurItem = MCurItem - 10
            IF MCurItem < 11 THEN MCurItem = 1
            GOTO ch:
        CASE pgdn$: MCurItem = MCurItem + 10
            IF MCurItem > MItems THEN MCurItem = MItems
            GOTO ch:
        CASE IS = delete$: DelConfirm: GOTO gtk:
        CASE enter$: EXIT SUB
        CASE escape$: SYSTEM
        CASE up$, lt$: MCurItem = MCurItem - 1: GOTO ch:
        CASE dn$, rt$: MCurItem = MCurItem + 1: GOTO ch:
        CASE ELSE: GOTO gtk:
    END SELECT

ch:
    IF MCurItem < 1 THEN MCurItem = 1: GOTO gtk:
    IF MCurItem > MItems THEN MCurItem = MItems: GOTO gtk:
    CALL DisplayOptions: DO UNTIL INKEY$ = "": LOOP: GOTO gtk:
END SUB

SUB LoadOptions
    MItems = 1:  RESTORE
    DO UNTIL R$ = "END"
        READ R$
        Option$(MItems) = R$
        MItems = MItems + 1
    LOOP
    MItems = MItems - 2

END SUB

SUB MCenter (row, text$)
    col = mcol - (LEN(text$)) / 2: LOCATE row, col: PRINT text$
END SUB

SUB MenuSetup
    mtop = 2: mbottom = 22
    mcol = 20
    mlongest = 18
    mf = 14
    mhf = 15: mhb = 9
END SUB

