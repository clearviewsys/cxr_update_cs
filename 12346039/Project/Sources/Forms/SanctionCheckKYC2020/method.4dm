Case of 
	: (Form event code:C388=On Load:K2:1)
		var $icon : Picture
		sl_setSanctionListCheckIcon(Form:C1466.CheckResult; ->$icon)
		Form:C1466.icon:=$icon
		If (Form:C1466.internalTableID#0)
			Form:C1466.table:=Table name:C256(Form:C1466.internalTableID)
		Else 
			Form:C1466.table:=""
		End if 
		LISTBOX SELECT ROW:C912(*; "lb_smartScan"; 1)
		LISTBOX SELECT ROW:C912(*; "lb_media"; 1)
End case 