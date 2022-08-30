//%attributes = {}
// isUserDesigner ->boolean
// returns true if user is designer 

C_BOOLEAN:C305($0)

If (User in group:C338(getApplicationUser; "Designers")) | (getApplicationUser="designer")
	$0:=True:C214
Else 
	$0:=False:C215
End if 