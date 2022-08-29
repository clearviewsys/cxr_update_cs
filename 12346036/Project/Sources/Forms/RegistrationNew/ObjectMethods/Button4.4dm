C_OBJECT:C1216($oResponse)
C_TEXT:C284($response)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$oResponse:=RAL2_registerClient(Form:C1466.ClientKey; FT_GetFirstName(Form:C1466.Name); FT_GetLastName(Form:C1466.Name); (Form:C1466.isCompany=1); Form:C1466.Company; Form:C1466.Email; Form:C1466.Phone; Form:C1466.Address; Form:C1466.City; Form:C1466.Province; Form:C1466.Country; Form:C1466.PostalCode)
		If ($oResponse.response="0")
			myAlert("Your account has been registered. Please check your email for a link to activate your registration")
			//Save client code and key to company info
			ALL RECORDS:C47([CompanyInfo:7])
			FIRST RECORD:C50([CompanyInfo:7])
			[CompanyInfo:7]ClientCode2:25:=$oResponse.clientCode
			[CompanyInfo:7]ClientKey2:26:=$oResponse.clientKey
			[CompanyInfo:7]Email:6:=Form:C1466.Email
			[CompanyInfo:7]CompanyName:1:=Form:C1466.Company
			[CompanyInfo:7]Tel1:3:=Form:C1466.Phone
			[CompanyInfo:7]Address:2:=Form:C1466.Address
			[CompanyInfo:7]City:9:=Form:C1466.City
			[CompanyInfo:7]Country:10:=Form:C1466.Country
			[CompanyInfo:7]CountryCode:28:=getCountryCode(Form:C1466.Country)
			SAVE RECORD:C53([CompanyInfo:7])
			Form:C1466.success:=True:C214
		Else 
			If ($oResponse.response="17")
				$response:=RAL2_emailClientKey(Form:C1466.Email; True:C214)
				If ($response="0")
					myAlert("An account already exists with that email."+Char:C90(Carriage return:K15:38)+"Cient Key and Code have been sent to the email associated with the account.")
					Form:C1466.success:=False:C215
				Else 
					If (Not:C34(RAL2_handleErrors($response)))
						REJECT:C38
					End if 
				End if 
			Else 
				If (Not:C34(RAL2_handleErrors($oResponse.response)))
					REJECT:C38
				End if 
			End if 
		End if 
End case 