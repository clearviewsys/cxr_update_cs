//%attributes = {}
C_DATE:C307($date)
C_REAL:C285($debit; $credit)
C_TEXT:C284($accountID; $reference)

READ ONLY:C145([ImportedRows:91])
LOAD RECORD:C52([ImportedRows:91])

$date:=[ImportedRows:91]creationDate:4
$debit:=[ImportedRows:91]Debit:8
$credit:=[ImportedRows:91]Credit:9
$accountID:=[ImportedRows:91]CXR_accountID:7

QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2=$date)
//QUERY SELECTION([Registers];[Registers]AccountID=$accountID)


QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8=$debit; *)
QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]Credit:7=$credit)
