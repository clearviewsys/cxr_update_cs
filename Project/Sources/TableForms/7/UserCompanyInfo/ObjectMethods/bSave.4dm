C_TEXT:C284($ret)
C_OBJECT:C1216($oRet)
$ret:=RAL2_verifyClient(Form:C1466.ClientCode; Form:C1466.ClientKey)
If ($ret="0")
	$oRet:=RAL2_updateClient([CompanyInfo:7]ClientCode2:25; [CompanyInfo:7]ClientKey2:26; [CompanyInfo:7]ClientKey2:26; \
		FT_GetFirstName(Form:C1466.Name); FT_GetLastName(Form:C1466.Name); String:C10(Form:C1466.isCompany); Form:C1466.CompanyName; Form:C1466.Phone; \
		Form:C1466.Address; Form:C1466.City; Form:C1466.State; Form:C1466.Country; Form:C1466.PostalCode)
	If ($oRet.response="0")
		[CompanyInfo:7]CompanyName:1:=Form:C1466.CompanyName
		[CompanyInfo:7]Tel1:3:=Form:C1466.Phone
		[CompanyInfo:7]Address:2:=Form:C1466.Address
		[CompanyInfo:7]City:9:=Form:C1466.City
		[CompanyInfo:7]Country:10:=Form:C1466.County
		[CompanyInfo:7]LicenseExpiryDate:23:=Date:C102(Form:C1466.LicenseExpiry)
		[CompanyInfo:7]ClientCode2:25:=Form:C1466.ClientCode
		[CompanyInfo:7]ClientKey2:26:=Form:C1466.ClientKey
		[CompanyInfo:7]Email:6:=Form:C1466.Email
		
		assignCompanyInfoVars
		createSelfCustomer
		SAVE RECORD:C53([CompanyInfo:7])
	Else 
		RAL2_handleErrors($oRet.response)
		REJECT:C38
	End if 
Else 
	RAL2_handleErrors($ret)
	REJECT:C38
End if 

