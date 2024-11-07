DECLARE SUB autoformat (ntf)
DECLARE FUNCTION i2a$ (h)

CLS
INPUT "NUMBER:  ", num

PRINT : PRINT : autoformat num

SUB autoformat (ntf)
    ntf$ = i2a$(ntf): dp = INSTR(ntf$, ".")
    IF dp > 0 THEN
        wp$ = MID$(ntf$, 1, dp - 1)
        dp$ = MID$(ntf$, (dp + 1), (LEN(ntf$) - dp))
    ELSE
        wp$ = ntf$: dp$ = ""
    END IF

    SELECT CASE LEN(wp$)
        CASE IS = 1: FMT$ = "#"
        CASE IS = 2: FMT$ = "##"
        CASE IS = 3: FMT$ = "###"
        CASE IS = 4: FMT$ = "#,###"
        CASE IS = 5: FMT$ = "##,###"
        CASE IS = 6: FMT$ = "###,###"
        CASE IS = 7: FMT$ = "#,###,###"
        CASE IS = 8: FMT$ = "##,###,###"
        CASE IS = 9: FMT$ = "###,###,###"
        CASE IS = 10: FMT$ = "#,###,###,###"
        CASE IS = 11: FMT$ = "##,###,###,###"
        CASE IS = 12: FMT$ = "###,###,###,###"
        CASE ELSE: FMT$ = "###,###,###,###,###"
    END SELECT

    IF dp > 0 THEN FMT$ = FMT$ + "." + STRING$(LEN(ntf$) - dp, "#")
    
    PRINT USING FMT$; VAL(wp$ + "." + dp$)
END SUB

FUNCTION i2a$ (h)
    i2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

