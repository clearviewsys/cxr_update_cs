//%attributes = {}
// getIC_FailedRecord (table;integrityCheckID)
C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($integrityCheckID; $2)
$tablePtr:=$1
$integrityCheckID:=$2

READ WRITE:C146([IC_FailedRecords:49])
CREATE RECORD:C68([IC_FailedRecords:49])
[IC_FailedRecords:49]IntegrityCheckID:1:=Substring:C12($integrityCheckID; 4; 100)
[IC_FailedRecords:49]recordID:3:=getPrimaryKeyFieldPtr($tablePtr)->
[IC_FailedRecords:49]tableNo:2:=Table:C252($tablePtr)
SAVE RECORD:C53([IC_FailedRecords:49])
READ ONLY:C145([IC_FailedRecords:49])