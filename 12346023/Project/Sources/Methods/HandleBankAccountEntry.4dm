//%attributes = {}
// most probably this is now obsolete

// there is no bank accounts any more


If (Form event code:C388=On Load:K2:1)
	If ([Accounts:9]isCashAccount:3)
		//SET ENTERABLE([Accounts];False)

		//SET VISIBLE(vBranchShortName;False)

		OBJECT SET ENTERABLE:C238([Accounts:9]AccountType:5; False:C215)
		OBJECT SET ENTERABLE:C238([Accounts:9]Currency:6; False:C215)
		GOTO OBJECT:C206([Accounts:9]OpeningDebit:9)
	End if 
End if 

If (Form event code:C388=On Data Change:K2:15)
	If (Not:C34(isCashAccount))
		AccountID:=makeAccountShortName
	End if 
End if 