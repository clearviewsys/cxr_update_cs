//%attributes = {}
// handleSaveClientRegistrationButton

C_TEXT:C284($ret)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$ret:=RAL2_verifyClient(Form:C1466.ClientCode; Form:C1466.ClientKey)
		If (RAL2_handleErrors($ret))
			ALL RECORDS:C47([CompanyInfo:7])
			FIRST RECORD:C50([CompanyInfo:7])
			notifyAlert("Registration"; "Registration is Verified"; 10)
			//Save clientCode and client key to system
			[CompanyInfo:7]ClientCode2:25:=Form:C1466.ClientCode
			[CompanyInfo:7]ClientKey2:26:=Form:C1466.ClientKey
			SAVE RECORD:C53([CompanyInfo:7])
			RAL2_Licensing
			Form:C1466.success:=True:C214
			ACCEPT:C269
			
		Else 
			REJECT:C38
		End if 
End case 