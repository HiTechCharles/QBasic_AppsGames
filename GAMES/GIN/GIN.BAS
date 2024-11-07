DECLARE SUB carddrawn (SOC)
DECLARE SUB center (row, text$)
DECLARE SUB clearcard (spot)
DECLARE SUB Deal ()
DECLARE FUNCTION FindCard (Va, pl)
DECLARE FUNCTION GetKey$ (allowed$)
DECLARE SUB HiLo (fc, Sc)
DECLARE FUNCTION I2a$ (h)
DECLARE SUB LoadFiles ()
DECLARE SUB menu ()
DECLARE SUB nextcard ()
DECLARE SUB Options ()
DECLARE SUB PlayGame ()
DECLARE SUB plotcard (spot, crd$)
DECLARE SUB RightJustify (row, col, text$)
DECLARE FUNCTION SameSuit (fc$, Sc$)
DECLARE SUB SetupScreen ()
DECLARE SUB ShowCPUCards ()
DECLARE SUB ShowPlayerCards ()
DECLARE SUB Shuffle ()          'Shuffles the cards
DECLARE SUB sort (sortarr$(), lower, upper)

CONST false = -1, TRUE = 1, Pi! = 3.14159266#
COMMON SHARED cardsleft, cv, cmsg$, NumDecks, card$, HiCard, drc$, drv$, GinBonus, points, fileerror, Knocking
COMMON SHARED LoCard, cardrow, cardcol, playerdeals, gamelimit, div$, dic$, hand, SI, UndBonus, fec, oklahoma

TYPE StatPack
      name AS STRING * 12
      Wins AS INTEGER
    Losses AS INTEGER
     Draws AS INTEGER
  HandsWon AS INTEGER
 HandsLost AS INTEGER
    PtsFor AS INTEGER
PtsAgainst AS INTEGER
END TYPE

DIM SHARED phand$(10, 2), chand$(10, 2), Stat AS StatPack
DIM SHARED deck(52), score(2), name$(2), HandsWon(2), hc(13), deadwood(2)

'H D S C

'--Variables---
'GameLimit      # of points to play to
'OklaHoma       =1 if playing OklaHoma Gin
'CardRow        Screen row on which the next plotted card will go
'CardCol        Screen collumn on which the next plotted card will go
'Card$         Short form of card, such as '6' or 'K'
'CardsLeft     Number of cards left
'CV            Number of the last card picked  2-10  11=J 12=Q  13=K  1=A
'CMSG$         The card's number and suit in words, such as 'ACE OF CLUBS'
'NumDecks      Number of decks of cards needed
'Suit$         card's suit, such as "" or'"
'TotalCards    Number of total cards  (determined by NumDecks*52)
'PlayerDeals   =1 if the player is to deal the next hand
'hand          # of hands played + 1
'dic$, div$    Discard pile card, discard plie value  (1-13)
'drc$, drv$    Card picked up from either draw pile or discard -- Card & value
'Points        amount of points the winner of the hand will get
'GinBonus      amount gained for going "GIN"  (default=25
'UndBonus      amount gained for undercutting  (having less than your opp. when opp. knocks)
'Knocking      =1 if knocking without GIN is allowed  if not allowed, you must always have GIN!

'------ARRAYS------
'Phand$(10, 2)  Player's cards
'CHand$(10, 2   Computer's cards
'Deck(52)       Keeps track of which cards are used
'Score(2)       keeps track of the score for both players
'Names$(2)      Player Names
'deadwood(2)    Points left in each player's hand

NewGame:
    CLEAR : playerdeals = INT(RND * 2):  NumDecks = 1
    IF playerdeals = 1 THEN playerdeals = 0 ELSE playerdeals = 1
    TotalCards = INT(NumDecks * 52): cardsleft = TotalCards

     WIDTH 40, 25: COLOR 9: CLS
     LoadFiles
     menu
     SYSTEM

