C_LONGINT:C283(cbCalculateLive; cbAutoValidate; cbsearchDeposits; cbSearchWithdrawals; cbSearchComments; cbSearchCheckmarked)
C_TEXT:C284(vValidationPrefix; vValidationStart; vValidationFormat)
C_LONGINT:C283(cbdisplayUnreconciled)

If (Form event code:C388=On Load:K2:1)
	//fillAdjustmentArrays(currency)
	C_REAL:C285(vOffBalance; vTargetBalance; vOpeningBalance; vSumOpeningBalance)
	vOffBalance:=0
	vTargetBalance:=0
	vOpeningBalance:=vSumOpeningBalance
	cbCalculateLive:=1
	cbSearchDeposits:=1
	cbSearchWithdrawals:=1
	
	cbAutoValidate:=1
	vValidationFormat:="000"
	vValidationStart:="1"
	cbdisplayUnreconciled:=0
	//SET QUERY LIMIT(500)
	//recon_RefreshList 
	
End if 


If (cbCalculateLive=1)
	calculateReconcileVars
End if 

handleCloseBox