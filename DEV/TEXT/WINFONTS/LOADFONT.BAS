'
'     北      北 北北北 北    北  膊膊膊 膊膊膊 膊    膊 膊膊膊 膊膊膊
'     北      北   北   北北  北  膊     膊  膊 膊膊  膊   膊   膊
'      北    北    北   北 北 北  膊膊   膊  膊 膊 膊 膊   膊   膊膊膊
'      北 北 北    北   北  北北  膊     膊  膊 膊  膊膊   膊       膊
'       北北北   北北北 北    北  膊     膊膊膊 膊    膊   膊   膊膊膊
'
'
'                               北北北  北北     Coded by jheaton
'                               北  北  北  北     March 22, 2001
'                               北  北  北北         josh_heaton@hotmail.com
'                               北  北  北  北
'                               北北北  北北    Version 1.0
'                                  北
'
'
'                      Windows 9x Fonts in QuickBasic!
'         (Please forgive the crappy text art, I'm not an artist)

'
'   After using the RUSH OS, I had a sudden inspiration to rip some Windows
' fonts into QuickBasic, and *BANG*, WinFontsQB was born! This is simple to
' use. Also see the ripper program, FONTRIP.EXE, a Win32 application written
' in Visual Basic 6.0. If I feel like making a future release, I might
' add direct Windows font support (no ripping required) and also I might just
' write some ASM to draw quicker, but I doubt it. If someone out there can
' speed up the Font procedure, by all means do. Just send me a copy of the
' source code so I can merge it into my current release. Also read FNTFRMT.TXT
' to see how the fonts are handled.
'
'   Thanks for selecting this collection of 1s and 0s to be copied on to your
' computer's hard disk and implementing the illogic into your collections
' of 1s and 0s. This program is freeware, so feel free to redistribute it
' FREELY.
'
'                                 -jheaton, "Who needs README files?"

DECLARE SUB Font (txt$, x%, y%, c%, FontFile$, Attribs%)
'Usage:
'  Font TextToPrint$, XCoord%, YCoord%, Color%, FontFileName$, Attributes%
'
' Pretty self-explanitory. Pass either ALIGN.CENTER or ALIGN.RIGHT for the
' XCoord% to do alignment. Attributes% is practically useless because you
' can use font formatting tokens in the string. They go like this:
'
' "This is some text $bbold text$b" <- $b toggles bold
' "What about $uunderlining?$u"     <- $u toggles underlining
' "And italics can be $icool$i"     <- $i toggles italics
' "Freeware dosn't cost $$"         <- $$ prints 1 $ (Freeware dosn't cost $)
' "$c1Blue$c2Green$c4Red"           <- $c changes text color at draw-time

TYPE FontCharInfo
     CharWidth AS INTEGER
     CharHeight AS INTEGER
     FileOffset AS LONG
END TYPE

CONST ATTRIB.BOLD = 1
CONST ATTRIB.UNDERLINE = 2
CONST ATTRIB.ITALICS = 4

CONST ALIGN.CENTER = -1          ' Alignment that will follow the ENTIRE
CONST ALIGN.RIGHT = -2           ' SCREEN unless you modify it

CONST WINFNTQB.VERSIONMAJOR = 1
CONST WINFNTQB.VERSIONMINOR = 0

DIM SHARED ScreenResX, ScreenResY

'
' Misc Arguments:
'
'   $b   - Toggle Bold
'   $u   - Toggle Underline
'   $i   - Toggle Italics
'   $c?? - Color
'   $$   - Print a dollar sign
'

SCREEN 12          'Pick your screen mode

ScreenResX = 640   'These are importaint for centering techniques
ScreenResY = 480

CLS

