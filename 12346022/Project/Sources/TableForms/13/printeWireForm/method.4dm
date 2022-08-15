handlePrintFormMethod

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Printing Detail:K2:18)
		RELATE ONE:C42([eWires:13]CustomerID:15)
		RELATE ONE:C42([eWires:13]InvoiceNumber:29)
		
		If (Is new record:C668([eWires:13]))
			
			If (getKeyValue("ewire.print.draft"; "false")="true")
				setVisibleIff(False:C215; "Print_ID_@")  // hide all id related data
				setVisibleIff(True:C214; "DRAFT_@")  //show DRAFT
			Else 
				setVisibleIff(False:C215; "DRAFT_@")  //hide DRAFT
				setVisibleIff(([eWires:13]doTransferToBank:33=False:C215); "Print_ID@")  //hide for bank
			End if 
			
		Else 
			setVisibleIff(([eWires:13]doTransferToBank:33=False:C215); "Print_ID@")  //hide for bank
			setVisibleIff(True:C214; "Print_ID_Invoice@")  //but show invoice num
		End if 
		
		OBJECT Get pointer:C1124(Object named:K67:5; "PRINT_marketingInfo")->:=getKeyValue("print.footer.text")
End case 