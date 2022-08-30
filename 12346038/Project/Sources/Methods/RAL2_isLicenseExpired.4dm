//%attributes = {}
//Method to check if the current RAL License is expired
//This method won't retreive data from the server, only read the expiry date in the db
//Returns:
//isLicenseExpired(Bool)

C_BOOLEAN:C305($0)
C_DATE:C307($expiry)

ALL RECORDS:C47([CompanyInfo:7])
FIRST RECORD:C50([CompanyInfo:7])

$expiry:=[CompanyInfo:7]LicenseExpiryDate:23
If ($expiry<Current date:C33)
	$0:=True:C214
	If ($expiry=Date:C102("00/00/00"))
		//expiry date of 0000-00-00 means the date is not set
		$0:=False:C215
	End if 
Else 
	$0:=False:C215
End if 

UNLOAD RECORD:C212([CompanyInfo:7])