errorhandler:
IF fec <> 1 THEN SOUND 1600, 4
SELECT CASE ERR
    CASE IS = 53:
    IF fec <> 1 THEN PRINT "FILE NOT FOUND OR NOT ACCESSABLE - "; FI$
    fileerror = 1
    IF fec = 1 THEN RESUME NEXT ELSE SYSTEM
    CASE IS = 61: PRINT "Disk Is full.  Delete unneeded files from the disk.": SYSTEM: RESUME NEXT
    CASE ELSE: PRINT : PRINT "ERROR"; ERR
END SELECT

SUB carddrawn (SOC)

IF SOC = 1 THEN
    COLOR 9: LOCATE 14, 15: PRINT "CARD":  LOCATE 15, 15: PRINT "DRAWN"
    COLOR 7, 8
    LOCATE 13, 11: PRINT "ÚÄÄ¿"
    LOCATE 14, 11: PRINT "³  ³"
    LOCATE 15, 11: PRINT "³  ³"
    LOCATE 16, 11: PRINT "ÀÄÄÙ"
    COLOR 15: LOCATE 21, 1: PRINT "  1   2   3   4   5   6   7   8   9   0"
ELSE
    FOR I = 13 TO 16
        LOCATE I, 11: PRINT SPACE$(9)
    NEXT I
    LOCATE 21, 1: PRINT SPACE$(40)
END IF

END SUB

SUB center (row, text$)
    col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB clearcard (spot)
    Sta = 14: card = 18
     SELECT CASE spot
        CASE IS = 11: cardrow = Sta: cardcol = 4
        CASE IS = 12: cardrow = Sta: cardcol = 12
        CASE IS = 13: cardrow = Sta: cardcol = 28
        CASE IS = 14: cardrow = Sta: cardcol = 37
     END SELECT
     
    LOCATE cardrow, cardcol: COLOR 0, 0: PRINT "  "
    LOCATE cardrow + 1, cardcol: PRINT "  "
END SUB

SUB Deal
    SELECT CASE playerdeals
    CASE IS = 0
        FOR pl = 1 TO 10
            nextcard
            phand$(pl, 1) = I2a$(cv)
            phand$(pl, 2) = card$

            nextcard
            chand$(pl, 1) = I2a$(cv)
            chand$(pl, 2) = card$
        NEXT pl
    CASE IS = 1
        FOR pl = 1 TO 10
            nextcard
            chand$(pl, 1) = I2a$(cv)
            chand$(pl, 2) = card$

            nextcard
            phand$(pl, 1) = I2a$(cv)
            phand$(pl, 2) = card$
        NEXT pl
END SELECT

    nextcard
    div$ = I2a$(cv): dic$ = card$
END SUB

FUNCTION FindCard (Va, pl)
    FOR J = 10 TO 1 STEP -1
        IF phand$(J, 1) = I2a$(Va) THEN FindCard = J: EXIT FUNCTION
        'IF pl = 2 AND chand$(j, 1) = I2a$(Va) THEN FindCard = j: EXIT FUNCTION
    NEXT J
END FUNCTION

FUNCTION GetKey$ (allowed$)
allowesc = 1: allowed$ = UCASE$(allowed$)
GTT:
    KY$ = UCASE$(INKEY$)
             IF KY$ <> "" AND INSTR(allowed$, KY$) > 0 THEN GetKey$ = KY$: EXIT FUNCTION
    IF allowesc <> 0 AND KY$ = CHR$(27) THEN GetKey$ = CHR$(27): EXIT FUNCTION  'Allow ESCape
GOTO GTT:

END FUNCTION

SUB HiLo (fc, Sc)
    'Determines the higher and lower rank of two cards
    'FC and SC are the cards to compare
    'The Higher card will be in HiCard, nad the lower card will be in LoCard
    'If both cards are equal, both HiCard, and LoCard will be 0

    IF fc > Sc THEN
        HiCard = fc: LoCard = Sc
    ELSEIF fc < Sc THEN
        LoCard = fc: HiCard = Sc
    ELSE
        HiCard = 0: LoCard = 0
    END IF
