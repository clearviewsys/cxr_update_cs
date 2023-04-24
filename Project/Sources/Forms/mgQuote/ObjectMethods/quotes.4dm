If (Form event code:C388=On Selection Change:K2:29)
	
	If (Form:C1466.currDeliveryOption#Null:C1517)
		OBJECT SET ENABLED:C1123(*; "btn_send"; True:C214)
		OBJECT SET ENABLED:C1123(*; "btn_get@"; True:C214)
		
	Else 
		OBJECT SET ENABLED:C1123(*; "btn_send"; False:C215)
		OBJECT SET ENABLED:C1123(*; "btn_get@"; False:C215)
		
	End if 
	
End if 
