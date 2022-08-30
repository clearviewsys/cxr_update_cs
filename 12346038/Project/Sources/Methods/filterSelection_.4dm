//%attributes = {}


C_POINTER:C301($1)  //table
C_TEXT:C284($2; $methodName)
C_POINTER:C301($3)  //pointer to name array
C_POINTER:C301($4)  // pointer to value array

C_LONGINT:C283($iResult)


If (Is nil pointer:C315($1))
	
Else 
	$methodName:="filterSelection_"+Table name:C256($1)
	//If (isUserAuthorizedToView ($1))
	
	//If (AP Does method exist ($methodName)=1)  //
	If (UTIL_isMethodExists($methodName))
		EXECUTE METHOD:C1007($methodName; $iResult; $2; $3; $4)
	End if 
End if 