DECLARE SUB TSmallFont (Teks$, x%, y%, warna%)
DECLARE SUB TSmallFontEffect (Huruf$, xt%, yt%, warna%, TSmallFont.Style%)

CONST maxX% = 320
DIM SHARED FontData AS STRING * 4096

XFD = FREEFILE
OPEN "light.fnt" FOR BINARY AS #XFD
GET #XFD, , FontData
CLOSE #XFD

SCREEN 7


'TSmallFont Teks$, X, Y, Color
'TSmallFontEffect Teks$, X, Y, Color, Effect

TSmallFont "^ANIMASI FONT", 0, 80, 10
TSmallFont "^CODE:R.HENDRA SURYANEGARA", 0, 100, 14
TSmallFont "^PRESS ANY KEY WHEN READY", 0, 185, 15

KEY$ = INPUT$(1)
CLS

TSmallFontEffect "^ANIMASI FONT 1", 0, 0, 10, 1
TSmallFontEffect "^ANIMASI FONT 2", 0, 20, 14, 2
TSmallFontEffect "^ANIMASI FONT 3", 0, 40, 10, 3
TSmallFontEffect "^ANIMASI FONT 4", 0, 60, 14, 4
TSmallFontEffect "^ANIMASI FONT 5", 0, 80, 10, 5
TSmallFontEffect "^ANIMASI FONT 6", 0, 100, 14, 6
TSmallFontEffect "^ANIMASI FONT 7", 0, 120, 10, 7
TSmallFontEffect "^ANIMASI FONT 8", 0, 140, 14, 8
TSmallFontEffect "^ANIMASI FONT 9", 0, 160, 10, 9
TSmallFontEffect "^ANIMASI FONT 10", 0, 180, 14, 10

SLEEP
END

DEFINT A-Z
SUB TSmallFont (Teks$, x%, y%, warna%)
    IF LEFT$(Teks$, 1) = "^" THEN
       Teks$ = MID$(Teks$, 2, LEN(Teks$) - 1)
       x% = (maxX% / 2) - LEN(Teks$) * 8 / 2
    END IF
    IF LEFT$(Teks$, 1) = "[" THEN
       Teks$ = MID$(Teks$, 2, LEN(Teks$) - 1)
       x% = 0
    END IF
    IF LEFT$(Teks$, 1) = "]" THEN
       Teks$ = MID$(Teks$, 2, LEN(Teks$) - 1)
       x% = maxX% - LEN(Teks$) * 8
    END IF

       DEF SEG = VARSEG(FontData)
       FOR i = 1 TO LEN(Teks$)
           Code = ASC(MID$(Teks$, i, 1))
           x% = x% + 8
           FOR II% = 0 TO 15
               Byte = PEEK(VARPTR(FontData) + (Code * 16) + II%)
               IF Byte AND 1 THEN PSET (x% - 1, y% + II%), warna%
               IF Byte AND 2 THEN PSET (x% - 2, y% + II%), warna%
               IF Byte AND 4 THEN PSET (x% - 3, y% + II%), warna%
               IF Byte AND 8 THEN PSET (x% - 4, y% + II%), warna%
               IF Byte AND 16 THEN PSET (x% - 5, y% + II%), warna%
               IF Byte AND 32 THEN PSET (x% - 6, y% + II%), warna%
               IF Byte AND 64 THEN PSET (x% - 7, y% + II%), warna%
               IF Byte AND 128 THEN PSET (x% - 8, y% + II%), warna%
           NEXT II%
       NEXT i
END SUB

