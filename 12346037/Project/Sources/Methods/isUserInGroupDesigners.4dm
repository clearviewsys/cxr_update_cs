//%attributes = {}
// IsUserDesigner ->boolean
// returns true if user is designer or administrator

C_BOOLEAN:C305($0)

If (User in group:C338(getApplicationUser; "Designers"))
	$0:=True:C214
Else 
	$0:=False:C215
End if 