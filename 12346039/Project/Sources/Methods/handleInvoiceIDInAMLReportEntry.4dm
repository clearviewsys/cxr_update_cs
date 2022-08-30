//%attributes = {}
C_LONGINT:C283($formEvent; $1)
$formEvent:=$1

C_TEXT:C284($whichObject)
$whichObject:=OBJECT Get name:C1087(Object current:K67:2)

If ($whichObject="cb_Invoice")
	[AML_Reports:119]invoiceID:2:=arrInvoices{arrInvoices}
Else 
	// in field, do nothing
End if 

If (Form event code:C388=$formEvent)
	// [AML_Reports]invoiceID:=Self->{Self->}
	RELATE ONE:C42([AML_Reports:119]invoiceID:2)
	If (Records in selection:C76([Invoices:5])=1)
		[AML_Reports:119]CustomerID:19:=[Invoices:5]CustomerID:2  // replate the current customer id
		RELATE ONE:C42([Invoices:5]CustomerID:2)  // load the customer info (name)
		[AML_Reports:119]DiscoveredByUserID:4:=[Invoices:5]CreatedByUserID:19
		[AML_Reports:119]DiscoveryNotes:8:=[Invoices:5]suspiciousNotes:31
		[AML_Reports:119]DiscoveryDate:3:=[Invoices:5]CreationDate:13
	Else 
		BEEP:C151
		// Self->:=""
		[AML_Reports:119]invoiceID:2:=""
	End if 
	
End if 