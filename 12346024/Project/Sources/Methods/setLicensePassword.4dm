//%attributes = {}
// setLicensePassword (License; Password)
// Purpose: Method to set the password of a License
// Returns: The password set, "" if no record found
// PRE: License#""

C_TEXT:C284($license; $1; $password; $2; $0)
C_LONGINT:C283($found)
Case of 
	: (Count parameters:C259=2)
		$license:=$1
		$password:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ASSERT:C1129($license#""; "License cannot be null")

SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY:C277([Licenses:160]; [Licenses:160]LicenseID:2=$license)
$found:=Records in selection:C76([Licenses:160])
READ WRITE:C146([Licenses:160])

If ($found=1)  // found
	LOAD RECORD:C52([Licenses:160])
	[Licenses:160]Password:12:=$password
	SAVE RECORD:C53([Licenses:160])
	UNLOAD RECORD:C212([Licenses:160])
	$0:=$password
End if 

READ ONLY:C145([Licenses:160])