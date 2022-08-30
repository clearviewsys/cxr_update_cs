Case of 
	: (Form event code:C388=On Load:K2:1)
		setEnterableIff(isUserSupport; "CompanyName")
		setEnterableIff(isUserSupport; "organization")
		
		setEnterableIff(isUserSupport; "Country")
		setEnterableIff(isUserSupport; "Currency")
		
		setEnterableIff(isUserSupport; "ClientCode")
		setEnterableIff(isUserSupport; "ClientKey")
		
		setEnterableIff(isUserSupport; "ClientCode2")
		setEnterableIff(isUserSupport; "ClientKey2")
		setEnterableIff(isUserSupport; "MaxPEPSanctionListCalls")
		
		setEnterableIff(isUserSupport; "BranchID")
		
		setEnterableIff(isUserSupport; "LicenseExpiryDate")
		setEnterableIff(isUserSupport; "SLA_LastRenewalDate")
		setEnterableIff(isUserSupport; "SLA_ExpiryDate")
		setEnterableIff(isUserSupport; "MaxVersionAllowed")
		setVisibleIff(isUserSupport; "bADD@")  // buttons should not be visible to standard users
		
		setVisibleIff(isUserSupport; "cvViewPassword@")
		
		setFieldAsPassword(->[CompanyInfo:7]ClientKey:16)
		setFieldAsPassword(->[CompanyInfo:7]ClientKey2:26)
		
		ALL RECORDS:C47([Registers:10])
		setEnterableIff((Records in selection:C76([Registers:10])=0); "Currency")
		
		ALL RECORDS:C47([SanctionLists:113])
		setVisibleIff(isUserSupport; "bEnable@")
		setVisibleIff(isUserSupport; "bDisable@")
		
		//SET TIMER(60)
		
	: (Form event code:C388=On Timer:K2:25)
		//SYNC_iRecCount:=Records in table([Sync_Queue])
		
End case 

