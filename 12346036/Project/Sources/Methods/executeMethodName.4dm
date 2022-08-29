//%attributes = {}
// executes a method but truncates long names

C_TEXT:C284($methodName; $1)
$methodName:=Substring:C12($1; 1; 31)


If (UTIL_isMethodExists($methodName))  //6/28/18 IBB
	EXECUTE FORMULA:C63($methodName)
Else 
	If (Current user:C182="designer")
		myAlert("Method does not exist: "+$methodName)
	End if 
	UTIL_Log("TEST"; "Method does NOT exist: "+$methodName)
End if 
