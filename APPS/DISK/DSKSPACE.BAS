DECLARE FUNCTION AfterIs$ ()
DECLARE FUNCTION CurrentTime$ ()
DECLARE SUB absolute (var1%, var2%, var3%, var4%, var5%, var6%, offset%)
DECLARE FUNCTION drv.freespace# (drive$)
DECLARE FUNCTION drv.totalspace# (drive$)
DECLARE FUNCTION GetKey$ (allowed$)
DECLARE FUNCTION I2a$ (h)
COMMON SHARED Avail$, DrvList$, ldl
ON ERROR GOTO ERRORHANDLER:

DrvList$ = "acdefghijklmnopqrstuvwxyz": ldl = LEN(DrvList$)
DIM SHARED label$(ldl), serial$(ldl), PercUsed(ldl), total#(ldl), free#(ldl)

WIDTH 40, 25: COLOR 15: CLS

FOR I = 1 TO ldl
    perc = (I / LEN(ldl)) * 100: LOCATE 1, 1: PRINT I2a$(perc); "%"
    CurDrv$ = MID$(DrvList$, I, 1)
    total#(I) = drv.totalspace#(CurDrv$)
   
    IF total#(I) > 0 THEN Avail$ = Avail$ + UCASE$(CurDrv$) ELSE GOTO bol:
    SHELL "vol " + CurDrv$ + ": > VL"
    OPEN "vl" FOR INPUT AS #5
    LINE INPUT #5, D$
    label$(I) = AfterIs$: serial$(I) = AfterIs$: CLOSE #5: KILL "VL"
    free#(I) = drv.freespace#(CurDrv$)
    PercUsed(I) = (free#(I) / total#(I)) * 100
bol:
NEXT I

CLS
OPEN "Dskspace.txt" FOR APPEND AS #5
PRINT #5, "Disk Report generated "; DATE$; "  "; CurrentTime$
PRINT #5, ""
PRINT #5, ""
PRINT #5, " DRIVE   VOLUME        SERIAL                 TOTAL SPACE      FREE SPACE"
PRINT #5, "LETTER   LABEL         NUMBER      % USED         (bytes)         (bytes)"
PRINT #5, "ออออออ   อออออ         ออออออ      ออออออ          ออออออ         อออออออ"
FOR I = 1 TO 25
    perc = (I / 25) * 100: LOCATE 1, 1: PRINT I2a$(perc); "%"
    CurDrv$ = UCASE$(MID$(DrvList$, I, 1))
    IF total#(I) < 1 THEN GOTO botl:
    PRINT #5, USING "     !   &"; CurDrv$; label$(I);
   
    PRINT #5, TAB(24); serial$(I);
    PRINT #5, TAB(36); USING "###.##"; PercUsed!(I);
    PRINT #5, TAB(45); USING "#,###,###,###"; total#(I);
    PRINT #5, TAB(61); USING "#,###,###,###"; free#(I)
botl:
NEXT I
PRINT #5, "": PRINT #5, "": CLOSE #5: SYSTEM


ERRORHANDLER:
SELECT CASE ERR
    CASE IS = 71: RESUME NEXT
    CASE ELSE: PRINT "ERROR #"; ERR: SYSTEM
END SELECT
CLOSE #5

FUNCTION AfterIs$
    LINE INPUT #5, D$: D$ = LTRIM$(RTRIM$(D$))
    D = INSTR(D$, "is") + 3
    AfterIs$ = MID$(D$, D, 11)
END FUNCTION

FUNCTION CurrentTime$
h = VAL(LEFT$(TIME$, 2))
M = VAL(MID$(TIME$, 4, 2)): M$ = I2a$(M)
S = VAL(RIGHT$(TIME$, 2)): S$ = I2a$(S)

SELECT CASE h
    CASE IS = 0: AP$ = "A": SH = 12
    CASE IS < 12: AP$ = "A": SH = h
    CASE IS = 12: AP$ = "P": SH = h
    CASE IS > 12: AP$ = "P": SH = h - 12
END SELECT

SH$ = I2a$(SH)
'             hour : minute <2 spaces> <AM or PM>
CurrentTime$ = SH$ + ":" + M$ + " " + AP$ + "M"



END FUNCTION

'Finds out the available free space of a drive in bytes.
'INPUT:
'þ Drive$ is the letter representation of the drive one wants to find out the
'  free space of.  If its length is zero, it is assumed to be the current
'  drive.  No space must come in front of the string (ie - " A:\" is not a
'  valid string)
'RETURN ON SUCCESS:
'þ The free space of the drive
'RETURN ON ERROR:
'þ -1 is returned on any type of error.  Such errors include non-alphabetic
'  drive letters and no such drive error
'COMMENT:
'þ Lost clusters are assumed to be in use
FUNCTION drv.freespace# (drive$)
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
    drv.freespace = -1
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
  IF ax% = &HFFFF THEN drv.freespace = -1: EXIT FUNCTION

  'convert integers to long integers (because of sign problems)
  ax& = ax% AND &H7FFF                            'ax = sectors per cluster
  IF (ax% AND &H8000) THEN ax& = (ax& OR &H8000&)
  bx& = bx% AND &H7FFF                            'bx = number of free clstrs
  IF (bx% AND &H8000) THEN bx& = (bx& OR &H8000&)
  cx& = cx% AND &H7FFF                            'cx = bytes per sector
  IF (cx% AND &H8000) THEN cx& = (cx& OR &H8000&)
  dx& = dx% AND &H7FFF                            'dx = total clusters
  IF (dx% AND &H8000) THEN dx& = (dx& OR &H8000&)

  'calculate free space and return
  drv.freespace# = 1# * ax& * bx& * cx& '(1# is for typecasting just in case)
END FUNCTION

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

FUNCTION GetKey$ (allowed$)
allowescape = 1:  allowed$ = UCASE$(allowed$): allowed$ = LTRIM$(RTRIM$(allowed$))

GTT:
    ky$ = UCASE$(INKEY$)
        IF ky$ <> "" AND INSTR(allowed$, ky$) > 0 THEN GetKey$ = ky$: EXIT FUNCTION
    IF allowescape <> 0 AND ky$ = CHR$(27) THEN GetKey$ = CHR$(27)
GOTO GTT:
END FUNCTION

FUNCTION I2a$ (h)
I2a$ = LTRIM$(RTRIM$(STR$(h)))
END FUNCTION

