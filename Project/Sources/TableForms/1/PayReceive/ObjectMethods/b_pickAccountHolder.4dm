C_TEXT:C284($bankAccountID)

pickWireTemplateForCustomer(->$bankAccountID; [Cheques:1]CustomerID:2)
If (OK=1)
	[Cheques:1]PayTo:15:=[WireTemplates:42]BeneficiaryFullName:9
End if 