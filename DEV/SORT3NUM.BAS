DIM scores(3), order(3)

names$(1) = "Charles": score(1) = 5: sortedscore(1) = score(1): order(1) = 1
names$(2) = "Troy": score(2) = 15: sortedscore(2) = score(2): order(2) = 2
names$(3) = "Amanda": score(3) = 10: sortedscore(3) = score(3): order(3) = 3

CLS
FOR pl = 1 TO 3
    PRINT names$(pl); " has"; sortedscore(pl)
NEXT pl

IF sortedscore(2) > sortedscore(1) THEN SWAP sortedscore(2), sortedscore(1): SWAP order(2), order(1)  '2>1
IF sortedscore(3) > sortedscore(1) THEN SWAP sortedscore(3), sortedscore(1):  SWAP order(3), order(1)  '3>1
IF sortedscore(3) > sortedscore(2) THEN SWAP sortedscore(3), sortedscore(2): SWAP order(3), order(2)  '3>2

PRINT
PRINT " First place - "; names$(order(1)); " with"; score(order(1))
PRINT "Second place - "; names$(order(2)); " with"; score(order(2))
PRINT " Third place - "; names$(order(3)); " with"; score(order(3))


