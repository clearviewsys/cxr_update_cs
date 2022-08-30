//%attributes = {}
//prependBIDToTable (->[WireTemplates];->[WireTemplates]WireTemplateID;"prependBranchIDToBankAccRec")

QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1="BAN@")  // this table used to be called BankAccounts so for legacy purpose need to do this test
updateTableUsingMethod(->[WireTemplates:42]; "prependBranchIDToBankAccRec"; False:C215)

QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1="WIR@")
updateTableUsingMethod(->[WireTemplates:42]; "prependBranchIDToBankAccRec"; False:C215)
