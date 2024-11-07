DECLARE SUB center (row, text$) 'Centers text on the screen on a given line
DECLARE SUB HiLo (Fc, Sc)       'Determine higher and lower card by rank
DECLARE FUNCTION I2a$ (h)       'Converts a numeric to a string variable
DECLARE SUB NextCard ()         'Get the next card from the top of the deck
DECLARE FUNCTION SameSuit (Fc$, Sc$)  'See if two cards have the same suit
DECLARE SUB Shuffle ()          'Shuffles the cards
DECLARE SUB TestSystem ()       'A quick test of this system

DIM SHARED deck(52)  'keeps track of which cards have been used so far
CONST false = -1, TRUE = 1, Pi! = 3.14159266#
COMMON SHARED CardsLeft, cv, cmsg$, NumDecks, TotalCards, card$, HiCard
COMMON SHARED LoCard
COMMON SHARED ace, two, thr, fou, fiv, six, sev, eig, nin, ten, jac, que, kin



'Card suits             
'--------Variables--------
'Card$         Short form of card, such as '6' or 'K'
'CardsLeft     Number of cards left
'CV            Number of the last card picked  2-10  11=J 12=Q  13=K  1=A
'CMSG$         The card's number and suit in words, such as 'ACE OF CLUBS'
'NumDecks      Number of decks of cards needed
'Suit$         card's suit, such as "" or'"
'TotalCards    Number of total cards  (determined by NumDecks*52)

'To get the next card in the deck, call the NEXTCARD sub.

'NEXT LINE IS REQUIRED to use this system.  it sets up variables that are
'used in the system.  You can change the NumDecks value to change the number
'of card decks.  The rest of the line should be left alone.
NumDecks = 1: RANDOMIZE TIMER: TotalCards = INT(NumDecks * 52): CardsLeft = TotalCards
'----------------------------------------------------------------------------

TestSystem

SUB center (row, text$)
    'change col below to 41 if using 80x25 text mode, or some graphics modes.
    col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB HiLo (Fc, Sc)
    'Determines the higher and lower rank of two cards
    'FC and SC are the cards to compare
    'The Higher card will be in HiCard, nad the lower card will be in LoCard
    'If both cards are equal, both HiCard, and LoCard will be 0

    IF Fc > Sc THEN
        HiCard = Fc: LoCard = Sc
    ELSEIF Fc < Sc THEN
        LoCard = Fc: HiCard = Sc
    ELSE
        HiCard = 0: LoCard = 0
    END IF
END SUB

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB NextCard
GetAnother:
    Z = INT(RND * 52) + 1
    '---------------Put card limit codes here---------------------------
    ' EXAMPLE:  if case 8 then goto GetAnother:  'do not allow 8s
    IF deck(Z) < NumDecks THEN GOTO det:  ELSE GOTO GetAnother:

det:      'Determine the card's rank
    'A=1  2-10=2-10  J=11  Q=12  K=13

    SELECT CASE Z
        CASE 1, 14, 27, 40: cmsg$ = "Ace of ": card$ = "A": ace = ace + 1
        CASE 2, 15, 28, 41: cmsg$ = "Two of ": card$ = "2": two = two + 1
        CASE 3, 16, 29, 42: cmsg$ = "Three of ": card$ = "3": thr = thr + 1
        CASE 4, 17, 30, 43: cmsg$ = "Four of ": card$ = "4": fou = fou + 1
        CASE 5, 18, 31, 44: cmsg$ = "Five of ": card$ = "5": fiv = fiv + 1
        CASE 6, 19, 32, 45: cmsg$ = "Six of ": card$ = "6": six = six + 1
        CASE 7, 20, 33, 46: cmsg$ = "Seven of ": card$ = "7": sev = sev + 1
        CASE 8, 21, 34, 47: cmsg$ = "Eight of ": card$ = "8": eig = eig + 1
        CASE 9, 22, 35, 48: cmsg$ = "Nine of ": card$ = "9": nin = nin + 1
        CASE 10, 23, 36, 49: cmsg$ = "Ten of ": card$ = "10": ten = ten + 1
        CASE 11, 24, 37, 50: cmsg$ = "Jack of ": card$ = "J": jac = jac + 1
        CASE 12, 25, 38, 51: cmsg$ = "Queen of ": card$ = "Q": que = que + 1
        CASE 13, 26, 39, 52: cmsg$ = "King of ": card$ = "K": kin = kin + 1
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
    CardsLeft = CardsLeft - 1
END SUB

FUNCTION SameSuit (Fc$, Sc$)
    IF Fc$ = Sc$ THEN SameSuit = TRUE ELSE SameSuit = false
END FUNCTION

SUB Shuffle
    Z = 0: CardsLeft = TotalCards: card$ = "":  ERASE deck
END SUB

SUB TestSystem
    COLOR 15: CLS : RANDOMIZE TIMER
    DO UNTIL CardsLeft = 0
        CLS : NextCard
        PRINT "   # of card decks: "; NumDecks; "  ("; I2a$(TotalCards); " cards)"
        PRINT "Card name in words:  "; cmsg$
        PRINT "   Card short form:  "; card$
        PRINT "   Cards remaining: "; CardsLeft
        st$ = st$ + card$ + " ": PRINT : PRINT : PRINT st$
    LOOP

Types:
    PRINT : PRINT
    PRINT "  ACES: "; ace; TAB(21); "EIGHTS: "; eig
    PRINT "  TWOS: "; two; TAB(21); " NINES: "; nin
    PRINT "THREES: "; thr; TAB(21); "  TENS: "; ten
    PRINT " FOURS: "; fou; TAB(21); " JACKS: "; jac
    PRINT " FIVES: "; fiv; TAB(21); "QUEENS: "; que
    PRINT " SIXES: "; six; TAB(21); " KINGS: "; kin
    PRINT "SEVENS: "; sev; TAB(21); " TOTAL: "; ace + two + thr + fou + fiv + six + sev + eig + nin + ten + jac + que + kin
END SUB

