//%attributes = {}
// handleLinkSelfCheckBox
// this is the object method for handling the 'isCustomer' checkbox in Links.Entry form

C_POINTER:C301($self)
$self:=$1

If (Form event code:C388=On Clicked:K2:4)
	If ($self->=True:C214)
		pickCustomer(->[Customers:3]CustomerID:1)
		If ([Customers:3]CustomerID:1#"")
			[Links:17]DOB:49:=[Customers:3]DOB:5
			[Links:17]FullName:4:=[Customers:3]FullName:40
			[Links:17]CompanyName:42:=[Customers:3]CompanyName:42
			[Links:17]email:5:=[Customers:3]Email:17
			[Links:17]MainPhone:8:=[Customers:3]CellPhone:13
			[Links:17]Nationality:33:=[Customers:3]Nationality:91
			
		End if 
		
		
	Else   // checkbox is false
		
		[Links:17]DOB:49:=Old:C35([Links:17]DOB:49)
		[Links:17]FullName:4:=Old:C35([Links:17]FullName:4)
		[Links:17]CompanyName:42:=Old:C35([Links:17]CompanyName:42)
		[Links:17]email:5:=Old:C35([Links:17]email:5)
		[Links:17]MainPhone:8:=Old:C35([Links:17]MainPhone:8)
		[Links:17]Nationality:33:=Old:C35([Links:17]Nationality:33)
	End if 
End if 