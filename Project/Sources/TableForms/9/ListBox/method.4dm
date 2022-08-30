C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)
C_LONGINT:C283(vTotalRows)

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Accounts:9])
	READ ONLY:C145([Currencies:6])
	
	GOTO OBJECT:C206(*; "searchArea")
	SET TIMER:C645(-1)
	If (Not:C34(isUserAllowedToViewProfits))
		LISTBOX SET COLUMN WIDTH:C833(*; "cur_Gain"; 0)
	End if 
	hideObjectsOnTrue(Not:C34(isUserManager); "b_hiddenAccounts")
End if 

If (Form event code:C388=On Outside Call:K2:11)
	acc_fillAccouctsListBox
	//calcAccountsListBoxSumVars 
	REDRAW WINDOW:C456
End if 

If (Form event code:C388=On Timer:K2:25)
	SET TIMER:C645(0)
	acc_fillAccouctsListBox
	//calcAccountsListBoxSumVars
End if 