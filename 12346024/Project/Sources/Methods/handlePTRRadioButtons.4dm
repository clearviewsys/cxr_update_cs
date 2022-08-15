//%attributes = {}
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
	: (lct_report=1)
		remittance_report_wires:=0
		remittance_report_ewires:=0
		
	: (remittance_report_wires=0)
		lct_report:=0
		remittance_report_ewires:=0
		
	: (remittance_report_ewires=0)
		lct_report:=0
		remittance_report_wires:=0
		
End case 
