DECLARE FUNCTION Exists (fi$)           'Check to see if file exists
DECLARE SUB FindSection (SEC$)          'Find INI file section
DECLARE FUNCTION LineType (IFN)         'Used by FindSection and ValueOf
DECLARE FUNCTION LoadINI (fi$, IFN)     'Load an INI file
DECLARE FUNCTION I2a$ (h)               'Convert numeric vars to string
DECLARE FUNCTION Trim$ (ttt$)           'Remove leading/trailing spaces
DECLARE FUNCTION ValueOf$ (key$, SEC$)  'Get the value of a key
COMMON SHARED FileStatus, fenem, key$, Value$

ON ERROR GOTO ErrorHandler:

'Error Codes
'    1.  File does not exist
'    2.  INI file section not found
'    3.  Key not present ANYwhere in the file
'    4.  Key does not exist in specified section
'    5.  Key found, but not in specified section


'File Status Codes
'    1 - Successful file load
'   -1 - File not found
'   -2 - File number in use


'Variables
'CurrentSection$        Current file section
'Key$                   Key
'Value$                 Value


'Line Types
'   -1 - End of file
'    0 - Comment
'    1 - Section  (CurrentSection$ gets changed
'    2 - Key  (Key$ and value$ get set


ErrorHandler:
    SELECT CASE ERR
        CASE IS = 0: SYSTEM
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
            PRINT "Error #"; ERR; "occured.": SYSTEM
    END SELECT

FUNCTION Exists (fi$)
    FileStatus = 0: fenem = 1
    OPEN fi$ FOR INPUT AS #237
    IF FileStatus = 0 THEN Exists = 1: CLOSE #237 ELSE Exists = -1
    fenem = 0
END FUNCTION

SUB FindSection (SEC$)
END SUB

FUNCTION I2a$ (h)
    I2a$ = Trim$(STR$(h))
END FUNCTION

FUNCTION LineType (IFN)
    IF EOF(IFN) THEN LineType = -1: EXIT FUNCTION
    LINE INPUT #IFN, wl$
    wl$ = Trim$(wl$)

    IF LEFT$(wl$, 1) = "#" OR LEFT$(wl$, 1) = ";" THEN
        LineType = 0: EXIT FUNCTION
    ELSEIF LEFT$(wl$, 1) = "[" AND RIGHT$(wl$, 1) = "]" THEN
        LineType = 1: CurSection$ = MID$(wl$, 2, LEN(wl$) - 1)
        key$ = "": Value$ = ""
    END IF
    
    e = INSTR(wl$, "=")
        IF e > 1 THEN
            key$ = MID$(wl$, 1, e - 1)
            Value$ = MID$(wl$, e + 1)
        END IF
END FUNCTION

FUNCTION LoadINI (ftl$, IFN)
    '+1 - successful file load
    '-1 - file does not exist
    '-2 - File Number already used

        SELECT CASE Exists(ftl$)
            CASE IS = 1
                OPEN ftl$ FOR INPUT AS #IFN
                LoadINI = 1: EXIT FUNCTION
            CASE IS = -1
                LoadINI = -1: EXIT FUNCTION
            END SELECT
END FUNCTION

FUNCTION Trim$ (ttt$)
    Trim$ = LTRIM$(RTRIM$(ttt$))
END FUNCTION

FUNCTION ValueOf$ (key$, SEC$)


END FUNCTION

