// #ORDA
// Form.rules

/* see also

matchThisInvoice_vs_AMLRule      // if rule applies ot 1 invoice only
matchCustomer_vs_AMLRule         // if rule applies to a selection of records (same customer)

checkCustomerKYCRequirements     // then check KYC requirements
checkInvoiceEDDRequirements      // then check EDD requirements

thenApplyAMLRuleActions           // then action

*/

If (Form event code:C388=On Load:K2:1)
	Form:C1466.Rule:=agg_newRuleEntity
End if 
