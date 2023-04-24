//%attributes = {}
// checks to see if Designer password is empty

#DECLARE->$passwordEmpty : Boolean

var $idx : Integer

$passwordEmpty:=False:C215

ARRAY TEXT:C222($users; 0)
ARRAY LONGINT:C221($userIDs; 0)

GET USER LIST:C609($users; $userIDs)

$idx:=Find in array:C230($users; "Designer")


If ($idx#-1)
	
	$passwordEmpty:=isPasswordEmpty($userIDs{$idx})
	
End if 

