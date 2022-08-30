//%attributes = {}
//createRecordReconciledRow (regiID;account;debit;credit;cur;validCode;)


C_TEXT:C284($regID; $accountID; $validationRef; $CCY; $CUR)
C_TEXT:C284($1; $2; $5; $6)
C_REAL:C285($debit; $credit; $3; $4)

$RegID:=$1
$accountID:=$2
$debit:=$3
$credit:=$4
$CUR:=$5
$validationRef:=$6

C_POINTER:C301($tablePtr)
$tablePtr:=->[ReconciledRows:85]

READ WRITE:C146($tablePtr->)
CREATE RECORD:C68($tablePtr->)

[ReconciledRows:85]BranchID:2:=getBranchID
[ReconciledRows:85]ReconciledRowID:1:=makeReconciledRowID
[ReconciledRows:85]ValidatedBy:12:=getApplicationUser
[ReconciledRows:85]AutoMatchRegisterID:16:=$RegID
[ReconciledRows:85]AccountID:6:=$accountID
[ReconciledRows:85]Debit:7:=$debit
[ReconciledRows:85]Credit:8:=$credit
[ReconciledRows:85]CCY:9:=$CUR
[ReconciledRows:85]ValidationDate:13:=Current date:C33
[ReconciledRows:85]ValidationRef:14:=$validationRef

//[ReconciledRows]CrossReference:=$crossRef
//[ReconciledRows]ExternalRef:=$extRef
//[ReconciledRows]isAutoMatched:=$isAutoMatch
//[ReconciledRows]isValidated:=$isValidated

SAVE RECORD:C53($tablePtr->)
UNLOAD RECORD:C212($tablePtr->)
READ ONLY:C145($tablePtr->)
