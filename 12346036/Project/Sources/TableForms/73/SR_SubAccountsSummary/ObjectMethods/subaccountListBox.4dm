C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)
C_TEXT:C284($accountID; $subAccountID; $title)

If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	$row:=$ColumnPtr->
	If ($row>0)
		$accountID:=arrAccounts{$row}
		$subAccountID:=arrSubAccounts{$row}
		QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<=vToDate)
		orderByRegisters
		FORM GOTO PAGE:C247(2)
		$title:="Account / SubAccounts Summary"
		OBJECT SET TITLE:C194(*; "ReportTitle"; $title+" "+$accountID+" : "+$subAccountID)
	End if 
End if 
