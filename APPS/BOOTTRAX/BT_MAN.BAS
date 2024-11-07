DECLARE SUB INTRO ()
DECLARE SUB center (row!, Text$)
DECLARE SUB gifload (A$)

INTRO

btb:
SCREEN 0: WIDTH 40, 25: COLOR 12: CLS : center 2, "BootTrax Manager"
COLOR 15: center 4, "By Charles Martin"

COLOR 11: LOCATE 7, 1: PRINT "V. View Log file - Shows each time"
                       PRINT "   the PC was turned on, as well as how"
                       PRINT "   many times per day."
                       
 COLOR 9: LOCATE 11, 1: PRINT "D. Delete log file - Resets the file"
                        PRINT "   that keeps track of computer usage."
COLOR 15: LOCATE 14, 1: PRINT "R. Recreate files - Makes new recording"
                        PRINT "   files in case of program errors."

COLOR 10: LOCATE 17, 1: PRINT "H. Help!!"
COLOR 13: LOCATE 18, 1: PRINT "X. Exit the manager."

COLOR 14: LOCATE 21, 1: PRINT "Press the letter next"
                        PRINT "to the option you want:"
glf:                    
k$ = LCASE$(INKEY$)
IF k$ = "v" THEN GOTO ViewLog:
IF k$ = "d" THEN GOTO DelLog:
IF k$ = "r" THEN GOTO RS:
IF k$ = "h" THEN SHELL "notepad BTreadme.txt": GOTO btb:
IF k$ = "x" THEN SYSTEM
IF k$ = CHR$(27) THEN SYSTEM
GOTO glf:

ViewLog:
SHELL "Notepad c:\pc_use.log": GOTO btb:

DelLog:
COLOR 15: CLS :
LOCATE 7, 1: PRINT "Are you sure you want to reset the"
PRINT "PC tracking file?  (Press Y or N):"
don:
k$ = LCASE$(INKEY$)
IF k$ = "y" THEN SHELL "DEL C:\PC_use.log": SHELL "BT_setup": GOTO btb:
IF k$ = "n" THEN COLOR 12: PRINT : PRINT "Wise choice.  It can't": PRINT "hurt to keep the file": SLEEP 3: GOTO btb:
IF k$ = CHR$(27) THEN PRINT : PRINT "Wise choice.  It can't": PRINT "hurt to keep the file.": SLEEP 3: GOTO btb:
GOTO don:

RS:
CLS
SHELL "if exist c:\pc_times.log del c:\pc_times.log"
SHELL "if exist c:\pc_use.log del c:\pc_use.log"
OPEN "C:\pc_times.log" FOR APPEND AS #3
PRINT #3, "01-01-2002": PRINT #3, times: CLOSE #3
GOTO btb:

SUB center (row, Text$)

col = 21 - LEN(Text$) / 2
LOCATE row, col: PRINT Text$

END SUB

SUB gifload (A$)
DEFINT A-Z
DIM Prefix(4095), Suffix(4095), OutStack(4095), shiftout%(8)
DIM Ybase AS LONG, powersof2(11) AS LONG, WorkCode AS LONG

FOR A% = 0 TO 7: shiftout%(8 - A%) = 2 ^ A%: NEXT A%
FOR A% = 0 TO 11: powersof2(A%) = 2 ^ A%: NEXT A%
IF A$ = "" THEN INPUT "GIF file"; A$: IF A$ = "" THEN END
IF INSTR(A$, ".") = 0 THEN A$ = A$ + ".gif"
OPEN A$ FOR BINARY AS #1
A$ = "      ": GET #1, , A$
IF A$ <> "GIF87a" THEN PRINT "Not a GIF87a file.": END
GET #1, , TotalX: GET #1, , TotalY: GOSUB GetByte
NumColors = 2 ^ ((A% AND 7) + 1): NoPalette = (A% AND 128) = 0
GOSUB GetByte: Background = A%
GOSUB GetByte: IF A% <> 0 THEN PRINT "Bad screen descriptor.": END
IF NoPalette = 0 THEN P$ = SPACE$(NumColors * 3): GET #1, , P$
DO
    GOSUB GetByte
    IF A% = 44 THEN
        EXIT DO
    ELSEIF A% <> 33 THEN
        PRINT "Unknown extension type.": END
    END IF
    GOSUB GetByte
    DO: GOSUB GetByte: A$ = SPACE$(A%): GET #1, , A$: LOOP UNTIL A% = 0
