//%attributes = {}
// selectCashRegistersByTill (tillNo;fromDate;toDate)

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
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // select all registers related to these accounts

QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate; *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
