//%attributes = {}
// validateInvoice_AML_AggrRules ( isDuringInvoice: boolean)
//
// called by: validateInvoice_AMLRulesPro
// PRE: The invoice must be loaded in memory
// This method in fact can only be called from the invoice module
// goes through the rules one by one and matches them
// #ORDA #AMLRules #pro #AMLengine
// [AML_AggrRules];"match"

C_BOOLEAN:C305($isDuringInvoice; $1)  // runBarch means running the method in a batch process style as opposed to 'during invoicing'

Case of 
	: (Count parameters:C259=0)
		$isDuringInvoice:=True:C214
		
	: (Count parameters:C259=1)
		$isDuringInvoice:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($i; $n)
C_OBJECT:C1216($invoiceObj; $customerEntity)
C_BOOLEAN:C305($match; $stop)
C_OBJECT:C1216($rulesES; $ruleEntity)
C_TEXT:C284($customerID)

//$invoiceObj:=ds.Invoices.query("InvoiceID = :1";[Invoices]InvoiceID).first()  // should find one invoice
$invoiceObj:=newInvoiceObjFromRecord
ASSERT:C1129($invoiceObj#Null:C1517)  // this invoice cannot be null

// create the customerEntity from an entity selection 
$customerID:=[Invoices:5]CustomerID:2
$customerEntity:=ds:C1482.Customers.query("CustomerID = :1"; $customerID).first()  // we need an entity and not an entity selection

If ($customerEntity#Null:C1517)  // what if the customer has been deleted but it is stil existing in the invoice
	ASSERT:C1129($customerEntity#Null:C1517)
	
	// 
	$rulesES:=ds:C1482.AML_AggrRules.query("isActive = true")  // look only for active rules
	ASSERT:C1129($rulesES#Null:C1517)
	
	$n:=$rulesES.length
	
	$match:=False:C215  // assume no rules matched yet #TB Latest changes
	$stop:=False:C215  // it's not the end of the rule-matching yet
	
	If ($n>0)
		
		$rulesES:=$rulesES.orderBy("rowNo")
		
		For each ($ruleEntity; $rulesES)
			If (Not:C34($stop))  // only executes when $end is false
				If ($ruleEntity.chainToRuleID#"")  // if there's a chained rule, evaluate it first
					//[AML_AggrRules];"match"
					$match:=matchThisInvoice_vs_AMLRule($invoiceObj; $customerEntity; $ruleEntity; False:C215) & matchThisInvoice_vs_AMLRule($invoiceObj; $customerEntity; $ruleEntity.nextRule; False:C215)  // #recursive 
				Else 
					$match:=matchThisInvoice_vs_AMLRule($invoiceObj; $customerEntity; $ruleEntity; False:C215)
				End if 
				
				If ($match)
					$stop:=$ruleEntity.thenStop
					If ($isDuringInvoice)
						notifyAlert("Matched with "+$ruleEntity.ruleName+" "+$invoiceObj.InvoiceID; $ruleEntity.description; 20)
					End if 
					
					// KYC Requirements from the Customer record
					checkCustomerKYCRequirements($ruleEntity; $customerEntity)
					
					// EDD Requirements from the Invoice record
					checkInvoiceEDDRequirements($ruleEntity; $invoiceObj)
					
					// this is what needs to be done! 
					// actions! 
					thenApplyAMLRuleActions($ruleEntity; $invoiceObj; $customerEntity; $isDuringInvoice)
					
					If ($customerEntity.touched())  // this is to save the Tags 
						$customerEntity.save()
					End if 
					
				End if 
			End if 
		End for each 
	End if 
	
Else 
	notifyAlert("Data Integrity Issue"; [Invoices:5]CustomerID:2+" doesn't exist!")
End if   // end of customerEntity#null 