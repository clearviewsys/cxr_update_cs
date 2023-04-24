//%attributes = {}
#DECLARE($userID : Integer)->$yes : Boolean

If (Validate password:C638($userID; ""))
	$yes:=True:C214
Else 
	$yes:=False:C215
End if 