Font "Ms Sans Serif is good for GUIs...", 10, 10, 7, "mssans.fnt", 0
Font "Or how about Tahoma?", 10, 30, 7, "tahoma.fnt", 0
Font "Maybe just some Arial to spice things up!", 10, 50, 7, "arial.fnt", 0
Font "These fonts are small and fast at about 3k per font.", 10, 70, 7, "courier.fnt", 0
t# = TIMER + .5: DO: LOOP WHILE t# > TIMER
Font "What more could you ask for, you say?", 10, 90, 7, "couriern.fnt", 0
t# = TIMER + 1.5: DO: LOOP WHILE t# > TIMER
Font "How about $ibasic$i formatting $ueffects$u?", 10, 110, 7, "fixedsys.fnt", 0
t# = TIMER + 1.5: DO: LOOP WHILE t# > TIMER
Font "Did I mention colors?", 170, 130, 1, "tahoma.fnt", ATTRIB.UNDERLINE
t# = TIMER + 1.5: DO: LOOP WHILE t# > TIMER
Font "BOLD!", 230, 150, 2, "tahoma.fnt", ATTRIB.BOLD
t# = TIMER + 1.5: DO: LOOP WHILE t# > TIMER
Font "Press $c15any key$c07 to see how to use this great technology...", 0, 200, 7, "system.fnt", 0
x$ = INPUT$(1)
CLS

Font "Usage:", 10, 10, 7, "mssans", 0
Font "  $bFont$b TextToPrint$$, XCoord%, YCoord%, Color%, FontFileName$$, Attributes%", 10, 30, 7, "mssans", 0

Font " Pretty self-explanitory. Pass either ALIGN.CENTER or ALIGN.RIGHT for the", 10, 60, 7, "mssans", 0
Font " XCoord% to do alignment. Attributes% is practically useless because you", 10, 75, 7, "mssans", 0
Font " can use font formatting tokens in the string. They go like this:", 10, 90, 7, "mssans", 0

Font CHR$(34) + "This is some text $$bbold text$$b" + CHR$(34) + " <- This prints: This is some text $bbold text$b", 10, 110, 7, "mssans", 0
Font CHR$(34) + "What about $$uunderlining?$$u" + CHR$(34) + " <- This prints: What about $uunderlining?$u", 10, 125, 7, "mssans", 0
Font CHR$(34) + "And italics can be $$icool$$i" + CHR$(34) + " <- This prints: And italics can be $icool$i", 10, 140, 7, "mssans", 0
Font CHR$(34) + "Freeware dosn't cost $$$$" + CHR$(34) + " <- This prints: Freeware dosn't cost $$", 10, 155, 7, "mssans", 0
Font CHR$(34) + "$$c1Blue$$c2Green$$c4Red" + CHR$(34) + " <- This prints: $c1Blue$c2Green$c4Red", 10, 170, 7, "mssans", 0

Font "Press $c15any key$c07 to see a nice demo and some pretty effects...", 0, 200, 7, "system.fnt", 0
x$ = INPUT$(1)


CLS

Font "WinFonts QB", ALIGN.CENTER, 30, 2, "verdana.fnt", 0
Font "Written by $ijheaton$i", ALIGN.CENTER, 60, 3, "tahoma.fnt", 0

text$ = "       Real Windows Fonts in 100% QB, Whoa!  These fonts were ripped using a Visual Basic Program" + CHR$(13)
text$ = text$ + "written by myself.  The process is really simple, so I provided a ripping program soon so you can make" + CHR$(13)
text$ = text$ + "your own fonts!  The only catch to this process is that a single character from a font cannot be wider then" + CHR$(13)
text$ = text$ + "16 pixels.  This is because I use a LINE statement with a pattern to draw the font. It's simple, but it's quick." + CHR$(13)
text$ = text$ + "Plus this means that the font files are small, only an integer for each scanline in a character (typically 8)."

Font text$, ALIGN.CENTER, 110, 7, "arial.fnt", 0

Font "Email me: $c1$ujosh_heaton@hotmail.com$u", ALIGN.RIGHT, 220, 7, "arial.fnt", 0

SUB Font (txt$, x%, y%, c%, FontFile$, Attribs%)

