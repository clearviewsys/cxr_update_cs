//%attributes = {}
// setFieldsToWebVariables  
// 

ARRAY TEXT:C222($anames; 0)
ARRAY TEXT:C222($avalues; 0)
WEB GET VARIABLES:C683($anames; $avalues)
C_LONGINT:C283($tableNum; $i; $fieldType)
C_POINTER:C301($theVarPtr)

C_TEXT:C284($theVarName)

For ($i; 1; Size of array:C274($anames))
	$theVarName:="web"+Field name:C257($tableNum; $i)
	$theVarPtr:=Get pointer:C304($theVarName)
	
	// check to see if the webVariable is returned
	
	If ((Find in array:C230($aNames; $theVarName)>0))  // then that variable was part of the form
		GET FIELD PROPERTIES:C258($tableNum; $i; $fieldType)
		Case of 
			: (($fieldType=Is alpha field:K8:1) | ($fieldType=Is text:K8:3))
				If (Field name:C257($tableNum; $i)#"")
					Field:C253($tableNum; $i)->:=$theVarPtr->
				End if 
			: (($FieldType=Is longint:K8:6) | ($fieldtype=Is real:K8:4) | ($fieldType=Is integer:K8:5))
				Field:C253($tableNum; $i)->:=Num:C11($theVarPtr->)
			: ($FieldType=Is date:K8:7)
				Field:C253($tableNum; $i)->:=Date:C102($theVarPtr->)
			: ($FieldType=Is boolean:K8:9)
				Field:C253($tableNum; $i)->:=stringToBoolean($theVarPtr->)
		End case 
	End if 
	
End for 
