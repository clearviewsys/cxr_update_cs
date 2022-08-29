

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		C_TEXT:C284($reportNumType; reportNumber)
		
		$reportNumType:=getKeyValue("FT.ReportNumber"; "INVOICE")
		
		If ($reportNumType="INVOICE")
			setKeyValue("FT.ReportNumber"; "SEQUENCE")
			reportNumber:="SEQUENCE"
		Else 
			setKeyValue("FT.ReportNumber"; "INVOICE")
			reportNumber:="INVOICE"
		End if 
		
End case 
