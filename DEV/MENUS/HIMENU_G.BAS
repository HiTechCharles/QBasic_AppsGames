DECLARE SUB center (row, text$)

'Thanks to Adam Stanchos for showing this menu from his Red Barron game!

start:
SCREEN 7, 0, 2, 0: CLS : LINE (95, 116)-(228, 180), 4, B: LINE (96, 117)-(229, 181), 12, B
 
COLOR 14: center 5, "CoolGames"
COLOR 12: center 7, "by Charles Martin"
          
COLOR 9: center 13, "Highlight the game you want"
         center 14, "to play and press ENTER:"
 
  C1 = 15: C2 = 4: C3 = 4: C4 = 4: c5 = 4: c6 = 4: c7 = 4
  highlight = 1
  SCREEN 7, 0, 0, 0: PCOPY 2, 0
DisplayText1:                                          
  COLOR C1: center 16, "様1様"
  COLOR C2: center 17, "様2様"
  COLOR C3: center 18, "様3様"
  COLOR C4: center 19, "様4様"
  COLOR c5: center 20, "様5様"
  COLOR c6: center 21, "様6様"
  COLOR c7: center 22, "Quit"


UserInput1:                                            
   a$ = INKEY$
   IF a$ = CHR$(0) + CHR$(72) THEN
      highlight = highlight - 1: GOTO HightOfMyLight1
   END IF
   IF a$ = CHR$(0) + CHR$(80) THEN
      highlight = highlight + 1: GOTO HightOfMyLight1
   END IF
   IF a$ = CHR$(13) THEN GOTO DetermineSelection1
   IF a$ = "a" OR a$ = "A" THEN ASCII% = 1
   GOTO UserInput1
                                                           
HightOfMyLight1:                                       
   IF highlight > 7 THEN highlight = 1
   IF highlight < 1 THEN highlight = 7
   IF highlight = 1 THEN C1 = 15: C2 = 4: C3 = 4: C4 = 4: c5 = 4: c6 = 4: c7 = 4
   IF highlight = 2 THEN C2 = 15: C1 = 4: C3 = 4: C4 = 4: c5 = 4: c6 = 4: c7 = 4
   IF highlight = 3 THEN C3 = 15: C1 = 4: C2 = 4: C4 = 4: c5 = 4: c6 = 4: c7 = 4
   IF highlight = 4 THEN C4 = 15: C1 = 4: C2 = 4: C3 = 4: c5 = 4: c6 = 4: c7 = 4
   IF highlight = 5 THEN c5 = 15: C1 = 4: C2 = 4: C3 = 4: C4 = 4: c6 = 4: c7 = 4
   IF highlight = 6 THEN c6 = 15: C1 = 4: C2 = 4: C3 = 4: C4 = 4: c5 = 4: c7 = 4
   IF highlight = 7 THEN c7 = 15: C1 = 4: C2 = 4: C3 = 4: C4 = 4: c5 = 4: c6 = 4
   GOTO DisplayText1
                                                           
DetermineSelection1:                                   
  IF highlight = 1 THEN SOUND 100, 2: GOTO start:
  IF highlight = 2 THEN SOUND 200, 2: GOTO start:
  IF highlight = 3 THEN SOUND 300, 2: GOTO start:
  IF highlight = 4 THEN SOUND 400, 2: GOTO start:
  IF highlight = 5 THEN SOUND 500, 2: GOTO start:
  IF highlight = 6 THEN SOUND 600, 2: GOTO start:
  IF highlight = 7 THEN SOUND 700, 2: SYSTEM
  GOTO DisplayText1

SUB center (row, text$)

col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

