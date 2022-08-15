//%attributes = {}
//getLicensePassword
//Parameters: License (Sring)
//Purpose: Return the password of a given License
//Returns: Associated password, "" if record not found

C_TEXT:C284($0; $1; $licenseID; $password)
Case of 
	: (Count parameters:C259=1)
		$licenseID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Licenses:160])
QUERY:C277([Licenses:160]; [Licenses:160]LicenseID:2=$licenseID)
If (Records in selection:C76([Licenses:160])=1)
	$password:=[Licenses:160]Password:12
End if 

$0:=$password