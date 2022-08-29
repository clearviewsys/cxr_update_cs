C_TEXT:C284(vSearchText; $text)

If (Shift down:C543)  // to speed up typing
Else 
	Case of 
		: (Form event code:C388=On Load:K2:1)
			HIGHLIGHT TEXT:C210(Self:C308->; Length:C16(Self:C308->)+1; Length:C16(Self:C308->)+1)
			
		: (Form event code:C388=On After Keystroke:K2:26)
			
			$text:=Get edited text:C655
			If (Length:C16($text)>=3)
				handlePickFormSearchField(->vSearchText; ->[Customers:3]; ->[Customers:3]CustomerID:1; ->[Customers:3]FullName:40; ->[Customers:3]ExternalAccountNo:96; ->[Customers:3]CompanyName:42; ->[Customers:3]PictureID_Number:69; ->[Customers:3]HomeTel:6; ->[Customers:3]CellPhone:13)
			End if 
		Else 
			handlePickFormSearchField(->vSearchText; ->[Customers:3]; ->[Customers:3]CustomerID:1; ->[Customers:3]FullName:40; ->[Customers:3]ExternalAccountNo:96; ->[Customers:3]CompanyName:42; ->[Customers:3]PictureID_Number:69; ->[Customers:3]HomeTel:6; ->[Customers:3]CellPhone:13)
	End case 
End if 



