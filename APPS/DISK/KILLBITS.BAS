DECLARE FUNCTION Exists (fts$)
DECLARE SUB FileSet ()
DECLARE SUB Finished ()
DECLARE SUB gotodir (dtt$)
DECLARE FUNCTION NameOnly$ (ftp$)
DECLARE SUB Openfile ()
DECLARE SUB Parse (stp$)
DECLARE FUNCTION rinstr% (Start%, Search$, LookFor$)
DECLARE SUB scanfile ()
DECLARE FUNCTION trim$ (ttt$)
COMMON SHARED nos, fi$, fenem, FileStatus, asp$

DIM SHARED nas$(100)
ON ERROR GOTO ErrorHandler:
    CLS
    Parse COMMAND$
    FileSet
    Openfile
    scanfile
    Finished

ErrorHandler:
    SELECT CASE ERR
        CASE IS = 53:
            IF fenem = 1 THEN
                FileStatus = -1
                RESUME NEXT
            ELSE
                SOUND 720, 1.5
                PRINT UCASE$(fi$); " could not be found."
                SLEEP 3: SYSTEM
            END IF
        CASE ELSE
            PRINT "Error #"; ERR; "occure.": SYSTEM
    END SELECT

FUNCTION Exists (fts$)
    FileStatus = 0: fenem = 1
    OPEN fts$ FOR INPUT AS #9
    IF FileStatus = 0 THEN Exists = 1 ELSE Exists = -1
    fenem = 0
END FUNCTION

SUB FileSet
    asp$ = CURDIR$
    p = rinstr(0, nas$(1), "\")
    IF p > 0 THEN
        fi$ = MID$(nas$(1), p + 1)
        gotodir LEFT$(nas$(1), p - 1)
    ELSE
        fi$ = nas$(1)
    END IF
END SUB

SUB Finished
    CLOSE #1, #2
    fenem = 1: KILL NameOnly$(fi$) + ".bak": fenem = 0
    NAME fi$ AS NameOnly$(fi$) + ".bak"
    NAME "_pass_" AS fi$
    gotodir asp$
    SYSTEM
END SUB

SUB gotodir (dtt$)
    IF MID$(dtt$, 2, 1) = ":" THEN
        drive$ = LEFT$(dtt$, 2)
        path$ = MID$(dtt$, 3)
        SHELL drive$
        SHELL "cd" + path$
    ELSE
        SHELL "cd" + dtt$
    END IF
END SUB

FUNCTION NameOnly$ (ftp$)
    p = INSTR(ftp$, ".")
    IF p = 0 THEN p = LEN(ftp$)
    NameOnly$ = LEFT$(ftp$, p - 1)
END FUNCTION

SUB Openfile
    OPEN fi$ FOR INPUT AS #1
    OPEN "_pass_" FOR APPEND AS #2
END SUB

SUB Parse (stp$)
'Splits a string into separate words  Each word is stored in
'an array called WD$  NOS contains the number of separate
'words.  Requires TRIM function

'   USAGE:  Parse "<STRING OF WORDS>"
'EXAMPLES:  PARSE "The quick brown fox jumps over the lazy dog." '9 NOS

WordSep$ = " "   'this is what separates each word
stp$ = trim$(stp$): LOS = LEN(stp$): wd = 1
IF stp$ = "" THEN EXIT SUB

FOR LTR = 1 TO LOS
    CH$ = MID$(stp$, LTR, 1)
    SELECT CASE CH$
        CASE IS = WordSep$: nas$(wd) = WSF$: wd = wd + 1: WSF$ = ""
        CASE ELSE:  WSF$ = WSF$ + CH$
    END SELECT
NEXT LTR

nas$(wd) = WSF$
nos = wd

END SUB

FUNCTION rinstr% (Start%, Search$, LookFor$)

'*******************************************************************************
'*  "Reverse INSTR".  Returns the character position of the LAST occurrence    *
'*  of a substring within another. If the Start argument is greater than zero, *
'*  search$ is truncated to (Start-1) before the search begins.  The Start     *
'*  argument is useful for subsequent calls to Rinstr, i.e., to find the second*
'*  to last occurrence, etc.                                                   *
'*  Example:   Rinstr(0,"Peter Piper","er")  --> 10                            *
'*             Rinstr(10,"Peter Piper","er") --> 4  (Searches "Peter Pip")     *
'*******************************************************************************

'   if either argument is null, return 0
    IF Search$ = "" OR LookFor$ = "" THEN
       rinstr% = 0
       EXIT FUNCTION
    END IF

'   return 0 if Start% > length of Search$ or is negative
    IF Start% > LEN(Search$) OR Start < 0 THEN
     rinstr% = 0
     EXIT FUNCTION
    END IF

'   truncate if start pos is > 0, otherwise use original search string
    IF Start% > 0 THEN
       s$ = LEFT$(Search$, Start% - 1)
    ELSE
       s$ = Search$
    END IF

    Last% = 0
'   get first occurrence
    X% = INSTR(s$, LookFor$)

'   go thru string, increasing start pos each time substring is found
    WHILE X% > 0
       Last% = X%
       X% = INSTR((Last% + 1), s$, LookFor$)
    WEND

    rinstr% = Last%


END FUNCTION

SUB scanfile
    DO UNTIL EOF(1)
        LINE INPUT #1, ol$: LTS$ = UCASE$(ol$)
        FOR s = 2 TO nos
            IF INSTR(LTS$, nas$(s)) > 0 THEN GOTO NoPass:
        NEXT s
        PRINT #2, ol$
NoPass:
    LOOP
END SUB

FUNCTION trim$ (ttt$)
    trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