'Here is the loader routine
'I know I could simplify the math (2 + 2 + 4) = 8, etc., but I wanted to
'show you what I was doing. Good luck reading this! ;)

DIM Char AS FontCharInfo
OrgAttribs% = Attribs%  'This gets modified so save its value so we don't
                        'suprise the end-user...

a% = INSTR(FontFile$, ".")
IF a% = 0 THEN FontFile$ = FontFile$ + ".fnt"

Handle = FREEFILE
OPEN FontFile$ FOR BINARY AS #Handle
     IF LOF(Handle) = 0 THEN
        CLOSE #Handle
        KILL FontFile$
        EXIT SUB
     END IF

     Version% = 0
     GET #Handle, , Version%
     IF (Version% MOD 256 <> WINFNTQB.VERSIONMINOR) OR (Version% \ 256 <> WINFNTQB.VERSIONMAJOR) THEN
        'Incorrect version
        CLOSE #Handle
        EXIT SUB
     END IF

     ty& = y%
     IF x% = ALIGN.CENTER THEN
        tx& = 0
        Widest& = 0
        FixLR% = 0
        FOR i% = 1 TO LEN(txt$)
            CharCnt% = ASC(MID$(txt$, i%, 1)) - 32
            IF CharCnt% = -19 THEN
               IF tx& > Widest& THEN Widest& = tx&: tx& = 0
               FixLR% = 1
              ELSEIF CharCnt% = ASC("$") - 32 THEN
               'Special formatting code
               i% = i% + 1
               code$ = LCASE$(MID$(txt$, i%, 1))
               'IF code$ = "b" THEN GOSUB ToggleBold       ' Don't run these
               'IF code$ = "u" THEN GOSUB ToggleUnderline  ' on centering
               'IF code$ = "i" THEN GOSUB ToggleItalics    ' just yet...
               IF code$ = "$" THEN
                  'Crank out a dollar sign on the screen
                  CharCnt% = ASC("$") - 32
                  GOTO CountCharWidthForCentering:    'HA! I'm using
                                                      'GOTOs! LOL!
               END IF
              ELSE
CountCharWidthForCentering:
               SEEK #Handle, (2 + 2 + 4) * CharCnt% + 1 + 2
               GET #Handle, , Char
               tx& = tx& + Char.CharWidth
            END IF
        NEXT
        IF tx& > Widest& THEN Widest& = tx&
        tx& = (ScreenResX \ 2) - (tx& \ 2)
       ELSEIF x% = ALIGN.RIGHT THEN
        tx& = 0
        Widest& = 0
        FixLR% = 0
        FOR i% = 1 TO LEN(txt$)
            CharCnt% = ASC(MID$(txt$, i%, 1)) - 32
            IF CharCnt% = -19 THEN
               IF tx& > Widest& THEN Widest& = tx&: tx& = 0
               FixLR% = 1
              ELSEIF CharCnt% = ASC("$") - 32 THEN
               'Special formatting code
               i% = i% + 1
               code$ = LCASE$(MID$(txt$, i%, 1))
               IF code$ = "$" THEN
                  'Crank out a dollar sign on the screen
                  CharCnt% = ASC("$") - 32
                  GOTO CountCharWidthForRight:
               END IF
              ELSE
