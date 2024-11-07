DECLARE SUB AddBook ()
DECLARE SUB CBDV ()
DECLARE SUB center (Row, text$)
DECLARE SUB ChangeInfo ()
DECLARE SUB ClearBoard ()
DECLARE SUB ClearLine (LN!)
DECLARE SUB DisplayRecords (beg, endd)
DECLARE SUB FindEmptyRecord ()
DECLARE SUB FindTitle (st$)
DECLARE FUNCTION GetInput$ (Row&, Col&, PasswordChar$, MaxWidth&, Fore&, Back&, Empty$, Insert&, Default$, Mask$, Flags&, Req$)
DECLARE SUB LoadIndex ()
DECLARE SUB Menu ()
DECLARE SUB NoTitleMatch ()
DECLARE FUNCTION Quote$ (txt$)
DECLARE SUB Search ()
DECLARE SUB TapKey ()
DECLARE SUB WaitForKey ()
COMMON SHARED reclen, EmptyRecord, match, found, A$, YearSearch, ma$, year, ryear
CONST CURRENTFORE = -1, CURRENTBACK = -2
CONST qbSetUp = 2, qbShowMask = 8, qbForceComplete = 256

reclen = 62
TYPE BOOKREC
      title AS STRING * 30
     Author AS STRING * 15
       isbn AS STRING * 13
   NumPages AS INTEGER  '4-digit number
       year AS INTEGER  '4-digit bumber
END TYPE

DIM SHARED bdata AS BOOKREC, NDX(100) AS INTEGER
OPEN "BOOKS.DAT" FOR RANDOM AS #1 LEN = reclen

 LoadIndex
 Menu

SUB AddBook
1
FindEmptyRecord
COLOR 14, 8: CLS : LOCATE 2, 1: PRINT "THIS IS BOOK #"; EmptyRecord
3
COLOR 15, 8: LOCATE 5, 1: PRINT " TITLE:  ";
A$ = GetInput$(5, 10, "", 30, 15, 1, "ù", 0, "", "", 0, "")
IF A$ = "" THEN EXIT SUB
bdata.title = A$
IF LEN(A$) < 3 THEN GOTO 3

10
LOCATE 7, 1, 1: COLOR 15, 8: PRINT "AUTHOR:  ";
A$ = GetInput$(7, 10, "", 15, 15, 1, "ù", 0, "", "", 0, "")
IF A$ = "" THEN EXIT SUB
bdata.Author = A$
IF LEN(A$) < 3 THEN GOTO 10

15
LOCATE 9, 1, 1: COLOR 15, 8: PRINT "ISBN #:  ";
A$ = GetInput$(9, 10, "", 13, 15, 1, "ù", 0, "", "", 0, "")
IF A$ = "" THEN EXIT SUB
bdata.isbn = A$
IF LEN(A$) <> 13 THEN
   COLOR 10, 8: : LOCATE 12, 1: PRINT "ISBN MUST be 13 characters."
   SLEEP 3: ClearLine 12: ClearBoard: GOTO 15
END IF

20
LOCATE 11, 1, 1: COLOR 15, 8: PRINT "NO. OF"
LOCATE 12, 1: PRINT " PAGES:  ";
bdata.NumPages = VAL(GetInput$(12, 10, "", 4, 15, 1, "ù", 0, "", "", 0, ""))
IF bdata.NumPages < 5 THEN GOTO 20

25
LOCATE 14, 1, 1: COLOR 15, 8: PRINT "BOOK'S"
LOCATE 15, 1: PRINT "  YEAR:  ";
bdata.year = VAL(GetInput$(15, 10, "", 4, 15, 1, "ù", 0, "", "", 0, ""))
IF bdata.year < 1 THEN GOTO 25

PUT #1, EmptyRecord, bdata: NDX(EmptyRecord) = 1

COLOR 13, 0: LOCATE 19, 1: PRINT "Add another book?  (Press Y or N):"
ron:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO 1
IF k$ = "n" THEN EXIT SUB
IF k$ = CHR$(27) THEN EXIT SUB
GOTO ron:
END SUB

SUB CBDV
bdata.title = "": bdata.Author = "": bdata.isbn = "": bdata.NumPages = 0: bdata.year = 0
END SUB

SUB center (Row, text$)
Col = 21 - LEN(text$) / 2: LOCATE Row, Col: PRINT text$
END SUB

SUB ChangeInfo
TES:
WIDTH 40, 25: COLOR 9, 8: CLS : center 2, "Change a book's information"
COLOR 14, 8: ClearBoard
LOCATE 5, 1: PRINT "Type in the book's number OR"
             PRINT "title that you wish to change:"
