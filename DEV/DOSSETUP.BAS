'COMPILE OPTIONS:  stand-alone EXE, Alternate math, Quick call opt, dos OR OS/2, near strings
SHELL "CD > C:\D": OPEN "C:\D" FOR INPUT AS #1: LINE INPUT #1, CD$
fullpath$ = LTRIM$(RTRIM$((UCASE$(CD$)))):  CLOSE #1: KILL "C:\d"
COLOR 15, 8: CLS : SHELL "cd i386":  SHELL "smartdrv"
SHELL "winnt /a /u:..\unattend.txt /s:" + fullpath$: SHELL "CD .."

