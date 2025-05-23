@echo off


@if "%1%" == "" goto USAGE

@cls
@echo.
@echo Voice File Completeness Check
@echo FOR VOICE:  %1%
@cd ..\voices\%1%
@echo.
@echo.
@echo �����Directories
@if not exist alphabet\nul echo      � Alphabet directory missing
@if not exist colors\nul echo      � Color directory missing
@if not exist numbers\nul echo      � Numbers directory missing
@if not exist shapes\nul echo      � Shapes directory missing
@if not exist Greetings\nul echo      � Greetings directory missing

@echo.
@echo �����Alphabet
@IF not exist alphabet\a.wav echo      � Letter 'A' missing
@IF NOT exist alphabet\b.wav echo      � Letter 'B' missing
@IF NOT exist alphabet\c.wav Echo      � Letter 'C' missing
@IF NOT exist alphabet\d.wav Echo      � Letter 'D' missing
@IF NOT exist alphabet\e.wav Echo      � Letter 'E' missing
@IF NOT exist alphabet\f.wav Echo      � Letter 'F' missing
@IF NOT exist alphabet\g.wav Echo      � Letter 'G' missing
@IF NOT exist alphabet\h.wav Echo      � Letter 'H' missing
@IF NOT exist alphabet\i.wav Echo      � Letter 'I' missing
@IF NOT exist alphabet\j.wav Echo      � Letter 'J' missing
@IF NOT exist alphabet\k.wav Echo      � Letter 'K' missing
@IF NOT exist alphabet\l.wav Echo      � Letter 'L' missing
@IF NOT exist alphabet\m.wav Echo      � Letter 'M' missing
@IF NOT exist alphabet\n.wav Echo      � Letter 'N' missing
@IF NOT exist alphabet\o.wav Echo      � Letter 'O' missing
@IF NOT exist alphabet\p.wav Echo      � Letter 'P' missing
@IF NOT exist alphabet\q.wav Echo      � Letter 'Q' missing
@IF NOT exist alphabet\r.wav Echo      � Letter 'R' missing
@IF NOT exist alphabet\s.wav Echo      � Letter 'S' missing
@IF NOT exist alphabet\t.wav Echo      � Letter 'T' missing
@IF NOT exist alphabet\u.wav Echo      � Letter 'U' missing
@IF NOT exist alphabet\v.wav Echo      � Letter 'V' missing
@IF NOT exist alphabet\w.wav Echo      � Letter 'W' missing
@IF NOT exist alphabet\x.wav Echo      � Letter 'X' missing
@IF NOT exist alphabet\y.wav Echo      � Letter 'Y' missing
@IF NOT exist alphabet\z.wav Echo      � Letter 'Z' missing

@echo.
@echo �����Colors
@if not exist colors\black.wav echo      � Color 'Black' missing
@if not exist colors\blue.wav echo      � Color 'Blue' missing
@if not exist colors\brown.wav echo      � Color 'Brown' missing
@if not exist colors\gray.wav echo      � Color 'Gray' missing
@if not exist colors\green.wav echo      � Color 'Green' missing
@if not exist colors\orange.wav echo      � Color 'Orange' missing
@if not exist colors\pink.wav echo      � Color 'Pink' missing
@if not exist colors\purple.wav echo      � Color 'Purple' missing
@if not exist colors\Red.wav echo      � Color 'Red' missing
@if not exist colors\white.wav echo      � Color 'White' missing
@if not exist colors\yellow.wav echo      � Color 'Yellow' missing

@echo.
@echo �����Greetings
@if not exist greetings\hi.wav echo      � 'Hello' greeting  missing
@if not exist greetings\bye.wav echo      � 'Goodbye' greeting  missing



@echo.
@echo �����Numbers
@if not exist numbers\0.wav echo      � Number 0 missing
@if not exist numbers\1.wav echo      � Number 1 missing
@if not exist numbers\2.wav echo      � Number 2 missing
@if not exist numbers\3.wav echo      � Number 3 missing
@if not exist numbers\4.wav echo      � Number 4 missing
@if not exist numbers\5.wav echo      � Number 5 missing
@if not exist numbers\6.wav echo      � Number 6 missing
@if not exist numbers\7.wav echo      � Number 7 missing
@if not exist numbers\8.wav echo      � Number 8 missing
@if not exist numbers\9.wav echo      � Number 9 missing
@if not exist numbers\10.wav echo      � Number 10 missing
@if not exist numbers\11.wav echo      � Number 11 missing
@if not exist numbers\12.wav echo      � Number 12 missing
@if not exist numbers\13.wav echo      � Number 13 missing
@if not exist numbers\14.wav echo      � Number 14 missing
@if not exist numbers\15.wav echo      � Number 15 missing
@if not exist numbers\16.wav echo      � Number 16 missing
@if not exist numbers\17.wav echo      � Number 17 missing
@if not exist numbers\18.wav echo      � Number 18 missing
@if not exist numbers\19.wav echo      � Number 19 missing
@if not exist numbers\20.wav echo      � Number 20 missing

@echo.
@echo �����Shapes
@If not exist shapes\Circle.wav Echo      � Shape 'Circle' missing
@If not exist shapes\Diamond.wav Echo      � Shape 'Diamond' missing
@If not exist shapes\Oval.wav Echo      � Shape 'Oval' missing
@If not exist shapes\Rectangle.wav Echo      � Shape 'Rectangle' missing
@If not exist shapes\Square.wav Echo      � Shape 'Square' missing
@If not exist shapes\Triangle.wav Echo      � Shape 'Triangle' missing

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

