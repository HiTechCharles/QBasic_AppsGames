'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴-�-퀭� �
'� *** Smooth scroller ***
'�
'� (Taken from the BackMan game)    Unoptimized.
'�
'� Programmed by SkurK/b. (skurk@multinet.no)
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴-�-퀭� �

        DIM ScrArea(1 TO 320 * 8)
        SCREEN 13: DEF SEG = &HA000
        Text$ = "I'd cut off my hands for one night with Milla Jovovich.... :)               "

        LINE (0, 190)-(319, 199), 23, BF

        DO WHILE INKEY$ = ""
                WAIT &H3DA, 8
                WAIT &H3DA, 8, 8
                GOSUB Scroll
        LOOP
        END

'------------------------------------------------------------------------

Scroll:
        GET (2, 190)-(319, 199), ScrArea
        PUT (1, 190), ScrArea, PSET
        FOR Y = 0 TO 7
                a = PEEK(8 - CharPtr + Y * 320)
                IF a > 0 THEN
                        PSET (317, 192 + Y), 30
                        PSET (318, 191 + Y), 20
                END IF
        NEXT Y
       
        IF CharPtr = 0 THEN
           IF TxtPtr > LEN(Text$) THEN TxtPtr = 0
                 TxtPtr = TxtPtr + 1
                 COLOR 16
                 LOCATE 1, 1                    'yes we are cheating.
                 PRINT MID$(Text$, TxtPtr, 1);  'Don't print anything here :)
                 CharPtr = 8
           ELSE
                 CharPtr = CharPtr - 1
           END IF
       
        RETURN