999
A$ = LTRIM$(RTRIM$(GetInput$(7, 1, "", 30, 15, 1, "ù", 0, "", "", 0, "")))
match = VAL(A$)
IF A$ = "" THEN EXIT SUB
IF match <> 0 THEN GOTO changeIt:
IF match = 0 AND LEN(A$) < 3 THEN GOTO 999:
FindTitle (A$)

SELECT CASE found
CASE IS = 0: NoTitleMatch: GOTO TES:
CASE IS = 1: GOTO changeIt:
CASE ELSE:
     LOCATE 23, 1: PRINT "Type in the book's number that you want to edit:"
60
     match = VAL(GetInput$(23, 50, "", 3, 15, 1, "ù", 0, "", "", 0, ""))
     IF match = 0 THEN EXIT SUB
     IF match > 100 THEN GOTO 60
     IF NDX(match) = 0 THEN
        COLOR 12, 8: PRINT :  PRINT : PRINT "You currently do not have a book #"; match
        PRINT "Press any key to try again.": SLEEP: GOTO TES:
     END IF
END SELECT

changeIt:
     IF NDX(match) = 0 THEN
        COLOR 12, 8: PRINT :  PRINT : PRINT "You currently do not have a book #"; match
        PRINT "Press any key to try again.": SLEEP: GOTO TES:
     END IF
GET #1, match, bdata
COLOR 14, 8: CLS : LOCATE 2, 1: PRINT "You are editing book #"; INT(match)
93
LOCATE 5, 1: PRINT " TITLE:  ";
N$ = RTRIM$(bdata.title)
A$ = GetInput$(5, 10, "", 30, 15, 1, "ù", 0, N$, "", 0, "")
IF A$ = "" THEN EXIT SUB
bdata.title = A$

910
LOCATE 7, 1, 1: COLOR 15, 8: PRINT "AUTHOR:  ";
N$ = RTRIM$(bdata.Author)
A$ = GetInput$(7, 10, "", 15, 15, 1, "ù", 0, N$, "", 0, "")
IF A$ = "" THEN EXIT SUB
bdata.Author = A$
IF LEN(A$) < 3 THEN GOTO 910

915
LOCATE 9, 1, 1: COLOR 15, 8: PRINT "ISBN #:  ";
N$ = RTRIM$(bdata.isbn)
A$ = GetInput$(9, 10, "", 13, 15, 1, "ù", 0, N$, "", 0, "")
IF A$ = "" THEN EXIT SUB
bdata.isbn = A$
IF LEN(A$) <> 13 THEN
   COLOR 10, 8: : LOCATE 12, 1: PRINT "ISBN MUST be 13 characters."
   SLEEP 3: ClearLine 12: ClearBoard: GOTO 915
END IF

920
LOCATE 11, 1, 1: COLOR 15, 8: PRINT "NO. OF"
LOCATE 12, 1: PRINT " PAGES:  ";
N$ = LTRIM$(RTRIM$(STR$(bdata.NumPages)))
bdata.NumPages = VAL(GetInput$(12, 10, "", 4, 15, 1, "ù", 0, N$, "", 0, ""))
IF bdata.NumPages < 5 THEN GOTO 920

925
LOCATE 14, 1, 1: COLOR 15, 8: PRINT "BOOK'S"
LOCATE 15, 1: PRINT "  YEAR:  ";
N$ = LTRIM$(RTRIM$(STR$(bdata.year)))
bdata.year = VAL(GetInput$(15, 10, "", 4, 15, 1, "ù", 0, N$, "", 0, ""))
IF bdata.year < 1 THEN GOTO 925

PUT #1, match, bdata: NDX(match) = 1

COLOR 13, 0: LOCATE 19, 1: PRINT "Edit another book?  (Press Y or N):"
ro:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN GOTO TES:
IF k$ = "n" THEN EXIT SUB
IF k$ = CHR$(27) THEN EXIT SUB
GOTO ro:
END SUB

SUB ClearBoard
DO UNTIL INKEY$ = "": LOOP
END SUB

SUB ClearLine (LN)
COLOR 8, 8: LOCATE LN, 1: PRINT SPACE$(40)
END SUB

SUB DisplayRecords (beg, endd)
WIDTH 80, 25: COLOR 8, 8: CLS
COLOR 13, 8: LOCATE 1, 1: PRINT "  #  TITLE                           AUTHOR           ISBN           PAGES  YEAR"
COLOR 10, 8: LOCATE 2, 1: PRINT "---  ------------------------------  ---------------  -------------  -----  ----"
COLOR 15, 8: R = 0