END SUB

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB LoadFiles
    ON ERROR GOTO errorhandler:
    fec = 1: OPEN "Gin.dat" FOR INPUT AS #1
    IF fileerror = 1 THEN
        OPEN "gin.dat" FOR APPEND AS #1
        WRITE #1, 100, 25, 1, 0, 25:  gamelimit = 100: GinBonus = 25
        Knocking = 1: oklahoma = 0: UndBonus = 25: CLOSE #1
    ELSE
        INPUT #1, gamelimit:  INPUT #1, GinBonus: INPUT #1, Knocking
        INPUT #1, oklahoma: INPUT #1, UndBonus:  CLOSE #1
    END IF

    OPEN "Gin.sts" FOR RANDOM AS #2 LEN = 26
    NumPlayers = LOF(2) / 26
END SUB

SUB menu
mbegin:
    CLS : COLOR 12: center 2, "Gin Rummy"
    COLOR 15: center 3, "By Charles Martin"

    COLOR 14, 9
    center 7, "  B. Begin a New game  "
    center 8, "                       "
    center 9, "  O. Options           "
    center 10, "                       "
    center 11, "  R. Rules             "
    center 12, "                       "
    center 13, "  S. Statistics        "
    center 14, "                       "
    center 15, "  X. Exit              "

COLOR 14, 8: center 18, "Press the letter next"
center 19, "to the desired option:"
    k$ = GetKey$("boqrsx")
        SELECT CASE k$
            CASE IS = "B": PlayGame: GOTO mbegin:
            CASE IS = "O": Options: GOTO mbegin:
            CASE IS = "R": WIDTH 80, 25: SHELL "read rules.txt": WIDTH 40: GOTO mbegin:
            CASE IS = "S":
            CASE "Q", "X", CHR$(27): SYSTEM
        END SELECT
END SUB

SUB nextcard
GetAnother:
    Z = INT(RND * 52) + 1
    '---------------Put card limit codes here---------------------------
    ' EXAMPLE:  if case 8 then goto GetAnother:  'do not allow 8s
    IF deck(Z) < NumDecks THEN GOTO det:  ELSE GOTO GetAnother:

det:      'Determine the card's rank
    'A=1  2-10=2-10  J=11  Q=12  K=13

    SELECT CASE Z
        CASE 1, 14, 27, 40: cmsg$ = "Ace of ": card$ = "A": cv = 1:  ACE = ACE + 1
        CASE 2, 15, 28, 41: cmsg$ = "Two of ": card$ = "2": cv = 2:  two = two + 1
        CASE 3, 16, 29, 42: cmsg$ = "Three of ": card$ = "3": cv = 3:  thr = thr + 1
        CASE 4, 17, 30, 43: cmsg$ = "Four of ": card$ = "4": cv = 4:  fou = fou + 1
        CASE 5, 18, 31, 44: cmsg$ = "Five of ": card$ = "5": cv = 5:  fiv = fiv + 1
        CASE 6, 19, 32, 45: cmsg$ = "Six of ": card$ = "6": cv = 6:  six = six + 1
        CASE 7, 20, 33, 46: cmsg$ = "Seven of ": card$ = "7": cv = 7:  sev = sev + 1
        CASE 8, 21, 34, 47: cmsg$ = "Eight of ": card$ = "8": cv = 8:  eig = eig + 1
        CASE 9, 22, 35, 48: cmsg$ = "Nine of ": card$ = "9": cv = 9:  nin = nin + 1
        CASE 10, 23, 36, 49: cmsg$ = "Ten of ": card$ = "10": cv = 10: ten = ten + 1
        CASE 11, 24, 37, 50: cmsg$ = "Jack of ": card$ = "J": cv = 11:  jac = jac + 1
        CASE 12, 25, 38, 51: cmsg$ = "Queen of ": card$ = "Q": cv = 12:  que = que + 1
        CASE 13, 26, 39, 52: cmsg$ = "King of ": card$ = "K": cv = 13:  kin = kin + 1
    END SELECT

