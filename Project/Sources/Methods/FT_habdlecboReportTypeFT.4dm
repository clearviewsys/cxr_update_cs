//%attributes = {}
ARRAY TEXT:C222(arrALLEFT; 0)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(cboReportTypeFT; 0)
		
		APPEND TO ARRAY:C911(cboReportTypeFT; "Large Cash Transaction Report")
		APPEND TO ARRAY:C911(cboReportTypeFT; "eWires EFT Incoming(Non-SWIFT)")
		APPEND TO ARRAY:C911(cboReportTypeFT; "eWires EFT Outgoing(Non-SWIFT)")
		APPEND TO ARRAY:C911(cboReportTypeFT; "Wires EFTI (Non-SWIFT)")
		APPEND TO ARRAY:C911(cboReportTypeFT; "Wires EFTO (Non-SWIFT)")
		APPEND TO ARRAY:C911(cboReportTypeFT; "Suspicious transaction report")
		cboReportTypeFT:=1
		
		
		
End case 

