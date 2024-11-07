DECLARE SUB center (Row, text$)
DECLARE SUB DisplayHow ()
DECLARE SUB HowItWorks ()
DECLARE FUNCTION InputString$ (Row%, column%, inputfield$, Foreground%, Background%, ValidCharacters$, ReturnMode%, EntryMode%, CaseMode%)
DECLARE SUB GetAndconvert ()
DECLARE SUB Intro ()
DECLARE FUNCTION letter2number$ (ltr$)
DECLARE FUNCTION trim$ (ttt$)
COMMON SHARED wts$, CalcBtn$

Intro
GetAndconvert
DisplayHow
HowItWorks

SUB center (Row, text$)
    col = 21 - LEN(text$) / 2: LOCATE Row, col: PRINT text$
END SUB

SUB DisplayHow
    COLOR 10, 0: CLS :
    PRINT
    PRINT "How's how to spell "; wts$
    PRINT "on your calculator!"
    PRINT
    PRINT "     1.  Clear the calculator"
    PRINT
    PRINT "     2.  press the following numbers in"
    PRINT "         the order shown:"
    PRINT "         "; CalcBtn$
    PRINT
    PRINT "     3.  Rotate the calculator 180ø"
    PRINT
    PRINT "     4.  Read the screen, and show the"
    PRINT "         audiance."
    PRINT
    PRINT
    PRINT "     Press any key to learn how this"
    PRINT "     all works!..."
    SLEEP
END SUB

SUB GetAndconvert
        COLOR 14: LOCATE 17, 1, 0: PRINT "Type in the word to"
                                   PRINT "spell:  >";
        wts$ = InputString$(18, 10, SPACE$(10), 15, 9, "IEHSGLO", 5, 1, 2):
        COLOR , 8: CalcBtn$ = ""

        FOR I = LEN(wts$) TO 1 STEP -1
            LTC$ = MID$(wts$, I, 1)
            IF I = LEN(wts$) AND LTC$ = "O" THEN CalcBtn$ = ". "
            CalcBtn$ = CalcBtn$ + letter2number(LTC$) + " "
        NEXT I
END SUB

SUB HowItWorks

END SUB

FUNCTION InputString$ (Row%, column%, inputfield$, Foreground%, Background%, ValidCharacters$, ReturnMode%, EntryMode%, CaseMode%)

'*******************************************************************************
'*   this function inputs a string of the desired length and desired characters*
'*   at the selected row, column and color                                     *
'*******************************************************************************

'   parameter list:
'   Row% - line# on screen to input string
'   Column% - column on screen to input string
'   InputField$ - the original string to edit
'   Foreground% - character color of input field
'   Background% - background color of input field
'   ValidCharacters$ - list of allowable input characters: "" = all allowed
'   ReturnMode% - way to return string:
'      1: return entire field as-is
'      2: return field less any trailing blanks
'      3: return field less any leading blanks
'      4: return field less both leading and trailing blanks
'      5: return field with all blanks removed
'      6: left justify and kill blanks between 1st and last char
'      7: right justify and kill inner blanks
'   EntryMode% - way to terminate input:
'      1: terminates only when enter is pressed
'      2: terminates after cursor goes past last character in field
'   CaseMode% - forces uppercase, lowercase or no preference
'      1: accept as entered
'      2: forces upper case
'      3: forces lower case

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
    CursorPosition% = LEN(trim$(inputfield$)) + 1                 ' 1st position in entry string
    EndColumn% = column% + Length% - 1    ' last column in entry string

    COLOR Foreground%, Background%        ' set specified colors
    LOCATE Row%, column%, 0               ' locate cursor
    PRINT inputfield$;                    ' display original field
    CurrentColumn% = column% + LEN(trim$(inputfield$))
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

SUB Intro
    WIDTH 40, 25: COLOR 9: CLS
    center 2, "Spell on Your Calculator": COLOR 14
    center 3, "By Charles Martin": COLOR 15
    LOCATE 6, 1: PRINT "Impress your friends - spell words on"
                 PRINT "your calculator!  Just type in a word"
                 PRINT "using the available letters shown at"
                 PRINT "the bottom.  The program will tell"
                 PRINT "you what to hit on your calculator"
                 PRINT "to spell the desired word."

    COLOR 13: LOCATE 16, 28: PRINT "PRESS  TO GET"
    COLOR 10: LOCATE 17, 28: PRINT "  1      I"
              LOCATE 18, 28: PRINT "  3      E"
              LOCATE 19, 28: PRINT "  4      H"
              LOCATE 20, 28: PRINT "  5      S"
              LOCATE 21, 28: PRINT "  6      G"
              LOCATE 22, 28: PRINT "  7      L"
              LOCATE 23, 28: PRINT "  0      O"
END SUB

FUNCTION letter2number$ (ltr$)
    SELECT CASE ltr$
        CASE IS = "I": letter2number$ = "1"
        CASE IS = "E": letter2number$ = "3"
        CASE IS = "H": letter2number$ = "4"
        CASE IS = "S": letter2number$ = "5"
        CASE IS = "G": letter2number$ = "6"
        CASE IS = "L": letter2number$ = "7"
        CASE IS = "O": letter2number$ = "0"
    END SELECT
END FUNCTION

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

