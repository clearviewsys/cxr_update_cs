handleListForm
If (Form event code:C388=On Display Detail:K2:22)
	If ([IC_FailedRecords:49]tableNo:2>0)
		vTableName:=Table name:C256([IC_FailedRecords:49]tableNo:2)
	Else 
		vTableName:=""
	End if 
End if 