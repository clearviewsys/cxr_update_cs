C_LONGINT:C283(hmReport; $vl_compression)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vl_compression:=0
		BLOB PROPERTIES:C536([Reports:73]xReport:3; $vl_compression)
		If ($vl_compression#Is not compressed:K22:11)
			EXPAND BLOB:C535([Reports:73]xReport:3)
		End if 
		
		//hmRep_BLOB TO REPORT (hmReport;hmRep_Import_hmReports;[Reports]xReport)
		
	Else 
		
		//hmRep_Palette_Update ("palette";hmReport)
End case 


