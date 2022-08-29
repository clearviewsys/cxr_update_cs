C_POINTER:C301($ptrTable; $ptrField)

$ptrTable:=Current default table:C363


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		//If (Is nil pointer($ptrTable))
		//$ptrTable:=Current form table  //this won't work in a subform
		//End if 
		
		If (Is nil pointer:C315($ptrTable)) | ($ptrTable=(->[LinkedDocs:4]))
			$ptrTable:=->[Invoices:5]
		End if 
		
		If (False:C215)  //testing
			QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1="TTINV139923")
		End if 
		
		
		If (Is new record:C668($ptrTable->))
			REDUCE SELECTION:C351([LinkedDocs:4]; 0)
		Else 
			$ptrField:=getPrimaryKeyFieldPtr($ptrTable)
			QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252($ptrTable); *)
			QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=$ptrField->)
		End if 
		
		
	: (Form event code:C388=On Close Box:K2:21)
		CLOSE WINDOW:C154
		
	Else 
		
End case 