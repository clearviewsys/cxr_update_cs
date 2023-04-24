Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Substring:C12(LicenseId{LicenseId}; 0; 3)="CXR")
			Form:C1466.ApplicationID:=LicenseId{LicenseId}
			[CompanyInfo:7]ApplicationID:30:=LicenseId{LicenseId}
			[CompanyInfo:7]LicenseExpiryDate:23:=Date:C102(ExpiryDate{ExpiryDate})
			Form:C1466.LicenseExpiry:=ExpiryDate{ExpiryDate}
			SAVE RECORD:C53([CompanyInfo:7])
			myAlert(LicenseId{LicenseId}+" has been selected as current license.")
		End if 
End case 