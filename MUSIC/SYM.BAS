'Program : Music (simphony no.9 beethoven)
'Programer : FARZAD BADILI(FDB@bigfoot.com)
'http://www.inernettrash.com/users/fdb/

REM simphony no.9 beethoven
b:
READ A$: PLAY "t150"
IF A$ = "end" THEN END
IF A$ = "stop" AND A = 0 THEN A = 1: GOTO b
IF A$ = "stop" AND A = 1 THEN STOP
IF A$ = "again" AND b = 1 THEN GOTO b
IF A$ = "again" AND b = 0 THEN b = 1: RESTORE: GOTO b
PLAY A$: GOTO b
DATA o3l4eefg,gfed,ccde,l2el8dl4d.
DATA o3l4eefg,gfed,ccde,l2dl8cl4c.,stop
DATA o3l4ddec,dl8efl4ec,dl8efl4ec,dl8efl4ed
DATA cdo2l4gg,again,end


