SHELL "if not exist c:\pc_times.log bt_setup"
OPEN "C:\PC_USE.log" FOR APPEND AS #1: OPEN "C:\PC_times.log" FOR INPUT AS #2
PRINT #1, "PC turned on:  "; DATE$; " at "; TIME$
INPUT #2, oldDate$: newdate$ = DATE$: INPUT #2, times
IF oldDate$ <> newdate$ THEN times = 1: PRINT #1, "PC started for the first time today": GOTO MNF:
IF oldDate$ = newdate$ THEN times = times + 1: PRINT #1, "PC starts today: "; times: GOTO MNF:
MNF:
CLOSE #2: OPEN "C:\pc_times.log" FOR OUTPUT AS #2
PRINT #2, newdate$: PRINT #2, times: PRINT #1, : CLOSE #1: CLOSE #2: SYSTEM