FOR l = beg TO endd
EVA:  
    GET #1, l, bdata
    IF bdata.NumPages = 0 AND bdata.year = 0 THEN GOTO EOL:
    R = R + 1: pr = pr + 1
    IF pr > 20 THEN
       COLOR 13, 8: TapKey: pr = 0: R = 0
       VIEW PRINT 3 TO 23: CLS : VIEW PRINT: GOTO EVA:
    ELSE
    LOCATE R + 2, 1: COLOR 15, 8: PRINT USING "###"; l; TAB(6); : PRINT bdata.title; TAB(38); bdata.Author; TAB(55); bdata.isbn; TAB(71);
    PRINT USING "####"; bdata.NumPages; : PRINT TAB(77);
    PRINT USING "####"; bdata.year
END IF
EOL:
NEXT l
COLOR 13, 8: WaitForKey
END SUB

SUB FindEmptyRecord
FOR I = 1 TO 100
IF NDX(I) = 0 THEN EmptyRecord = I: EXIT SUB ELSE EmptyRecord = 0
NEXT I
IF EmptyRecord = 0 THEN
   PRINT : PRINT "You have reached the maximum"
   PRINT "amount of books that can be stored."
   PRINT "Remove one or more booxs and try again."
END IF
END SUB

SUB FindTitle (st$)
WIDTH 80, 25: COLOR 8, 8: CLS
COLOR 13, 8: LOCATE 1, 1: PRINT "  #  TITLE                           AUTHOR           ISBN           PAGES  YEAR"
COLOR 10, 8: LOCATE 2, 1: PRINT "---  ------------------------------  ---------------  -------------  -----  ----"
COLOR 15, 8: st$ = UCASE$(st$): R = 1: pr = 0: match = 0: found = 0

FOR I = 1 TO 100
    GET #1, I, bdata
    GT$ = UCASE$(bdata.title)
TOT:
    IF pr > 19 THEN
       COLOR 10, 8: TapKey: R = 1
       pr = 0: VIEW PRINT 3 TO 23: CLS : VIEW PRINT: GOTO TOT:
END IF
    IF INSTR(GT$, st$) > 0 THEN
       LOCATE R + 2, 1: COLOR 15, 8: PRINT USING "###"; I; TAB(6); : PRINT bdata.title; TAB(38); bdata.Author; TAB(55); bdata.isbn; TAB(71);
       PRINT USING "####"; bdata.NumPages; : PRINT TAB(77);
       PRINT USING "####"; bdata.year
       R = R + 1: pr = pr + 1: found = found + 1: match = I
    END IF
NEXT I
END SUB

DEFLNG A-Z
              'Define all unsigned variables to be LONG
