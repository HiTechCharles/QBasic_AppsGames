DECLARE SUB center (row!, text$)
RANDOMIZE TIMER: WIDTH 40, 25: COLOR 9: CLS

DIM digit3(3), digit4(4): center 4, "3 & 4-digit numbers you shoud play"

FOR H = 1 TO 3: digit3(H) = INT(RND * 9): NEXT H
FOR H = 1 TO 4: digit4(H) = INT(RND * 9): NEXT H

COLOR 11: LOCATE 9, 10: PRINT "3-DIGIT: "; digit3(1); digit3(2); digit3(3)
COLOR 7: LOCATE 12, 10: PRINT "4-DIGIT: "; digit4(1); digit4(2); digit4(3); digit4(4)

COLOR 12: LOCATE 15, 1: PRINT "If you win with these numbrs, Charles   Martin gets a cut of the winnings."
COLOR 14: center 18, "Press any key to quit": SLEEP: SYSTEM

SUB center (row, text$)

col = 21 - LEN(text$) / 2
LOCATE row, col: PRINT text$

END SUB

