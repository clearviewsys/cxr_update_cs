//%attributes = {}
// isSelectionHomogeneous (->table;->field;->commonValue): boolean
// this function returns true if all the values in the field are the same
// it returns the common value in the commonValue field
// please initialize the commonValue before calling (there's no way for this method to know how to initialize the
// pointer value cause it may be of different types.

C_POINTER:C301($tablePtr; $fieldPtr; $valuePtr; $1; $2; $3)
C_BOOLEAN:C305($0)
C_LONGINT:C283($instances)
ARRAY TEXT:C222($arrSelection; 0)

$tablePtr:=$1
$fieldPtr:=$2
$valuePtr:=$3

If (Records in selection:C76($tablePtr->)>0)  // there is a selection
	SELECTION TO ARRAY:C260($fieldPtr->; $arrSelection)
	$instances:=Count in array:C907($arrSelection; $arrSelection{1})  // see if the first item is repeated in all the array
	
	If ($instances=Size of array:C274($arrSelection))  // if all the elements are the same (homogeneous)
		$0:=True:C214
		$valuePtr->:=$arrSelection{1}
	Else 
		$0:=False:C215
		$valuePtr->:=""
	End if 
Else 
	$0:=False:C215
End if 

CLEAR VARIABLE:C89($arrSelection)