FUNCTION GetInput$ (Row&, Col&, PasswordChar$, MaxWidth&, Fore&, Back&, Empty$, Insert&, Default$, Mask$, Flags&, Req$)
   SELECT CASE Flags
   CASE qbSetUp: SetUp = -1
   CASE qbShowMask: ShowMask = -1
   CASE qbForceComplete: Force = -1
   CASE qbSetUp + qbShowMask: SetUp = -1: ShowMask = -1
   CASE qbSetUp + qbForceComplete: SetUp = -1: Force = -1
   CASE qbShowMask + qbForceComplete: ShowMask = -1: Force = -1
   CASE qbSetUp + qbShowMask + qbForceComplete: SetUp = -1: ShowMask = -1: Force = -1
   END SELECT
   ' Print text for foreground and background saves
   LOCATE Row, Col: PRINT "A"
   GetForeColor = SCREEN(Row, Col, 1) MOD 16       'Save foreground color
   GetBackColor = SCREEN(Row, Col, 1) / 16         'Save background color
   Mask = 0
   IF Mask$ <> "" THEN
      Mask = -1
      MaxWidth = LEN(Mask$)
      FOR CountLen = 1 TO LEN(Mask$)
         A$ = MID$(Mask$, CountLen, 1)
         IF A$ = "#" OR A$ = "$" THEN
            Ms$ = Ms$ + A$
            MaskCount = MaskCount + 1
         END IF
      NEXT
   END IF
   IF Empty$ = "" THEN Empty$ = " "
   text$ = Default$
   CurrentPos = LEN(text$) + 1
   GOSUB PutText                                   'Put text on screen
   IF SetUp THEN EXIT FUNCTION
   DO
      I$ = INKEY$             'Get keyboard character
      SELECT CASE I$
      CASE CHR$(8)            'Backspace
         IF LEN(text$) > 0 THEN
            text$ = MID$(text$, 1, CurrentPos - 2) + MID$(text$, CurrentPos, LEN(text$))
            CurrentPos = CurrentPos - 1
         END IF
      CASE CHR$(27)           'Escape
         IF Force AND LEN(text$) < MaskCount THEN
         ELSE
            IsThere = 0
            FOR CheckReq = 1 TO LEN(Req$)
               A$ = MID$(Req$, CheckReq, 1)
               IF INSTR(1, text$, A$) = 0 THEN
                  IsThere = -1
               END IF
            NEXT
            IF NOT IsThere THEN
               EXIT FUNCTION
            END IF
         END IF
      CASE CHR$(13)           'Enter
         IF Force AND LEN(text$) < MaskCount THEN
         ELSE
            IsThere = 0
            FOR CheckReq = 1 TO LEN(Req$)
               A$ = MID$(Req$, CheckReq, 1)
               IF INSTR(1, text$, A$) = 0 THEN
                  IsThere = -1
               END IF
            NEXT
            IF NOT IsThere THEN
               EXIT DO
            END IF
         END IF
      CASE CHR$(0) + "M"      'Right
         IF Mask = 0 THEN
            IF CurrentPos < LEN(text$) + 1 THEN
               CurrentPos = CurrentPos + 1
            END IF
         END IF
      CASE CHR$(0) + "K"      'Left
         IF Mask = 0 THEN
            IF CurrentPos > 1 THEN
               CurrentPos = CurrentPos - 1
            END IF
         END IF
      CASE ELSE               'Anything else
         IF Mask = 0 THEN
            IF LEN(I$) = 1 AND LEN(text$) < MaxWidth THEN
               IfInsCurrent = CurrentPos
               IF Insert = 1 THEN IfInsCurrent = CurrentPos + 1
               text$ = MID$(text$, 1, CurrentPos - 1) + I$ + MID$(text$, IfInsCurrent, LEN(text$))
               CurrentPos = CurrentPos + 1
            END IF
         ELSE
            IF LEN(I$) = 1 AND LEN(text$) < MaskCount THEN
               IF MID$(Ms$, LEN(text$) + 1, 1) = "#" THEN
                  IF VAL(I$) > 0 OR I$ = "0" THEN
                     text$ = text$ + I$
                     CurrentPos = CurrentPos + 1
                  END IF
               ELSEIF MID$(Ms$, LEN(text$) + 1, 1) = "$" THEN
                  text$ = text$ + I$
                  CurrentPos = CurrentPos + 1
               END IF
            END IF
         END IF
      END SELECT
SkipIt:
      IF I$ <> "" THEN GOSUB PutText
   LOOP
   ' Set the text to be returned
   GetInput$ = text$
   ' Restore previous colors
   COLOR GetForeColor, GetBackColor
   LOCATE , , 0, 10, 11
   EXIT FUNCTION

