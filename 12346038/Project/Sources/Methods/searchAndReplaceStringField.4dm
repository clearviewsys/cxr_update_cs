//%attributes = {}
// searchAndReplaceStringField(->[TABLE];->field; oldValue;newValue)
C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_TEXT:C284($oldString; $newString)
$tablePtr:=$1
$fieldPtr:=$2
$oldString:=$3
$newString:=$4

READ WRITE:C146($tablePtr->)
QUERY:C277($tablePtr->; $fieldPtr->=$oldString)
Repeat 
	APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=$newString)
	If (Records in set:C195("LockedSet")>0)
		USE SET:C118("LockedSet")
		myAlert("There are "+String:C10(Records in set:C195("LockedSet"))+" locked records in "+getElegantTableName($tablePtr)+". Please unlock these records.")
	End if 
	
Until (Records in set:C195("LockedSet")=0)  // Done when there are no locked records
READ ONLY:C145($tablePtr->)
