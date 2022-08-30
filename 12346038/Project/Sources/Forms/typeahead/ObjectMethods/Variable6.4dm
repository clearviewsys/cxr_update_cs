If (Form event code:C388=On Data Change:K2:15)
	QUERY:C277([Customers:3]; [Customers:3]isCompany:41=True:C214)
	pickORDA(Self:C308; ->[Customers:3]Address:7; True:C214)
End if 
applyFocusRect