LOOP
GET #1, , XStart: GET #1, , YStart: GET #1, , XLength: GET #1, , YLength
XEnd = XStart + XLength: YEnd = YStart + YLength: GOSUB GetByte
IF A% AND 128 THEN PRINT "Can't handle local colormaps.": END
Interlaced = A% AND 64: PassNumber = 0: PassStep = 8
GOSUB GetByte
ClearCode = 2 ^ A%
EOSCode = ClearCode + 1
FirstCode = ClearCode + 2: NextCode = FirstCode
StartCodeSize = A% + 1: CodeSize = StartCodeSize
StartMaxCode = 2 ^ (A% + 1) - 1: MaxCode = StartMaxCode

BitsIn = 0: BlockSize = 0: BlockPointer = 1
x% = XStart: y% = YStart: Ybase = y% * 320&

SCREEN 13: DEF SEG = &HA000
IF NoPalette = 0 THEN
    OUT &H3C7, 0: OUT &H3C8, 0
    FOR A% = 1 TO NumColors * 3: OUT &H3C9, ASC(MID$(P$, A%, 1)) \ 4: NEXT A%
END IF
LINE (0, 0)-(319, 199), Background, BF
DO
    GOSUB GetCode
    IF Code <> EOSCode THEN
        IF Code = ClearCode THEN
            NextCode = FirstCode
            CodeSize = StartCodeSize
            MaxCode = StartMaxCode
            GOSUB GetCode
            CurCode = Code: LastCode = Code: LastPixel = Code
            IF x% < 320 THEN POKE x% + Ybase, LastPixel
            x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine
        ELSE
            CurCode = Code: StackPointer = 0
            IF Code > NextCode THEN EXIT DO
            IF Code = NextCode THEN
                CurCode = LastCode
                OutStack(StackPointer) = LastPixel
                StackPointer = StackPointer + 1
            END IF

            DO WHILE CurCode >= FirstCode
                OutStack(StackPointer) = Suffix(CurCode)
                StackPointer = StackPointer + 1
                CurCode = Prefix(CurCode)
            LOOP

            LastPixel = CurCode
            IF x% < 320 THEN POKE x% + Ybase, LastPixel
            x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine

            FOR A% = StackPointer - 1 TO 0 STEP -1
                IF x% < 320 THEN POKE x% + Ybase, OutStack(A%)
                x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine
            NEXT A%

            IF NextCode < 4096 THEN
                Prefix(NextCode) = LastCode
                Suffix(NextCode) = LastPixel
                NextCode = NextCode + 1
                IF NextCode > MaxCode AND CodeSize < 12 THEN
                    CodeSize = CodeSize + 1
                    MaxCode = MaxCode * 2 + 1
                END IF
            END IF
            LastCode = Code
        END IF
    END IF
LOOP UNTIL DoneFlag OR Code = EOSCode
'BEEP
'A$ = INPUT$(1)
CLOSE #1
EXIT SUB

GetByte: A$ = " ": GET #1, , A$: A% = ASC(A$): RETURN

NextScanLine:
    IF Interlaced THEN
        y% = y% + PassStep
        IF y% >= YEnd THEN
            PassNumber = PassNumber + 1
            SELECT CASE PassNumber
            CASE 1: y% = 4: PassStep = 8
            CASE 2: y% = 2: PassStep = 4
            CASE 3: y% = 1: PassStep = 2
            END SELECT
        END IF
    ELSE
        y% = y% + 1
    END IF
    x% = XStart: Ybase = y% * 320&: DoneFlag = y% > 199
RETURN
GetCode:
    IF BitsIn = 0 THEN GOSUB ReadBufferedByte: LastChar = A%: BitsIn = 8
    WorkCode = LastChar \ shiftout%(BitsIn)
    DO WHILE CodeSize > BitsIn
        GOSUB ReadBufferedByte: LastChar = A%
        WorkCode = WorkCode OR LastChar * powersof2(BitsIn)
        BitsIn = BitsIn + 8
    LOOP
    BitsIn = BitsIn - CodeSize
    Code = WorkCode AND MaxCode
RETURN
ReadBufferedByte:
    IF BlockPointer > BlockSize THEN
        GOSUB GetByte: BlockSize = A%
        A$ = SPACE$(BlockSize): GET #1, , A$
        BlockPointer = 1
    END IF
    A% = ASC(MID$(A$, BlockPointer, 1)): BlockPointer = BlockPointer + 1
RETURN

END SUB

DEFSNG A-Z
SUB INTRO

CLS : gifload "ms.gif"
COLOR 27: LOCATE 11, 4: PRINT "Martin"
          LOCATE 11, 29: PRINT "Software"
center 21, "P R E S E N T S"
SLEEP 3: SCREEN 0: CLS : SCREEN 13: CLS :

gifload "bt.gif"
LOCATE 1, 27: PRINT " Press any key": LOCATE 2, 27: PRINT "to continue...": SLEEP:

END SUB

