

Case of 
	: (Form event code:C388=On Header:K2:17)
		
	: (Form event code:C388=On Display Detail:K2:22)
		RELATE ONE:C42([Wires:8]CustomerID:2)
		
		OBJECT Get pointer:C1124(Object named:K67:5; "PRINT_marketingInfo")->:=getKeyValue("print.footer.text")
End case 