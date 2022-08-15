C_LONGINT:C283($n; $i)
C_TEXT:C284($request)
$n:=LISTBOX Get number of rows:C915(accountsListBox)
$request:=Request:C163("Give a unique label to store currenct account balances under:"; "Snapshot-"+String:C10(Current date:C33))
If (OK=1)
	READ WRITE:C146([BalanceSnapshots:72])
	For ($i; 1; $n)
		CREATE RECORD:C68([BalanceSnapshots:72])
		[BalanceSnapshots:72]AccountID:2:=arrAccountNames{$i}
		[BalanceSnapshots:72]Date:1:=Current date:C33
		[BalanceSnapshots:72]Balance:3:=arrAccountBalances{$i}
		[BalanceSnapshots:72]MemoryLabel:4:=$request
		SAVE RECORD:C53([BalanceSnapshots:72])
		UNLOAD RECORD:C212([BalanceSnapshots:72])
		
	End for 
	ALERT:C41("Important: You must make sure to save the invoice later or else the stored balanc"+"es will be lost.")
End if 