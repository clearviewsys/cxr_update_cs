//%attributes = {}
CONFIRM:C162("Compress Selection or All Records?"; "All Records"; "Selection")
If (OK=1)
	updateTableUsingMethod(->[LinkedDocs:4]; "compressLinkedDoc"; True:C214; "Compressing attached documents.")
Else 
	bQueryRecords(->[LinkedDocs:4])
	
	updateTableUsingMethod(->[LinkedDocs:4]; "compressLinkedDoc"; False:C215; "Compressing attached documents.")
	
	
End if 