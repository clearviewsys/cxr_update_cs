C_BOOLEAN:C305(<>useCommissionRules)
C_LONGINT:C283($i)


If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	C_TEXT:C284(vReceivedorPaid; vMethod; vSubMethod; vCurrency)
	C_REAL:C285(vAmount; vFeeLocal; vPercentFee)
	C_TEXT:C284(vRuleName; vCustomerID)
	
	vReceivedOrPaid:=c_Received
	vRuleName:=""
	
	initFeeRulesLBArrays
	
	C_LONGINT:C283($n)
	
	ALL RECORDS:C47([FeeRules:59])
	$n:=Records in selection:C76([FeeRules:59])
	ORDER BY:C49([FeeRules:59]; [FeeRules:59]RuleNo:1; >)
	FIRST RECORD:C50([FeeRules:59])
	
	listbox_deleteAllRows(->feeRulesListBox)
	
	For ($i; 1; $n)
		listbox_appendRow(->feeRulesListBox)
		
		setFeeRulesLBColumnVarsToFields($i)
		
		NEXT RECORD:C51([FeeRules:59])
	End for 
	
	setVisibleIff((<>useCommissionRules=False:C215); "warningText")
End if 
