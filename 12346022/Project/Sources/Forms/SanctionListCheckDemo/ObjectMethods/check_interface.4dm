If (Form:C1466.showInterface=0)
	Form:C1466.comfirmReject:=0
	OBJECT SET ENABLED:C1123(*; "check_confirm"; False:C215)
Else 
	OBJECT SET ENABLED:C1123(*; "check_confirm"; True:C214)
End if 