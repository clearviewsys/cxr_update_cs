//%attributes = {}
// selectAccountsByTillNo (tillNo;{fromDate;toDate})
// select all Accounts that are related to a tillno and orders them

C_TEXT:C284($till; $1)
C_DATE:C307($fromDate; $2)
C_DATE:C307($toDate; $3)

$till:=$1

Case of 
	: (Count parameters:C259=3)
		$fromDate:=$2
		$toDate:=$3
	Else 
		$fromDate:=Current date:C33
		$toDate:=Current date:C33
End case 

QUERY:C277([CashRegisters:33]; [CashRegisters:33]CashRegisterID:1=$till)

RELATE MANY SELECTION:C340([CashAccounts:34]CashRegisterID:2)  // select all the cash accounts related to the tills selected
RELATE ONE SELECTION:C349([CashAccounts:34]; [Accounts:9])  // select all related accounts
QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isHidden:21=False:C215)
ORDER BY:C49([Accounts:9]; [Accounts:9]MainAccountID:2; >; [Accounts:9]Currency:6; >; [Accounts:9]AccountID:1; >)  // order the accounts by their ledger, currency and name
