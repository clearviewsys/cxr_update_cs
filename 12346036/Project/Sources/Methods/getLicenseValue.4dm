//%attributes = {}
//getLicenseValue
//Parameters: License (Sring)
//Purpose: Return the value of a given License
//Returns: Associated value, "" if record not found

C_TEXT:C284($0; $1; $licenseID; $value)
Case of 
	: (Count parameters:C259=1)
		$licenseID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Licenses:160])
QUERY:C277([Licenses:160]; [Licenses:160]LicenseID:2=$licenseID)
If (Records in selection:C76([Licenses:160])=1)
	$value:=[Licenses:160]Value:3
End if 

$0:=$value