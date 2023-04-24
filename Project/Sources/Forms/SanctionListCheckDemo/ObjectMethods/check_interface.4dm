Form:C1466.options.showInterface:=Self:C308->=1
If (Form:C1466.options.showInterface)
	OBJECT SET ENABLED:C1123(*; "check_confirm"; True:C214)
Else 
	Form:C1466.options.comfirmReject:=0
	OBJECT SET ENABLED:C1123(*; "check_confirm"; False:C215)
End if 