DECLARE SUB DoneScanning ()
DECLARE SUB Info ()
DECLARE SUB Scan ()
COMMON SHARED nos, rsn
DIM SHARED wav$(2500)


Scan
RANDOMIZE TIMER: rsn = INT(RND * nos) + 1
Info
SHELL "microwav " + wav$(rsn)

SUB DoneScanning
    CLOSE #1: KILL "W"
END SUB

SUB Info
IF INSTR(COMMAND$, "/D") > 0 THEN
    PRINT
    PRINT "Number of WAV files: "; nos
    PRINT "       File to play:  "; wav$(rsn)
END IF

END SUB

SUB Scan
    SHELL "dir /a:-d /b /o:gn /-p *.wav > w": OPEN "W" FOR INPUT AS #1: nos = 1

    DO UNTIL EOF(1)
        IF nos > 2500 THEN PRINT "Limit of 2500 files!  A higher-capacity version is available upon request from drwfan54@yahoo.com": DoneScanning: SYSTEM
        LINE INPUT #1, wav$(nos)
        IF NOT EOF(1) THEN nos = nos + 1
    LOOP
    DoneScanning
END SUB

