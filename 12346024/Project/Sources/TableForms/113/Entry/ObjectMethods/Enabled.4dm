If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1))
	If ([SanctionLists:113]IsEnabled:4)
		OBJECT SET ENABLED:C1123(*; "but_manual"; True:C214)
		OBJECT SET ENABLED:C1123(*; "but_invoice"; [SanctionLists:113]isManual:7)
		OBJECT SET ENABLED:C1123(*; "but_customer"; [SanctionLists:113]isManual:7)
	Else 
		OBJECT SET ENABLED:C1123(*; "but_manual"; False:C215)
		OBJECT SET ENABLED:C1123(*; "but_invoice"; False:C215)
		OBJECT SET ENABLED:C1123(*; "but_customer"; False:C215)
	End if 
End if 