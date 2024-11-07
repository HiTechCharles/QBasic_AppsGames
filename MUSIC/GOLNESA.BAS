'Program : Music (Golnesa)
'Programer : FARZAD BADILI(FDB@bigfoot.com)
'http://www.inernettrash.com/users/fdb/

REM golnesa
b:
READ A$: PLAY "t150"
IF A$ = "end" THEN END
IF A$ = "stop" AND A = 0 THEN A = 1: GOTO b
IF A$ = "stop" AND A = 1 THEN STOP
IF A$ = "again" AND b = 1 THEN GOTO b
IF A$ = "again" AND b = 0 THEN b = 1: RESTORE: GOTO b
PLAY A$: GOTO b
DATA o3l4eee,l2ee,l4dl2l4d,l2ed
DATA o3l4eee,l2ee,l4dl2l4d,l2ed
DATA l4p4edc,l2de,o3l4cl2dl4e,dcl2e
DATA o3l4cl2dl4e,dcl2e
DATA l4cl2dl4e,l2dc,again,end


