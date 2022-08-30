C_TEXT:C284(vToCountry; vCurrency)
C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(vIsCancelled)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		vToCountry:=<>COMPANYCOUNTRY
		vFromDate:=Current date:C33
		vToDate:=Current date:C33
		vCurrency:=<>BASECURRENCY
		vIsCancelled:=0
		vCustomerID:=""
		
	: (Form event code:C388=On Timer:K2:25)
		getRemoteEwireList
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
	Else 
		
End case 
