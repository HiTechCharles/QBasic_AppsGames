' --------------------------------------------------------------------------------
' MSWINDOW.BAS  - Recreate Microsoft Windows on your screen with this
'
' Eric Harms Software
' 8036 South McVicker
' Burbank, ILL. 60459
' --------------------------------------------------------------------------------

CLS : SCREEN 9

'Define the window's properties
row = 9: height = 330: col = 9: length = 630
WinTitle$ = "Mars Exploration Rovers - NetScape"

'Draw the form's boarder
LINE (column, row)-(column + length, row + height), 0, B

'Create a border and fill it in
FOR i% = 1 TO 2
    row = row + 1: column = column + 1: height = height - 1: length = length - 1
    LINE (column, row)-(column + length, row), 7
    LINE (column, row)-(column, row + height), 7
NEXT i%

'Create the control box
row = row + 1: column = column + 1: height = height - 1: length = length - 1

LINE (column, row)-(column + length, row), 0
LINE (column, row)-(column, row + height), 0
                               
LINE (column, row)-(column + 18, row + 18), 7, BF
LINE (column, row)-(column + 18, row + 18), 0, B

LINE (column + 18, row - 2)-(column + 18, row + 5), 0
LINE (column - 2, row + 18)-(column + 5, row + 18), 0
                            
'Create the click portion in the control box
LINE (column + 5, row + 7)-(column + 13, row + 9), 15, BF: LINE (column + 5, row + 7)-(column + 13, row + 9), 0, B

'Add the click portion's shade.
LINE (column + 14, row + 7)-(column + 14, row + 9), 8
LINE (column + 6, row + 10)-(column + 14, row + 10), 8, B

' --------------------------------------------------------------------------------
' Create the title bar.
' --------------------------------------------------------------------------------

LINE (column + 18, row)-(column + length, row + 18), 9, BF
LINE (column + 18, row)-(column + length, row + 18), 0, B

LINE (column + length, row - 3)-(column + length + 2, row + height), 7, BF
LINE (column + length, row - 3)-(column + length + 3, row + height), 0, B

LINE (column + length, row - 2)-(column + length, row - 1), 7
LINE (column + length - 18, row - 2)-(column + length - 18, row - 1), 0

LINE (column + length, row + 18)-(column + length + 2, row + 18), 0

'Create the bottom line border and paint it.
LINE (column, row + height - 3)-(column + length, row + height - 3), 0, B
LINE (column, row + height - 2)-(column + length + 2, row + height), 7, BF
LINE (column - 2, row + height)-(column + length + 2, row + height), 0, B

'Get side break lines.
LINE (column - 2, row + height - 18)-(column, row + height - 18), 0
LINE (column + length - 2, row + height - 18)-(column + length + 2, row + height - 18), 0

LINE (column + 18, row + height)-(column + 18, row + height - 2), 0
LINE (column + length - 18, row + height)-(column + length - 18, row + height - 2), 0

'Paint the inner form.
LINE (column + 1, row + 19)-(column + length - 1, row + height - 4), 7, BF
LOCATE 2, 5: PRINT WinTitle$
SLEEP

