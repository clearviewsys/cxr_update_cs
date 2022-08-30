Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		If (Form:C1466.selectedItems#Null:C1517)
			OBJECT SET ENABLED:C1123(*; "PickButton"; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*; "PickButton"; False:C215)
		End if 
		
End case 
