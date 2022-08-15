
modifyRecordCustomerByID([Customers:3]CustomerID:1)

If (OK=1)
	vSearchText:=[Customers:3]CustomerID:1
	ACCEPT:C269  //handleAutoFillSearch (->vSearchText;->[Customers];->[Customers]CustomerID;->[Customers]FullName;->[Customers]CustomerID;->arrKey;->arrValue)
End if 