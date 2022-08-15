handlepickFormMethod

If ((Form event code:C388=On Activate:K2:9) | (Form event code:C388=On Load:K2:1))
	GOTO OBJECT:C206(vSearchText)
	//handleAutoFillSearch (->vSearchText;Current form table;->[Customers]CustomerID;->[Customers]FullName;->[Customers]FullName)
End if 