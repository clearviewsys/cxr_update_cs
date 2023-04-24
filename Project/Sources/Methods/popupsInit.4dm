//%attributes = {}
C_TEXT:C284($1; $formObjectProperty)  // which property holds data about all popups
C_TEXT:C284($2; $popupFormObjectName)  // name of the form object which is popup
C_COLLECTION:C1488($3; $values; $indices)  // collection where the data comes from (usually built from entity selection)
C_COLLECTION:C1488($4; $propertyNames)  // collection of objects defining which collection properties holds values to display in popup and which separator to use
C_OBJECT:C1216($5; $default)  // which item to select by default
C_TEXT:C284($6; $method)  // method to run in On Data Change

C_POINTER:C301($popupPtr)
C_OBJECT:C1216($item; $colitem)
C_TEXT:C284($currArrayItem)
C_LONGINT:C283($valueType)

$formObjectProperty:=$1
$popupFormObjectName:=$2
$values:=$3
$propertyNames:=$4
$method:=""

If (Count parameters:C259>4)
	$default:=$5
	If (Count parameters:C259>5)
		$method:=$6
	End if 
End if 

If (Form:C1466[$formObjectProperty]=Null:C1517)
	Form:C1466[$formObjectProperty]:=New object:C1471
End if 


Form:C1466[$formObjectProperty][$popupFormObjectName]:=New object:C1471("values"; $values; "method"; $method)

For each ($colitem; $propertyNames)
	Form:C1466[$formObjectProperty][$popupFormObjectName][$colitem.propertyName]:=New object:C1471
	Form:C1466[$formObjectProperty][$popupFormObjectName][$colitem.propertyName].separator:=$colitem.separator
End for each 

$popupPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $popupFormObjectName)

For each ($item; Form:C1466[$formObjectProperty][$popupFormObjectName].values)
	
	$currArrayItem:=""
	
	For each ($colitem; $propertyNames)
		
		$valueType:=Value type:C1509($item[$colitem.propertyName])
		
		Case of 
				
			: ($valueType=Is text:K8:3)
				
				$currArrayItem:=$currArrayItem+$item[$colitem.propertyName]+$colitem.separator
				
				
			: ($valueType=Is real:K8:4)
				
				$currArrayItem:=$currArrayItem+String:C10($item[$colitem.propertyName])+$colitem.separator
				
				
			: ($valueType=Is date:K8:7)
				
				$currArrayItem:=$currArrayItem+String:C10($item[$colitem.propertyName])+$colitem.separator
				
				
		End case 
		
	End for each 
	
	APPEND TO ARRAY:C911($popupPtr->; $currArrayItem)
	
End for each 

If ($default#Null:C1517)
	
	If ($default.type="index")
		// if index, just select by it
		Form:C1466[$formObjectProperty][$popupFormObjectName].setDefault:=$default.value
	Else 
		// if not index look for ID, find the proper index
		$indices:=$values.indices($default.property+" = :1"; $default.value)
		If ($indices#Null:C1517)
			Form:C1466[$formObjectProperty][$popupFormObjectName].setDefault:=$indices[0]+1
		End if 
	End if 
End if 

If (Form:C1466[$formObjectProperty][$popupFormObjectName].setDefault#Null:C1517)
	$popupPtr->:=Form:C1466[$formObjectProperty][$popupFormObjectName].setDefault
Else 
	$popupPtr->:=0
End if 
