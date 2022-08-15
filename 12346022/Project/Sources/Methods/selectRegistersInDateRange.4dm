//%attributes = {}

// selectRegistersInDateRange (accountID;fromDate;toDate;{onSelection})

C_TEXT:C284($1; $accountID)
C_DATE:C307($2; $3; $fromDate; $toDate)
C_BOOLEAN:C305($4; $onSelection)

$accountID:=$1
$fromDate:=$2
$toDate:=$3
$onSelection:=False:C215
If (Count parameters:C259=4)
	$onSelection:=$4
End if 

If ($onSelection)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]AccountID:6=$accountID; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2>=$fromDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
Else 
	QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2>=$fromDate; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
End if 