PutText:
   IF Fore <> CURRENTFORE THEN
      COLOR Fore
   ELSE
      COLOR GetForeColor
   END IF
   IF Back <> CURRENTBACK THEN
      COLOR , Back
   ELSE
      COLOR , GetBackColor
   END IF
   ' Put the character for empty spaces
   LOCATE Row, Col + LEN(text$), 0: PRINT STRING$(MaxWidth - LEN(text$), Empty$);
   ' Print the text on the screen
   IF Mask = 0 THEN
      IF PasswordChar$ = "" THEN
         LOCATE Row, Col, 0: PRINT text$;
         IF Insert = 0 THEN
            LOCATE Row, Col + CurrentPos - 1, 1, 10, 11: PRINT ;
         ELSE
            LOCATE Row, Col + CurrentPos - 1, 1, 1, 11: PRINT ;
         END IF
      ELSE
         LOCATE Row, Col, 0: PRINT STRING$(LEN(text$), PasswordChar$);
         IF Insert = 0 THEN
            LOCATE Row, Col + CurrentPos - 1, 1, 10, 11: PRINT ;
         ELSE
            LOCATE Row, Col + CurrentPos - 1, 1, 1, 11: PRINT ;
         END IF
      END IF
   ELSE
      IF PasswordChar$ = "" THEN
         txt$ = Mask$
         B = 0
         AlR = 0
         FOR FillText = 1 TO LEN(Mask$)
            A$ = MID$(Mask$, FillText, 1)
            IF A$ = "$" OR A$ = "#" THEN
               B = B + 1
               IF B = LEN(text$) AND AlR = 0 THEN AlR = 1: NTxt = FillText
               MID$(txt$, FillText, 1) = MID$(text$, B, 1)
            END IF
         NEXT
         IF LEN(text$) = 0 THEN NTxt = 0
         FOR fillChar = 1 TO LEN(txt$)
            IF MID$(txt$, fillChar, 1) = "~" THEN
               MID$(txt$, fillChar, 1) = "$"
            END IF
         NEXT
         IF NOT ShowMask THEN txt$ = MID$(txt$, 1, NTxt)
         LOCATE Row, Col, 0: PRINT txt$;
         IF Insert = 0 THEN
            LOCATE Row, Col + NTxt, 1, 10, 11: PRINT ;
         ELSE
            LOCATE Row, Col + NTxt, 1, 1, 11: PRINT ;
         END IF
      ELSE
         txt$ = Mask$
         B = 0
         AlR = 0
         FOR FillText = 1 TO LEN(Mask$)
            A$ = MID$(Mask$, FillText, 1)
            IF A$ = "$" OR A$ = "#" THEN
               B = B + 1
               IF B = LEN(text$) AND AlR = 0 THEN AlR = 1: NTxt = FillText
               MID$(txt$, FillText, 1) = PasswordChar$
            END IF
         NEXT
         IF LEN(text$) = 0 THEN NTxt = 0
         FOR fillChar = 1 TO LEN(txt$)
            IF MID$(txt$, fillChar, 1) = "~" THEN
               MID$(txt$, fillChar, 1) = "$"
            END IF
         NEXT
         IF NOT ShowMask THEN txt$ = MID$(txt$, 1, NTxt)
         LOCATE Row, Col, 0: PRINT txt$;
         IF Insert = 0 THEN
            LOCATE Row, Col + NTxt, 1, 10, 11: PRINT ;
         ELSE
            LOCATE Row, Col + NTxt, 1, 1, 11: PRINT ;
         END IF
      END IF
   END IF
   RETURN
END FUNCTION

DEFSNG A-Z
SUB LoadIndex
FOR I = 1 TO 100
GET #1, I, bdata
IF bdata.NumPages = 0 AND bdata.year = 0 THEN NDX(I) = 0 ELSE NDX(I) = 1
NEXT I
END SUB

SUB Menu
ClearBoard
dbmbegin:
WIDTH 40, 25: COLOR 14, 8: CLS : center 2, "BookShop Database"
COLOR 9, 8: center 3, "By Charles Martin"

COLOR 11, 8: LOCATE 7, 1:
PRINT "     A.  Add a book"
PRINT
PRINT "     C.  Change a book's information"
PRINT
PRINT "     D.  Display selected book info"
PRINT
PRINT "     R.  Remove a book"
PRINT
PRINT "     S.  Search the database"
PRINT
PRINT "     X.  Exit"
PRINT : PRINT : COLOR 13
center CSRLIN, "Choose the desired operation by"
center CSRLIN, "pressing its letter:"
GMO:
k$ = LCASE$(INKEY$)
IF k$ = "a" THEN AddBook: GOTO dbmbegin:
IF k$ = "c" THEN ChangeInfo: GOTO dbmbegin:
IF k$ = "d" THEN GOTO DSR:
IF k$ = "r" THEN GOTO RMbook:
IF k$ = "s" THEN Search: GOTO dbmbegin:
IF k$ = "x" THEN CLOSE #1: SYSTEM
IF k$ = CHR$(27) THEN CLOSE #1: SYSTEM
GOTO GMO:

DSR:
CLS : COLOR 11, 8: center 2, "Display selected books"
LOCATE 5, 1: PRINT "Starting book number:   (From 1 to 100)"
             PRINT "Enter 0 to show ALL books"
50
st = VAL(GetInput$(7, 1, "", 3, 15, 1, "ù", 0, "", "", 0, ""))
IF st = 0 THEN st = 1: ed = 100: GOTO dit:
IF st < 1 OR st > 100 THEN GOTO 50

gen:
LOCATE 10, 1: COLOR 15, 8: PRINT "Ending book number:  (From"; st; "to 100)  "
55
ed = VAL(GetInput$(11, 1, "", 3, 15, 1, "ù", 0, "", "", 0, ""))
IF ed = 0 THEN ed = 100: GOTO dit:
IF ed < st OR st > 100 THEN GOTO 55

