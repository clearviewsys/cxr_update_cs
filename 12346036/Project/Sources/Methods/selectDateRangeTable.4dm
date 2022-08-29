//%attributes = {}
// selectDateRangeTable(->[table];->fielddate;fromDate;toDate; onSelction)


C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_DATE:C307($fromDate; $toDate; $3; $4)
C_BOOLEAN:C305($onSelection; $5)
$tablePtr:=$1
$fieldPtr:=$2
$fromDate:=$3
$toDate:=$4

If (Count parameters:C259=4)
	QUERY:C277($tablePtr->; $fieldPtr->>=$FromDate; *)
	QUERY:C277($tablePtr->;  & ; $fieldPtr-><=$ToDate)
Else 
	$onSelection:=$5
	
	If ($onSelection)
		QUERY SELECTION:C341($tablePtr->; $fieldPtr->>=$FromDate; *)
		QUERY SELECTION:C341($tablePtr->;  & ; $fieldPtr-><=$ToDate)
	Else 
		QUERY:C277($tablePtr->; $fieldPtr->>=$FromDate; *)
		QUERY:C277($tablePtr->;  & ; $fieldPtr-><=$ToDate)
	End if 
End if 