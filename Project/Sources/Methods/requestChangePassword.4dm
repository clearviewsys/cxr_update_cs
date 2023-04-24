//%attributes = {}
// requestChangePassword (currentPassword)-> string:
// this method returns the new password string. It will check to make sure that the user knows
// the current password

C_TEXT:C284(vCurrentPassword; vOldPassword; vNewPassword1; vNewPassword2; vPassword)
C_TEXT:C284($1; $0)
C_LONGINT:C283($win)

If (Count parameters:C259=1)
	vCurrentPassword:=$1
Else 
	vCurrentPassword:="password"
End if 

vOldPassword:=""
vNewPassword1:=""
vNewPassword2:=""
vNewHint:=""

$win:=openFormWindow(->[CompanyInfo:7]; "ChangePassword"; Movable form dialog box:K39:8)
If (OK=1)
	$0:=vNewPassword1
Else 
	$0:=""
End if 
