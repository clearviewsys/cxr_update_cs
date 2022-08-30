If (Form event code:C388=On Data Change:K2:15)
	pickORDA(->[Customers:3]CustomerID:1)
End if 

//pickORDA (Self;->[Customers]CustomerID)
//pickORDA (Self;->[Customers]CustomerID;False)
//pickORDA (Self;->[Customers]CustomerID;False;self->)
