If (Form event code:C388=On Getting Focus:K2:7)
	OBJECT SET VISIBLE:C603(*; "dotPassword"; True:C214)
End if 

If (Form event code:C388=On Losing Focus:K2:8)
	OBJECT SET VISIBLE:C603(*; "dotPassword"; False:C215)
	
End if 