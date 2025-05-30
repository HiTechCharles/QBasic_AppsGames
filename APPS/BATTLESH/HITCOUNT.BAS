DECLARE SUB ReadFile ()
DECLARE SUB ShowResults ()
DECLARE FUNCTION Row2LTR$ (r!)
DECLARE SUB SaveUpdatedCount ()
DECLARE SUB LoadPrevCount ()
DECLARE SUB Setupscreen ()
DECLARE SUB sqrpaint (l$, N, s, num$)
COMMON SHARED Fi$, nodata

DIM SHARED HitCount(10, 10) AS INTEGER
CONST true = 1: false = -1

ON ERROR GOTO ErrorHandler:
    Setupscreen
    LoadPrevCount
    'LOCATE 5, 50: INPUT "File Name:  >", fi$
    ReadFile
    ShowResults
    SaveUpdatedCount
    SYSTEM


ErrorHandler:
    SELECT CASE ERR
        CASE IS = 53:
            nodata = true: RESUME NEXT
        CASE ELSE:
            PRINT "Error #"; ERR; "occured.": SYSTEM
        END SELECT

SUB LoadPrevCount
    OPEN "Hitcount.dat" FOR INPUT AS #4
    IF nodata = false THEN
        FOR row = 1 TO 10
            FOR col = 1 TO 10
                INPUT #4, ssn
                HitCount(row, col) = ssn
            NEXT col
        NEXT row
    CLOSE #4
    END IF
END SUB

SUB ReadFile
    OPEN Fi$ FOR INPUT AS #4

    LINE INPUT #4, tmp$
    FOR row = 1 TO 10
        FOR col = 1 TO 10
            INPUT #4, ssn
            IF ssn > 0 THEN
                HitCount(row, col) = HitCount(row, col) + ssn
            END IF
        NEXT col
    NEXT row
    CLOSE #4
END SUB

FUNCTION Row2LTR$ (r)
    tmp$ = "ABCDEFGHIJ"
    Row2LTR$ = MID$(tmp$, r, 1)
END FUNCTION

SUB SaveUpdatedCount
    OPEN "Hitcount.dat" FOR OUTPUT AS #4
    FOR row = 1 TO 10
        FOR col = 1 TO 10
                PRINT #4, HitCount(row, col);
        NEXT col
        PRINT #4, ""
    NEXT row
    CLOSE #4
END SUB

SUB Setupscreen
    SCREEN 0: WIDTH 80, 25: COLOR 7, 8: CLS : LOCATE 1, 1
    PRINT "�����������������������������������������ͻ"
    PRINT "� � 1 � 2 � 3 � 4 � 5 � 6 � 7 � 8 � 9 �10 �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�A�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�B�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�C�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�D�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�E�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�F�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�G�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�H�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�I�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������Ķ"
    PRINT "�J�   �   �   �   �   �   �   �   �   �   �"
    PRINT "�����������������������������������������ͼ"

    COLOR 11
    LOCATE 2, 5: PRINT "1": LOCATE 2, 9: PRINT "2": LOCATE 2, 13: PRINT "3"
    LOCATE 2, 17: PRINT "4": LOCATE 2, 21: PRINT "5": LOCATE 2, 25: PRINT "6"
    LOCATE 2, 29: PRINT "7": LOCATE 2, 33: PRINT "8": LOCATE 2, 37: PRINT "9"
    LOCATE 2, 40: PRINT "10":  LOCATE 4, 2: PRINT "A": LOCATE 6, 2: PRINT "B"
    LOCATE 8, 2: PRINT "C": LOCATE 10, 2: PRINT "D": LOCATE 12, 2: PRINT "E"
    LOCATE 14, 2: PRINT "F": LOCATE 16, 2: PRINT "G": LOCATE 18, 2: PRINT "H"
    LOCATE 20, 2: PRINT "I": LOCATE 22, 2: PRINT "J":

END SUB

SUB ShowResults
    FOR row = 1 TO 10
        FOR col = 1 TO 10
            IF HitCount(row, col) = 0 THEN
                sqrpaint Row2LTR(row), col, 6, ""
            ELSE
                sqrpaint Row2LTR(row), col, 7, STR$(HitCount(row, col))
            END IF
        NEXT col
    NEXT row
END SUB

SUB sqrpaint (l$, N, s, sh$)
    SELECT CASE l$
        CASE IS = "A": l = 4
        CASE IS = "B": l = 6
        CASE IS = "C": l = 8
        CASE IS = "D": l = 10
        CASE IS = "E": l = 12
        CASE IS = "F": l = 14
        CASE IS = "G": l = 16
        CASE IS = "H": l = 18
        CASE IS = "I": l = 20
        CASE IS = "J": l = 22
    END SELECT

    SELECT CASE N
        CASE IS = 1:  z = 4
        CASE IS = 2:  z = 8
        CASE IS = 3:  z = 12
        CASE IS = 4:  z = 16
        CASE IS = 5:  z = 20
        CASE IS = 6:      z = 24
        CASE IS = 7:  z = 28
        CASE IS = 8:  z = 32
        CASE IS = 9:  z = 36
        CASE IS = 10:  z = 40
    END SELECT

    LOCATE l, z
    l% = l: z% = z
    SELECT CASE s
        CASE IS = -1: COLOR 15, 15: PRINT "���"
        CASE IS = 1: COLOR 12, 12: PRINT "���"
        CASE IS = 5: COLOR 15, 9: PRINT "???"
        CASE IS = 6: COLOR 8, 8: PRINT "   "
        CASE IS = 7: COLOR 15, 8: PRINT USING "###"; VAL(sh$)
    END SELECT
END SUB

