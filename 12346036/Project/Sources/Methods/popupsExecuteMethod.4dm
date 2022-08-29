//%attributes = {}
// executes mehod associated with popup

C_TEXT:C284($1; $formObjectProperty)
C_TEXT:C284($2; $popupName; $methodToExecute)
C_OBJECT:C1216($dummy; $selected)

$formObjectProperty:=$1
$popupName:=$2

If (Form:C1466[$formObjectProperty][$popupName]#Null:C1517)
	
	$selected:=popupsGetSelected($formObjectProperty; $popupName)
	$selected.formObjName:=$popupName
	
	If (Form:C1466[$formObjectProperty][$popupName].method#Null:C1517)
		$methodToExecute:=Form:C1466[$formObjectProperty][$popupName].method
		If ($methodToExecute#"")
			EXECUTE METHOD:C1007(Form:C1466[$formObjectProperty][$popupName].method; $dummy; $selected)
		End if 
	End if 
	
End if 