GetSuit:
    SELECT CASE Z
        CASE 1 TO 13: cmsg$ = cmsg$ + "Hearts": card$ = card$ + "": suit$ = "": GOTO MoveOn:
        CASE 14 TO 26: cmsg$ = cmsg$ + "Diamonds": card$ = card$ + "": suit$ = "": GOTO MoveOn:
        CASE 27 TO 39: cmsg$ = cmsg$ + "Spades": card$ = card$ + "": suit$ = "": GOTO MoveOn:
        CASE 40 TO 52: cmsg$ = cmsg$ + "Clubs": card$ = card$ + "": suit$ = "": GOTO MoveOn
        CASE ELSE:  PRINT : PRINT "ERROR:  card pick out of range of 1-12": SYSTEM
    END SELECT

MoveOn:
    deck(Z) = deck(Z) + 1
    cardsleft = cardsleft - 1
END SUB

SUB Options
    fmt$ = "#,###": COLOR 9: CLS : center 2, "Options"

TopOpt:
    COLOR 14: LOCATE 5, 1: PRINT " +/- Scoring Limit.... "; : COLOR 15: PRINT USING fmt$; gamelimit:
    COLOR 14: LOCATE 7, 1: PRINT "  G. Gin Bonus........ "; : COLOR 15: PRINT USING fmt$; GinBonus
   COLOR 14: LOCATE 9, 1: PRINT "  K. Knocking allowed? "; : COLOR 15: IF Knocking = 1 THEN PRINT "  YES" ELSE PRINT "   NO"
    COLOR 14: LOCATE 11, 1: PRINT "  N. Player Name...... "; : COLOR 15: PRINT name$(1)
   COLOR 14: LOCATE 13, 1: PRINT "  O. OklaHoma Gin?.... "; : COLOR 15: IF oklahoma = 1 THEN PRINT "  YES" ELSE PRINT "   NO"
   COLOR 14: LOCATE 15, 1: PRINT "  U. UnderCut Bonus... "; : COLOR 15: PRINT USING fmt$; UndBonus
   COLOR 14: LOCATE 17, 1: PRINT "  X. Exit the Options Menu"

k$ = GetKey$("+-gknoux")
    SELECT CASE k$
        CASE IS = "-"
            gamelimit = gamelimit - 25
            IF gamelimit < 0 THEN gamelimit = 9500
        CASE IS = "+"
            gamelimit = gamelimit + 25
            IF gamelimit > 9800 THEN gamelimit = 0
         CASE IS = "G"
            GinBonus = GinBonus + 5
            IF GinBonus > 50 THEN GinBonus = 0
        CASE IS = "K"
            Knocking = Knocking + 1
            IF Knocking > 1 THEN Knocking = 0
        CASE IS = "N"
            COLOR 10: LOCATE 23, 1: INPUT "What's your name?  >", name$(1)
            LOCATE 22, 1: PRINT SPACE$(40)
        CASE IS = "O"
            oklahoma = oklahoma + 1
            IF oklahoma > 1 THEN oklahoma = 0
        CASE IS = "U"
            UndBonus = UndBonus + 5
            IF UndBonus > 50 THEN UndBonus = 0
        CASE IS = CHR$(27), IS = "X"
            KILL "gin.dat"
            OPEN "gin.dat" FOR OUTPUT AS #1
            WRITE #1, gamelimit, GinBonus, Knocking, oklahoma, UndBonus
            CLOSE #1: EXIT SUB
        END SELECT
    GOTO TopOpt:
END SUB

SUB PlayGame
altnp1$ = CHR$(1): altnp2$ = CHR$(2):  altnp3$ = CHR$(3):  altnp4$ = CHR$(4)
altnp5$ = CHR$(5): altnp6$ = CHR$(6):  altnp7$ = CHR$(7): altnp8$ = CHR$(8)
altnp9$ = CHR$(9): altnp0$ = CHR$(0) + CHR$(83)  'unknown

