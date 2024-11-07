'Program : Music (Moscow Nights)
'Programer : FARZAD BADILI(FDB@bigfoot.com)
'http://www.inernettrash.com/users/fdb/

REM moscow nights
b:
READ A$: PLAY "t150"
IF A$ = "end" THEN END
IF A$ = "STOP" AND A = 0 THEN A = 1: GOTO b
IF A$ = "stop" AND A = 1 THEN STOP
IF A$ = "again" AND b = 1 THEN GOTO b
IF A$ = "again" AND b = 0 THEN b = 1: RESTORE: GOTO b
PLAY A$: GOTO b
DATA o3l8acec,l4dl8co3b,l4o4ed,o3l2a,o4cegg,l4al8gf,l2e
DATA o4l4f+g+,l8bal4e,p4l8co3a,edl4f
DATA o4p4l8gf,l4el8dc,l4ed,l2o3a
DATA o4p4l8gf,l4el8dc,l4ed,l2o4a,again,end

