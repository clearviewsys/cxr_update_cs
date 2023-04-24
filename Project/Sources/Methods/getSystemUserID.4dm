//%attributes = {}
// getSystemUserID ( User Name ) -> Number
// modified @milan 20210127 - added check for if username not in list of users
// returns 0 in that case

C_TEXT:C284($1)
C_LONGINT:C283($UID; $0; $idx)

ARRAY INTEGER:C220($arrUserIDs; 0)
GET USER LIST:C609($arrUserNames; $arrUserIDs)

$idx:=Find in array:C230($arrUserNames; $1)

If ($idx#-1)
	$UID:=$arrUserIDs{$idx}  // find the user id for user 'Support Team'
Else 
	$UID:=0  // User doesn't exists
End if 

$0:=$UID
