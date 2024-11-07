DECLARE SUB a.circle ()
DECLARE SUB a.parallelogram ()
DECLARE SUB a.rectangle ()
DECLARE SUB a.square ()
DECLARE SUB a.trapezoid ()
DECLARE SUB a.triangle ()
DECLARE SUB center (row!, text$)
DECLARE SUB MENU ()

'------------AREA FORMULAS------------
'      6 CIRCLE = PI ù RADIUS ù RADIUS
'PARALLELOGRAM = BASE ù HEIGHT
'    RECTANGLE = LENGTH ù WIDTH
'       SQUARE = SIDE ù SIDE
'    TRAPEZOID = HEIGHT ù (BASE1 + BASE2) ù .5
'     TRIANGLE = BASE ù HEIGHT ù .5

WIDTH 40, 25: MENU

SUB a.circle
   COLOR 14: CLS : center 5, "Compute Area of a Circle"
   COLOR 15: LOCATE 10, 1: INPUT "Radius of Circle =====> ", Radius
   area = 3.14159266# * Radius * Radius
   LOCATE 15, 1: PRINT "Area of Circle =====>  "; USING "###,###,###.####"; area
   LOCATE 16, 28: PRINT "SQUARE UNITS"
END SUB

SUB a.parallelogram
   COLOR 14: CLS : center 5, "Compute Area of a Parallelogram"
   COLOR 15: LOCATE 10, 1: INPUT "Base of Parallelogram =====> ", Base1
   LOCATE 12, 1: INPUT "Height of Parallelogram ===> ", Height
   area = Base1 * Height
   LOCATE 16, 5: PRINT "Area is  "; USING "###,###,###.####"; area
   LOCATE 17, 18: PRINT "SQUARE UNITS"
END SUB

SUB a.rectangle
   COLOR 14: CLS : center 5, "Compute Area of a Rectangle"
   COLOR 15: LOCATE 10, 1: INPUT "Length of Rectangle =====> ", Length
   LOCATE 11, 1: INPUT "Width of Rectangle ======> ", Wide
   area = Length * Wide
   LOCATE 16, 5: PRINT "Area is  "; USING "###,###,###.####"; area
   LOCATE 17, 18: PRINT "SQUARE UNITS"
END SUB

SUB a.square
   COLOR 14: CLS : center 5, "Compute Area of a Square"
   COLOR 15: LOCATE 10, 1: INPUT "Length of Side of Square ====> ", Side
   area = Side * Side
   LOCATE 15, 1: PRINT "Area of Square =====>  "; USING "###,###,###.####"; area
   LOCATE 16, 28: PRINT "SQUARE UNITS"
END SUB

SUB a.trapezoid
   COLOR 14: CLS : center 5, "Compute Area of a Trapezoid"
   COLOR 15: LOCATE 10, 1: INPUT "Primary Base of Trapezoid =====> ", Base1
   LOCATE 11, 1: INPUT "Secondary Base of Trapezoid ===> ", Base2
   LOCATE 12, 1: INPUT "Height of Trapezoid =========> ", Height
   area = Height * (Base1 + Base2) * .5
   LOCATE 16, 5: PRINT "Area is  "; USING "###,###,###.####"; area
   LOCATE 17, 18: PRINT "SQUARE UNITS"
END SUB

SUB a.triangle
   COLOR 14: CLS : center 5, "Compute Area of a Triangle"
   LOCATE 10, 1: INPUT "Base of Triangle =====> ", Base1
   LOCATE 11, 1: INPUT "Height of Triangle ===> ", Height
   area = Base1 * Height * .5
   LOCATE 15, 5: PRINT "Area is  "; USING "###,###,###.####"; area
   LOCATE 16, 18: PRINT "SQUARE UNITS"
END SUB

SUB center (row, text$)
col = 21 - LEN(text$) / 2: LOCATE row, col: PRINT text$
END SUB

SUB MENU
Mbegin:
   COLOR 10: CLS : center 2, "Computing Area"
   COLOR 2: center 3, "By Charles Martin"
LOCATE 7, 1: COLOR 15:
PRINT "     1.  Circle"
PRINT "     2.  Parallelogram"
PRINT "     3.  Rectangle"
PRINT
PRINT "     4.  Square"
PRINT "     5.  Trapezoid"
PRINT "     6.  Triangle"
PRINT
PRINT "     7.  Exit"

COLOR 11: center 19, "Press the number next"
          center 20, "to the desired shape:"
gtoa:
k$ = LCASE$(INKEY$)
    IF k$ = "1" THEN a.circle: GOTO EOC:
    IF k$ = "2" THEN a.parallelogram: GOTO EOC:
    IF k$ = "3" THEN a.rectangle: GOTO EOC:
    IF k$ = "4" THEN a.square: GOTO EOC:
    IF k$ = "5" THEN a.trapezoid: GOTO EOC:
    IF k$ = "6" THEN a.triangle: GOTO EOC:
    IF k$ = "7" THEN SYSTEM
    IF k$ = CHR$(27) THEN SYSTEM
GOTO gtoa:

EOC:
COLOR 13: center 21, "Press any key to continue...": SLEEP: GOTO Mbegin:

END SUB

