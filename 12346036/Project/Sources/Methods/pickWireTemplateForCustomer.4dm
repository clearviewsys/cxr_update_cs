//%attributes = {}
// pickBankAccountforCustomer(self;theCustomerID)

C_POINTER:C301($1)
C_TEXT:C284($2; theCustomerID)
theCustomerID:=$2
pickWireTemplates($1; "selectWireTemplatesForCustomer")
