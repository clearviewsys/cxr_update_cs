//%attributes = {"shared":true}
// assertInvalidNumberOfParams (methodName{;count parameters})
// this assertion will definitely fail if the number of parameters are wrong
// call this with the calling method name


C_TEXT:C284($1; $error)
$error:="Invalid number of parameters passed to function "
C_LONGINT:C283($2)

Case of 
		
	: (Count parameters:C259=1)
		ASSERT:C1129(False:C215; $error+$1)
		
		
	: (Count parameters:C259=2)
		ASSERT:C1129(False:C215; $error+$1+" "+String:C10($2))
	Else 
		ASSERT:C1129(False:C215; $error+Current method name:C684)
End case 