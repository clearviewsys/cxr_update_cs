//%attributes = {"shared":true}
// changeSupportTeamPassword ({MAC Address})

C_TEXT:C284($macAddress; $password; $1)
If ((User in group:C338(Current user:C182; "Administrators")) | (User in group:C338(Current user:C182; "Designers")))
	Case of 
		: (Count parameters:C259=0)
			$macAddress:=UTIL_getMacAddress  //Get MAC address 
		: (Count parameters:C259=1)
			$macAddress:=$1
	End case 
	
	ARRAY INTEGER:C220($arrGroup; 3)
	$arrGroup{1}:=15002  // belong to Administrators
	
	$arrGroup{2}:=15003  // belong to Support Team group
	
	$arrGroup{3}:=15004  // belong to Clerks
	
	C_LONGINT:C283($UID)
	
	GET USER LIST:C609($arrUserNames; $arrUserIDs)
	$UID:=$arrUserIDs{Find in array:C230($arrUserNames; "Support Team")}  // find the user id for user 'Support Team'
	
	
	$password:=getSupportTeamPassword($macAddress)
	//  Set user properties (userID; name; startup; password; nbLogin; lastLogin{; memberships}) -->  Numbe
	
	$UID:=Set user properties:C612($UID; "Support Team"; ""; $password; 1; Current date:C33; $arrGroup)  // change user password
	
	If (Not:C34(Validate password:C638($UID; $password)))
		myAlert("Support team password failed to reset.")
	End if 
	// clear the arrays
	
	ARRAY INTEGER:C220($arrGroup; 0)
	ARRAY REAL:C219($arrUserIDs; 0)
Else 
	myAlert("Only the administrator can reset support team password.")
End if 
