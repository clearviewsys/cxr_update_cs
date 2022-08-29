//%attributes = {}
//getBankAccountBalance(bankaccountID) -> real:balance


C_TEXT:C284($1)
C_REAL:C285($totalWithdraw; $totalDeposit; $0)

QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$1)

$totalWithdraw:=Sum:C1([Registers:10]Credit:7)
$totalDeposit:=Sum:C1([Registers:10]Debit:8)
$0:=($totalDeposit)+[Accounts:9]OpeningDebit:9-($totalWithdraw)
