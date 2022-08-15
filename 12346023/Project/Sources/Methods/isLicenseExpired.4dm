//%attributes = {}
// isLicenceExpired -> bool
// this method returns true if the rental license has expired 

C_BOOLEAN:C305($0)

C_DATE:C307($expiryDate)

$expiryDate:=<>LicenseExpiryDate
If ($expiryDate<Current date:C33)  // today is after the expiry date then it's expired
	$0:=True:C214  // expired
Else 
	$0:=False:C215 | ($expiryDate=!00-00-00!)  // if expiry date is null it is okay
End if 