SUB TSmallFontEffect (Huruf$, xt%, yt%, warna%, TSmallFont.Style%)

    DIM lokawalx%(40, 16, 8), lokawaly%(40, 16, 8)
    DIM lokakhirx%(40, 16, 8), lokakhiry%(40, 16, 8)
    DIM lokPosisix%(40, 16, 8), lokPosisiy%(40, 16, 8)
    DIM LokStatus%(40, 16, 8), Posisi%(40, 16, 8)
    DIM DATAX%(1441)
    DIM DATAY%(1441)
    
    PakaiEffect$ = "YA"

    IF LEN(Huruf$) > 40 THEN
       Huruf$ = LEFT$(Huruf$, 40)
    END IF
    IF LEFT$(Huruf$, 1) = "^" THEN
       Huruf$ = MID$(Huruf$, 2, LEN(Huruf$) - 1)
       xt% = (maxX% / 2) - LEN(Huruf$) * 8 / 2
    END IF
    IF LEFT$(Huruf$, 1) = "[" THEN
       Huruf$ = MID$(Huruf$, 2, LEN(Huruf$) - 1)
       xt% = 0
    END IF
    IF LEFT$(Huruf$, 1) = "]" THEN
       Huruf$ = MID$(Huruf$, 2, LEN(Huruf$) - 1)
       xt% = maxX% - LEN(Huruf$) * 8
    END IF
    
    MaxPosisi% = 18

    Posisi% = 1
    SELECT CASE TSmallFont.Style%
           CASE 1
                FOR T = 1 TO 1441
                   DATAX%(T) = 319 * RND
                   DATAY%(T) = 239 * RND
                NEXT
           CASE 2
                x = 160: y = 100: rX = 120: rY = 100
                FOR T = 1 TO 1441
                   dx = x + INT(rX * COS(T * 3.14 / 720))
                   dy = y + INT(rY * SIN(T * 3.14 / 720))
                   DATAX%(T) = dx
                   DATAY%(T) = dy
                NEXT
           CASE 3
                x = 160: y = 100: rX = 120: rY = 100
                FOR T = 1 TO 1441
                   dx = x + INT(rX * SIN(T * 3.14 / 720))
                   dy = y + INT(rY * COS(T * 3.14 / 720))
                   DATAX%(T) = dx
                   DATAY%(T) = dy
                NEXT
           CASE 4
                x = 319: y = 120: rX = 120: rY = 50
                FOR T = 1 TO 1441
                   dx = x + INT(rX * COS(T) * 3.14 / 220)
                   dy = y + INT(rY * SIN(T * 3.14 / 720))
                   DATAX%(T) = dx
                   DATAY%(T) = dy
                NEXT
           CASE 5
                x = 1: y = 120: rX = 120: rY = 50
                FOR T = 1 TO 1441
                   dx = x + INT(rX * SIN(T) * 3.14 / 220)
                   dy = y + INT(rY * COS(T * 3.14 / 720))
                   DATAX%(T) = dx
                   DATAY%(T) = dy
                NEXT
           CASE 6
                FOR T = 1 TO 1441
                    DATAX%(T) = 320 * RND
                    DATAY%(T) = 1
                NEXT T
           CASE 7
                FOR T = 1 TO 1441
                    DATAX%(T) = 320 * RND
                    DATAY%(T) = 239
                NEXT T
           CASE 8
                FOR T = 1 TO 1441
                    DATAX%(T) = 1
                    DATAY%(T) = 239 * RND
                NEXT T
           CASE 9
                FOR T = 1 TO 1441
                    DATAX%(T) = 319
                    DATAY%(T) = 239 * RND
                NEXT T
           CASE 10
                FOR T = 1 TO 1441
                    DATAX%(T) = xt%
                    DATAY%(T) = yt% + 60 * RND - 20
                NEXT
           CASE ELSE
                GOTO Ini
    END SELECT
    
    SELECT CASE Halaman%
           CASE 0
                Tujuan1% = 1
                Tujuan2% = 2
           CASE 1
                Tujuan1% = 0
                Tujuan2% = 2
           CASE 2
                Tujuan1% = 0
                Tujuan2% = 1
    END SELECT

    FOR x = 1 TO LEN(Huruf$)
        FOR i = 1 TO 16
            FOR j = 1 TO 8
                Posisi% = Posisi% + 1
                IF Posisi% > 1441 THEN Posisi% = 1
                lokawalx%(x, i, j) = DATAY%(Posisi%) + RND * 4
                lokakhirx%(x, i, j) = yt% + i - 1
                lokawaly%(x, i, j) = DATAX%(Posisi%) + RND * 4
                lokakhiry%(x, i, j) = (x - 1) * 8 + xt% + j - 1
                LokStatus%(x, i, j) = 1
                Posisi%(x, i, j) = 1
            NEXT
        NEXT
    NEXT

    DEF SEG = VARSEG(FontData)
        FOR i = 1 TO LEN(Huruf$)
            Code = ASC(MID$(Huruf$, i, 1))
            FOR II% = 0 TO 15
                Byte = PEEK(VARPTR(FontData) + (Code * 16) + II%)
                IF Byte < 128 THEN lokawalx%(i, II% + 1, 1) = -1 ELSE Byte = Byte - 128
                IF Byte < 64 THEN lokawalx%(i, II% + 1, 2) = -1 ELSE Byte = Byte - 64
                IF Byte < 32 THEN lokawalx%(i, II% + 1, 3) = -1 ELSE Byte = Byte - 32
                IF Byte < 16 THEN lokawalx%(i, II% + 1, 4) = -1 ELSE Byte = Byte - 16
                IF Byte < 8 THEN lokawalx%(i, II% + 1, 5) = -1 ELSE Byte = Byte - 8
                IF Byte < 4 THEN lokawalx%(i, II% + 1, 6) = -1 ELSE Byte = Byte - 4
                IF Byte < 2 THEN lokawalx%(i, II% + 1, 7) = -1 ELSE Byte = Byte - 2
                IF Byte < 1 THEN lokawalx%(i, II% + 1, 8) = -1 ELSE Byte = Byte - 1
            NEXT II%
        NEXT i


       SCREEN 7, , 2, 0
       PCOPY 0, 1
       PCOPY 0, 2


       LenHur = LEN(Huruf$)
       panjang = 1
       Habis = 1
       DO
          FOR x = 1 TO panjang
              FOR i = 1 TO 16
                  FOR j = 1 TO 8
                      IF (lokawalx%(x, i, j) <> -1) AND LokStatus%(x, i, j) <> 0 THEN
                         lokPosisix%(x, i, j) = INT(lokawalx%(x, i, j) + Posisi%(x, i, j) * (lokakhirx%(x, i, j) - lokawalx%(x, i, j)) / MaxPosisi%)
                         lokPosisiy%(x, i, j) = INT(lokawaly%(x, i, j) + Posisi%(x, i, j) * (lokakhiry%(x, i, j) - lokawaly%(x, i, j)) / MaxPosisi%)
                         IF lokPosisix%(x, i, j) = lokakhirx%(x, i, j) AND lokPosisiy%(x, i, j) = lokakhiry%(x, i, j) THEN
                            lokPosisix%(x, i, j) = lokakhirx%(x, i, j)
                            lokPosisiy%(x, i, j) = lokakhiry%(x, i, j)
                            LokStatus%(x, i, j) = 0
                         ELSE
                            Habis = 0
                         END IF
                      END IF
                      Posisi%(x, i, j) = Posisi%(x, i, j) + 1
                      IF Posisi%(x, i, j) >= MaxPosisi% THEN
                         lokPosisix%(x, i, j) = lokakhirx%(x, i, j)
                         lokPosisiy%(x, i, j) = lokakhiry%(x, i, j)
                         LokStatus%(x, i, j) = 0
                         Posisi%(x, i, j) = MaxPosisi%
                      END IF
                  NEXT
              NEXT
          NEXT
          FOR x = 1 TO panjang
              FOR i = 1 TO 16
                  FOR j = 1 TO 8
                      IF lokawalx%(x, i, j) <> -1 THEN
                         PSET (lokPosisiy%(x, i, j), lokPosisix%(x, i, j)), warna%
                      END IF
                  NEXT
              NEXT
          NEXT
          PCOPY 2, 0
          PCOPY 1, 2
  
          panjang = panjang + 1
          IF panjang >= LenHur THEN panjang = LenHur
       LOOP UNTIL panjang = LenHur AND Posisi%(LenHur, 16, 8) = MaxPosisi%
Ini:
ERASE lokawalx%, lokawaly%, lokakhirx%, lokakhiry%
ERASE lokPosisix%, lokPosisiy%, LokStatus%, Posisi%
ERASE DATAX%, DATAY%
END SUB

