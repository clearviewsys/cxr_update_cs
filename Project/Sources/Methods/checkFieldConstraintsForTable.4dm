//%attributes = {}
// checkFieldConstraintsForTable (->table; conditional?)
// check all field constraints for a certain table




C_POINTER:C301($tablePtr; $1)
C_POINTER:C301($fieldPtr)
C_BOOLEAN:C305($isConditional; $2)

C_LONGINT:C283($i; $tableNo; $type)
C_BOOLEAN:C305(isTrue)
C_TEXT:C284($condition)

Case of 
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$isConditional:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tableNo:=Table:C252($tablePtr)

// add mandatory fields first
READ ONLY:C145([FieldConstraints:69])
QUERY:C277([FieldConstraints:69]; [FieldConstraints:69]TableNo:1=$tableNo; *)  // #optimized @tiran combined the queries
QUERY:C277([FieldConstraints:69];  & ; [FieldConstraints:69]isConditional:7=$isConditional; *)  // conditional constraints don't count
QUERY:C277([FieldConstraints:69];  & ; [FieldConstraints:69]isWebConstraint:13#1)  //not a web only contraint

FIRST RECORD:C50([FieldConstraints:69])

For ($i; 1; Records in selection:C76([FieldConstraints:69]))
	$fieldPtr:=Field:C253([FieldConstraints:69]TableNo:1; [FieldConstraints:69]FieldNo:2)
	GET FIELD PROPERTIES:C258($fieldPtr; $type)
	
	$condition:=[FieldConstraints:69]condition:14
	
	If ($condition="")
		isTrue:=True:C214
	Else 
		EXECUTE FORMULA:C63("isTrue:=("+$condition+")")  //have to used process var here
	End if 
	
	If (isTrue)
		colourizeField($fieldPtr; [FieldConstraints:69]isMandatory:4)  // added by @tiran on Nov 24/2020
		
		Case of 
			: (($type=Is alpha field:K8:1) | ($type=Is text:K8:3))  // string
				If ([FieldConstraints:69]isMandatory:4)
					checkAddErrorIf(($fieldPtr->=""); [FieldConstraints:69]FieldLabel:3+" cannot be left blank.")
				Else 
					checkAddWarningOnTrue(($fieldPtr->=""); "You forgot to enter: "+[FieldConstraints:69]FieldLabel:3)
				End if 
				
			: ($type=Is date:K8:7)
				If ([FieldConstraints:69]isMandatory:4)
					checkAddErrorIf(($fieldPtr->=nullDate); [FieldConstraints:69]FieldLabel:3+" must be filled with a valid date.")
				Else 
					checkAddWarningOnTrue(($fieldPtr->=nullDate); "You forgot to enter a date for "+[FieldConstraints:69]FieldLabel:3)
				End if 
				
			: (($type=Is real:K8:4) | ($type=Is longint:K8:6) | ($type=Is integer:K8:5))
				If ([FieldConstraints:69]isMandatory:4)
					checkAddErrorIf(($fieldPtr->=0); [FieldConstraints:69]FieldLabel:3+" must be greater than zero.")
				Else 
					checkAddWarningOnTrue(($fieldPtr->=0); [FieldConstraints:69]FieldLabel:3+" is left zero.")
				End if 
				
			: ($type=Is picture:K8:10)
				If ([FieldConstraints:69]isMandatory:4)
					checkAddErrorIf((Picture size:C356($fieldPtr->)=0); [FieldConstraints:69]FieldLabel:3+" must contain an image.")
				Else 
					checkAddWarningOnTrue((Picture size:C356($fieldPtr->)=0); [FieldConstraints:69]FieldLabel:3+" does not contain any image.")
				End if 
				
		End case 
		
	End if 
	NEXT RECORD:C51([FieldConstraints:69])
	
End for 
