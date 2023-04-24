If (Form event code:C388=On Load:K2:1)
	
	QUERY:C277([Registers:10]; [Registers:10]BranchID:39="HO"; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]AccountID:6#"Cash-NZD")
	
	WA OPEN URL:C1020(*; "WPTWebArea"; "http://localhost:8002")
	
End if 