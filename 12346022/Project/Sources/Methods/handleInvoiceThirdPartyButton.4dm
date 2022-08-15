//%attributes = {}
// handleInvoiceThirdPartyButton
// getBuild
// [ThirdParties];"Entry"

If ([Invoices:5]ThirdPartyisInvolved:22)
	
	// Get saved information if third party is involved
	
	QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=vInvoiceNumber)
	If (Records in selection:C76([ThirdParties:101])=0)
		//executeMethodName ("newRecord"+Table name(->[ThirdParties])) // TB: Not sure why Jaime called this method
		newRecordThirdParties
		// newRecordThirdParties method unloads the current record, search it again
		QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=vInvoiceNumber)
	Else 
		editRecordTable(->[ThirdParties:101])
	End if 
	
	makeThirdPartyName
Else 
	REDUCE SELECTION:C351([ThirdParties:101]; 0)
	[ThirdParties:101]LastName:3:=""
	[ThirdParties:101]FirstName:4:=""
End if 
