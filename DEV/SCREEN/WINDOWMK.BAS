DECLARE SUB WindowMake (Row, Col, WinHight, WinWidth, ShadowPos, Border, BorderColor, BackColor, Title$, TitlePos, TitleColor)
WIDTH 40, 25: CLS
 CALL WindowMake(1, 1, 8, 40, 0, 5, 13, 9, " WELCOME! ", 1, 10)
'                ³  ³   ³   ³   ³  ³  ³  ³    ³             ³  ÀÄÄÄÄÄÄÄ¿
'    RowÄÄÄÄÄÄÄÄÄÙ  ³   ³   ³   ³  ³  ³  ³    ³             ÀÄÄÄÄÄÄÄ¿  ³
'    ColumnÄÄÄÄÄÄÄÄÄÙ   ³   ³   ³  ³  ³  ³    ³ Title Postion (0-3)ÄÙ  ³
'    Window HightÄÄÄÄÄÄÄÙ   ³   ³  ³  ³  ³    ³ Title ColorÄÄÄÄÄÄÄÄÄÄÄÄÙ
'    Window WidthÄÄÄÄÄÄÄÄÄÄÄÙ   ³  ³  ³  ³    ³
'    Shadow Location (0-4)ÄÄÄÄÄÄÙ  ³  ³  ³    ³  ***************************
'    Border Style (0-5)ÄÄÄÄÄÄÄÄÄÄÄÄÙ  ³  ³    ³  * Use PageUp and PageDown *
'    Border ColorÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  ³    ³  * to scroll the pages     *
'    Window ColorÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    ³  * starting from the top.  *
'    Window TitleÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  ***************************
'Page 1                    
' ÄÄ Value Significance:
'           -> Shadow Location :   0 = No Shadow
'                                  1 = Top Left
'                                  2 = Top Right
'                                  3 = Bottom Right
'                                  4 = Bottom Left
'                                  5 = All around
'           -> Border Style    :   0 = No Border
'                                  1 = Single Line
'                                  2 = Double Line
'                                  3 = Single Horizontal, Double Vertical
'                                  4 = Double Horizontal, Single Vertical
'                                  5 = Thick Line
'           -> Title Position  :   0 = No Title
'                                  1 = Left
'                                  2 = Centered
'                                  3 = Right
'Page 2              
' ***Notes:
'           -> If your planning on putting shadows with your windows, make
'              sure you have a colored surface behind the window because
'              a real shadow couldn't be seen on black surfaces, obviously.
'
'           -> If the coordinates are out of range or the title and shadow
'              are out of place, you will get some Illegal Function Calls.
'              Simply fix your coordinates to correct the problem.
'
'           -> If used properly, Window Maker can save you a lot of time
'              and frustration while at the same time able to make you
'              professional looking windows.
'
'           -> If you have ideas on how to make this code any better, please
'              feel free to e-mail me. It's posted at the top if you didn't
'              catch it. :)
'
'Page 3
'****************************   Actual Coding   *****************************


COLOR 11, 1: LOCATE 3, 2: PRINT "Welcome to the Timer.  Press any key"
             LOCATE 4, 2: PRINT "while the clock is running to stop"
             LOCATE 5, 2: PRINT "the timer, and get a list of options."
             LOCATE 7, 2: PRINT "(c) 2001-2003 Martin Software"
COLOR 14, 8: LOCATE 10, 20: PRINT "Press any key to start the timer.": SLEEP


SUB WindowMake (Row, Col, WinHight, WinWidth, ShadowPos, Border, BorderColor, BackColor, Title$, TitlePos, TitleColor)
  
  SELECT CASE Border
    CASE 0
      HTLine$ = " "
      HBLine$ = " "
      VLine$ = " "
      TLCorner$ = " "
      TRCorner$ = " "
      BLCorner$ = " "
      BRCorner$ = " "
      TitleLeft$ = "³"
      TitleRight$ = "³"
    CASE 1
      HTLine$ = "Ä"
      HBLine$ = "Ä"
      VLine$ = "³"
      TLCorner$ = "Ú"
      TRCorner$ = "¿"
      BLCorner$ = "À"
      BRCorner$ = "Ù"
      TitleLeft$ = "´"
      TitleRight$ = "Ã"
    CASE 2
      HTLine$ = "Í"
      HBLine$ = "Í"
      VLine$ = "º"
      TLCorner$ = "É"
      TRCorner$ = "»"
      BLCorner$ = "È"
      BRCorner$ = "¼"
      TitleLeft$ = "¹"
      TitleRight$ = "Ì"
    CASE 3
      HTLine$ = "Ä"
      HBLine$ = "Ä"
      VLine$ = "º"
      TLCorner$ = "Ö"
      TRCorner$ = "·"
      BLCorner$ = "Ó"
      BRCorner$ = "½"
      TitleLeft$ = "´"
      TitleRight$ = "Ã"
    CASE 4
      HTLine$ = "Í"
      HBLine$ = "Í"
      VLine$ = "³"
      TLCorner$ = "Õ"
      TRCorner$ = "¸"
      BLCorner$ = "Ô"
      BRCorner$ = "¾"
      TitleLeft$ = "¹"
      TitleRight$ = "Ì"
    CASE 5
      HTLine$ = "ß"
      HBLine$ = "Ü"
      VLine$ = "Û"
      TLCorner$ = "Û"
      TRCorner$ = "Û"
      BLCorner$ = "Û"
      BRCorner$ = "Û"
      TitleLeft$ = "Û"
      TitleRight$ = "Û"
    END SELECT
 
  COLOR BorderColor, BackColor: LOCATE Row, Col: PRINT TLCorner$ + STRING$((WinWidth - 2), HTLine$) + TRCorner$
 
  FOR i = 1 TO (WinHight - 2)
   LOCATE Row + i, Col: PRINT VLine$ + STRING$((WinWidth - 2), " ") + VLine$
  NEXT i
  
   LOCATE ((Row - 1) + WinHight), Col: PRINT BLCorner$ + STRING$((WinWidth - 2), HBLine$) + BRCorner$

