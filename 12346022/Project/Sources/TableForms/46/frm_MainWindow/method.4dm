Case of 
	: (Form event code:C388=On Load:K2:1)
		BKP_InitializeGlobalVariables
		BKP_InitializeFormVariables
		
		// defaults
		//_O_DISABLE BUTTON(IncludeAltStructFile)
		OBJECT SET ENABLED:C1123(IncludeAltStructFile; False:C215)
		
		BKP_readDefaultBackupXML
End case 