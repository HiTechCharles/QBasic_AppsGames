cs$ = RTRIM$(COMMAND$)
SELECT CASE cs$
    CASE IS = "ON", "OFF": SHELL "verify " + cs$: SYSTEM
    CASE IS = "N": SHELL "VERIFY ON": SYSTEM
    CASE IS = "F": SHELL "VERIFY OFF": SYSTEM
    CASE IS = "STATUS", "STAT": SHELL "verify": SYSTEM
    CASE IS = "/?", "-?", "HELP", "MAN", "-MAN": GOTO USAGE:
END SELECT
SHELL "verify > v": OPEN "v" FOR INPUT AS #1: INPUT #1, cs$
cs$ = RIGHT$(cs$, 3): cs$ = UCASE$(LTRIM$(RTRIM$(cs$))): CLOSE #1: KILL "V"
IF cs$ = "OFF" THEN ns$ = "ON" ELSE ns$ = "OFF"
COLOR 15: PRINT : PRINT : PRINT "Integrity checking is "; cs$; " - Turn it "; ns$; "?"
PRINT "(Press Y or N):"
gk:
    k$ = UCASE$(INPUT$(1))
    IF k$ = "Y" THEN SHELL "verify " + ns$: GOTO eop:
    IF k$ = "N" THEN GOTO eop:
GOTO gk:
eop: PRINT : PRINT : SYSTEM
USAGE:
COLOR 15: PRINT : PRINT : PRINT "VERIF - By Charles Martin"
PRINT "Tells your operating system whether to"
PRINT "verify that your files are being written"
PRINT "correctly to a disk."
PRINT ""
PRINT "USAGE:  VERIF ON"
PRINT "        VERIF OFF"
PRINT ""
PRINT "Use VERIF without a parameter to display"
PRINT "and/or change the current VERIF setting."
PRINT : PRINT : SYSTEM

