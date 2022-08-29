If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1))
	If ([SanctionLists:113]IsEnabled:4)
		OBJECT SET ENABLED:C1123(*; "but_auto@"; [SanctionLists:113]isManual:7)
		//OBJECT SET ENABLED(*; "but_customer"; [SanctionLists]isManual)
		
	End if 
End if 