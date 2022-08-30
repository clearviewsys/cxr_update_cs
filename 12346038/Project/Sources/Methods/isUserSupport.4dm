//%attributes = {}
// isUserSupport
// this Method should return if the user is part of the Support Group
C_BOOLEAN:C305($0)

If (getApplicationUser="Support")
	$0:=True:C214
Else 
	$0:=(False:C215 | isUserDesigner)  // if the user is designer, then allow them
End if 