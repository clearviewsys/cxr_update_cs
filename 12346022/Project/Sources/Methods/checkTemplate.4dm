//%attributes = {}
checkInit
checkIfNullString(->[CompanyInfo:7]CompanyName:1; "FieldName")  // for mandatory strings

checkIfNullString(->[CompanyInfo:7]CompanyName:1; "FieldName")  // for mandatory strings

//checkIfValidDate (->[Forms];"DateField")  ` for mandatory dates

//checkLowerBound (->;"NumberField";0)  ` for mandatory numbers

If (checkErrorExist)
	myAlert(checkGetErrorString)
	REJECT:C38
Else 
	// validation code
	
	// validate transaction
	
End if 