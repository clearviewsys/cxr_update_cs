//%attributes = {}
C_TEXT:C284($UID; $UID1; $UID2)
C_LONGINT:C283($id)

$UID1:=String:C10(getSystemUserID("Designer"))
//$UID2:=String(getSystemUserID ("Clear View Systems"))

createPrivilegeRecord($UID1; 0; True:C214; True:C214; True:C214; True:C214; True:C214; True:C214; True:C214)  // designers privilege
//createPrivilegeRecord ($UID2;0;True;True;True;True;True;True;True)

$UID:=String:C10(getSystemUserID("Administrator"))  // administrator Privileges
createPrivilegeRecord($UID; 0; True:C214; True:C214; True:C214; True:C214; True:C214; True:C214; True:C214)

$id:=getSystemUserID("Support")  // in project mode this user might not exist, avoid error
If ($id#0)
	$UID:=String:C10($id)  // Support Privileges
	createPrivilegeRecord($UID; 0; True:C214; True:C214; True:C214; True:C214; True:C214; True:C214; True:C214)
End if 
