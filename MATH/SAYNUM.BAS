DECLARE FUNCTION Pad$ (Orig$, NewLength%, Side%, Char$)

num = 1234
num$ = LTRIM$(RTRIM$(STR$(num)))
num$ = Pad$(num$, 4, -1, "0")

Thou:
    t$ = MID$(num$, 1, 1)
    SELECT CASE VAL(t$)
        CASE IS > 0
            SHELL "play " + t$ + ".wav"
            SHELL "play  1000.wav"
        END SELECT

hun:
    t$ = MID$(num$, 2, 1)
    SELECT CASE VAL(t$)
        CASE IS > 0
            SHELL "play " + t$ + ".wav"
            SHELL "play  100.wav"
        END SELECT


FUNCTION Pad$ (Orig$, NewLength%, Side%, Char$)

'*******************************************************************************
'*  Pads a string with a specified character on the specified side(s) up to    *
'*  the new length.                                                            *
'*  The Side% argument is expressed:  <0 = Left, 0 = Center, >0 = Right        *
'*  Examples:  Pad$("Hello!",10,1," ") --> "Hello!    "                        *
'*             Pad$("$500",10,-1,"*")  --> "******$500"                        *
'*             Pad$("WOW",20,0,"!")    --> "!!!!!!!!WOW!!!!!!!!!"              *
'*******************************************************************************

'   if char$ is null, default to space
    IF Char$ = "" THEN
       C$ = " "
    ELSE
       C$ = Char$
    END IF

    L% = LEN(Orig$)

'   if already = to new length, return the original
    IF L% = NewLength% THEN
       Pad$ = Orig$
       EXIT FUNCTION
    END IF

'   create string of pad characters
    Padx$ = STRING$(NewLength%, C$)

    SELECT CASE Side%

'      pad left
       CASE IS < 0
          Pad$ = RIGHT$(Padx$ + Orig$, NewLength%)

'      pad right
       CASE IS > 0
          Pad$ = LEFT$(Orig$ + Padx$, NewLength%)

'      pad center
       CASE ELSE
          IF L% > NewLength% THEN
               C$ = Orig$
'              trim 1 char off alternating sides until string is new length
               DO WHILE L% > NewLength%
                    L% = L% - 1
                    IF L% MOD 2 = 0 THEN
                         C$ = RIGHT$(C$, L%)
                    ELSE
                         C$ = LEFT$(C$, L%)
                    END IF
               LOOP
               Pad$ = C$
          ELSE
               Diff% = NewLength% - L
               L% = Diff% \ 2
               R% = Diff% - L
               Pad$ = STRING$(L%, C$) + Orig$ + STRING$(R%, C$)
          END IF

    END SELECT



END FUNCTION

