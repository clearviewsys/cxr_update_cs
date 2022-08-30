

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		If (Self:C308->=[Confirmations:153]confirmCode:17)  //success
			OBJECT SET ENABLED:C1123(*; "btn_approve"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "Approve_Color"; 0x00FFFFFF; 0xA800)
		Else 
			notifyAlert("Confirmation"; "Confirmation Code NOT Valid"; 5)
			OBJECT SET ENABLED:C1123(*; "btn_approve"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "Approve_Color"; Dark shadow color:K23:3; Dark shadow color:K23:3)
		End if 
		
	Else 
		
End case 