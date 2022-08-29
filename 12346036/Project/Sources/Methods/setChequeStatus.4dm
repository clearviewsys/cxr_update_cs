//%attributes = {}
// setChequeStatus ( 0=pending; 1= Cleared; 2=Bounced;{BankName})
// bank name is only required for clearing a cheque
// PRE: record must be selected, [cheques]currency field must be valid


C_LONGINT:C283($status; $1)
$status:=$1
[Cheques:1]chequeStatus:14:=$status
If ($status=1)
	C_TEXT:C284($bankAccountID; $2)
	$bankAccountID:=$2
	[Cheques:1]AccountID:7:=$bankAccountID
	[Cheques:1]DepositDate:17:=Current date:C33
Else 
	If ([Cheques:1]isPaid:11)  // account payable
		[Cheques:1]AccountID:7:=makeChequePayable([Cheques:1]Currency:9)
	Else 
		[Cheques:1]AccountID:7:=makeChequeReceivable([Cheques:1]Currency:9)
	End if 
	[Cheques:1]DepositDate:17:=!00-00-00!
	
End if 