'---Shadows---
 SELECT CASE ShadowPos
  
   CASE 1
     FOR i = (Row - 1) TO (WinHight + (Row - 2))
       a% = SCREEN(i, (Col - 2))
       b% = SCREEN(i, (Col - 1))
      COLOR 8, 0: LOCATE i, (Col - 2): PRINT CHR$(a%); CHR$(b%)
     NEXT i
     FOR i = Col TO (WinWidth + (Col - 3))
       a% = SCREEN((Row - 1), i)
      COLOR 8, 0: LOCATE (Row - 1), i: PRINT CHR$(a%)
     NEXT i
  
   CASE 2
     FOR i = Row TO (WinHight + (Row - 2))
       a% = SCREEN(i, (WinWidth + Col))
       b% = SCREEN(i, (WinWidth + Col + 1))
      COLOR 8, 0: LOCATE i, (WinWidth + Col): PRINT CHR$(a%); CHR$(b%)
     NEXT i
     FOR i = (Col + 2) TO (WinWidth + Col + 1)
       a% = SCREEN((Row - 1), i)
      COLOR 8, 0: LOCATE (Row - 1), i: PRINT CHR$(a%)
     NEXT i
  
   CASE 3
     FOR i = Row + 1 TO (WinHight + (Row - 1))
       a% = SCREEN(i, (WinWidth + Col))
       b% = SCREEN(i, (WinWidth + Col + 1))
      COLOR 8, 0: LOCATE i, (WinWidth + Col): PRINT CHR$(a%); CHR$(b%)
     NEXT i
     FOR i = (Col + 2) TO (WinWidth + (Col + 1))
       a% = SCREEN((WinHight + Row), i)
      COLOR 8, 0: LOCATE (Row + WinHight), i: PRINT CHR$(a%)
     NEXT i
  
   CASE 4
     FOR i = Row + 1 TO (WinHight + (Row - 1))
       a% = SCREEN(i, (Col - 2))
       b% = SCREEN(i, (Col - 1))
      COLOR 8, 0: LOCATE i, (Col - 2): PRINT CHR$(a%); CHR$(b%)
     NEXT i
     FOR i = (Col - 2) TO (WinWidth + Col - 3)
       a% = SCREEN((WinHight + Row), i)
      COLOR 8, 0: LOCATE (Row + WinHight), i: PRINT CHR$(a%)
     NEXT i
  
   CASE 5
     FOR i = (Row - 1) TO (WinHight + Row)
       a% = SCREEN(i, (Col - 2))
       b% = SCREEN(i, (Col - 1))
      COLOR 8, 0: LOCATE i, (Col - 2): PRINT CHR$(a%); CHR$(b%)
     NEXT i
     FOR i = Col TO (WinWidth + (Col - 1))
       a% = SCREEN((Row - 1), i)
      COLOR 8, 0: LOCATE (Row - 1), i: PRINT CHR$(a%)
     NEXT i
     FOR i = Row - 1 TO (WinHight + Row)
       a% = SCREEN(i, (WinWidth + Col))
       b% = SCREEN(i, (WinWidth + Col + 1))
      COLOR 8, 0: LOCATE i, (WinWidth + Col): PRINT CHR$(a%); CHR$(b%)
     NEXT i
     FOR i = Col TO (WinWidth + Col)
       a% = SCREEN((WinHight + Row), i)
      COLOR 8, 0: LOCATE (Row + WinHight), i: PRINT CHR$(a%)
     NEXT i
  
   END SELECT

'---Title---

   SELECT CASE TitlePos
    
     CASE 0
       EXIT SUB
     CASE 1
       TitlePos = (Col + 3)
     CASE 2
       TitleLength = LEN(Title$)
       TitlePos = (((WinWidth / 2) - (INT(TitleLength) / 2))) + Col
     CASE 3
       TitleLength = LEN(Title$)
       TitlePos = (WinWidth + (Col + 2)) - (INT(TitleLength + 5))
     CASE ELSE
       EXIT SUB

   END SELECT
    
     COLOR BorderColor, BackColor: LOCATE Row, TitlePos - 1: PRINT TitleLeft$; : COLOR TitleColor, BackColor: PRINT Title$; : COLOR BorderColor, BackColor: PRINT TitleRight$

'----------
 COLOR 7, 0

END SUB