CountCharWidthForRight:
               SEEK #Handle, (2 + 2 + 4) * CharCnt% + 1 + 2
               GET #Handle, , Char
               tx& = tx& + Char.CharWidth
            END IF
        NEXT
        IF tx& > Widest& THEN Widest& = tx&
        tx& = ScreenResX - tx&
       ELSE
        tx& = x%
     END IF
     ttx& = tx&
     FOR i% = 1 TO LEN(txt$)
         CharCnt% = ASC(MID$(txt$, i%, 1))
         FixLR% = 0
         IF CharCnt% = 13 THEN
            'Line return, fix it
            FixLR% = 1
            CharCnt% = ASC("A") - 32
           ELSEIF CharCnt% = ASC("$") THEN
            'Special formatting code
            i% = i% + 1
            code$ = LCASE$(MID$(txt$, i%, 1))
            IF code$ = "b" THEN GOSUB ToggleBold: CharCnt% = -1
            IF code$ = "u" THEN GOSUB ToggleUnderline: CharCnt% = -1
            IF code$ = "i" THEN GOSUB ToggleItalics: CharCnt% = -1
            IF code$ = "c" THEN GOSUB SetTempColor: CharCnt% = -1
            'HA! I'm using GOSUBs! ^^^

            IF code$ = "$" THEN
               'Crank out a dollar sign on the screen
               CharCnt% = ASC("$") - 32
            END IF
           ELSEIF CharCnt% < 32 OR CharCnt% > 126 THEN
            CharCnt% = 127
           ELSE
            CharCnt% = CharCnt% - 32
         END IF
         IF CharCnt% > -1 THEN
            SEEK #Handle, (2 + 2 + 4) * CharCnt% + 1 + 2
            GET #Handle, , Char
            SEEK #Handle, Char.FileOffset
            REDIM CharDat&(Char.CharHeight)
            IF FixLR% <> 0 THEN
               'Do a line return
               ttx& = tx&
               ty& = ty& + Char.CharHeight
               FixLR% = 0
              ELSE
               'Draw char on screen
               IF CharCnt% <> 0 THEN
                  'Don't draw a space because there is a bug for some reason.
                  FOR cty% = 0 TO Char.CharHeight - 1
                      t% = 0
                      GET #Handle, , t%
                      CharDat&(cty%) = t%
                      offset% = 0
                      IF (Attribs% AND ATTRIB.ITALICS) <> 0 THEN offset% = -cty% / 3
                      LINE (ttx& + offset%, ty& + cty%)-(ttx& + 16 + offset%, ty& + cty%), c%, , CharDat&(cty%)' MOD 32767
                      IF (Attribs% AND ATTRIB.BOLD) <> 0 THEN
                         LINE (ttx& + offset% + 1, ty& + cty%)-(ttx& + 17 + offset%, ty& + cty%), c%, , CharDat&(cty%)' MOD 32767
                      END IF
                  NEXT
               END IF
               IF (Attribs% AND ATTRIB.UNDERLINE) <> 0 THEN LINE (ttx&, Char.CharHeight + 1 + ty&)-(ttx& + Char.CharWidth, Char.CharHeight + 1 + ty&), c%
               ttx& = ttx& + Char.CharWidth
            END IF
         END IF
     NEXT

CLOSE

Attribs% = OrgAttribs%

EXIT SUB

'Mini-Procedures! :)
'Hey, I support using GOSUBS in SUBS as long as you can organize the code.

ToggleBold:

IF (Attribs% AND ATTRIB.BOLD) <> 0 THEN
   Attribs% = Attribs% - ATTRIB.BOLD
  ELSE
   Attribs% = Attribs% + ATTRIB.BOLD
END IF

RETURN

ToggleUnderline:

IF (Attribs% AND ATTRIB.UNDERLINE) <> 0 THEN
   Attribs% = Attribs% - ATTRIB.UNDERLINE
  ELSE
   Attribs% = Attribs% + ATTRIB.UNDERLINE
END IF

RETURN

ToggleItalics:

IF (Attribs% AND ATTRIB.ITALICS) <> 0 THEN
   Attribs% = Attribs% - ATTRIB.ITALICS
  ELSE
   Attribs% = Attribs% + ATTRIB.ITALICS
END IF

RETURN

SetTempColor:

clr$ = ""

i% = i% + 1 'Get past the "c"

WHILE INSTR("0123456789", MID$(txt$, i%, 1))
      clr$ = clr$ + MID$(txt$, i%, 1)
      i% = i% + 1
WEND

i% = i% - 1   'Back up one char

c% = VAL(clr$)

RETURN

END SUB

