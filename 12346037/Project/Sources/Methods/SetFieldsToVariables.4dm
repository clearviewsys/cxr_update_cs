//%attributes = {}
// SetFieldsToVariables (»table)

// assign fields to variables for the given table
// PRE:    ASSERT the variables v{fieldname} are already defined
// POST: FieldName:= vFieldName  (for all fields in the table)

C_POINTER:C301($1)
C_POINTER:C301($theVarPtr)
C_LONGINT:C283($i; $fieldType; $tableNum)

ARRAY TEXT:C222($anames; 0)
ARRAY TEXT:C222($avalues; 0)
C_TEXT:C284($theVarName)

WEB GET VARIABLES:C683($anames; $avalues)

$tableNum:=Table:C252($1)

For ($i; 1; Get last field number:C255($1))
	If (Is field number valid:C1000($tableNum; $i))  // Jan 16, 2012 18:32:37 -- I.Barclay Berry 
		$theVarName:="web"+Field name:C257($tableNum; $i)
		
		$theVarPtr:=Get pointer:C304($theVarName)
		
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
		
	End if 
	
End for 
