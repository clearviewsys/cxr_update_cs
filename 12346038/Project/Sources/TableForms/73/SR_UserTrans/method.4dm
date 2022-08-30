If (Form event code:C388=On Load:K2:1)
	OBJECT SET TITLE:C194(*; "ReportTitle"; "User Transactions")
End if 

If (Form event code:C388=On Outside Call:K2:11)
	handleSR_UserTrans
End if 