alt1$ = CHR$(0) + CHR$(120):  alt2$ = CHR$(0) + CHR$(121): : alt3$ = CHR$(0) + CHR$(122)
alt4$ = CHR$(0) + CHR$(123): alt5$ = CHR$(0) + CHR$(124):  alt6$ = CHR$(0) + CHR$(125)
alt7$ = CHR$(0) + CHR$(126): alt8$ = CHR$(0) + CHR$(127):  alt9$ = CHR$(0) + CHR$(128)
alt0$ = CHR$(10):  alta$ = CHR$(0) + CHR$(30): altj$ = CHR$(0) + CHR$(36)
altq$ = CHR$(0) + CHR$(16):  altk$ = CHR$(0) + CHR$(37): name$(2) = "COMPUTER"
allalt$ = alt1$ + alt2$ + alt3$ + alt4$ + alt5$ + alt6$ + alt7$ + alt8$ + alt9$ + alt0$
allalt$ = allalt$ + altnp1$ + altnp2$ + altnp3$ + altnp4$ + altnp5$ + altnp6$ + altnp7$ + altnp8$ + altnp9$ + altnp0$ + alta$ + altj$ + altq$ + altk$

NextHand:
    hand = hand + 1: ak = 0
    SetupScreen
    Shuffle
    Deal
    ShowPlayerCards

    IF playerdeals = 0 THEN turn = 1 ELSE turn = 2
    plotcard 14, dic$
    FOR I = 12 TO 16:  LOCATE I, 27: PRINT "    ": NEXT I
    COLOR 14: LOCATE 13, 15

UpCard:
    IF ak > 2 THEN
        FOR I = 12 TO 16:  LOCATE I, 15: PRINT SPACE$(17): NEXT I
            COLOR 7:
            LOCATE 13, 27: PRINT "ÚÄÄ¿"
            LOCATE 14, 27: PRINT "³  ³"
            LOCATE 15, 27: PRINT "³  ³"
            LOCATE 16, 27: PRINT "ÀÄÄÙ"
            LOCATE 12, 27: COLOR 9: PRINT "DECK"
            IF turn = 1 THEN GOTO Player ELSE GOTO Computer:
        END IF
    SELECT CASE turn
        CASE IS = 1
            RightJustify 13, 32, name$(1) + ", do you"
            RightJustify 14, 32, "want the UpCard?"
            COLOR 9: RightJustify 15, 32, "(Press Y or N):"
            k$ = GetKey$("ynp")
            IF k$ = "N" THEN ak = ak + 1: turn = 2: GOTO UpCard:
            IF k$ = "Y" OR k$ = "P" THEN
                drc$ = dic$: drv$ = div$: clearcard 14: GFD = 1
                FOR I = 12 TO 16:  LOCATE I, 15: PRINT SPACE$(17): NEXT I
                COLOR 7:
                LOCATE 13, 27: PRINT "ÚÄÄ¿"
                LOCATE 14, 27: PRINT "³  ³"
                LOCATE 15, 27: PRINT "³  ³"
                LOCATE 16, 27: PRINT "ÀÄÄÙ"
                LOCATE 12, 27: COLOR 9: PRINT "DECK"
                GOTO GetDiscard:
            END IF
    CASE IS = 2
    BEEP: ak = ak + 1: GOTO UpCard:
    END SELECT

SYSTEM
DO UNTIL ATK <> 0
TOL:
    SELECT CASE turn  '1=player  2=computer
        CASE IS = 1
Player:
            ShowPlayerCards
            J$ = "DQ"
                IF ak <= 2 THEN J$ = J$ + "P"
            k$ = GetKey$(J$)
                IF k$ = "P" THEN drc$ = dic$: drv$ = div$: clearcard 14: GFD = 1
                IF k$ = "D" THEN nextcard: drc$ = card$: drv$ = I2a$(cv): plotcard 13, I2a$(cardsleft): GFD = 0
                IF k$ = CHR$(27) OR k$ = "Q" THEN SYSTEM
GetDiscard:
                carddrawn 1: plotcard 12, drc$
            k$ = GetKey$("1234567890qD")
                IF k$ = "Q" THEN SYSTEM
                IF k$ = "D" THEN SWAP drv$, div$: SWAP drc$, dic$: GOTO EOPT:

            cp = VAL(k$)
            IF cp = 0 THEN cp = 10
            SWAP div$, phand$(cp, 1)
            SWAP dic$, phand$(cp, 2)
            SWAP drv$, phand$(cp, 1)
            SWAP drc$, phand$(cp, 2)
