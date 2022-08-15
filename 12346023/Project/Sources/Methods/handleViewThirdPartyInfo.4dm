//%attributes = {}
// handleViewThirdPartyInfo (invoiceID)
C_TEXT:C284($invoiceID; $1)

Case of 
	: (Count parameters:C259=0)
		$invoiceID:=vInvoiceNumber
	: (Count parameters:C259=1)
		$invoiceID:=$1
	Else 
End case 

C_LONGINT:C283($selectedRecord)
READ ONLY:C145([ThirdParties:101])

If ([Invoices:5]ThirdPartyisInvolved:22)
	// Get saved information if third party is involved
	QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=$invoiceID)
	displaySelectedRecords(->[ThirdParties:101])
	//If (Records in selection([ThirdParties])=1)
	//$selectedRecord:=Selected record number([ThirdParties])
	//If ($selectedRecord>=0)
	//GOTO SELECTED RECORD([ThirdParties];$selectedRecord)
	//DIALOG([ThirdParties];"View")
	//End if 
	//
	//End if 
End if 
