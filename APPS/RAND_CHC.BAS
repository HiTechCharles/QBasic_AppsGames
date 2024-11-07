DECLARE SUB center (row, text$)

IF INSTR(COMMAND$, "/N") > 0 OR INSTR(COMMAND$, "-N") > 0 THEN WIDTH 40, 25: GOTO begin:

WIDTH 40, 25

begin:
COLOR 12: CLS : center 2, "RandomStuff": COLOR 15: center 4, "By Charles Martin"

LOCATE 7, 1: PRINT "How many choices or items?"
             PRINT "(Between 2 and 17)"; : INPUT "  ", ch
IF ch < 2 OR ch > 17 THEN PRINT : PRINT "Between 2 and 17 choices, please.": SLEEP 3: GOTO begin:
CLS
PRINT "Now, tell me the choices/items to pick  from.  Type in each choice name, then"
PRINT "hit ENTER.     ("; ch; "choices selected )"
PRINT : PRINT : COLOR 14: DIM ci$(ch): DIM cc(ch): DIM NC(ch)

FOR y = 1 TO ch
sol:
    PRINT : PRINT "Choice #"; : PRINT USING "##"; y; : PRINT " - "; : INPUT "", ci$(y)
    IF LEN(ci$(y)) < 2 OR LEN(ci$(y)) > 23 THEN PRINT : PRINT "Names should have between 2 and 23     letters in it.": SLEEP 3: CLS : GOTO sol:
NEXT

COLOR 9: CLS : PRINT "C#   Choice name": LOCATE 1, 31: PRINT "Level"
      COLOR 14: PRINT "ออ   อออออออออออ": LOCATE 2, 31: PRINT "อออออ"
COLOR 15
FOR v = 1 TO ch
    PRINT USING "##   "; v; : PRINT ci$(v)
NEXT
RANDOMIZE tiemr

DO UNTIL w = 1
    FOR u = 1 TO ch
        LOCATE (u + 2), 31: PRINT USING "#,###,###"; cc(u)
    NEXT

   
    FOR u = 1 TO ch
        IF cc(u) >= 1000000 THEN w = 1: wc = u
        NC(u) = INT(RND * 20)
        cc(u) = cc(u) + NC(u)
    NEXT u
LOOP

Winner:
FOR e = 1 TO ch
LOCATE (e + 2), 31: PRINT USING "#,###,###"; cc(e)
NEXT

PLAY "o3l15cg"
COLOR 14: LOCATE 21, 1: PRINT "Your computer thinks you should choose"
          LOCATE 22, 10: PRINT "#"; wc; "- "; ci$(wc)
          LOCATE 23, 1: PRINT "Press any key to quit.": SLEEP: SYSTEM

SUB center (row, text$)

col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$;

END SUB

