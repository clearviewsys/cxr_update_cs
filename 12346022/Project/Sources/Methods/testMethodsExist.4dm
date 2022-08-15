//%attributes = {}
C_TEXT:C284($methodName)
C_LONGINT:C283($i)
$methodName:=Request:C163("Name of prefix method to test on all tables:")
For ($i; 1; Get last table number:C254)
	setErrorTrap("testMethodsExist"; "method doesn't exist for table "+Table name:C256($i))
	executeMethodName($methodName+Table name:C256($i))
	endErrorTrap
End for 
