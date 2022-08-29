//%attributes = {}
// isDateExpired(date)->boolean
// Unit test completed @Zoya

C_DATE:C307($1)
C_BOOLEAN:C305($0)

If (($1>!00-00-00!) & ($1<=Current date:C33))
	$0:=True:C214
Else 
	$0:=False:C215
End if 