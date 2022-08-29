//%attributes = {}
// setLicenseValue (License; Value)
// Purpose: Method to set the value of a License
// If the license record doesn't exist, it will create a new one
// Returns: The value set
// PRE: License#""

C_TEXT:C284($license; $1; $value; $2; $0)
C_LONGINT:C283($found)
Case of 
	: (Count parameters:C259=2)
		$license:=$1
		$value:=$2
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
Else   // assert nothing found
	ASSERT:C1129($found=0)  // if this fails, it means there were more than one record in the licenseValue pair
	CREATE RECORD:C68([Licenses:160])
	[Licenses:160]LicenseID:2:=$license
End if 

[Licenses:160]Value:3:=$value
SAVE RECORD:C53([Licenses:160])
UNLOAD RECORD:C212([Licenses:160])
READ ONLY:C145([Licenses:160])
$0:=$value