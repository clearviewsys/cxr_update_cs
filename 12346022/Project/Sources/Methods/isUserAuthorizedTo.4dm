//%attributes = {}
// isUserAuthorizedTo (->[table];{CRUD}) -> boolean

C_POINTER:C301($1)
C_LONGINT:C283($2)
C_POINTER:C301($fieldPtr)
C_BOOLEAN:C305($0)
$0:=False:C215


Case of 
	: ($2=1)  //CREATE
		$fieldPtr:=->[Privileges:24]canCreate:4
	: ($2=2)  // REVIEW ; VIEW
		$fieldPtr:=->[Privileges:24]canView:3
	: ($2=3)  // UPDATE
		$fieldPtr:=->[Privileges:24]canModify:9
	: ($2=4)  // DELETE
		$fieldPtr:=->[Privileges:24]canDelete:5
	: ($2=5)  // PRINT
		$fieldPtr:=->[Privileges:24]canPrint:6
		
	Else 
		$fieldPtr:=->[Privileges:24]canView:3
		
End case 


If (isUserSuperAdmin)  // super admin is authorized to add privileges
	$0:=True:C214
Else 
	selectPrivilegesForTable(<>UserID; $1)  // first lookup the privilege for that particular table
	
	If (Records in selection:C76([Privileges:24])=1)  // if found 
		
		$0:=$fieldPtr->
	Else 
		selectDefaultPrivilegesForUser(<>UserID)  // then lookup for default privileges for user
		
		If (Records in selection:C76([Privileges:24])=1)
			$0:=$fieldPtr->
		End if 
	End if 
End if 