EOPT:
            carddrawn 0: plotcard 14, dic$:  turn = 2: ShowPlayerCards
        CASE IS = 2:
Computer:
            
            turn = 1
        END SELECT
GOTO TOL:
LOOP

END SUB

SUB plotcard (spot, crd$)
    Sta = 14: card = 18
    SELECT CASE spot
        CASE IS = 1: cardrow = card: cardcol = 2
        CASE IS = 2: cardrow = card: cardcol = 6
        CASE IS = 3: cardrow = card: cardcol = 10
        CASE IS = 4: cardrow = card: cardcol = 14
        CASE IS = 5: cardrow = card: cardcol = 18
        CASE IS = 6: cardrow = card: cardcol = 22
        CASE IS = 7: cardrow = card: cardcol = 26
        CASE IS = 8: cardrow = card: cardcol = 30
        CASE IS = 9: cardrow = card: cardcol = 34
        CASE IS = 10: cardrow = card: cardcol = 38
        CASE IS = 11: cardrow = Sta: cardcol = 4
        CASE IS = 12: cardrow = Sta: cardcol = 12
        CASE IS = 13: LOCATE Sta, 28
            IF LEN(crd$) = 1 THEN PRINT " " + crd$ ELSE PRINT crd$:
            EXIT SUB
        CASE IS = 14: cardrow = Sta: cardcol = 37
    END SELECT

        IF LEN(crd$) = 2 THEN ca$ = " " + LEFT$(crd$, 1) ELSE ca$ = "10"
    LOCATE cardrow, cardcol: COLOR 15, 8: PRINT ca$
    LOCATE cardrow + 1, cardcol: PRINT " " + RIGHT$(crd$, 1)
END SUB

SUB RightJustify (row, col, text$)
    LOCATE row, (col - LEN(text$)): PRINT text$
END SUB

FUNCTION SameSuit (fc$, Sc$)
    IF fc$ = Sc$ THEN SameSuit = TRUE ELSE SameSuit = false
END FUNCTION

SUB SetupScreen
    WIDTH 40, 25: COLOR 15: CLS
    LOCATE 13, 1: COLOR 7
    PRINT "  ÚÄÄ¿                    ÚÄÄ¿     ÚÄÄ¿"
    PRINT "  ³  ³                    ³  ³     ³  ³"
    PRINT "  ³  ³                    ³  ³     ³  ³"
    PRINT "  ÀÄÄÙ                    ÀÄÄÙ     ÀÄÄÙ"
    PRINT "ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿"
    PRINT "³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³"
    PRINT "³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³"
    PRINT "ÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙ"
    COLOR 9: LOCATE 12, 1: PRINT "  KNOCK                   DECK  DISCARD"
    IF oklahoma <> 1 THEN FOR I = 12 TO 16: LOCATE I, 1: PRINT SPACE$(7):  NEXT

    COLOR 4, 8: LOCATE 1, 1
    PRINT "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
    PRINT "º                         º"
    PRINT "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    PRINT "º                         º"
    PRINT "º                         º"
    PRINT "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
    COLOR 15: LOCATE 2, 3: PRINT "Hand "; I2a$(hand); ", Play to ";
    IF gamelimit < 1000 THEN PRINT I2a$(gamelimit) ELSE PRINT USING "#,###"; gamelimit

    COLOR 14:
    LOCATE 4, 3: PRINT name$(2); TAB(16); USING "#,###  ##"; score(2); HandsWon(2)
    LOCATE 5, 3: PRINT name$(1); TAB(16); USING "#,###  ##"; score(1); HandsWon(1)
END SUB

