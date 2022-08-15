//%attributes = {}

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		fromDate:=Date:C102(getKeyValue("JAM.GLReport.lastest.from.date"; String:C10(Current date:C33(*))))
		toDate:=Date:C102(getKeyValue("JAM.GLReport.lastest.to.date"; String:C10(Current date:C33(*))))
		reportDescription:="GL Report from "+String:C10(fromDate)+" to "+String:C10(toDate)
		
		operationMode:=1  // Testing Mode
		GOTO OBJECT:C206(fromDate)
		
		
		
End case 

