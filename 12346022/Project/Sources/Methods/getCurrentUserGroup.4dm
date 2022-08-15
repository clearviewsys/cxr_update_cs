//%attributes = {}
// getCurrentUserGroup
// return the current user group



C_TEXT:C284($0)
READ ONLY:C145([Users:25])
QUERY:C277([Users:25]; [Users:25]UserID:1=<>UserID)  // select the current user

If (Records in selection:C76([Users:25])=1)
	$0:=[Users:25]Group:30
Else 
	$0:=""
End if 