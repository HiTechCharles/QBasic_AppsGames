WIDTH 40, 25: COLOR 9: CLS : LOCATE 2, 5: PRINT "The Bank's Computer System": CorrPswd$ = "cash"
COLOR 14: LOCATE 9, 1: PRINT "Password:  "; : COLOR 15
DO
5   char1$ = INPUT$(1)
    IF char1$ = CHR$(13) THEN GOTO 10
    IF char1$ <> "" THEN PRINT "*"; : pswd$ = pswd$ + char1$
        
    'x = POS(0) + 1: y = CSRLIN: LOCATE 10, 1: COLOR 9: PRINT "TYPED:  "; pswd$: LOCATE x, y: COLOR 14
    GOTO 5
LOOP
  
10 
IF pswd$ <> CorrPswd$ THEN BEEP: PRINT :  PRINT : PRINT "No, that's not it... GOODBYE!": SYSTEM
IF pswd$ = CorrPswd$ THEN PRINT : PRINT : PRINT "Cha Ching!  It's money!": SYSTEM

