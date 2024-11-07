SHELL "del c:\primes.txt": OPEN "C:\primes.txt" FOR APPEND AS #1

begin:
COLOR 15, 9: CLS :

PRINT : PRINT "Prime number listing program"
PRINT : INPUT "What's the highest number you want listed?  (2-999,999,999)?   ", hpn&
IF hpn& < 2 OR hpn& > 999999999 THEN GOTO begin:

ppn:
PRINT #1, "Prime numbers listed form 1 to"; hpn&

PRINT : PRINT : PRINT "Listed prime numbers will go into a file C:\PRIMES.TXT"
PRINT : PRINT : SHELL "pause": CLS

starttime = TIMER
FOR num& = 1 TO hpn& STEP 2
  Prime = 1
  FOR I = 2 TO SQR(num&)
    IF num& MOD I = 0 THEN Prime = 0
  NEXT I
  IF Prime = 1 THEN PNF = PNF + 1: PRINT USING "###,###,###"; num&; : PRINT "",
   IF Prime = 1 THEN PRINT #1, USING "###,###,###"; num&; : PRINT #1, " is prime."
NEXT num&

PLAY "L8CEFGP16L8EL4Gg": elapsedtime = TIMER - starttime:
PRINT

minutes = INT(elapsedtime / 60)
IF minutes < 1 THEN minutes = 0: seconds = elapsedtime MOD 60
COLOR 14: PRINT : PRINT :  PRINT "It took "; minutes; "minutes,"; seconds; "seconds."
PRINT "to find all the prime numbers."

PRINT #1, "/\/\/\/\/\/\/\/\/\/\/\/\/\"
PRINT #1,
PRINT #1, "It took "; minutes; "minutes,"; seconds; "seconds."
PRINT #1, "to find all the prime numbers.": CLOSE #1
   

    
    
     PRINT : PRINT : SHELL "pause"

  CLS
  PRINT : PRINT "Would you like to see the contents of the list file?  (Y or N)"
pfd:
LET k$ = LCASE$(INKEY$)
IF k$ = "y" THEN SHELL "more < c:\primes.txt": GOTO endprog:
IF k$ = "n" THEN PRINT : PRINT "The listed primes file is at C:\PRIMES.TXT": GOTO endprog:
IF k$ = CHR$(27) THEN PRINT : PRINT "The listed primes file is at C:\PRIMES.TXT": GOTO endprog:
GOTO pfd:

endprog:
PRINT : PRINT : SHELL "pause": SYSTEM


