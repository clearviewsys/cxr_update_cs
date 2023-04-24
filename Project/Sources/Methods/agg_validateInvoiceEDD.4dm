//%attributes = {}
// agg_validateInvoiceEDD (ruleObj;invoiceObj)
// formerly called: checkInvoiceEDDRequirements 
// this method called from the agg_validateInvoiceOnSave

// #ORDA
// #TB

C_OBJECT:C1216($ruleEntity; $invoiceObj; $1; $2)

Case of 
	: (Count parameters:C259=2)
		$ruleEntity:=$1
		$invoiceObj:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//[AML_AggrRules]thenRequirePOT
//[AML_AggrRules]thenRequireSOF
//[AML_AggrRules]thenRequireTPD

//[Invoices]didAskIfThirdPartyIsInvolved
//[Invoices]AMLPurposeOfTransaction
//[Invoices]SourceOfFund
//[Invoices]ThirdPartyName
//[invoices];"Entry"

checkIfCheckboxValueIs($ruleEntity.thenRequirePOT; $invoiceObj.AMLPurposeOfTransaction; "Purpose of Transaction (POT)")
checkIfCheckboxValueIs($ruleEntity.thenRequireSOF; $invoiceObj.SourceOfFund; "Source of Funds (SOF)")

If ($ruleEntity.thenRequireTPD)  // boolean
	checkAddErrorIf(($invoiceObj.didAskIfThirdPartyIsInvolved=False:C215); "Third-Party Determination is required!")
End if 

//[Invoices]didAskIfCustomerIsPEP
If ($ruleEntity.thenRequirePEP)  // boolean
	checkAddErrorIf(($invoiceObj.didAskIfCustomerIsPEP=False:C215); "PEP Determination is required!")
End if 

