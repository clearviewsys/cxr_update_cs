//%attributes = {}

C_DATE:C307($refDate)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$refDate:=initialDate
		
		ARRAY TEXT:C222(arrALLRegisterID; 0)
		ARRAY TEXT:C222(arrALLEFT; 0)
		
		While ($refDate<=finalDate)
			// GAML_GetPTRTransactions 
			GAMLGetPTRTransactionsOnDate($refDate)
			$refDate:=Add to date:C393($refDate; 0; 0; 1)
			
		End while 
		
		
		Case of 
			: (cboReportType=1)
				QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrALLRegisterID)
				
			: (cboReportType=2)
				QUERY WITH ARRAY:C644([eWires:13]eWireID:1; arrALLEFT)
				
			: (cboReportType=3)
				QUERY WITH ARRAY:C644([Wires:8]CXR_WireID:1; arrALLEFT)
				
		End case 
End case 
