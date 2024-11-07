@echo off
@copy /y hang.dat talking
@copy /y hang.dat lite
@copy /y hang.dat withso~2

@copy /y puzzles.exe talking
@copy /y puzzles.exe lite
@copy /y puzzles.exe withso~2

if exist *.obj del *.obj