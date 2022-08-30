//%attributes = {}

C_BOOLEAN:C305($0)

//If (isUserAdministrator )  ` administrator is allowed anyway
//$0:=True
//Else 
$0:=isUserAllowedTo(->[Users:25]isComplianceOfficer:16)  // the other users are allowed only 
//End if 