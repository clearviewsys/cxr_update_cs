//%attributes = {}
// isUserAuthorizedToAddRecord (->[table]) -> boolean

C_POINTER:C301($1)
C_BOOLEAN:C305($0)
$0:=False:C215

selectPrivilegesForTable(<>UserID; $1)  // first lookup the privilege for that particular table

If (Records in selection:C76([Privileges:24])=1)  // if found 

	$0:=[Privileges:24]canImport:7
Else 
	selectDefaultPrivilegesForUser(<>UserID)  // then lookup for default privileges for user

	If (Records in selection:C76([Privileges:24])=1)
		$0:=[Privileges:24]canImport:7
	End if 
End if 