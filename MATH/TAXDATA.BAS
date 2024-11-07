DECLARE SUB CreateFromCSV ()
DECLARE SUB DisplayRecords ()

COMMON SHARED OutOfData, IPE

TYPE SalesTaxClass
    state AS STRING * 24
     abbr AS STRING * 2
     rate AS SINGLE
END TYPE  '30

DIM SHARED SalesTax AS SalesTaxClass

    CLS
    IF COMMAND$ = "/K" THEN KILL "salestax.dat"  'kill random db before converting
    OPEN "Salestax.dat" FOR RANDOM AS #2 LEN = 30
    
    CreateFromCSV
    DisplayRecords
    

DATA Alabama,AL,4
DATA Arizona,AZ,5.6
DATA Arkansas,AR,6
DATA California,CA,7.25
DATA Colorado,CO,2.9
DATA Connecticut,CT,6
DATA Florida,FL,6
DATA Georgia,GA,4
DATA Idaho,ID,5
DATA Illinois,IL,6.25
DATA Indiana,IN,6
DATA Iowa,IA,5
DATA Kansas,KS,5.3
DATA Kentucky,KY,6
DATA Louisiana,LA,4
DATA Maine,ME,5
DATA Maryland,MD,5
DATA Massachusetts,MA,5
DATA Michigan,MI,6
DATA Minnesota,MN,6.5
DATA Mississippi,MS,7
DATA Missouri,MO,5
DATA Nebraska,NE,5.5
DATA Nevada,NV,6.5
DATA New Jersey, NJ, 7
DATA New Mexico, NM, 5
DATA New York, NY, 4
DATA North Carolina, NC, 4.5
DATA North Dakota, ND, 5
DATA Ohio,OH,5.5
DATA Oklahoma,OK,4.5
DATA Pennsylvania,PA,6
DATA Rhode Island, RI, 7
DATA South Carolina, SC, 5
DATA South Dakota, SD, 4
DATA Tennessee,TN,6
DATA Texas,TX,6.25
DATA Utah,UT,4.75
DATA Vermont,VT,6
DATA Virginia,VA,5
DATA Washington,WA,6.5
DATA West Virginia, WV, 6
DATA Wisconsin,WI,5
DATA Wyoming,WY,4

SUB CreateFromCSV
    OPEN "salestax.csv" FOR INPUT AS #1: rn = 0
    DO
        INPUT #1, SalesTax.state
        INPUT #1, SalesTax.abbr
        INPUT #1, SalesTax.rate
        rn = rn + 1
        PUT #2, rn, SalesTax
    LOOP UNTIL EOF(1)
    CLOSE #1

    PRINT "Sales Tax data for"; rn; "states successfully added"
END SUB

SUB DisplayRecords
    FOR rn = 1 TO (LOF(2) / 30)
        GET #2, rn, SalesTax
        IF rn MOD 22 = 0 THEN SLEEP: CLS
        PRINT SalesTax.state, SalesTax.abbr, SalesTax.rate
    NEXT rn
END SUB

