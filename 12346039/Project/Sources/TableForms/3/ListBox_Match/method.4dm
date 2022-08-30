//[Customers]CellPhone
//[Customers]PictureID_Image
//displayCustomersMatchingName

If (Form event code:C388=On Load:K2:1)
	Form:C1466.match:=0
	If (Form:C1466.list.length>0)
		LISTBOX SELECT ROW:C912(*; "ListBox"; 1)
		handleCustomerMatchStamp
	End if 
	
End if 


