//%attributes = {}
// setLicenseExpiry (License; Date)
// Purpose: Method to set the expiry date of a License
// Returns: True on success, False on failure (ie license doesn't exist)
// PRE: License#""

C_TEXT:C284($license; $1)
C_DATE:C307($expiry; $2)
C_LONGINT:C283($found)
C_BOOLEAN:C305($0)
$0:=False:C215
Case of 
	: (Count parameters:C259=2)
		$license:=$1
		$expiry:=$2
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
	[Licenses:160]ExpiryDate:4:=$expiry
	SAVE RECORD:C53([Licenses:160])
	UNLOAD RECORD:C212([Licenses:160])
	$0:=True:C214
End if 

