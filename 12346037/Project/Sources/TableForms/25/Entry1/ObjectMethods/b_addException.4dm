If (arrTableNumbers>0)
	createPrivilegeRecord([Users:25]UserID:1; arrTableNumbers{arrTableNumbers}; False:C215; False:C215; False:C215; False:C215; False:C215; False:C215; False:C215)
	RELATE MANY:C262([Users:25]UserID:1)
Else 
	ALERT:C41("Please select a table first")
End if 