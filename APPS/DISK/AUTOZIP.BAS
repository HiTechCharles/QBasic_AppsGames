COLOR 15, 0: CLS
SHELL "dir /a:d /b /-p /o:gn > List.txt"

OPEN "LIST.TXT" FOR INPUT AS #1: OPEN "AUtozip.bat" FOR APPEND AS #2
PRINT #2, "@echo off"

DO UNTIL EOF(1)
    LINE INPUT #1, file$
    file$ = LTRIM$(RTRIM$(file$))
    PRINT #2, "@pkzip -exx -r " + CHR$(34); file$ + ".zip" + CHR$(34); " " + CHR$(34) + file$ + "\*.*" + CHR$(34)
    PRINT #2, "@echo."
LOOP

PRINT #2, "@md _NewZips": PRINT #2, "@move *.zip _newzips > nul"
CLOSE 1, 2: : KILL "list.txt": SHELL "autozip.bat":
KILL "autozip.bat": SYSTEM

