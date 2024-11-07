CLS : SHELL "if exist c:\pc_times.log del c:\pc_times.log"
OPEN "C:\pc_times.log" FOR APPEND AS #1
PRINT #1, "01-01-2002": PRINT #1, times: CLOSE #1

