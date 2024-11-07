DECLARE SUB CTimer ()
DECLARE SUB StartStopDisplay ()
DECLARE SUB usage ()
DECLARE SUB usage ()
DECLARE FUNCTION CurrentTime$ ()
DECLARE FUNCTION I2a$ (h)
DECLARE SUB printrealtime (rx, cx)
DECLARE SUB realtime (nos!)
DECLARE SUB TimeToFile ()
COMMON SHARED hrs, min, sec

IF INSTR(COMMAND$, "/?") > 0 THEN usage
IF INSTR(COMMAND$, "-?") > 0 THEN usage
IF INSTR(COMMAND$, "HELP") > 0 THEN usage
IF COMMAND$ = "" THEN usage

StartStopDisplay
TimeToFile
SYSTEM

SUB CTimer
    st = TIMER: SHELL COMMAND$:  realtime TIMER - st
END SUB

FUNCTION CurrentTime$
h = VAL(LEFT$(TIME$, 2))
m = VAL(MID$(TIME$, 4, 2)): m$ = I2a$(m)
S = VAL(RIGHT$(TIME$, 2)): S$ = I2a$(S)

SELECT CASE h
    CASE IS = 0: AP$ = "A": SH = 12
    CASE IS < 12: AP$ = "A": SH = h
    CASE IS = 12: AP$ = "P": SH = h
    CASE IS > 12: AP$ = "P": SH = h - 12
END SELECT

SH$ = I2a$(SH)
'             hour : minute <2 spaces> <AM or PM>
IF LEN(m$) = 1 THEN m$ = "0" + m$
CurrentTime$ = SH$ + ":" + m$ + " " + AP$ + "M"

END FUNCTION

FUNCTION I2a$ (h)
    I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

SUB printrealtime (rx, cx)
LOCATE rx
IF hrs <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "###,### Hour"; hrs;
    IF hrs > 1 THEN PRINT "s"
    IF hrs = 1 THEN PRINT : PRINT
    IF hrs >= 2 THEN PRINT
IF min <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "     ## Minute"; min;
    IF min > 1 THEN PRINT "s"
    IF min = 1 THEN PRINT : PRINT
    IF min >= 2 THEN PRINT
    
IF sec <> 0 THEN LOCATE CSRLIN, cx: PRINT USING "     ## Second"; sec;
    IF sec >= 2 THEN PRINT "s"
END SUB

SUB realtime (nos)
    IF nos < 60 THEN
        hrs = 0: min = 0: sec = nos: GOTO 50    'if < 1 min, all seconds, done
    ELSEIF nos >= 60 AND nos < 3600 THEN
        hrs = 0: min = INT(nos / 60): sim = min * 60: sec = nos - sim: GOTO 50
    ELSEIF nos >= 3600 THEN
        min = INT(nos / 60): hrs = INT(min / 60):
        sim = min * 60: sec = nos - sim: min = min - (hrs * 60): GOTO 50
    END IF
50
END SUB

SUB StartStopDisplay
    OPEN "CMDTIMER.TXT" FOR APPEND AS 1
    COLOR 15: CLS : PRINT "COMMAND STARTED ON " + DATE$ + " @" + CurrentTime$
    PRINT #1, "COMMAND STARTED ON " + DATE$ + " @" + CurrentTime$
    PRINT STRING$(40, 196): COLOR 15:  PRINT : PRINT : PRINT STRING$(40, 196)
    CTimer

    PRINT "COMMAND ENDED ON " + DATE$ + " @" + CurrentTime$
    PRINT #1, "COMMAND   ENDED ON " + DATE$ + " @" + CurrentTime$
    PRINT : PRINT #1, ""
    PRINT "ELAPSED TIME:"; : printrealtime CSRLIN, 15
END SUB

SUB TimeToFile
    IF hrs <> 0 THEN PRINT #1, I2a$(hrs); " hour";
        IF hrs > 1 THEN PRINT #1, "s";
        IF hrs > 0 THEN PRINT #1, ", ";
    IF min <> 0 THEN PRINT #1, I2a$(min); " minute";
        IF min > 1 THEN PRINT #1, "s";
        IF min > 0 THEN PRINT #1, ", ";
    IF sec <> 0 THEN PRINT #1, I2a$(INT(sec)); " second";
        IF sec <> 1 THEN PRINT #1, "s";

    PRINT #1, ""
    PRINT #1, ""
    PRINT #1, "          컴컴컴컴컴컴컴컴評컴컴컴컴컴컴컴�"
    CLOSE #1
END SUB

SUB usage
PRINT : PRINT : COLOR 15:
PRINT "Command Timer by Charles Martin"
PRINT "Tells you how long a DOS command, pro-"
PRINT "gram, or batch file takes to complete."
PRINT "Anything that can be typed at the"
PRINT "regular DOS prompt is allowed."
PRINT
PRINT "To time your work using an actual"
PRINT "DOS prompt, use CMDTIMER command"
PRINT
PRINT "   USAGE:  CMDTIMER <Command/program/batchFile>"
PRINT "EXAMPLES:  CMDTIMER Copy *.* A:"
PRINT "           CMDTIMER network.bat"
PRINT : PRINT : SYSTEM
END SUB

