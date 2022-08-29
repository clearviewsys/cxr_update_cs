C_LONGINT:C283($n; $i)
C_TEXT:C284($request)
$n:=LISTBOX Get number of rows:C915(accountsListBox)
$request:=Request:C163("Please name the Memory label to restore the balances from :")

READ ONLY:C145([BalanceSnapshots:72])
QUERY:C277([BalanceSnapshots:72]; [BalanceSnapshots:72]MemoryLabel:4=$request)

If (Records in selection:C76([BalanceSnapshots:72])>0)
	
	For ($i; 1; $n)
		QUERY:C277([BalanceSnapshots:72]; [BalanceSnapshots:72]AccountID:2=arrAccountNames{$i}; *)
		QUERY:C277([BalanceSnapshots:72];  & ; [BalanceSnapshots:72]MemoryLabel:4=$request)
		LOAD RECORD:C52([BalanceSnapshots:72])
		arrAdjustedBalances{$i}:=[BalanceSnapshots:72]Balance:3
		setOffBalanceArrayRow($i)
		
	End for 
Else 
	ALERT:C41("Invalid name.")
End if 
