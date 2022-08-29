C_TEXT:C284($message; $reason)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->=True:C214)  //clicked
			$reason:=myRequest("What is the reason?"; "")
			$message:="Customer put on hold by "+getApplicationUser+" for the reason of: "+$reason+CRLF
			[Customers:3]Comments:43:=$message+[Customers:3]Comments:43
			createRecordExceptionLog(->[Customers:3]; "Customer put ON HOLD"; [Customers:3]CustomerID:1; "Customers was placed ON HOLD by "+getApplicationUser+CRLF+"Reason: "+$reason)
			
			
		Else   // unchecked
			$reason:=myRequest("What is the reason?"; "")
			$message:="Customer put off hold by "+getApplicationUser+" for the reason of: "+$reason+CRLF
			[Customers:3]Comments:43:=$message+[Customers:3]Comments:43
			createRecordExceptionLog(->[Customers:3]; "Customer taken off HOLD"; [Customers:3]CustomerID:1; "Customers was placed OFF HOLD by "+getApplicationUser+CRLF+"Reason: "+$reason)
			
		End if 
	Else 
		
End case 