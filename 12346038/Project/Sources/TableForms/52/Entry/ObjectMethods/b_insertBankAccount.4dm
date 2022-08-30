C_TEXT:C284(vCustomerID; vBankAccountID; $textBlock)
vCustomerID:=""
vBankAccountID:=""

pickCustomer(->vCustomerID)
pickWireTemplateForCustomer(->vBankAccountID; vCustomerID)


appendLabelString(->$textBlock; ""; [WireTemplates:42]BeneficiaryFullName:9; True:C214)
appendLabelString(->$textBlock; "Bank: "; [WireTemplates:42]BankName:3; True:C214)
appendLabelString(->$textBlock; ""; [WireTemplates:42]BankAddress:10; True:C214)
appendLabelString(->$textBlock; ", "; [WireTemplates:42]BankCity:11)
appendLabelString(->$textBlock; ", "; [WireTemplates:42]BankCountry:12; True:C214)

appendLabelString(->$textBlock; "Account #"; [WireTemplates:42]AccountNo:6; True:C214)
appendLabelString(->$textBlock; "Branch: "; [WireTemplates:42]BranchTransitNo:5; True:C214)
appendLabelString(->$textBlock; "Transit: "; [WireTemplates:42]BankInstitutionNo:4; True:C214)
appendLabelString(->$textBlock; "Fax: "; [WireTemplates:42]Fax:16; True:C214)
appendLabelString(->$textBlock; "Phone: "; [WireTemplates:42]Phone:15; True:C214)
appendLabelString(->$textBlock; "SWIFT: "; [WireTemplates:42]SWIFT:8; True:C214)

insertTextAtInsertionPointer(->[Letters:52]Body:4; $textBlock)

