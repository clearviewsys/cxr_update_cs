//%attributes = {}
C_LONGINT:C283($winRef)
If (isUserAdministrator)
	$winRef:=Open form window:C675("InitialConfigurations"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("InitialConfigurations")
	
Else 
	myAlert_AdminPrivilegeNeeded
End if 