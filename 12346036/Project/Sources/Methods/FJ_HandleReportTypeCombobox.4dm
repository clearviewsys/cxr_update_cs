//%attributes = {}
C_DATE:C307($refDate)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$refDate:=initialDate
		
		ARRAY TEXT:C222(arrALLRegisterID; 0)
		ARRAY TEXT:C222(arrALLEFT; 0)
		
		
		//While ($refDate<=finalDate)
		//FJ_GetTransactionsOnDate ($refDate)
		//$refDate:=Add to date($refDate;0;0;1)
		
		//End while 
		
		
		//Case of 
		//: (cboReportType=1)
		//QUERY WITH ARRAY([Registers]RegisterID;arrALLRegisterID)
		
		//: (cboReportType=2)
		//QUERY WITH ARRAY([eWires]eWireID;arrALLEFT)
		
		//: (cboReportType=3)
		//QUERY WITH ARRAY([Wires]CXR_WireID;arrALLEFT)
		
		//End case 
End case 
