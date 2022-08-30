//%attributes = {}
// isUserAuthorizedToAddRecord (->[table]; boolean import(true)/export(true)) -> boolean
C_POINTER:C301($1)
C_BOOLEAN:C305($0; $2; $isImport)
$0:=False:C215
$isImport:=$2

selectPrivilegesForTable(<>UserID; $1)  // first lookup the privilege for that particular table
If (Records in selection:C76([Privileges:24])=0)  // if not found 
	selectDefaultPrivilegesForUser(<>UserID)  // then lookup for default privileges for user
End if 

If ($isImport)
	$0:=[Privileges:24]canImport:7
Else 
	$0:=[Privileges:24]canExport:8
End if 
