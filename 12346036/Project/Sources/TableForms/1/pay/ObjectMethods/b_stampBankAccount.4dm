C_TEXT:C284(vCustomerID; vBankAccountID; $textBlock)
vCustomerID:=""
vBankAccountID:=""

CONFIRM:C162("Insert bank account from:"; "Same Customer"; "Another Customer")
If (OK=1)
	vCustomerID:=[Cheques:1]CustomerID:2
Else 
	pickCustomer(->vCustomerID)
End if 
pickWireTemplateForCustomer(->vBankAccountID; vCustomerID)

$textBlock:=serializeWireTemplate

insertTextAtInsertionPointer(->[Cheques:1]Memo:10; $textBlock)

