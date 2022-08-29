//%attributes = {}
// createRecordTellerProofLine (tellerProofID;demon;curr;count1;count2)
C_TEXT:C284($tellerProofID; $1)
C_REAL:C285($denom; $2)
C_TEXT:C284($curr; $3)
C_LONGINT:C283($qty1; $4)
C_LONGINT:C283($qty2; $5)

$tellerProofID:=$1
$denom:=$2
$curr:=$3
$qty1:=$4
$qty2:=$5

CREATE RECORD:C68([TellerProofLines:79])
[TellerProofLines:79]TellerProofID:1:=$tellerProofID
[TellerProofLines:79]Denomination:3:=$denom
[TellerProofLines:79]Currency:2:=$curr
[TellerProofLines:79]Count1:4:=$qty1
[TellerProofLines:79]Count2:5:=$qty2
[TellerProofLines:79]Total:6:=($qty1+$qty2)*$denom
SAVE RECORD:C53([TellerProofLines:79])
UNLOAD RECORD:C212([TellerProofLines:79])