@echo off


@if "%1%" == "" goto USAGE

@cls
@echo.
@echo Voice File Completeness Check
@echo FOR VOICE:  %1%
@cd ..\voices\%1%
@echo.
@echo.
@echo ÄÄÄÄÄDirectories
@if not exist alphabet\nul echo      ù Alphabet directory missing
@if not exist colors\nul echo      ù Color directory missing
@if not exist numbers\nul echo      ù Numbers directory missing
@if not exist shapes\nul echo      ù Shapes directory missing
@if not exist Greetings\nul echo      ù Greetings directory missing

@echo.
@echo ÄÄÄÄÄAlphabet
@IF not exist alphabet\a.wav echo      ù Letter 'A' missing
@IF NOT exist alphabet\b.wav echo      ù Letter 'B' missing
@IF NOT exist alphabet\c.wav Echo      ù Letter 'C' missing
@IF NOT exist alphabet\d.wav Echo      ù Letter 'D' missing
@IF NOT exist alphabet\e.wav Echo      ù Letter 'E' missing
@IF NOT exist alphabet\f.wav Echo      ù Letter 'F' missing
@IF NOT exist alphabet\g.wav Echo      ù Letter 'G' missing
@IF NOT exist alphabet\h.wav Echo      ù Letter 'H' missing
@IF NOT exist alphabet\i.wav Echo      ù Letter 'I' missing
@IF NOT exist alphabet\j.wav Echo      ù Letter 'J' missing
@IF NOT exist alphabet\k.wav Echo      ù Letter 'K' missing
@IF NOT exist alphabet\l.wav Echo      ù Letter 'L' missing
@IF NOT exist alphabet\m.wav Echo      ù Letter 'M' missing
@IF NOT exist alphabet\n.wav Echo      ù Letter 'N' missing
@IF NOT exist alphabet\o.wav Echo      ù Letter 'O' missing
@IF NOT exist alphabet\p.wav Echo      ù Letter 'P' missing
@IF NOT exist alphabet\q.wav Echo      ù Letter 'Q' missing
@IF NOT exist alphabet\r.wav Echo      ù Letter 'R' missing
@IF NOT exist alphabet\s.wav Echo      ù Letter 'S' missing
@IF NOT exist alphabet\t.wav Echo      ù Letter 'T' missing
@IF NOT exist alphabet\u.wav Echo      ù Letter 'U' missing
@IF NOT exist alphabet\v.wav Echo      ù Letter 'V' missing
@IF NOT exist alphabet\w.wav Echo      ù Letter 'W' missing
@IF NOT exist alphabet\x.wav Echo      ù Letter 'X' missing
@IF NOT exist alphabet\y.wav Echo      ù Letter 'Y' missing
@IF NOT exist alphabet\z.wav Echo      ù Letter 'Z' missing

@echo.
@echo ÄÄÄÄÄColors
@if not exist colors\black.wav echo      ù Color 'Black' missing
@if not exist colors\blue.wav echo      ù Color 'Blue' missing
@if not exist colors\brown.wav echo      ù Color 'Brown' missing
@if not exist colors\gray.wav echo      ù Color 'Gray' missing
@if not exist colors\green.wav echo      ù Color 'Green' missing
@if not exist colors\orange.wav echo      ù Color 'Orange' missing
@if not exist colors\pink.wav echo      ù Color 'Pink' missing
@if not exist colors\purple.wav echo      ù Color 'Purple' missing
@if not exist colors\Red.wav echo      ù Color 'Red' missing
@if not exist colors\white.wav echo      ù Color 'White' missing
@if not exist colors\yellow.wav echo      ù Color 'Yellow' missing

@echo.
@echo ÄÄÄÄÄGreetings
@if not exist greetings\hi.wav echo      ù 'Hello' greeting  missing
@if not exist greetings\bye.wav echo      ù 'Goodbye' greeting  missing



@echo.
@echo ÄÄÄÄÄNumbers
@if not exist numbers\0.wav echo      ù Number 0 missing
@if not exist numbers\1.wav echo      ù Number 1 missing
@if not exist numbers\2.wav echo      ù Number 2 missing
@if not exist numbers\3.wav echo      ù Number 3 missing
@if not exist numbers\4.wav echo      ù Number 4 missing
@if not exist numbers\5.wav echo      ù Number 5 missing
@if not exist numbers\6.wav echo      ù Number 6 missing
@if not exist numbers\7.wav echo      ù Number 7 missing
@if not exist numbers\8.wav echo      ù Number 8 missing
@if not exist numbers\9.wav echo      ù Number 9 missing
@if not exist numbers\10.wav echo      ù Number 10 missing
@if not exist numbers\11.wav echo      ù Number 11 missing
@if not exist numbers\12.wav echo      ù Number 12 missing
@if not exist numbers\13.wav echo      ù Number 13 missing
@if not exist numbers\14.wav echo      ù Number 14 missing
@if not exist numbers\15.wav echo      ù Number 15 missing
@if not exist numbers\16.wav echo      ù Number 16 missing
@if not exist numbers\17.wav echo      ù Number 17 missing
@if not exist numbers\18.wav echo      ù Number 18 missing
@if not exist numbers\19.wav echo      ù Number 19 missing
@if not exist numbers\20.wav echo      ù Number 20 missing

@echo.
@echo ÄÄÄÄÄShapes
@If not exist shapes\Circle.wav Echo      ù Shape 'Circle' missing
@If not exist shapes\Diamond.wav Echo      ù Shape 'Diamond' missing
@If not exist shapes\Oval.wav Echo      ù Shape 'Oval' missing
@If not exist shapes\Rectangle.wav Echo      ù Shape 'Rectangle' missing
@If not exist shapes\Square.wav Echo      ù Shape 'Square' missing
@If not exist shapes\Triangle.wav Echo      ù Shape 'Triangle' missing

@echo.
@echo.
@cd ...\programs
Goto end

:USAGE
@echo.
@echo.
@echo Voice File Checker -- Used by VOICES.EXE
@echo This program checks to see if any voice files are missing from a set
@echo It is reccomended that you use VOICES.EXE to add and check voices
@echo  Voice folder should always be in quotes.  (")
@echo.
@echo    USAGE:  VOICECHECK "<Voice Folder>"
@echo EXAMPLES:  VOICECHECK "Uncle Chuck"  (check files in "Uncle Chuck directory)
@echo.

:END

