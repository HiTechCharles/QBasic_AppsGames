BP:
COLOR 15: CLS :  LOCATE 7, 1: INPUT "What's the message?  ", msg$
IF LEN(msg$) < 1 OR LEN(msg$) > 15 THEN GOTO BP:

CLS : msg$ = LTRIM$(RTRIM$(msg$)):  RANDOMIZE TIMER
    
     DO WHILE INKEY$ = ""
am:     L = L + 1
        IF L = 125 THEN L = 0: CLS : GOTO am:
        C = INT(RND * 15) + 1: COLOR C: PRINT msg$; "  "; : SLEEP 1
      LOOP
      FOR S = 1 TO 3
        FOR i = 650 TO 1000 STEP 25: SOUND i, 1: NEXT i
      NEXT S

