//%attributes = {}
// seteWireLinkInfoByLoadingLink
// this method is called from the eWire form (from the invoice)
// the method will load all link info and assigns the eWire fields to the corresponding link info

// changed this method in vers 4.361


C_TEXT:C284(<>companyCountry)

[eWires:13]LinkID:8:=[Links:17]LinkID:1
//[eWires]AgentID:=[Links]AuthorizedUser // commented out by TB in version 4.361
//[eWires]CustomerName:=[Links]CustomerName // commented out by TB in version 4.361

If ([eWires:13]isPaymentSent:20)
	//[eWires]fromCountry:=<>companyCountry
	//[eWires]toCountry:=[Links]Country
	//[eWires]ForeignAccount:=getAgentPendingAccountID ([Links]AuthorizedUser;[eWires]isPaymentSent;[eWires]ToCurrency)
	
Else 
	//[eWires]toCountry:=<>companyCountry // commented out by TB in version 4.361
	//[eWires]fromCountry:=[Links]Country // commented out by TB in version 4.361
	//[eWires]ForeignAccount:=getAgentPendingAccountID ([Links]AuthorizedUser;[eWires]isPaymentSent;[eWires]FromCurrency) // commented out by TB in version 4.361
	
End if 