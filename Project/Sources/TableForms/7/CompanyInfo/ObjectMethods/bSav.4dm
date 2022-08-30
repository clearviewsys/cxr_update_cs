checkInit
checkIfNullString(->[CompanyInfo:7]CountryCode:28; "Country Code")
checkIfNullString(->[CompanyInfo:7]Currency:11; "Base Currency")
checkAddErrorIf(([CompanyInfo:7]Currency:11="SEK") & ([CompanyInfo:7]organizationNo:18=""); "Please add a 10 digit Swedish Organization number")

checkIfDateIsFilled(->[CompanyInfo:7]LicenseExpiryDate:23; False:C215; "Rental License Expiry Date")
checkIfDateIsFilled(->[CompanyInfo:7]SLA_ExpiryDate:21; True:C214; "SLA Expiry Date")
checkIfDateIsFilled(->[CompanyInfo:7]SLA_LastRenewalDate:22; True:C214; "SLA Last Renewal Date")
checkIfNullString(->[CompanyInfo:7]HighestVersionAllowed:24; "Authorized up to version")

If (isValidationConfirmed)
	assignCompanyInfoVars
	createSelfCustomer
Else 
	myAlert("Validation is not confirmed.")
	REJECT:C38
End if 