Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		If ([Customers:3]isCompany:41)
			chkisIndividual:=0
			chkisCompany:=1
		Else 
			chkisIndividual:=1
			chkisCompany:=0
		End if 
		suspiciousNotes:=[Invoices:5]suspiciousNotes:31
		
End case 
