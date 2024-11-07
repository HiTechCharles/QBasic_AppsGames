' Bmpload Version 2 By Doug Barry (PD Computers)
'  This is the fastest BMP Loader I have ever seen, and I wrote it !!!!
'  God it's fast, anyway it uses assembler to copy a variable to the another
'  part of the memory, here I have used it to put the image data into the
'  bit of the Physical ram that overlaps the video memory, hence loading
'  the picture in one vertical blank space (one 50Hz cycle)
'
' Thanks load to Dan Holmes for finding out the memory copying routine, and
'  Andrew Griffin/Jon Sutton for info on the BMP structure.
'  Also to the guy/gal that posted ShowBMP9.bas on the net and to the
'  guy/gal that wrote CPLASMA.BAS for the "OUT" command for palette setting.

' Enjoy, even though it's uncommented it should be easy to understand,
'  being only 65, yes count 'em 65 lines of code (WOW!!!!!!!!).

' My E-Mail is pdcomputers@iname.com
' or s3dougla@doreen.rainhammark.kent.sch.uk if this don't work.
' i will try to reply and help with any of your problems.

DECLARE SUB SetPALETTE (Slot%, R%, G%, B%)
DECLARE SUB memcopy (fromseg%, fromoffset%, toseg%, tooffset%, bytes%)
DIM SHARED Buffer(319, 199) AS STRING * 1
DIM SHARED Pointer AS STRING * 1
DIM SHARED ImageDataSegment(200) AS STRING * 320
DEFINT A-Z


'----------INPUT FILE TO LOAD HERE
FileName$ = LCASE$(LTRIM$(RTRIM$(COMMAND$)))
FileName$ = "m:\number.bmp"

OPEN FileName$ FOR BINARY AS #1
IF LOF(1) < 2 THEN PRINT "File does not exist": KILL FileName$: SYSTEM
GET #1, 54, Pointer
SCREEN 13
FOR Slot% = 0 TO 255
 GET #1, , Pointer
 B% = INT(ASC(Pointer) / 4)
 GET #1, , Pointer
 G% = INT(ASC(Pointer) / 4)
 GET #1, , Pointer
 R% = INT(ASC(Pointer) / 4)
 SetPALETTE Slot%, R%, B%, G%
 GET #1, , Pointer
NEXT Slot%
FOR Y = 199 TO 0 STEP -1
  GET #1, , ImageDataSegment(Y)
NEXT
CLOSE
memcopy VARSEG(ImageDataSegment(0)), VARPTR(ImageDataSegment(0)), &HA000, 0, &HFA00
SYSTEM

SUB memcopy (fromseg%, fromoffset%, toseg%, tooffset%, bytes%)
  asm$ = ""
  asm$ = asm$ + CHR$(85)
  asm$ = asm$ + CHR$(137) + CHR$(229)
  asm$ = asm$ + CHR$(30)
  asm$ = asm$ + CHR$(139) + CHR$(70) + CHR$(10)
  asm$ = asm$ + CHR$(142) + CHR$(192)
  asm$ = asm$ + CHR$(139) + CHR$(70) + CHR$(14)
  asm$ = asm$ + CHR$(142) + CHR$(216)
  asm$ = asm$ + CHR$(139) + CHR$(118) + CHR$(8)
  asm$ = asm$ + CHR$(139) + CHR$(126) + CHR$(12)
  asm$ = asm$ + CHR$(139) + CHR$(78) + CHR$(6)
  asm$ = asm$ + CHR$(243)
  asm$ = asm$ + CHR$(164)
  asm$ = asm$ + CHR$(31)
  asm$ = asm$ + CHR$(93)
  asm$ = asm$ + CHR$(203)
  WAIT &H3DA, 8
  DEF SEG = VARSEG(asm$)
    CALL Absolute(BYVAL fromseg%, BYVAL fromoffset%, BYVAL toseg%, BYVAL tooffset%, BYVAL bytes%, SADD(asm$))
  DEF SEG
END SUB

SUB SetPALETTE (Slot, R, G, B)
  OUT &H3C8, Slot
  OUT &H3C9, R
  OUT &H3C9, B
  OUT &H3C9, G
END SUB

