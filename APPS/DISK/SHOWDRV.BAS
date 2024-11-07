DECLARE SUB absolute (var1%, var2%, var3%, var4%, var5%, var6%, offset%)
DECLARE SUB center (row, text$)
DECLARE FUNCTION drv.totalspace# (drive$)
DECLARE FUNCTION GETKEY$ (allowed$)
COMMON SHARED avail$, DrvList
ON ERROR GOTO ERRORHANDLER:  avail$ = ""

DrvList$ = "acdefghijklmnopqrstuvwxyz"
FOR i = 1 TO 25
    CurDrv$ = MID$(DrvList$, i, 1): TOT# = drv.totalspace#(CurDrv$)
    IF TOT# > 0 THEN avail$ = avail$ + UCASE$(CurDrv$)
NEXT i
'-----------------

WIDTH 40, 25: COLOR 0: CLS : COLOR 11:  center 2, "Show the contents of a drive"
center 3, "By Charles Martin"

COLOR 14: : center 7, "AVAILABLE DRIVE LETTERS:"
FOR i = 1 TO LEN(avail$)
    st$ = st$ + MID$(avail$, i, 1)
    IF LEN(avail$) < 10 THEN st$ = st$ + "   "
NEXT i
COLOR 15, 0: center 9, st$: COLOR 13: center 15, "Press the letter of the drive"
center 16, "whose contents you want to see:"

DL$ = GETKEY$(avail$)
IF DL$ = CHR$(27) THEN SYSTEM

SHELL "cd\": COLOR 9: LOCATE 19, 1: PRINT "The contents of drive "; UCASE$(DL$)
PRINT "will now be displayed..."

Z = FREEFILE
SHELL "start /max " + DL$ + ":\"
SYSTEM
'-----------------
ERRORHANDLER:
SELECT CASE ERR
    CASE IS = 71: RESUME NEXT
    CASE ELSE: PRINT "ERROR #"; ERR: SYSTEM
END SELECT

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

'Finds out the total space of a drive in bytes.
'INPUT:
'þ Drive$ is the letter representation of the drive one wants to find out the
'  total space of.  If its length is zero, it is assumed to be the current
'  drive.  No space must come in front of the string (ie - " A:\" is not a
'  valid string)
'RETURN ON SUCCESS:
'þ The total space of the drive
'RETURN ON ERROR:
'þ -1 is returned on any type of error.  Such errors include non-alphabetic
'  drive letters and no such drive error)
FUNCTION drv.totalspace# (drive$)
  'convert drive letter to corresponding letter
  driveseg% = VARSEG(drive$)  'get drive$'s segment
  driveoff% = SADD(drive$)    'get drive$'s offset
  DEF SEG = driveseg%         'define segment
  drive% = PEEK(driveoff%)    'get ASCII equivalent of first letter of drive$
  DEF SEG
  IF drive$ = "" THEN         'if length of drive$ is zero, use default drive
    drive% = 0  'default drive
  ELSEIF drive% >= ASC("A") AND drive% <= ASC("Z") THEN
    drive% = drive% - 64
  ELSEIF drive% >= ASC("a") AND drive% <= ASC("z") THEN
    drive% = drive% - 96
  ELSE                        'if nothing fits, exit with error code (-1)
    drv.totalspace = -1
    EXIT FUNCTION
  END IF

  'store machine code
  asm$ = ""
  asm$ = asm$ + CHR$(&H55)                              'push bp
  asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)                 'mov bp, sp
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)     'mov bx, [bp+06]
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H17)                 'mov dx, [bx]
  asm$ = asm$ + CHR$(&HB4) + CHR$(&H36)                 'mov ah, 36h
  asm$ = asm$ + CHR$(&HCD) + CHR$(&H21)                 'int 21h
  asm$ = asm$ + CHR$(&H53)                              'push bx
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HC)     'mov bx, [bp+0c]
  asm$ = asm$ + CHR$(&H89) + CHR$(&H7)                  'mov [bx], ax
  asm$ = asm$ + CHR$(&H58)                              'pop ax
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HA)     'mov bx, [bp+0a]
  asm$ = asm$ + CHR$(&H89) + CHR$(&H7)                  'mov [bx], ax
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)     'mov bx, [bp+08]
  asm$ = asm$ + CHR$(&H89) + CHR$(&HF)                  'mov [bx], cx
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)     'mov bx, [bp+06]
  asm$ = asm$ + CHR$(&H89) + CHR$(&H17)                 'mov [bx], dx
  asm$ = asm$ + CHR$(&H5D)                              'pop bp
  asm$ = asm$ + CHR$(&HCA) + CHR$(&H8) + CHR$(&H0)      'retf 0008h

  'execute
  asmseg% = VARSEG(asm$)      'get segment of stored machine codes
  asmoff% = SADD(asm$)        'get offset of stored machine codes
  DEF SEG = asmseg%           'define segment
  dx% = drive%                'transfer data from drive% to dx%
  CALL absolute(var1%, var2%, ax%, bx%, cx%, dx%, asmoff%) 'execute
  DEF SEG
  'if invalid drive
  IF ax% = &HFFFF THEN drv.totalspace = -1: EXIT FUNCTION

  'convert integers to long integers (because of sign problems)
  ax& = ax% AND &H7FFF                            'ax = sectors per cluster
  IF (ax% AND &H8000) THEN ax& = (ax& OR &H8000&)
  bx& = bx% AND &H7FFF                            'bx = number of free clstrs
  IF (bx% AND &H8000) THEN bx& = (bx& OR &H8000&)
  cx& = cx% AND &H7FFF                            'cx = bytes per sector
  IF (cx% AND &H8000) THEN cx& = (cx& OR &H8000&)
  dx& = dx% AND &H7FFF                            'dx = total clusters
  IF (dx% AND &H8000) THEN dx& = (dx& OR &H8000&)

  'calculate total space and return
  drv.totalspace# = 1# * ax& * cx& * dx& '(1# is for typecasting just in case)
END FUNCTION

FUNCTION GETKEY$ (allowed$)
AllowEsc = 1: allowed$ = UCASE$(allowed$)
GTT:
    KY$ = UCASE$(INKEY$)
    IF KY$ <> "" AND INSTR(allowed$, KY$) > 0 THEN GETKEY$ = KY$: EXIT FUNCTION
    IF AllowEsc <> 0 AND KY$ = CHR$(27) THEN GETKEY$ = CHR$(27): EXIT FUNCTION  'Allow ESCape
GOTO GTT:

END FUNCTION

