//%attributes = {}
C_LONGINT:C283($status)

QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=[Cheques:1]Currency:9; *)
QUERY:C277([Accounts:9];  & ; [Accounts:9]isBankAccount:7=True:C214)
$status:=1

If (Records in selection:C76([Accounts:9])=1)  // there's only one bank of that currency
	setChequeStatus($status; [Accounts:9]AccountID:1)
Else 
	pickReceiveChequeAccountID(->[Cheques:1]AccountID:7; [Cheques:1]Currency:9)
	If ([Accounts:9]isBankAccount:7)
		setChequeStatus($status; [Accounts:9]AccountID:1)
	Else 
		myAlert("You should select a bank account in order to clear this cheque.")
	End if 
End if 