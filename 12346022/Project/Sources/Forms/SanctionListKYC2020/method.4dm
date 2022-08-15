If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Bound Variable Change:K2:52))
	OBJECT SET ENABLED:C1123(*; "but_saveReport"; Form:C1466.kyc2020.tableId#0)
	If (Current user:C182="Designer")
		OBJECT SET VISIBLE:C603(*; "b_trace"; True:C214)
	End if 
End if 

sl_handleKYC2020LogTabs(Form event code:C388; OBJECT Get pointer:C1124(Object named:K67:5; "tab_main"))
sl_setSanctionListCheckIcon(Form:C1466.kyc2020.checkResult; OBJECT Get pointer:C1124(Object named:K67:5; "txt_status"))