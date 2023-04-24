//%attributes = {}
// setFieldLookAsMandatory (->field;isMandatory)
// this method makes the look & feel of a field as mandatory
// this method can be more elaborated to add fields to an array of mandatory fields
// so that the form validator can check before approving the form


C_POINTER:C301($1; $fieldPtr)
C_BOOLEAN:C305($2; $isMandatory)
C_LONGINT:C283($r; $g; $b)

Case of 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		$isMandatory:=True:C214
		
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$isMandatory:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$r:=250
$g:=140
$b:=140
C_BOOLEAN:C305($isEmpty)
$isEmpty:=isFieldEmpty($fieldPtr)

If ($isMandatory & $isEmpty)  // colourie if the field is empty
	OBJECT SET RGB COLORS:C628($fieldPtr->; 127; ($R*256*256)+($G*256)+$B)
End if 