dit:
COLOR 14, 8:
PRINT : PRINT : PRINT : PRINT "About to display book numbers"
PRINT "from"; st; "to"; ed: SLEEP 3: DisplayRecords st, ed
GOTO dbmbegin:

RMbook:
WIDTH 40, 25: COLOR 9, 8: CLS : center 2, "REMOVE a book"

COLOR 14, 8:
LOCATE 5, 1: PRINT "Type in the book's number OR"
             PRINT "title that you wish to remove:"
1999
ClearBoard
A$ = LTRIM$(RTRIM$(GetInput$(7, 1, "", 30, 15, 1, "ù", 0, "", "", 0, "")))
match = VAL(A$)
IF A$ = "" THEN GOTO dbmbegin:
IF match <> 0 THEN GOTO KillIt:
IF match = 0 AND LEN(A$) < 3 THEN GOTO RMbook:
FindTitle (A$)

SELECT CASE found
CASE IS = 0: NoTitleMatch: GOTO RMbook:
CASE IS = 1: GOTO KillIt:
CASE ELSE:
     LOCATE 23, 1: PRINT "Type in the book's number that you want to remove:"
600
     match = VAL(GetInput$(23, 55, "", 3, 15, 1, "ù", 0, "", "", 0, ""))
     IF match = 0 THEN GOTO dbmbegin:
     IF match > 100 THEN GOTO 600
     IF NDX(match) = 0 THEN
        COLOR 12, 8: PRINT :  PRINT : PRINT "You currently do not have a book #"; match
        PRINT "Press any key to try again.": SLEEP: GOTO RMbook:
     ELSE
     CBDV
     PUT #1, match, bdata: NDX(match) = 0
     COLOR 13, 8: PRINT : PRINT "Book #"; match; "has been removed."
     PRINT "Press any key...": SLEEP: GOTO dbmbegin:
END IF
END SELECT

KillIt:
IF NDX(match) = 0 THEN
   COLOR 12, 8: PRINT : PRINT : PRINT "You currently do not have a book #"; match
   PRINT "Press any key to try again.": SLEEP: GOTO RMbook:
END IF
COLOR 15, 8: LOCATE 12, 1: PRINT "Are you sure you want to remove book"
PRINT "#"; match; " (Press Y or N)"
kion:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN
     CBDV
     PUT #1, match, bdata: NDX(match) = 0
     COLOR 13, 8: PRINT : PRINT "Book #"; match; "has been removed."
     PRINT "Press any key...": SLEEP: GOTO dbmbegin:
ELSEIF k$ = "n" THEN
    GOTO dbmbegin:
ELSE
END IF
GOTO kion:
END SUB

SUB NoTitleMatch
WIDTH 40, 25: CLS
COLOR 11, 8: center 7, "The title you typed"
          center 8, "in does not match any books."
          center 11, "Try typing in just PART of"
          center 12, "the title.  For example,"              '
          center 14, "Instead of " + Quote$("Cheaper by the dozen")
          center 15, "try " + Quote$("Cheaper") + " or " + Quote$("Dozen")
COLOR 14, 8: center 18, "Press any key to try again...": SLEEP
END SUB

FUNCTION Quote$ (txt$)
Quote$ = CHR$(34) + txt$ + CHR$(34)
END FUNCTION

SUB Search
GetType:
WIDTH 40, 25: COLOR 7, 8: CLS : center 2, "Search the Database"

COLOR 14, 8: LOCATE 6, 1: PRINT "Choose a search category:"
COLOR 15, 8: LOCATE 7, 1:
PRINT "     T. Title"
PRINT "     A. Author"
PRINT "     I. ISBN #"
PRINT "     Y. Copyright Year"
PRINT "     Q. Return to the Main Menu"
PRINT : PRINT : COLOR 13, 8: PRINT "Choose a category by pressing"
                          PRINT "the letter next to it:"
gst:
k$ = LCASE$(INKEY$)
IF k$ = "t" THEN GOTO ByTitle:
IF k$ = "a" THEN GOTO ByAuthor:
IF k$ = "i" THEN GOTO ByISBN:
IF k$ = "y" THEN GOTO ByYear:
IF k$ = "q" THEN EXIT SUB
IF k$ = CHR$(27) THEN EXIT SUB
GOTO gst:

ByTitle:
COLOR 15, 8: LOCATE 19, 1: PRINT "Type in the TITLE, or PART of the"
                        PRINT "TITLE, that you want to search for:"
