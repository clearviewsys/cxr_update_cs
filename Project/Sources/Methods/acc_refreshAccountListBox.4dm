//%attributes = {}
C_LONGINT:C283($i; $n)
READ ONLY:C145([Accounts:9])

$n:=Size of array:C274(acc_AccountsListBox)
For ($i; 1; $n)
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=acc_arrAccountIDs{$i})
	LOAD RECORD:C52([Accounts:9])
	acc_fillAccountsListBoxRow($i)
End for 
refreshRowCount(->acc_accountsListBox)

calcAccountsListBoxSumVars