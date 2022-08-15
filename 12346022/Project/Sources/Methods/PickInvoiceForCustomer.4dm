//%attributes = {}
// pickInvoiceForCustomer (SearchString; ->fieldPtr)
// #ORDA

C_LONGINT:C283($win)
C_OBJECT:C1216($obj)
C_TEXT:C284($1; $preQueryString)  // Make this selection first, then query within i.e. filter hidden Accounts
C_POINTER:C301($tablePtr; $2)

If (Count parameters:C259<2)
	
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	
Else 
	$preQueryString:=$1
	$tablePtr:=$2
End if 

//$tablePtr:=Table(Table($fieldPtr))  // the pointer to the same table as the field is pointing to

$obj:=New object:C1471
$obj.searchString:=$preQueryString
$obj.title:=getElegantTableName($tablePtr)+" Picker"
$obj.searchMethod:="search"+Table name:C256($tablePtr)  // e.g. searchCustomers

READ ONLY:C145($tablePtr->)
ALL RECORDS:C47($tablePtr->)

$obj.pickerList:=Create entity selection:C1512($tablePtr->)

$obj.initialList:=Create entity selection:C1512($tablePtr->)  // keep a version of the original selection

$win:=Open form window:C675($tablePtr->; "Picker")

DIALOG:C40($tablePtr->; "Picker"; $obj)  // $obj is passed to the Form object of that form. 

If (OK=1)
	If ($obj.selectedEntities#Null:C1517)
		READ ONLY:C145($tablePtr->)
		USE ENTITY SELECTION:C1513($obj.selectedEntities)
		
	End if 
End if 