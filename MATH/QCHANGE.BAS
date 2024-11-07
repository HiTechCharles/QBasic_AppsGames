DECLARE SUB Center (row!, text$)     'Centers text on a given line
DECLARE SUB ClearBoard ()            'Clear keyboard buffer
DECLARE FUNCTION FormatString$ ()    '
DECLARE SUB GetAmounts ()            'Get amounts owed, and paid
DECLARE FUNCTION I2a$ (h)            'Convert numbers into string variables
DECLARE FUNCTION Limitinput$ (ALLOWEDCHARS, ALLOWEDCHARS$, row, col, et$)  'Take input from the user
DECLARE SUB PressAKey ()             'Displays a message and waits for a key to be pressed
DECLARE FUNCTION ReRun ()         'Ask the user to rerun the program, or quit
DECLARE SUB ShowResults ()           'Show the bills/coins needed to make change
DECLARE FUNCTION TakeOut (Value!, Unit!)
DECLARE FUNCTION ValidateChange! ()  'Checks for exact change, and not enough money given

COMMON SHARED TotalSales!, CashGiven!, change!, DoneScanning
ON ERROR GOTO ErrorHandler:

begin:
    ClearBoard
    GetAmounts
    IF ValidateChange = -1 THEN GOTO begin:
    ShowResults
    IF ReRun = 1 THEN CLEAR : GOTO begin:  ELSE SYSTEM


 DATA $100 bill,  $100 bills,   100.00
 DATA $50 bill,   $50 bills,     50.00
 DATA $20 bill,   $20 bills,     20.00
 DATA $10 bill,   $10 bills,     10.00
 DATA $5 bill,    $5 bills,       5.00
'DATA $2 bill,    $2 bills,       2.00
 DATA $1 bill,    $1 bills,       1.00
'DATA 50› piece,  50› pieces,     0.50
 DATA Quarter,    Quarters,       0.25
 DATA Dime,       Dimes,          0.10
 DATA Nickel,     Nickels,        0.05
 DATA Penny,      Pennies,        0.01
 DATA END,        END,            0.00


ErrorHandler:
    SELECT CASE ERR
        CASE 4
            DoneScanning = 1: RESUME NEXT
        CASE ELSE:
            PRINT "ERROR #"; ERR; "occured.": SYSTEM
    END SELECT

SUB Center (row, text$)
    col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB ClearBoard
    DO UNTIL INKEY$ = "": LOOP
END SUB

FUNCTION FormatString$
    SELECT CASE CashGiven!    'Select format string based on cash paid
        CASE IS < 100: fmt$ = "##"     '<100, 2-digit #
        CASE IS < 1000: fmt$ = "###"   '<1000, 3-digit #
        CASE IS < 10000: fmt$ = "#,###"
        CASE IS < 100000: fmt$ = "##,###"
        CASE IS < 1000000: fmt$ = "###,###,###"
        CASE IS < 10000000: fmt$ = "#,###,###"
        CASE IS < 100000000: fmt$ = "##,###,###"
        CASE ELSE: fmt$ = "###,###,###"
    END SELECT
    fmt$ = fmt$ + ".##"
    FormatString$ = fmt$
END FUNCTION

3 SUB GetAmounts
    WIDTH 40, 25: COLOR 9: CLS : Center 2, "Quick Change"
                      COLOR 11:  Center 3, "By Charles Martin"

    LOCATE 6, 1, 1: COLOR 13
    PRINT "Give the amount owed, and the customer's"
    PRINT "payment.  the program will then tell you"
    PRINT "how much Change! to give, including"
    PRINT "the bills and coins to use."

BOG:
    LOCATE 12, 1: COLOR 11: PRINT "How much money does the customer owe?"
    PRINT "Press ESCape to EXIT the program:"
    PRINT "     $";
    COLOR 13: amt$ = Limitinput$(12, "0123456789.e", CSRLIN, POS(0), et$)
    TotalSales! = VAL(amt$)
    IF amt$ = CHR$(27) THEN SYSTEM
    IF TotalSales! = 0 THEN SYSTEM

PaidAmt:
    VIEW PRINT 16 TO 23
    COLOR 11: LOCATE 16, 1: PRINT "How much money did the customer pay?"
    PRINT "     $"; : COLOR 13: amt$ = Limitinput$(12, "0123456789.e", CSRLIN, POS(0), et$)
    CashGiven! = VAL(amt$)
    IF amt$ = CHR$(27) THEN SYSTEM
    IF CashGiven! < 1 THEN SOUND 785, 1: CLS : GOTO PaidAmt:
    VIEW PRINT
END SUB

FUNCTION I2a$ (h)
I2a$ = LTRIM$(RTRIM$(STR$(h)))
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

SUB PressAKey
    COLOR 26: LOCATE 23, 26: PRINT "Press a key...": SLEEP
END SUB

FUNCTION ReRun
    COLOR 9:
    LOCATE 22, 20, 0: PRINT "Press ENTER to rerun,"
    LOCATE 23, 23: PRINT "or ESCAPE to quit:"
GAK:
    k$ = UCASE$(INKEY$)
        IF k$ = CHR$(13) OR k$ = " " THEN ReRun = 1: EXIT FUNCTION
        IF k$ = CHR$(27) THEN ReRun = -1: EXIT FUNCTION
    GOTO GAK:
END FUNCTION

SUB ShowResults

    fmt$ = FormatString$
    COLOR 14:  CLS : LOCATE 2, 1
    PRINT "  OWED:  $"; USING fmt$; TotalSales!
    PRINT "  PAID:  $"; USING fmt$; CashGiven!
    PRINT "CHANGE:  $"; USING fmt$; change!

    COLOR 15: LOCATE 8, 1:  RESTORE
    DO UNTIL DoneScanning = 1
        READ curs$, curp$, amount!
        IF curs$ = "END" THEN EXIT DO
        AOCU = TakeOut(change!, amount!)
        
        SELECT CASE AOCU
            CASE 0: GOTO EOL:
            CASE 1: PRINT USING "     ### "; AOCU; : PRINT curs$
            CASE ELSE: PRINT USING "     ### "; AOCU; : PRINT curp$
        END SELECT
EOL:
    LOOP
END SUB

FUNCTION TakeOut (Value!, Unit!)
    TKO = 0
    DO UNTIL Unit! > Value!
        TKO = TKO + 1
        Value! = Value! - Unit!
    LOOP
    TakeOut = TKO
END FUNCTION

FUNCTION ValidateChange
    change! = CashGiven! - TotalSales!
    
    SELECT CASE change!
        CASE IS = 0
            COLOR 12: Center 20, "Customer gave exact change."
            ValidateChange = -1:  PressAKey: EXIT FUNCTION
        CASE IS < 0
            COLOR 12: LOCATE 19, 1: PRINT "The customer's payment is less than"
                                    PRINT "the amount owed.  Make sure you get"
                                    PRINT "enough money from the customer."
            SOUND 390, 1: SOUND 0, 1: SOUND 390, 1: SOUND 0, 1: SOUND 260, 1: SOUND 0, 1: SOUND 130, 1
            ValidateChange = -1: PressAKey: EXIT FUNCTION
        END SELECT
    ValidateChange = 1
END FUNCTION

