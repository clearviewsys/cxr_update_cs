C_OBJECT:C1216($ret)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$ret:=RAL2_updateClient(Form:C1466.ClientCode; [CompanyInfo:7]ClientKey2:26; Form:C1466.ClientKey)
		
		If ($ret.response="0")
			myAlert("Password has been updated")
			[CompanyInfo:7]ClientKey2:26:=Form:C1466.ClientKey
			SAVE RECORD:C53([CompanyInfo:7])
		Else 
			RAL2_handleErrors($ret.response)
		End if 
End case 
