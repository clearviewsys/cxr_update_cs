//%attributes = {}
// listbox_editCurrentRow (column object name ;focus object)


C_TEXT:C284($1; $listboxName)
C_POINTER:C301($2)
C_POINTER:C301($columnPtr)
C_LONGINT:C283($Row)

$listBoxName:=$1

$ColumnPtr:=$2  // focus object

If (Not:C34(Is nil pointer:C315($columnPtr)))
	$Row:=$ColumnPtr->
	EDIT ITEM:C870(*; $listBoxName; $row)
End if 