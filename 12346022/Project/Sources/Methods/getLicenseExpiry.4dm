//%attributes = {}
//getLicenseExpiry
//Parameters: License (Sring)
//Purpose: Return the expiry date of a given License
//Returns: Associated expiry, 00/00/00 if record not found

C_TEXT:C284($0; $1; $licenseID; $value)
C_DATE:C307($expiry)
Case of 
	: (Count parameters:C259=1)
		$licenseID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Licenses:160])
QUERY:C277([Licenses:160]; [Licenses:160]LicenseID:2=$licenseID)
If (Records in selection:C76([Licenses:160])=1)
	$expiry:=[Licenses:160]ExpiryDate:4
End if 

$0:=String:C10($expiry)