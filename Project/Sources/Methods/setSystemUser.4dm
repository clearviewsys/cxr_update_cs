//%attributes = {}
// setSystemUser ({user name})
C_TEXT:C284($1; $currentUser)
C_PICTURE:C286(<>userPicture)

If (Count parameters:C259=1)
	$currentUser:=$1
Else 
	$currentUser:=Current user:C182
End if 

C_TEXT:C284(<>CurrentUser; <>ApplicationUser; <>UserID)
<>SystemUser:=$currentUser
//<>ApplicationUser:=$currentUser
setApplicationUser($currentUser)
<>UserID:=String:C10(getSystemUserID($currentUser))
loadPictureResource("systemUser"; -><>userPicture)
//GET PICTURE FROM LIBRARY("systemUser"; <>userPicture)