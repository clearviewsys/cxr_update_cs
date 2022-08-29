C_BOOLEAN:C305($match)
C_OBJECT:C1216($statsObj; $ruleObj; $customerObj; $invoiceObj)
C_TEXT:C284($thisInvoiceID; $customerID)

$ruleObj:=newRuleObjectFromFormObject

//$thisCustomer:=ds.Customers.query("CustomerID = :1";String(Form.customerID)).first()
$customerID:=String:C10(Form:C1466.customerID)
$customerObj:=ds:C1482.Customers.query("CustomerID = :1"; $customerID).first()
$thisInvoiceID:=String:C10(Form:C1466.invoiceID)
$invoiceObj:=ds:C1482.Invoices.query("InvoiceID = :1"; $thisInvoiceID).first()
//[Customers]isWalkin
//If (($customerObj#Null) & ($invoiceObj#Null))
//$match:=matchCustomer_vs_AMLRule ($invoiceObj;$ruleObj)
//Else 
//notifyAlert ("Nill Object";"Either Customer or Invoice object is null")
//End if 
Case of 
	: (($customerID#"") & ($thisInvoiceID#"") & ($customerObj#Null:C1517) & ($invoiceObj#Null:C1517))  // there is a customer
		$match:=matchThisInvoice_vs_AMLRule($invoiceObj; $customerObj; $ruleObj; True:C214)
	: (($customerID#"") & ($thisInvoiceID="") & ($customerObj#Null:C1517) & ($invoiceObj#Null:C1517))
		C_OBJECT:C1216($filterObj; $statsObj)
		// the reason we are sending a filter is because the matching isn't happening yet. 
		// it's just a filter for getting stats on a customer
		$filterObj:=newAML_AggrRuleFilter
		$statsObj:=getTransactionStats($filterObj)
		Form:C1466.stats:=$statsObj
		$match:=matchCustomer_vs_AMLRule($customerObj; $statsObj; $ruleObj)
		
	Else 
		$match:=False:C215
End case 

If ($match)
	stampText("stamp_OK"; "Rule matched✔"; "blue")
Else 
	stampText("stamp_OK"; "No Match"; "grey")
End if 