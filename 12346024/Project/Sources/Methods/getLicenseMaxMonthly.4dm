//%attributes = {}
//getLicenseMaxMonthly
//Parameters: License (Sring)
//Purpose: Return the Max Monthly Hits of a given License
//Returns: Associated Max Monthly Hits, 0 if record not found

C_TEXT:C284($1; $licenseID)
C_LONGINT:C283($0; $value)
Case of 
	: (Count parameters:C259=1)
		$licenseID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Licenses:160])
QUERY:C277([Licenses:160]; [Licenses:160]LicenseID:2=$licenseID)
If (Records in selection:C76([Licenses:160])=1)
	$value:=[Licenses:160]MaxMonthlyHit:6
End if 

$0:=$value