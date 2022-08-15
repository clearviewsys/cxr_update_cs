//%attributes = {}
//Method: isLicenseRecordExpired (License)
//Parameters: License (string)
//Purpose: Check if a License Record is expired, 
//either by date or monthly or total hits
//Returns: IsExpired (bool) 
//Pre: Single License Exists for License Id

C_TEXT:C284($1; $licenseId)
C_BOOLEAN:C305($0; $isExpired)
C_DATE:C307($expiry; $zeroDate)

Case of 
	: (Count parameters:C259=1)
		$licenseId:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$isExpired:=False:C215
READ ONLY:C145([Licenses:160])
QUERY:C277([Licenses:160]; [Licenses:160]LicenseID:2=$licenseID)
ASSERT:C1129(Records in selection:C76([Licenses:160])=1)

//Expiry date of 00/00/00 is a non-expiry date so it will be fine
$expiry:=Date:C102([Licenses:160]ExpiryDate:4)
$zeroDate:=Date:C102("00/00/00")
If (((Current date:C33-$expiry)>0) & (($expiry-$zeroDate)#0))
	$isExpired:=True:C214
End if 

// if max monthly/total hit is not set (aka 0) it should be not expired @waikin
If (([Licenses:160]MonthlyHit:5>[Licenses:160]MaxMonthlyHit:6) & ([Licenses:160]MaxMonthlyHit:6#0))
	$isExpired:=True:C214
End if 

If (([Licenses:160]TotalHit:7>[Licenses:160]MaxTotalHit:8) & ([Licenses:160]MaxTotalHit:8#0))
	$isExpired:=True:C214
End if 

$0:=$isExpired