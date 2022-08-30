//%attributes = {}
// setLicenseMaxTotal (License; Value (int))
// Purpose: Method to set the max total hits of a License
// Returns: The value set, 0 if not found
// PRE: License#""

C_TEXT:C284($license; $1)
C_LONGINT:C283($value; $2; $0)
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
	[Licenses:160]MaxTotalHit:8:=$value
	SAVE RECORD:C53([Licenses:160])
	UNLOAD RECORD:C212([Licenses:160])
	$0:=$value
End if 


READ ONLY:C145([Licenses:160])