A$ = LTRIM$(RTRIM$(GetInput$(21, 1, "", 30, 15, 1, "ù", 0, "", "", 0, "")))
IF A$ = "" THEN EXIT SUB
IF LEN(A$) < 3 AND A$ <> "" THEN GOTO ByTitle:
FindTitle (A$)
IF found = 0 THEN NoTitleMatch: GOTO GetType:
COLOR 10, 8: WaitForKey: EXIT SUB

ByAuthor:
COLOR 15, 8: LOCATE 19, 1: PRINT "Type in the AUTHOR's name, or PART"
                        PRINT "of the AUTHOR'S name, that you want"
                        PRINT "to search for:"
A$ = LTRIM$(RTRIM$(GetInput$(21, 21, "", 15, 15, 1, "ù", 0, "", "", 0, "")))
IF A$ = "" THEN EXIT SUB
IF LEN(A$) < 3 AND A$ <> "" THEN GOTO ByAuthor:

WIDTH 80, 25: COLOR 8, 8: CLS
COLOR 13, 8: LOCATE 1, 1: PRINT "  #  TITLE                           AUTHOR           ISBN           PAGES  YEAR"
COLOR 10, 8: LOCATE 2, 1: PRINT "---  ------------------------------  ---------------  -------------  -----  ----"
COLOR 15, 8: st$ = UCASE$(A$): R = 1: pr = 0: found = 0

FOR I = 1 TO 100
    GET #1, I, bdata
    GT$ = UCASE$(bdata.Author)
TOT2:
    IF pr > 19 THEN
       COLOR 10, 8: TapKey: R = 1
       pr = 0: VIEW PRINT 3 TO 23: CLS : VIEW PRINT: GOTO TOT2:
END IF
    IF INSTR(GT$, st$) > 0 THEN
       LOCATE R + 2, 1: COLOR 15, 8: PRINT USING "###"; I; TAB(6); : PRINT bdata.title; TAB(38); bdata.Author; TAB(55); bdata.isbn; TAB(71);
       PRINT USING "####"; bdata.NumPages; : PRINT TAB(77);
       PRINT USING "####"; bdata.year
       R = R + 1: pr = pr + 1: found = found + 1
    END IF
NEXT I
IF found = 0 THEN
WIDTH 40, 25: CLS : COLOR 15, 8: center 7, "The AUTHOR name you typed"
                   center 8, "in does not match any books."
                   center 10, "Try using just PART of the anme. "
                   center 11, "For example, instead of " + Quote$("Amanda Martin")
                   center 12, "try " + Quote$("Amanda")
                   COLOR 10, 8: center 15, "Press any key to try again...": SLEEP: GOTO GetType:
END IF
COLOR 10, 8: WaitForKey: EXIT SUB

ByISBN:
COLOR 15, 8: LOCATE 19, 1: PRINT "Type in the ISBN NUMBER that you"
                        PRINT "want to search for:"
A$ = LTRIM$(RTRIM$(GetInput$(20, 21, "", 13, 15, 1, "ù", 0, "", "", 0, "")))
IF A$ = "" THEN EXIT SUB
IF LEN(A$) <> 13 THEN GOTO ByISBN:
WIDTH 80, 25: COLOR 8, 8: CLS
COLOR 13, 8: LOCATE 1, 1: PRINT "  #  TITLE                           AUTHOR           ISBN           PAGES  YEAR"
COLOR 10, 8: LOCATE 2, 1: PRINT "---  ------------------------------  ---------------  -------------  -----  ----"
COLOR 15, 8: st$ = UCASE$(A$): R = 1: pr = 0: found = 0

FOR I = 1 TO 100
    GET #1, I, bdata
    GT$ = UCASE$(bdata.isbn)
TOT3:
    IF pr > 19 THEN
       COLOR 10, 8: TapKey: R = 1
       pr = 0: VIEW PRINT 3 TO 23: CLS : VIEW PRINT: GOTO TOT3:
END IF
    IF GT$ = st$ THEN
       LOCATE R + 2, 1: COLOR 15, 8: PRINT USING "###"; I; TAB(6); : PRINT bdata.title; TAB(38); bdata.Author; TAB(55); bdata.isbn; TAB(71);
       PRINT USING "####"; bdata.NumPages; : PRINT TAB(77);
       PRINT USING "####"; bdata.year
       R = R + 1: pr = pr + 1: found = found + 1
    END IF
NEXT I
IF found = 0 THEN
WIDTH 40, 25: CLS : COLOR 15, 8: center 7, "The ISBN # you typed in does"
                   center 8, "not match any books."
                   center 10, "Try using a different search"
                   center 11, "category such as " + Quote$("By Title")
                   center 12, "or " + Quote$("By Author.")
         COLOR 10, 8: center 15, "Press any key to try again...": SLEEP: GOTO GetType:
