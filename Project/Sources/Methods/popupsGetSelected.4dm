//%attributes = {}
C_OBJECT:C1216($0)
C_TEXT:C284($1; $formObjectProperty)
C_TEXT:C284($2; $popupName)
C_POINTER:C301($objptr)

$formObjectProperty:=$1
$popupName:=$2

If (Form:C1466[$formObjectProperty][$popupName]#Null:C1517)
	
	
	$objptr:=OBJECT Get pointer:C1124(Object named:K67:5; $popupName)
	
	$0:=New object:C1471
	
	$0.idx:=$objptr->
	
	If ($0.idx>0)
		$0.obj:=Form:C1466[$formObjectProperty][$popupName].values[$0.idx-1]
	End if 
	
End if 
