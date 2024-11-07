'JOYCAL.BAS
'by Logan Hoehn
'Jan. 3, 1998
'I made this program because when you use the STICK function,
'the value you get is different depending on what joystick
'you are using.  This program uses a calibration process so
'that you know what postition your joystick is in no matter
'what kind of joystick it is.

'Feel free to make any changes to this program you want.  If
'you use this code in your own programs, I don't care if you
'give me credit or not.  If you have any problems, suggestions
'or questions about this program, e-mail them to me at:
'<e-mail address>

SCREEN 9

'CALIBRATION:
'You might want to save these values (y1, y2, y3, x1, x2, x3)
'to a file and then input them instead of going through the
'calibration process every time you run a program that uses
'this code
'--------------------------------------------------------------

a1 = STICK(2)
a2 = STICK(3)

PRINT "Hold joystick to center position"
PRINT "(don't touch it) and press a button."
DO
PRINT STICK(0)
PRINT STICK(1)
LOCATE CSRLIN - 2, 1
LOOP UNTIL STRIG(1) OR STRIG(3) OR STRIG(5) OR STRIG(7) OR INKEY$ <> ""
DO
PRINT STICK(0)
PRINT STICK(1)
LOCATE CSRLIN - 2, 1
LOOP WHILE STRIG(1) OR STRIG(3) OR STRIG(5) OR STRIG(7) OR INKEY$ <> ""
x2 = STICK(0)
y2 = STICK(1)

LOCATE CSRLIN + 3, 1

PRINT "Hold joystick to top left"
PRINT "and press a button."
DO
PRINT STICK(0)
PRINT STICK(1)
LOCATE CSRLIN - 2, 1
LOOP UNTIL STRIG(1) OR STRIG(3) OR STRIG(5) OR STRIG(7)
DO
PRINT STICK(0)
PRINT STICK(1)
LOCATE CSRLIN - 2, 1
LOOP WHILE STRIG(1) OR STRIG(3) OR STRIG(5) OR STRIG(7)
x1 = STICK(0)
y1 = STICK(1)

LOCATE CSRLIN + 3, 1

PRINT "Hold joystick to bottom right"
PRINT "and press a button."
DO
PRINT STICK(0)
PRINT STICK(1)
LOCATE CSRLIN - 2, 1
LOOP UNTIL STRIG(1) OR STRIG(3) OR STRIG(5) OR STRIG(7)
DO
PRINT STICK(0)
PRINT STICK(1)
LOCATE CSRLIN - 2, 1
LOOP WHILE STRIG(1) OR STRIG(3) OR STRIG(5) OR STRIG(7)
x3 = STICK(0)
y3 = STICK(1)

x1 = (x2 - x1) / 2 + x1
y1 = (y2 - y1) / 2 + y1
x3 = (x3 - x2) / 2 + x2
y3 = (y3 - y2) / 2 + y2

LOCATE CSRLIN + 3, 1


'--------------------------------------------------------------
'The rest of this program is just an example of using
'the joystick functions and calibration values

CLS
LINE (224, 90)-(384, 206), 4, B
CIRCLE (244, 30), 15, 15
CIRCLE (244, 30), 15, 15
CIRCLE (244, 30), 15, 15
CIRCLE (324, 30), 15, 15
CIRCLE (284, 30), 15, 15
CIRCLE (364, 30), 15, 15
LOCATE 1, 31
PRINT "1    2    3    4"

DO

LOCATE 16, 30
PRINT "X ="; STICK(0)
LOCATE 16, 43
PRINT "Y ="; STICK(1)

'Coordinates for circle
c1 = 304
c2 = 148
'Check joystick values
'Decide whether it's pointing left or right, up or down
IF STICK(0) < x1 THEN c1 = c1 - 55
IF STICK(0) > x3 THEN c1 = c1 + 55
IF STICK(1) < y1 THEN c2 = c2 - 40
IF STICK(1) > y3 THEN c2 = c2 + 40
'Decide whether or not it needs to draw circle
IF c2 <> c4 OR c1 <> c3 THEN
  LINE (225, 91)-(383, 205), 0, BF
  CIRCLE (c1, c2), 15, 4
  PAINT (c1, c2), 4
END IF
c3 = c1
c4 = c2

'Check for buttons being pressed
IF STRIG(1) THEN PAINT (244, 30), 15 ELSE PAINT (244, 30), 0: CIRCLE (244, 30), 15, 15
IF STRIG(3) THEN PAINT (324, 30), 15 ELSE PAINT (324, 30), 0: CIRCLE (324, 30), 15, 15
IF STRIG(5) THEN PAINT (284, 30), 15 ELSE PAINT (284, 30), 0: CIRCLE (284, 30), 15, 15
IF STRIG(7) THEN PAINT (364, 30), 15 ELSE PAINT (364, 30), 0: CIRCLE (364, 30), 15, 15

LOOP UNTIL INKEY$ <> ""

