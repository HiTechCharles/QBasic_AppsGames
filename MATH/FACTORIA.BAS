FAS:
COLOR 15: CLS : PRINT "This program computes the factorials"
PRINT "of X by iterative multiplications": PRINT : INPUT "What is X?  ", x
IF x < 2 OR x > 19 THEN PRINT : PRINT "X must be greater than 1, and less then 20.": SLEEP 3: GOTO FAS:
z# = 1: FOR I = 1 TO x: z# = z# * I: NEXT I
PRINT : PRINT "X ="; INT(x), "X! = "; : PRINT USING "###,###,###,###,###,###"; z#
PRINT






