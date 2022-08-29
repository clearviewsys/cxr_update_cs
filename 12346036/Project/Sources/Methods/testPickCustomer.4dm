//%attributes = {}
C_TEXT:C284(vCustomerID)
C_LONGINT:C283($i)

For ($i; 1; 2)
	vCustomerID:="212"
	pickCustomer(->vCustomerID)
	If (OK=1)
		myAlert([Customers:3]CustomerID:1+" "+[Customers:3]FullName:40)
		ASSERT:C1129((vCustomerID=[Customers:3]CustomerID:1); "assertion failed")
	Else 
		
	End if 
	
End for 