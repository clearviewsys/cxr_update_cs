//%attributes = {}
C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $whatToExport)  // "ALL|SELECTION"
C_COLLECTION:C1488($0)
C_OBJECT:C1216($currRecord)

$tablePtr:=$1
$0:=New collection:C1472

If (Count parameters:C259>1)
	$whatToExport:=$2
Else 
	$whatToExport:="SELECTION"
End if 


If ($whatToExport="ALL")
	ALL RECORDS:C47($tablePtr->)
End if 

FIRST RECORD:C50($tablePtr->)

While (Not:C34(End selection:C36($tablePtr->)))
	
	$currRecord:=objFromRecord($tablePtr)
	
	$0.push($currRecord)
	
	NEXT RECORD:C51($tablePtr->)
	
End while 
