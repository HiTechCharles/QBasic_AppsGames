DECLARE SUB Cleararea (t, b, Lt, rt)
DECLARE SUB PrintW (text$)
DECLARE FUNCTION Trim$ (ttt$)
DECLARE SUB wordwrap (top, btm, left, right, fg, bg, text$, wal)
COMMON SHARED cp, wsf$

WIDTH 40, 25
    COLOR 14: CLS
    PRINT "ษอออออออออออออออออออป"
    PRINT "บ                   บ"
    PRINT "บ                   บ"
    PRINT "บ                   บ"
    PRINT "บ                   บ"
    PRINT "บ                   บ"
    PRINT "ศอออออออออออออออออออผ"

wordwrap 2, 6, 2, 20, 15, 9, "My fellow Americans, ask not what your country can do for you -- ask what can you   do for your country.                                  --John F. Kennedy", 1

SUB Cleararea (t, b, Lt, rt)
    FOR I = t TO b
        LOCATE I, Lt: PRINT TAB(rt + 1);
    NEXT I
END SUB

SUB PrintW (text$)
    bol = 0: LOS = LEN(Trim$(text$)): cp = POS(0)

    FOR LTR = 1 TO LOS
        CH$ = MID$(text$, LTR, 1)
        SELECT CASE CH$
            CASE IS = " ": GOSUB PNW:
            CASE ELSE:  wsf$ = wsf$ + CH$
        END SELECT
    NEXT LTR

    GOSUB PNW:
    EXIT SUB


'----------------------------------------------------------------------------
PNW:  IF cp + LEN(wsf$) > 40 THEN PRINT : bol = 0
        IF bol <> 0 THEN PRINT " " + wsf$;  ELSE PRINT wsf$;
        cp = POS(0): wsf$ = "": bol = bol + 1: RETURN
END SUB

FUNCTION Trim$ (ttt$)
    Trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

SUB wordwrap (top, btm, left, right, fg, bg, text$, wal)
'WordWrap - Prints a string, keeping within set screen boundaries.
'For example, you have a text box drawn from rows 1 to 7, collumns 1 to 20.
'This would make the area inside the box rows 2-6 and collumns 2-19.
'Using this SUB and any string, the text will print to this area only,
'stopping at the end of each box fill.

'PARAMETERS:
'   TOP, BOTTOM              First and last lines where printing is allowed.
'   LEFT, RIGHT              Horizontal screen area.
'   FOREGROUND, BACKGROUND   Colors to use.
'   TEXT                     Text to print inside the selected area.
'   WAIT                     If 1, WordWrap will pause after last screen of text.

'   USAGE:  WordWrap top, bottom, left, right, foreground, Background, text, wait
'EXAMPLES:  WordWrap 2, 22, 2, 20, 15, 0, "Text", 0

    COLOR fg, bg
    Cleararea top, btm, left, right
    LOCATE top, left: wp = 0: LOS = LEN(Trim$(text$)): cp = POS(0)

    FOR LTR = 1 TO LOS
        CH$ = MID$(text$, LTR, 1)
        SELECT CASE CH$
            CASE IS = " ": GOSUB PrintNextWord:
            CASE ELSE:  wsf$ = wsf$ + CH$
        END SELECT
    NEXT LTR

    GOSUB PrintNextWord
    IF wal > 0 THEN GOSUB wayt:
    EXIT SUB

'----------------------------------------------------------------------------
PrintNextWord:  IF cp + LEN(wsf$) > right THEN
                    IF CSRLIN + 1 > btm THEN
                        GOSUB wayt:
                        Cleararea top, btm, left, right
                        LOCATE top, left: : COLOR fg, bg
                        PRINT wsf$;
                    ELSE
                        LOCATE CSRLIN + 1, left: PRINT wsf$;
                    END IF
                ELSE
                    IF wp <> 0 THEN PRINT " " + wsf$;  ELSE PRINT wsf$;
                END IF
                cp = POS(0): wsf$ = "": wp = wp + 1: RETURN

wayt:   COLOR 31: LOCATE btm, right: PRINT "Û": SLEEP:
        COLOR fg, bg: LOCATE btm, right: PRINT " ": RETURN
END SUB

