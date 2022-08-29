//%attributes = {}
// createPrivilegeRecord(  tableNum; active ; maxRecords;expDate)
C_LONGINT:C283($1; $tableNum)
C_BOOLEAN:C305($2; $isActive)
C_LONGINT:C283($3; $maxRecords)
C_DATE:C307($4; $expDate)

$tableNum:=$1
$isActive:=$2
$maxRecords:=$3
$expDate:=$4

QUERY:C277([TableLimitations:55]; [TableLimitations:55]TableNo:1=$tableNum)
READ WRITE:C146([TableLimitations:55])

If (Records in selection:C76([TableLimitations:55])>=1)
	LOAD RECORD:C52([TableLimitations:55])
Else   // no record has been found 
	
	CREATE RECORD:C68([TableLimitations:55])
	[TableLimitations:55]TableNo:1:=$tableNum
	[TableLimitations:55]isActivated:4:=$isActive
	[TableLimitations:55]MaxRecords:2:=$maxRecords
	[TableLimitations:55]ExpiryDate:3:=$expDate
	SAVE RECORD:C53([TableLimitations:55])
	UNLOAD RECORD:C212([TableLimitations:55])
	
End if 


