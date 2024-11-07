DECLARE SUB center (row, text$)
DIM SHARED items, num, avg, tot, min, max, median, mode

IF COMMAND$ <> "" THEN GOTO FileProc:

avbegin:
WIDTH 40, 25: COLOR 14: CLS : center 2, CHR$(34) + "On the Average" + CHR$(34)
center 3, "By Charles Martin"

COLOR 9: LOCATE 6, 1: PRINT "After giving this program a series of"
                      PRINT "numbers, you will get the average of"
                      PRINT "those numbers.": PRINT : PRINT : COLOR 15

DO UNTIL INKEY$ = "": LOOP
PRINT "Your first number, please:  "; : INPUT "", num
IF num = 0 THEN PRINT : PRINT "You cannot use 0 as the first number.": SLEEP 3: CLS : GOTO avbegin:
min = num: max = num: avg = num: total = num

NuScrn:
VIEW PRINT: CLS
items = items + 1: avg = total / items: median = (min + max) / 2: COLOR 15: LOCATE 2, 1
             PRINT "      # OF ITEMS: "; USING "#,###,###,###"; items
COLOR 15, 9: PRINT " CURRENT AVERAGE: "; USING "#,###,###,###.###"; avg
COLOR 15, 8: PRINT "          MEDIAN: "; USING "#,###,###,###.###"; median
COLOR 15, 9: PRINT "      LAST ENTRY: "; USING "#,###,###,###.###"; num
COLOR 15, 8: PRINT "    LOWEST ENTRY: "; USING "#,###,###,###.###"; min
COLOR 15, 9: PRINT "   HIGHEST ENTRY: "; USING "#,###,###,###.###"; max
COLOR 15, 8: PRINT "TOTAL OF NUMBERS: "; USING "#,###,###,###.###"; total
VIEW PRINT 9 TO 23:

chimp:
COLOR 14, 8:
LOCATE 13, 1: PRINT "What is the next number?  (Ener 0 to"
PRINT "stop giving numbers.)  ";
COLOR 11: INPUT ">", num
IF num = 0 THEN GOTO EndAvg:
total = total + num
IF num > max THEN max = num
IF num < min THEN min = num
GOTO NuScrn:

EndAvg:
COLOR 12, 8: : PRINT : PRINT : PRINT "OK, that's everything.": SLEEP 2
VIEW PRINT: CLS
avg = total / items: COLOR 15: LOCATE 2, 1:
             PRINT "      # OF ITEMS: "; USING "#,###,###,###"; items
COLOR 15, 9: PRINT "   FINAL AVERAGE: "; USING "#,###,###,###.###"; avg
COLOR 15, 8: PRINT "          MEDIAN: "; USING "#,###,###,###.###"; median
COLOR 15, 9: PRINT "    LOWEST ENTRY: "; USING "#,###,###,###.###"; min
COLOR 15, 8: PRINT "   HIGHEST ENTRY: "; USING "#,###,###,###.###"; max
COLOR 15, 9: PRINT "TOTAL OF NUMBERS: "; USING "#,###,###,###.###"; total
COLOR 10, 8: LOCATE 14, 1: PRINT "Another run?  (Press Y or N)"

gch:
k$ = LCASE$(INKEY$)
    IF k$ = "y" THEN CLEAR : GOTO avbegin:
    IF k$ = "n" THEN PRINT : PRINT "Good bye.": SYSTEM
    IF k$ = CHR$(27) THEN PRINT : PRINT "Good bye.": SYSTEM
GOTO gch:

FileProc:
OPEN COMMAND$ FOR INPUT AS #5: min = 9999999
DO UNTIL EOF(5)
    INPUT #5, num
    total = total + num: items = items + 1
    IF num > max THEN max = num
    IF mum < min THEN min = num
LOOP

avg = total / items: median = (min + max) / 2
CLOSE #5: OPEN COMMAND$ FOR APPEND AS #5
PRINT #5, ""
PRINT #5, ""
PRINT #5, "               컴컴컴컴컴컴컴컴"
PRINT #5, ""
PRINT #5, "      # OF ITEMS:  "; items
PRINT #5, "   FINAL AVERAGE:  "; avg
PRINT #5, "          MEDIAN:  "; median
PRINT #5, "    LOWEST ENTRY:  "; min
PRINT #5, "   HIGHEST ENTRY:  "; max
PRINT #5, "TOTAL OF NUMBERS:  "; total
CLOSE #5: BEEP: BEEP: SYSTEM

SUB center (row, text$)

col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$

END SUB