SUB ShowCPUCards
    COLOR 7, 0: LOCATE 8, 1:
    PRINT "ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿ÚÄÄ¿"
    PRINT "³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³"
    PRINT "³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³³  ³"
    PRINT "ÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙÀÄÄÙ"

    cardrow = 9: cardcol = 2: COLOR 15, 8

    FOR I = 1 TO 10
        C$ = chand$(I, 2)
        IF LEN(C$) = 2 THEN ca$ = LEFT$(C$, 1) ELSE ca$ = "10"
        su$ = RIGHT$(C$, 1):

        LOCATE cardrow, cardcol
        IF VAL(ca$) = 10 THEN PRINT ca$ ELSE PRINT " " + ca$
        
        LOCATE cardrow + 1, cardcol: PRINT " " + su$
        cardcol = cardcol + 4
    NEXT I:  FOR I = 12 TO 16: LOCATE I, 1: PRINT SPACE$(40): NEXT I

END SUB

SUB ShowPlayerCards
ERASE hc, deadwood: : SI = 1: sort phand$(), SI, 10

    FOR I = 1 TO 10
        cv = VAL(phand$(I, 1))
        hc(cv) = hc(cv) + 1
        cc$ = phand$(I, 2)
        plotcard I, cc$
    NEXT I
    FOR V = 13 TO 1 STEP -1
        CardsInSet = hc(V)
        IF CardsInSet >= 3 THEN
            FOR I = 1 TO CardsInSet
                fc = FindCard(V, 1)
                SWAP phand$(fc, 1), phand$(SI, 1)
                SWAP phand$(fc, 2), phand$(SI, 2)
                SI = SI + 1
            NEXT I
        END IF
    NEXT V
    
    IF SI = 11 THEN
        deadwood(1) = 0: points = GinBonus: SYSTEM
    ELSE
        sort phand$(), SI, 10

    FOR I = SI TO 10
        SELECT CASE VAL(phand$(I, 1))
            CASE 1 TO 10: deadwood(1) = deadwood(1) + VAL(phand$(I, 1))
            CASE 11 TO 13: deadwood(1) = deadwood(1) + 10
        END SELECT
    NEXT I
    FOR I = 1 TO 10
        cc$ = phand$(I, 2)
        plotcard I, cc$
    NEXT I
    END IF
END SUB

SUB Shuffle
    RANDOMIZE TIMER: Z = 0: cardsleft = TotalCards: card$ = "":  ERASE deck, chand$, phand$
END SUB

SUB sort (sortarr$(), lower, upper)

    DIM SortStackLow%(128)
    DIM SortStackHigh%(128)

    StackPointer% = 1

    SortStackLow%(StackPointer%) = lower
    SortStackHigh%(StackPointer%) = upper
    StackPointer% = StackPointer% + 1

    DO

       StackPointer% = StackPointer% - 1
       Low% = SortStackLow%(StackPointer%)
       High% = SortStackHigh%(StackPointer%)

       DO

         ii = Low%
         jj = High%
         Mid% = (Low% + High%) \ 2
         compare = VAL(sortarr$(Mid%, 1))

         DO

            DO WHILE VAL(sortarr$(ii, 1)) > compare
               ii = ii + 1
            LOOP

            DO WHILE VAL(sortarr$(jj, 1)) < compare
               jj = jj - 1
            LOOP

            IF ii <= jj THEN
               SWAP sortarr$(ii, 1), sortarr$(jj, 1)
               SWAP sortarr$(ii, 2), sortarr$(jj, 2)
               ii = ii + 1
               jj = jj - 1
            END IF

         LOOP WHILE ii <= jj

         IF jj - Low% < High% - ii THEN
            IF ii < High% THEN
               SortStackLow%(StackPointer%) = ii
               SortStackHigh%(StackPointer%) = High%
               StackPointer% = StackPointer% + 1
            END IF
            High% = jj
         ELSE
            IF Low% < jj THEN
               SortStackLow%(StackPointer%) = Low%
               SortStackHigh%(StackPointer%) = jj
               StackPointer% = StackPointer% + 1
            END IF
            Low% = ii
         END IF

       LOOP WHILE Low% < High%

    LOOP WHILE StackPointer% <> 1


 
END SUB

