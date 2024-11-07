DECLARE FUNCTION DRV.freespace# (Drive$)
'MUST compile with QBasic 4.5
'You must also load QB's extra library.  When starting QBasic, use this syntax:
'   QB /Lqb

IF COMMAND$ <> "" THEN
    d$ = LEFT$(COMMAND$, 1)
ELSE
    SHELL "CD > FI": OPEN "FI" FOR INPUT AS #1: INPUT #1, L$: d$ = LEFT$(L$, 1)
    CLOSE #1: KILL "FI"
END IF
WIDTH 40, 25: COLOR 15: CLS
d# = DRV.freespace#(d$): K# = d# / 1024: M# = K# / 1024
PRINT "DRIVE "; d$; " HAS":
PRINT USING "     #,###,###,###.##  BYTES FREE"; d#
PRINT USING "     #,###,###,###.##  KB FREE"; K#
PRINT USING "     #,###,###,###.##  MB FREE"; M#
PRINT : PRINT : PRINT "Press any key...": SLEEP: SYSTEM

FUNCTION DRV.freespace# (Drive$)
 'convert drive letter to corresponding letter
  driveseg% = VARSEG(Drive$)  'get drive$'s segment
  driveoff% = SADD(Drive$)    'get drive$'s offset
  DEF SEG = driveseg%         'define segment
  Drive% = PEEK(driveoff%)    'get ASCII equivalent of first letter of drive$
  DEF SEG
  IF Drive$ = "" THEN         'if length of drive$ is zero, use default drive
    Drive% = 0  'default drive
  ELSEIF Drive% >= ASC("A") AND Drive% <= ASC("Z") THEN
    Drive% = Drive% - 64
  ELSEIF Drive% >= ASC("a") AND Drive% <= ASC("z") THEN
    Drive% = Drive% - 96
  ELSE                        'if nothing fits, exit with error code (-1)
    DRV.freespace = -1
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
  dx% = Drive%                'transfer data from drive% to dx%
  CALL absolute(var1%, var2%, ax%, bx%, cx%, dx%, asmoff%) 'execute
  DEF SEG
  'if invalid drive
  IF ax% = &HFFFF THEN DRV.freespace = -1: EXIT FUNCTION

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
  DRV.freespace# = 1# * ax& * bx& * cx& '(1# is for typecasting just in case)
END FUNCTION

