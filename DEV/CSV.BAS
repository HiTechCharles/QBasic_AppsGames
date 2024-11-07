DECLARE FUNCTION trim$ (ttt$)

'CSV converter  NO BLANK LINES IN CSV ALLOWED!
'This type of file has the format of:
'Col1,Col2,col3,col4,Col5,Col6

'positions on each line where collumns start  (for the OUTPUT file.)  if you
'wanted the second collumn of data to start 10 spaces from the left side of
'the screen, Col2=10


'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Program Setup ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
Col2 = 9: col3 = 17: col4 = 25: col5 = 41: col6 = 49    '³
csvfile$ = "det.csv": output$ = "DET.txt"               '³
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SHELL "del " + output$ + " > nul": CLS 'delete output file before U start
OPEN csvfile$ FOR INPUT AS 1: OPEN output$ FOR APPEND AS 2

t! = TIMER  'time the operation
DO WHILE NOT EOF(1)
    INPUT #1, dat$  'Get input for all collumns  add more INPUTs if more collumns
    INPUT #1, day$
    INPUT #1, hoa$
    INPUT #1, opp$
    INPUT #1, tim$
    INPUT #1, Net$

    PRINT #2, day$;
    PRINT #2, TAB(Col2); dat$;
    PRINT #2, TAB(col3); hoa$;
    PRINT #2, TAB(col4); opp$;
    PRINT #2, TAB(col5); tim$;
    PRINT #2, TAB(col6); opp$;
    
    IF EOF(1) THEN EXIT DO   'extra check for EOF
LOOP
PRINT "conversion from "; csvfile$; " to "; output$; " took"; TIMER - t!; "seconds"

CLOSE #1, #2: SHELL "edit sl.txt software.csv"  'edit files after processing

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

