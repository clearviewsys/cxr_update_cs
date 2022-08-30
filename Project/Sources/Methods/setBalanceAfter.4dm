//%attributes = {}
// getAccountBalanceBeforeAfter (balanceBefore;->balanceAfter;amount; isPaid)
// useful for seeing how much remains in the account after a transfer

C_REAL:C285($balanceBefore; $1)
C_POINTER:C301($balanceAfterPtr; $2)
C_REAL:C285($amount; $3)
C_BOOLEAN:C305($isPay; $4)

C_REAL:C285($balanceBefore; $balanceAfter)

$balanceBefore:=$1
$balanceAfterPtr:=$2
$amount:=$3
$isPay:=$4

$balanceAfter:=0
$balanceAfter:=($balanceBefore)-(Num:C11($isPay)*$amount)+(Num:C11(Not:C34($isPay))*$amount)
$balanceAfterPtr->:=$balanceAfter
colorizeNegs($balanceAfterPtr)