END IF
COLOR 10, 8: WaitForKey: EXIT SUB

ByYear:
COLOR 15, 8: LOCATE 19, 1: PRINT "Type in the YEAR that you"
                           PRINT "want to search for:"
year = VAL(GetInput$(20, 25, "", 4, 15, 1, "ù", 0, "", "", 0, ""))
IF year = 0 THEN EXIT SUB
COLOR 13, 8: CLS
center 2, "Search the Database"
center 3, STR$(year)

LOCATE 7, 1: COLOR 14, 8: PRINT "Choose one of the following by number:"
COLOR 15, 8: PRINT "     1. Books made BEFORE"; year
          PRINT "     2. Books made DURING"; year
          PRINT "     3. Books made AFTER "; year
gsm:
k$ = LCASE$(INKEY$)
IF k$ = "1" THEN YearSearch = 1: ma$ = "BEFORE": GOTO YRsearch:
IF k$ = "2" THEN YearSearch = 2: ma$ = "DURING": GOTO YRsearch:
IF k$ = "3" THEN YearSearch = 3: ma$ = "AFTER": GOTO YRsearch:
IF k$ = CHR$(27) THEN EXIT SUB
GOTO gsm

YRsearch:
WIDTH 80, 25: COLOR 8, 8: CLS
COLOR 13, 8: LOCATE 1, 1: PRINT "  #  TITLE                           AUTHOR           ISBN           PAGES  YEAR"
COLOR 10, 8: LOCATE 2, 1: PRINT "---  ------------------------------  ---------------  -------------  -----  ----"
COLOR 15, 8: R = 1: pr = 0: found = 0

FOR I = 1 TO 100
    GET #1, I, bdata
TOT4:
    ryear = bdata.year
    IF ryear = 0 THEN GOTO eoys:
    IF pr > 19 THEN
       COLOR 10, 8: TapKey: R = 1
       pr = 0: VIEW PRINT 3 TO 23: CLS : VIEW PRINT: GOTO TOT4:
    END IF
SELECT CASE YearSearch
    CASE IS = 1
    IF ryear < year THEN
       LOCATE R + 2, 1: COLOR 15, 8: PRINT USING "###"; I; TAB(6); : PRINT bdata.title; TAB(38); bdata.Author; TAB(55); bdata.isbn; TAB(71);
       PRINT USING "####"; bdata.NumPages; : PRINT TAB(77);
       PRINT USING "####"; bdata.year
       R = R + 1: pr = pr + 1: found = found + 1: GOTO eoys:
    ELSE GOTO eoys:
    END IF
    CASE IS = 2:
    IF ryear = year THEN
       LOCATE R + 2, 1: COLOR 15, 8: PRINT USING "###"; I; TAB(6); : PRINT bdata.title; TAB(38); bdata.Author; TAB(55); bdata.isbn; TAB(71);
       PRINT USING "####"; bdata.NumPages; : PRINT TAB(77);
       PRINT USING "####"; bdata.year
       R = R + 1: pr = pr + 1: found = found + 1: GOTO eoys:
   ELSE : GOTO eoys:
   END IF
   CASE IS = 3:
   IF ryear > year THEN
       LOCATE R + 2, 1: COLOR 15, 8: PRINT USING "###"; I; TAB(6); : PRINT bdata.title; TAB(38); bdata.Author; TAB(55); bdata.isbn; TAB(71);
       PRINT USING "####"; bdata.NumPages; : PRINT TAB(77);
       PRINT USING "####"; bdata.year
       R = R + 1: pr = pr + 1: found = found + 1: GOTO eoys:
   ELSE GOTO eoys:
   END IF
END SELECT

eoys:
NEXT I
IF found = 0 THEN
WIDTH 40, 25: CLS : COLOR 15, 8: center 7, "No books were found with a"
                    center 8, "copyright year " + ma$ + STR$(year)
                   center 10, ""
                   center 11, ""
                   center 12, ""
         COLOR 10, 8: center 15, "Press any key to try again...": SLEEP: GOTO GetType:
END IF
COLOR 10, 8: WaitForKey: EXIT SUB
END SUB

SUB TapKey
LOCATE 23, 21: PRINT "Tap a key to continue the list...": SLEEP
END SUB

SUB WaitForKey
LOCATE 23, 21: PRINT "Press ENTER to continue...": DO UNTIL INKEY$ = CHR$(13): LOOP
END SUB

